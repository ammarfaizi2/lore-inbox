Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262634AbREZKm1>; Sat, 26 May 2001 06:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262633AbREZKmR>; Sat, 26 May 2001 06:42:17 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:13316 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S262632AbREZKmF>;
	Sat, 26 May 2001 06:42:05 -0400
Message-ID: <20010525222543.A4605@bug.ucw.cz>
Date: Fri, 25 May 2001 22:25:43 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>, patches@x86-64.org
Subject: bzImage loading directly from floppy 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

...is broken. If imagesize is 0xf123, bootsect_second only returns
0xf000 in ax, which is < 0xf123, so it continues loading. Then,
bootsect_second returns 0x10000, but it is 16 bit register, so it is
0x0000, and that's also < 0xf123. So it is looping forever.

It can be fixed like this: (Another possible workaround is to set max
size in tools/misc.c to 0xefff instead of 0xffff. OTOH it would be
nice to be able to boot images up to 2.88MB directly from floppy).
								Pavel
(Okay to commit into x86-64 tree?)

--- linux/arch/i386/boot/setup.S	Tue May  8 12:11:01 2001
+++ linux/arch/x86_64/boot/setup.S	Fri May 25 22:18:57 2001
@@ -771,6 +774,8 @@
 	incb	%cs:bootsect_dst_base+2		# to 0x10000
 bootsect_ex:
 	movb	%cs:bootsect_dst_base+2, %ah
+	cmpb	$0x20, %ah
+	je	realbig
 	shlb	$4, %ah				# we now have the number of
 						# moved frames in %ax
 	xorb	%al, %al
@@ -779,6 +784,13 @@
 	popw	%cx
 	lret
 
+realbig:
+	movw	$0xffff,%ax
+	popw	%bx
+	popw	%si
+	popw	%cx
+	lret
+
 bootsect_gdt:
 	.word	0, 0, 0, 0
 	.word	0, 0, 0, 0

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
