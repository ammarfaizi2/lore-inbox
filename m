Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLFACj>; Tue, 5 Dec 2000 19:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130572AbQLFAC3>; Tue, 5 Dec 2000 19:02:29 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:26375 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129183AbQLFACQ>; Tue, 5 Dec 2000 19:02:16 -0500
Message-ID: <3A2D7AA4.9E7D414F@transmeta.com>
Date: Tue, 05 Dec 2000 15:30:44 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11-pre5 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>, kai@thphy.uni-duesseldorf.de
Subject: That horrible hack from hell called A20
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, here is my latest attempt to find a way to toggle A20M# that
genuinely works on all machines -- including Olivettis, IBM Aptivas,
bizarre notebooks, yadda yadda.

The bizarre notebooks with broken SMM code are the ones I really worry
most about... there may very well be NO WAY to support them that actually
works on all machines, because you don't get any kind of feedback that
they are broken.

If you have had A20M# problems with any kernel -- recent or not --
*please* try this patch, against 2.4.0-test12-pre5:

	ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/a20-test12-pre5.diff 

--- arch/i386/boot/setup.S.12p5 Tue Dec  5 15:19:10 2000
+++ arch/i386/boot/setup.S      Tue Dec  5 15:22:13 2000
@@ -636,6 +636,7 @@
 # First, try the "fast A20 gate".
 #
        inb     $0x92,%al
+       movb    %al,%dl
        orb     $0x02,%al                       # Fast A20 on
        andb    $0xfe,%al                       # Don't reset CPU!
        outb    %al,$0x92
@@ -648,9 +649,17 @@
 # did the trick and stop its probing at that stage; but subsequent ones
 # must not do so.
 #
+       pushw   %dx
        movb    $0x01,%dl                       # A20-sensitive
        call    empty_8042
+       popw    %dx
        jnz     a20_wait                        # A20 already on?
+
+# If A20 is still off, we need to go to the KBC.  Set the
+# "fast A20 gate" to its original value, since some smartass
+# manufacturers have apparently decided to use A20M# as a GPIO!
+       movb    %dl,%al
+       outb    %al,$0x92
 
        movb    $0xD1, %al                      # command write
        outb    %al, $0x64


-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
