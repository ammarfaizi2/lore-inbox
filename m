Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130801AbQL2AcA>; Thu, 28 Dec 2000 19:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132917AbQL2Abu>; Thu, 28 Dec 2000 19:31:50 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:47512 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S130801AbQL2Abk>;
	Thu, 28 Dec 2000 19:31:40 -0500
Importance: Normal
Subject: [PATCH] e820 memory detection fix for ThinkPad
To: torvalds@transmeta.com, alan@redhat.com, linux-kernel@vger.kernel.org
From: "Marc Joosen" <mjoosen@us.ibm.com>
Date: Thu, 28 Dec 2000 19:01:08 -0500
Message-ID: <OF83FEDA3F.35E7599F-ON852569C3.0082DCC9@pok.ibm.com>
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Release 5.0.6 |December 14, 2000) at
 12/28/2000 07:01:10 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  Hi Linus, Alan, lkml-readers,

  I first sent this two weeks ago, but other than a suggestion from a
linux-kernel reader, I got no response. This small patch didn't appear
in a 2.4.0-test kernel either, so I'm just submitting it again.

  This is a tiny patch to make the int15/e820 memory mapping work on IBM
ThinkPads. Until now, I have had to give lilo a mem= option with one meg
of RAM less than I actually have; otherwise ACPI events would overwrite
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


--- linux/arch/i386/boot/setup.S.orig    Mon Oct 30 17:44:29 2000
+++ linux/arch/i386/boot/setup.S   Thu Dec 21 19:37:12 2000
@@ -289,10 +289,11 @@
 # a whole bunch of different types, and allows memory holes and
 # everything.  We scan through this memory map and build a list
 # of the first 32 memory areas, which we return at [E820MAP].
-#
+# This is documented at http://www.teleport.com/~acpi/acpihtml/topic245.htm
+
+#define SMAP  0x534d4150

 meme820:
-    movl $0x534d4150, %edx        # ascii `SMAP'
     xorl %ebx, %ebx               # continuation counter
     movw $E820MAP, %di            # point into the whitelist
                              # so we can have the bios
@@ -300,13 +301,15 @@

 jmpe820:
     movl $0x0000e820, %eax        # e820, upper word zeroed
+    movl $SMAP, %edx              # do this every time, some
+                             # bioses are forgetful
     movl $20, %ecx           # size of the e820rec
     pushw     %ds                 # data record.
     popw %es
     int  $0x15                    # make the call
     jc   bail820                  # fall to e801 if it fails

-    cmpl $0x534d4150, %eax        # check the return is `SMAP'
+    cmpl $SMAP, %eax              # check the return is `SMAP'
     jne  bail820                  # fall to e801 if it fails

 #   cmpl $1, 16(%di)              # is this usable memory?


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
try this patch in the next 2.[24]-pre kernel? Thanks, and a happy New
Year! (And be careful with fireworks, you need those fingers.)

  BTW: I work for IBM, but I'm not in the PC department (or even
ThinkPad development). Unfortunately I won't be able to answer all your
IBM-related questions...
  BTW2: I'm not on the linux-kernel mailing list, so please reply to
mjoosen@us.ibm.com.


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
