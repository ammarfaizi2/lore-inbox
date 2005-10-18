Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbVJRL5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVJRL5f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 07:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbVJRL5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 07:57:34 -0400
Received: from wine.ocn.ne.jp ([220.111.47.146]:38617 "EHLO
	smtp.wine.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S1750712AbVJRL5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 07:57:34 -0400
To: linux-kernel@vger.kernel.org
Subject: [BUG?] About sysctl_string()
From: Tetsuo Handa <from-linux-kernel@i-love.sakura.ne.jp>
Message-Id: <200510182056.FHE94932.FMSGLJPtNStYVOOMF@i-love.sakura.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Tue, 18 Oct 2005 20:57:11 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have posted this question to kernelnewbies-ml,
but I post here too, for this is a bit difficult question.

I have several questions about sysctl().

Q1: Why does sysctl_string() return 0 when it succeed?

    The sysctl_string() do r/w operations,
    so we needn't to proceed with automatic r/w
    when sysctl_string() is called as
    a strategy routine (i.e. table->strategy).
    http://lxr.linux.no/source/kernel/sysctl.c#L1087

Q2: If Q1 is not a bug, then I have Q2.
    Why not terminate with '\0' if doing string copy operation
    at http://lxr.linux.no/source/kernel/sysctl.c#L1115 ?

    At least, as with table->strategy == &sysctl_string ,
    '\0' should be always added after string copy operation.
    For example, /proc/sys/kernel/hostname uses
    sysctl_string() for strategy routine.
    http://lxr.linux.no/source/kernel/sysctl.c#L249
    Since sysctl_string() returns 0, do_sysctl_strategy()
    continues and proceeds with automatic r/w.
    But since automatic r/w doesn't set trailing '\0',
    table->data doesn't end with '\0' if newlen > table->maxlen.
    This makes system_utsname.nodename not null-terminated.

Q3: The parse_table() call table->strategy() if
	table->child != NULL && table->strategy != NULL .
    http://lxr.linux.no/source/kernel/sysctl.c#L1049
    Can such table (table->child != NULL && table->strategy != NULL) exist?

    If such table can exist, table->strategy() is called
    without ctl_perm(table, r/w) checks,
    allowing non-root process read/write that table.
    We need to call ctl_perm() before calling table->strategy(),
    aren't we?

    If such table can't exist, we can remove
    "if (table->strategy) { ... }" block
    (from http://lxr.linux.no/source/kernel/sysctl.c#L1049
     to http://lxr.linux.no/source/kernel/sysctl.c#L1056 ),
    aren't we?

Q4: do_sysctl() gets lock_kernel() but no uts_sem lock
    ( http://lxr.linux.no/source/kernel/sysctl.c#L1001 ), and
    sys_sethostname() gets uts_sem lock but no lock_kernel()
    ( http://lxr.linux.no/source/kernel/sys.c#L1376 ).
    This allows one process update hostname via sys_sysctl()
    and the other process update hostname via sys_sethostname()
    at the same time.
    As with hostname, the race condition probably won't crash the system.
    But there MAY be more sysctl-accessible variables
    that can produce race condition.
    Why not review all sysctl-accessible variables?

Best Regards.

----- demo code for Q2 start -----
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <linux/unistd.h>
#include <linux/types.h>
#include <linux/sysctl.h>
#include <errno.h>

_syscall1(int, _sysctl, struct __sysctl_args *, args);
static int sysctl(int *name, int nlen, void *oldval, size_t *oldlenp, void *newval, size_t newlen) {
    struct __sysctl_args args={name,nlen,oldval,oldlenp,newval,newlen};
    return _sysctl(&args);
}

int main(int argc, char *argv[]) {
    int name[] = { CTL_KERN, KERN_NODENAME };
    static char buffer[128];
    memset(buffer, 0, sizeof(buffer));
    snprintf(buffer, sizeof(buffer) - 1, "12345678901234567890123456789012345678901234567890123456789012345");
    if (sysctl(name, 2, NULL, 0, buffer, sizeof(buffer))) perror("sysctl");
    else printf("hostname was set via sysctl()\n");
    return 0;
}
----- demo code for Q2 end -----
