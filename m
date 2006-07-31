Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWGaXrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWGaXrt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 19:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWGaXrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 19:47:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:40155 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932192AbWGaXrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 19:47:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=T0w/md7foMyQTXEcNpYMKZ1QMoZ0vt/szKFXH2gxDcmPp4ZmBNePJdtZ1b6w+Q0MLfDOerSkWIwDW38z0fssIdhwkY49ZhhYhYoCAMB8TKf4gFxuJjuWnH3WnyALlybeeQFcwrOKhxNnn7pyYJy7dCrtXjoB5baMLF2pvxh8qrY=
Date: Tue, 1 Aug 2006 01:47:27 +0200
From: Diego Calleja <diegocg@gmail.com>
To: akpm@osdl.org
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] AUX_DEVICE_INFO is one byte long, use 'movb'
Message-Id: <20060801014727.603e25a4.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bugzilla #6552 says:

"In arch/i386/boot/setup.S, movw is used instead of movb for PS/2 mouse
information, although it is unsigned char. This does not harm, because
the jmp instruction overwritten by movw is used before executing movw,
and never be used again"

I've no idea if this is a real bug or how it gets fixed, so I'm submitting
it for review instead of letting it die of boredom in bugzilla. Aditionally
to i386, I've changed x86-64, which mirrors the same code.

Credits to Yoshinori K. Okuji, who found the problem and suggested a fix.


Signed-off-by: Diego Calleja <diegocg@gmail.com>


Index: 2.6/arch/i386/boot/setup.S
===================================================================
--- 2.6.orig/arch/i386/boot/setup.S	2006-08-01 01:04:34.000000000 +0200
+++ 2.6/arch/i386/boot/setup.S	2006-08-01 01:04:49.000000000 +0200
@@ -494,12 +494,12 @@
 	movw	%cs, %ax			# aka SETUPSEG
 	subw	$DELTA_INITSEG, %ax		# aka INITSEG
 	movw	%ax, %ds
-	movw	$0, (0x1ff)			# default is no pointing device
+	movb	$0, (0x1ff)			# default is no pointing device
 	int	$0x11				# int 0x11: equipment list
 	testb	$0x04, %al			# check if mouse installed
 	jz	no_psmouse
 
-	movw	$0xAA, (0x1ff)			# device present
+	movb	$0xAA, (0x1ff)			# device present
 no_psmouse:
 
 #if defined(CONFIG_X86_SPEEDSTEP_SMI) || defined(CONFIG_X86_SPEEDSTEP_SMI_MODULE)
Index: 2.6/arch/x86_64/boot/setup.S
===================================================================
--- 2.6.orig/arch/x86_64/boot/setup.S	2006-08-01 01:04:39.000000000 +0200
+++ 2.6/arch/x86_64/boot/setup.S	2006-08-01 01:05:26.000000000 +0200
@@ -526,12 +526,12 @@
 	movw	%cs, %ax			# aka SETUPSEG
 	subw	$DELTA_INITSEG, %ax		# aka INITSEG
 	movw	%ax, %ds
-	movw	$0, (0x1ff)			# default is no pointing device
+	movb	$0, (0x1ff)			# default is no pointing device
 	int	$0x11				# int 0x11: equipment list
 	testb	$0x04, %al			# check if mouse installed
 	jz	no_psmouse
 
-	movw	$0xAA, (0x1ff)			# device present
+	movb	$0xAA, (0x1ff)			# device present
 no_psmouse:
 
 #include "../../i386/boot/edd.S"
