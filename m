Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264526AbUGMBan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbUGMBan (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 21:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbUGMBan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 21:30:43 -0400
Received: from mail.ccur.com ([208.248.32.212]:59659 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S264526AbUGMBah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 21:30:37 -0400
Message-ID: <40F33B35.3020209@ccur.com>
From: "Blackwood, John" <john.blackwood@ccur.com>
To: linux-kernel@vger.kernel.org
Cc: ak@muc.de
Subject: Re: [PATCH] arch/i386|x86_64/kernel/ptrace.c linux-2.6.7
Date: Mon, 12 Jul 2004 21:30:29 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blackwood, John wrote:
> Hi Andi,
> 
> In linux-2.6.7, I would like to suggest a few small changes to the error
> checking the PTRACE_GETREGS and PTRACE_SETREGS processing in
> sys_ptrace().
> 
> While working on our own linux debugger, we noticed that if an invalid
> user-space address is passed in, then the ptrace() call would return
> success even though the registers were not properly read
> (PTRACE_GETREGS)
> or written (PTRACE_SETREGS).
> 
> Since the access_ok() check only ensures that the user-space address
> is within the range of valid user space addresses, the subsequent
> __put_user() or __get_user() calls can still fail if the user-space
> address is not current a valid address within the caller's address
> space.
> 
> The suggested fix below for i386 and x86_64 is to logically OR the
> returned
> value into 'ret' from the __put_user() or __get_user() calls, in the
> same way that the arch/x86_64/ia32/ptrace32.c code does.
> 
> Additionally, for x86_64 only, the access_ok() size parameter should
> really
> be sizeof(struct user_regs_struct) instead of FRAME_SIZE, since on
> x86_64
> the user_regs_struct being read/written is actually a bit larger than
> the FRAME_SIZE define.
> 
> 
> Thank you.
> 
Sorry, I guess my diffs got new-line-botched-up.

I'll try again:

diff -ru linux-2.6.7/arch/i386/kernel/ptrace.c
linux/arch/i386/kernel/ptrace.c
--- linux-2.6.7/arch/i386/kernel/ptrace.c       2004-06-16
01:19:03.000000000 -0400
+++ linux/arch/i386/kernel/ptrace.c     2004-07-12 13:09:33.000000000 -0400
@@ -428,11 +428,11 @@
                         ret = -EIO;
                         break;
                 }
+               ret = 0;
                 for ( i = 0; i < FRAME_SIZE*sizeof(long); i += sizeof(long)
) {
-                       __put_user(getreg(child, i), datap);
+                       ret |= __put_user(getreg(child, i), datap);
                         datap++;
                 }
-               ret = 0;
                 break;
         }

@@ -442,12 +442,12 @@
                         ret = -EIO;
                         break;
                 }
+               ret = 0;
                 for ( i = 0; i < FRAME_SIZE*sizeof(long); i += sizeof(long)
) {
-                       __get_user(tmp, datap);
+                       ret |=__get_user(tmp, datap);
                         putreg(child, i, tmp);
                         datap++;
                 }
-               ret = 0;
                 break;
         }





diff -ru linux-2.6.7/arch/x86_64/kernel/ptrace.c
linux/arch/x86_64/kernel/ptrace.c
--- linux-2.6.7/arch/x86_64/kernel/ptrace.c     2004-06-16
01:19:09.000000000 -0400
+++ linux/arch/x86_64/kernel/ptrace.c   2004-07-12 16:03:35.584411668 -0400
@@ -429,30 +429,30 @@
                 break;

         case PTRACE_GETREGS: { /* Get all gp regs from the child. */
-               if (!access_ok(VERIFY_WRITE, (unsigned __user *)data,
FRAME_SIZE)) {
+               if (!access_ok(VERIFY_WRITE, (unsigned __user *)data,
sizeof(struct user_regs_struct))) {
                         ret = -EIO;
                         break;
                 }
+               ret = 0;
                 for (ui = 0; ui < sizeof(struct user_regs_struct); ui +=
sizeof(long)) {
-                       __put_user(getreg(child, ui),(unsigned long __user
*) data);
+                       ret |= __put_user(getreg(child, ui),(unsigned long
__user *) data);
                         data += sizeof(long);
                 }
-               ret = 0;
                 break;
         }

         case PTRACE_SETREGS: { /* Set all gp regs in the child. */
                 unsigned long tmp;
-               if (!access_ok(VERIFY_READ, (unsigned __user *)data,
FRAME_SIZE)) {
+               if (!access_ok(VERIFY_READ, (unsigned __user *)data,
sizeof(struct user_regs_struct))) {
                         ret = -EIO;
                         break;
                 }
+               ret = 0;
                 for (ui = 0; ui < sizeof(struct user_regs_struct); ui +=
sizeof(long)) {
-                       __get_user(tmp, (unsigned long __user *) data);
+                       ret |= __get_user(tmp, (unsigned long __user *)
data);
                         putreg(child, ui, tmp);
                         data += sizeof(long);
                 }
-               ret = 0;
                 break;
         }



