Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263323AbVBEHkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263323AbVBEHkp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 02:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbVBEHkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 02:40:45 -0500
Received: from hornet.berlios.de ([195.37.77.140]:16095 "EHLO
	hornet.berlios.de") by vger.kernel.org with ESMTP id S263323AbVBEHkV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 02:40:21 -0500
From: Michael Frank at BerliOS <mhf@hornet.berlios.de>
Date: Sat, 05 Feb 2005 08:40:14 +0100
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.11-rc3 fix compile failure in arch/i386/kernel/i387.c
Message-ID: <4204785E.nailLAW1YU0SF@hornet.berlios.de>
User-Agent: nail 10.5 4/27/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 February 2005 13:36, you wrote:
> On Sat, Feb 05, 2005 at 06:29:06AM +0100, Michael Frank at BerliOS wrote:
> > Using patch-2.6.11-rc3.bz2 from kernel.org on top of
> > 2.6.10, a compile failure in /arch/i386/kernel/i387.c
> > due to tsk->used_math undef.
> >
> > The patch log shows offsets but no rejects
> >
> > patching file arch/i386/kernel/i387.c
> > Hunk #6 succeeded at 538 (offset 15 lines).
> > Hunk #7 succeeded at 553 (offset 15 lines).
>
> No offsets (or compile problems) here.  Have you verified
> that your 2.6.10 had no local changes?

OK, checked that after downloading Vanilla 2.6.10 from kernel.org

My local tree which was built incrementally since 2.6.8 or so has an extra function:

$ mdiff -kd xx linux-2.6.10-Vanilla linux-2.6.10-Today
diff -uN -r -X /etc/sys/dont/kexdiff linux-2.6.10-Vanilla/Makefile linux-2.6.10-Today/Makefile
--- linux-2.6.10-Vanilla/Makefile       2005-01-04 5:54:17.000000000 +0100
+++ linux-2.6.10-Today/Makefile 2005-02-05 08:02:11.000000000 +0100
@@ -336,7 +336,7 @@
 CFLAGS_MODULE   = $(MODFLAGS)
 AFLAGS_MODULE   = $(MODFLAGS)
 LDFLAGS_MODULE  = -r
-CFLAGS_KERNEL  =-g
+CFLAGS_KERNEL  =
 AFLAGS_KERNEL  =

 NOSTDINC_FLAGS  = -nostdinc -iwithprefix include
diff -uN -r -X /etc/sys/dont/kexdiff linux-2.6.10-Vanilla/arch/i386/kernel/i387.c linux-2.6.10-Today/arch/i386/kernel/i387.c
--- linux-2.6.10-Vanilla/arch/i386/kernel/i387.c        2005-01-04 5:54:17.000000000 +0100
+++ linux-2.6.10-Today/arch/i386/kernel/i387.c  2005-02-05 08:02:13.000000000 +0100
@@ -519,21 +519,6 @@
        return fpvalid;
 }

-int dump_extended_fpu( struct pt_regs *regs, struct user_fxsr_struct *fpu )
-{
-       int fpvalid;
-       struct task_struct *tsk = current;
-
-       fpvalid = tsk->used_math && cpu_has_fxsr;
-       if ( fpvalid ) {
-               unlazy_fpu( tsk );
-               memcpy( fpu, &tsk->thread.i387.fxsave,
-                       sizeof(struct user_fxsr_struct) );
-       }
-
-       return fpvalid;
-}
-
 int dump_task_fpu(struct task_struct *tsk, struct user_i387_struct *fpu)
 {
        int fpvalid = tsk->used_math;

Above are the only differences between both trees and I have not touched i387.c

Looking at earlier patch logs, the 15 line offset appeared first with 2.6.10-rc3
and there were no rejects.

Would you happen to know when this function was removed?

 Thank You
 Michael
