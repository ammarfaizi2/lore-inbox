Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWEUCDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWEUCDy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 22:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWEUCDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 22:03:54 -0400
Received: from koto.vergenet.net ([210.128.90.7]:31948 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1751419AbWEUCDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 22:03:53 -0400
Date: Sat, 20 May 2006 11:09:19 +0900
From: Horms <horms@verge.net.au>
To: ebiederm@xmission.com, linux-kernel@vger.kernel.org, fastboot@osdl.org
Subject: Re: [PATCH] kexec: typo in machine_kexec()
Message-ID: <20060520020919.GA6802@verge.net.au>
References: <20060404234806.GA25761@verge.net.au> <200604051310.55956.kernel@kolivas.org> <20060404234806.GA25761@verge.net.au> <20060404200557.1e95bdd8.rdunlap@xenotime.net> <20060405055754.GA3277@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060405055754.GA3277@verge.net.au>
X-Cluestick: seven
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kexec: rework kexec_crash logic to make it a little less nested

Signed-Off-By: Simon Horman <horms@verge.net.au>

 kernel/kexec.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

6d28ed0c03ff2d9345a5b198a52f6ee3cc7dd424
diff --git a/kernel/kexec.c b/kernel/kexec.c
index bf39d28..281736f 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1042,6 +1042,7 @@ #endif
 
 void crash_kexec(struct pt_regs *regs)
 {
+	struct pt_regs fixed_regs;
 	struct kimage *image;
 	int locked;
 
@@ -1055,16 +1056,15 @@ void crash_kexec(struct pt_regs *regs)
 	 * sufficient.  But since I reuse the memory...
 	 */
 	locked = xchg(&kexec_lock, 1);
-	if (!locked) {
-		image = xchg(&kexec_crash_image, NULL);
-		if (image) {
-			struct pt_regs fixed_regs;
-			crash_setup_regs(&fixed_regs, regs);
-			machine_crash_shutdown(&fixed_regs);
-			machine_kexec(image);
-		}
-		xchg(&kexec_lock, 0);
+	if (locked)
+		return;
+	image = xchg(&kexec_crash_image, NULL);
+	if (image) {
+		crash_setup_regs(&fixed_regs, regs);
+		machine_crash_shutdown(&fixed_regs);
+		machine_kexec(image);
 	}
+	xchg(&kexec_lock, 0);
 }
 
 static int __init crash_notes_memory_init(void)

