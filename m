Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263847AbUEXCto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbUEXCto (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 22:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUEXCtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 22:49:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.173]:57835 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263847AbUEXCtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 22:49:17 -0400
X-From-Line: nobody Sun May 23 22:57:28 2004
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Albert Cahalan <albert@users.sourceforge.net>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scaled-back caps, take 4
References: <fa.i8g63r1.9jata3@ifi.uio.no> <fa.hjocttu.1cgcc3q@ifi.uio.no>
	<40B0F65F.3020706@myrealbox.com>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sun, 23 May 2004 22:57:27 +0200
In-Reply-To: <40B0F65F.3020706@myrealbox.com> (Andy Lutomirski's message of
 "Sun, 23 May 2004 12:07:11 -0700")
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
Message-ID: <87pt8upmjf.fsf@goat.bogus.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@myrealbox.com> writes:

> [sorry if this is a resend -- i don't think it worked the first
> time.]
>
> Olaf Dietsche wrote:
>> Andy Lutomirski <luto@myrealbox.com> writes:
>
>>>First, CAP_SETPCAP is never obtainable (by anything).
>>>Since cap_bset never has this bit set, nothing can inherit it
>>>from fP.  capset_check prevents it from getting set in pI.
>> # mv /sbin/init /sbin/init.bin
>> # cat >/sbin/init
>> #! /bin/sh
>> if test $$ -eq 1; then
>>         mount /proc
>>         echo -1 >/proc/sys/kernel/cap-bound
>> fi
>> exec /sbin/init.bin "$@"
>> ^D
>> # chmod 755 /sbin/init
>> # reboot
>
> Wow -- I missed that.  Does anyone actually do this?  And is there a
> reason why it should work like this?

Because in kernel/sysctl.c:
int proc_dointvec_bset(ctl_table *table, int write, struct file *filp,
			void __user *buffer, size_t *lenp)
allows init only to set cap_bset.
You can write a module to set cap_bset, of course, or patch the kernel
to define CAP_INIT_EFF_SET to ~0.

>>>cap_bprm_set_security does:
>>>fP = fI = (new_uid == 0 || new_euid == 0)
>>>fE = (new_euid == 0)
>> Only if (!issecure (SECURE_NOROOT))
>> [...]
>
> I don't see any way to change securebits.

I thought there has been a /proc way, to set securebits, but maybe I
confused this with cap_bset. Anyway, here's the easy way out:

diff -urN a/include/linux/securebits.h b/include/linux/securebits.h
--- a/include/linux/securebits.h        Sat Oct  5 18:42:33 2002
+++ b/include/linux/securebits.h        Sun May 23 22:38:02 2004
@@ -1,7 +1,7 @@
 #ifndef _LINUX_SECUREBITS_H
 #define _LINUX_SECUREBITS_H 1
 
-#define SECUREBITS_DEFAULT 0x00000000
+#define SECUREBITS_DEFAULT (SECURE_NO_SETUID_FIXUP | SECURE_NOROOT)
 
 extern unsigned securebits;
 
>> Please, don't get me wrong. For me, it's just a matter of maintaining
>> a slightly bigger fscaps patch. But I don't think capabilities in
>> Linux are really broken, only because some proponents of SELinux claim
>> so.
>
>
> I find caps to be broken, and I don't use SELinux.  I want to be able
> to run programs as non-root with limited caps, which I currently can't
> do without modifying each program to start as root, then drop caps,
> then set KEEPCAPS, then drop root.  And even with that change, these
> programs can't usefully exec themselves, which could be useful.

This is, where filesystem capabilities come into play. You implemented
them yourself. Execing is still a problem, though. However, if you
activate SECURE_NO_SETUID_FIXUP this issue is gone, too.

> And no, I don't think this patch is necessary, or that it should be
> applied or used by itself.  I think it makes a good starting point to
> fix caps
> (which a lot of people seem to think are broken).

Well, I know, that I don't have a strong following. :-)

Regards, Olaf.
