Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWCNKrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWCNKrE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 05:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWCNKrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 05:47:04 -0500
Received: from wildsau.enemy.org ([193.170.194.34]:55177 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S932081AbWCNKrD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 05:47:03 -0500
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200603141043.k2EAhlTV016354@wildsau.enemy.org>
Subject: procfs uglyness caused by "cat"
To: linux-kernel@vger.kernel.org
Date: Tue, 14 Mar 2006 11:43:46 +0100 (MET)
CC: Herbert Rosmanith <kernel@wildsau.enemy.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hello list,

when doing "cat /proc/uptime" or similar files, the
routine which prepares the buffer gets called twice.

this is because "cat" reads two times from the file,
as a system-call-trace shows:

    # strace -f cat /proc/uptime
    ...
    read(3, "5241.09 5082.74\n", 1024)      = 16
    ...
    read(3, "", 1024)                       = 0
    ...

this leads to uptime_read_proc() being called two times,
the second time with parameter off=16, but since this
is ignored, the work is done twice: clock_...gettime(),
cputime_to_timespec(), sprintf(), proc_calc_metrics()
and so on.

insert a printk-statement if you don't beleive this.

btw, there's no wrong information produced because of this,
because *page points to the same location both calls.

a simple way to get rid of this:

static int uptime_read_proc(char *page, char **start, off_t off,
                                 int count, int *eof, void *data)
{
        struct timespec uptime;
        struct timespec idle;
        int len;
        cputime_t idletime;

+	if (off)
+		return 0;

        cputime_add(init_task.utime, init_task.stime);
        do_posix_clock_monotonic_gettime(&uptime);
        cputime_to_timespec(idletime, &idle);
        len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
...
and so on.

this affects possibly all /proc files which ignore the offset parameter
and are evaluated(?) with "cat".

regards,
h.rosmanith


