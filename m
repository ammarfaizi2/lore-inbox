Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVH2R37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVH2R37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 13:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbVH2R37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 13:29:59 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:51429 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751150AbVH2R36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 13:29:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PrGZQpPeKnjRaFDs15+CcMf/0V0YyvIPh6dLNQOLcs255zaUMzvAh+/pF4z3JcbrujNIS66EOklquKoIqqaxfkEGMjH+HnFVD0a01XGJCXqr5HrGFBgirI2CmESoNQnIOZkzFDHA9DsVH+wInjpq65SoWep4CNQnpCux5JzBWIw=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Chris Zankel <chris@zankel.net>
Subject: [PATCH] convert verify_area to access_ok in xtensa/kernel/signal.c
Date: Mon, 29 Aug 2005 19:31:00 +0200
User-Agent: KMail/1.8.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508291931.00764.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


verify_area() is deprecated and has been for quite a while.
I thought I had cleaned up all users and was planning to submit the final
patches to get rid of it completely, but when I did a final check I found 
that xtensa has been added after my initial cleanup and it still uses 
verify_area(), so we have to get that cleaned up before I can get on with 
the final verify_area removal.


This patch converts all uses of verify_area() in xtensa/kernel/signal.c to 
use access_ok() instead.

Please apply.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/arch/xtensa/kernel/signal.c linux-2.6.13/arch/xtensa/kernel/signal.c
--- linux-2.6.13-orig/arch/xtensa/kernel/signal.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/arch/xtensa/kernel/signal.c	2005-08-29 03:40:12.000000000 +0200
@@ -104,7 +104,7 @@ sys_sigaction(int sig, const struct old_
 
 	if (act) {
 		old_sigset_t mask;
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
 			return -EFAULT;
@@ -116,7 +116,7 @@ sys_sigaction(int sig, const struct old_
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 
 	if (!ret && oact) {
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
 		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
 			return -EFAULT;
@@ -236,7 +236,7 @@ restore_sigcontext(struct pt_regs *regs,
 	err |= __copy_from_user (regs->areg, sc->sc_areg, XCHAL_NUM_AREGS*4);
 	err |= __get_user(buf, &sc->sc_cpstate);
 	if (buf) {
-		if (verify_area(VERIFY_READ, buf, sizeof(*buf)))
+		if (!access_ok(VERIFY_READ, buf, sizeof(*buf)))
 			goto badframe;
 		err |= restore_cpextra(buf);
 	}
@@ -357,7 +357,7 @@ asmlinkage int sys_sigreturn(struct pt_r
 	if (regs->depc > 64)
 		panic ("Double exception sys_sigreturn\n");
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 
 	if (__get_user(set.sig[0], &frame->sc.oldmask)
@@ -394,7 +394,7 @@ asmlinkage int sys_rt_sigreturn(struct p
 		return 0;
 	}
 
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 
 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
