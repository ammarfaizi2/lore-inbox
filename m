Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129703AbQLTArb>; Tue, 19 Dec 2000 19:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130391AbQLTArV>; Tue, 19 Dec 2000 19:47:21 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:18310 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S129703AbQLTArO>;
	Tue, 19 Dec 2000 19:47:14 -0500
Importance: Normal
Subject: [PATCH] e820 memory detection fix for ThinkPad
To: alan@redhat.com, linux-kernel@vger.kernel.org
From: "Marc Joosen" <mjoosen@us.ibm.com>
Date: Tue, 19 Dec 2000 19:16:40 -0500
Message-ID: <OF28B11D4D.E0E35F30-ON852569BA.007BEF88@pok.ibm.com>
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Build V506_12112000 |December 11, 2000) at
 12/19/2000 07:16:40 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  Hi Alan, lkml-readers,

  This is a tiny patch to make the int15/e820 memory mapping work on IBM
ThinkPads. Until now, I have had to give lilo a mem= option with one meg
of RAM less than I actually have, so ACPI events don't overwrite any
data. The only alternative was to use one of the patches available on
http://www.pell.portland.or.us/~orc/Memory/, but these are quite big. I
tracked down the problem, at least for the ThinkPad 600X (2645-4EU), to
arch/i386/boot/setup.S: apparently the bios doesn't retain the value of
register %edx, so after the first entry is read the ascii word `SMAP' is
lost and further entries won't be recognized. The solution is simple,
just move the assignment 6 lines down so it's inside the loop that is
done for every entry.
  This patch is for 2.4.0-test7..12, but it should work for pre13
kernels and even 2.2 kernels with the memory map backport:

--- linux/arch/i386/boot/setup.S.orig    Sat Dec  9 05:56:07 2000
+++ linux/arch/i386/boot/setup.S   Sat Dec  9 06:43:03 2000
@@ -292,7 +292,6 @@
 #

 meme820:
-    movl $0x534d4150, %edx        # ascii `SMAP'
     xorl %ebx, %ebx               # continuation counter
     movw $E820MAP, %di            # point into the whitelist
                              # so we can have the bios
@@ -300,6 +299,7 @@

 jmpe820:
     movl $0x0000e820, %eax        # e820, upper word zeroed
+    movl $0x534d4150, %edx        # ascii `SMAP'
     movl $20, %ecx           # size of the e820rec
     pushw     %ds                 # data record.
     popw %es

  (I hope it came through properly... it may have been Lotus-Notified.)
My ThinkPad now shows this during boot:

Linux version 2.4.0-test12 (mjoosen@hexane) (gcc version 2.95.2 19991024 (release)) #2 Sun Dec 10 23:51:04 EST 2000
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 000000000bed0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000f000 @ 000000000bfd0000 (ACPI data)
 BIOS-e820: 0000000000001000 @ 000000000bfdf000 (ACPI NVS)
 BIOS-e820: 0000000000020000 @ 000000000bfe0000 (reserved)
 BIOS-e820: 0000000000020000 @ 00000000fffe0000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009f800 for 4096 bytes.
...

and that's without a mem= option to lilo, of course. May I suggest you
try this patch in the next 2.[24]-pre kernel? Thanks!

  BTW: I work for IBM, but I'm not in the PC department (or even
ThinkPad development). Unfortunately I won't be able to answer all your
IBM-related questions...
  BTW2: I'm not on the linux-kernel mailing list, so please reply to
<mjoosen @ us.ibm.com> (remove anti-spam spacing).


  Regards,

--
  Marc Joosen
  Communication Link Design
  IBM T.J. Watson Research Center
  Yorktown Heights, NY


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
