Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbTA2PaQ>; Wed, 29 Jan 2003 10:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbTA2PaQ>; Wed, 29 Jan 2003 10:30:16 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:950 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S264673AbTA2PaO>;
	Wed, 29 Jan 2003 10:30:14 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15927.62893.336010.363817@harpo.it.uu.se>
Date: Wed, 29 Jan 2003 16:39:25 +0100
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: two x86_64 fixes for 2.4.21-pre3
In-Reply-To: <20030128212753.GA29191@wotan.suse.de>
References: <15921.37163.139583.74988@harpo.it.uu.se>
	<20030124193721.GA24876@wotan.suse.de>
	<15926.60767.451098.218188@harpo.it.uu.se>
	<20030128212753.GA29191@wotan.suse.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > > It looks as if %gs handling isn't quite right.
 > 
 > You are running vanilla 2.4.21pre3, right? 
 > 
 > I just noticed that my big update which has this all fixed went 
 > only in after pre3.

I got 2.4.21-pre4 which has your x86_64 updates. It works MUCH better.
Still some problems remain:

1. One unknown ioctl is logged from RH8.0 init:

ioctl32(iwconfig:185): Unknown cmd fd(3) cmd(00008b01){00} arg(ffffda90) on socket:[389]

2. gdb still seems broken. gdb ./sleep [where ./sleep is simply main() calling
   nanosleep(), but linked with -lpthread] hangs or loops and takes forever
   to respond to ^C.

3. bootsect.S still needs a patch to prevent 'bzdisk' kernels from
   disabling the FDC

/Mikael

--- linux-2.4.21-pre4/arch/x86_64/boot/bootsect.S.~1~	2002-11-30 17:12:24.000000000 +0100
+++ linux-2.4.21-pre4/arch/x86_64/boot/bootsect.S	2003-01-29 16:08:38.000000000 +0100
@@ -395,9 +395,15 @@
 # NOTE: Doesn't save %ax or %dx; do it yourself if you need to.
 
 kill_motor:
+#if 1
+	xorw	%ax, %ax		# reset FDC
+	xorb	%dl, %dl
+	int	$0x13
+#else
 	movw	$0x3f2, %dx
 	xorb	%al, %al
 	outb	%al, %dx
+#endif
 	ret
 
 sectors:	.word 0
