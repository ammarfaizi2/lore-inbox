Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131521AbQLVBfC>; Thu, 21 Dec 2000 20:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131609AbQLVBew>; Thu, 21 Dec 2000 20:34:52 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:18323 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S131521AbQLVBel>;
	Thu, 21 Dec 2000 20:34:41 -0500
Importance: Normal
Subject: [PATCH] Re: e820 memory detection fix for ThinkPad
To: alan@redhat.com, linux-kernel@vger.kernel.org
From: "Marc Joosen" <mjoosen@us.ibm.com>
Date: Thu, 21 Dec 2000 20:04:02 -0500
Message-ID: <OF4FB68CB1.98A5E1AA-ON852569BD.000420DA@pok.ibm.com>
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Release 5.0.6 |December 14, 2000) at
 12/21/2000 08:04:04 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Weinhall wrote:

> On Tue, Dec 19, 2000 at 07:16:40PM -0500, Marc Joosen wrote:
> >
> >   This is a tiny patch to make the int15/e820 memory mapping work on
IBM
> > ThinkPads. Until now, I have had to give lilo a mem= option with one
meg
>
> If this simple patch solves your problem, great! But in that case,
> PLEASE add a note telling WHY the assignment is done for every
> iteration; else some smarthead will probably submit a patch someday
> in the future along the lines of "assigning this only once makes the
> loop faster"...
>
> Anyhow, good spotting!

  Thanks for the tip, David. I hope that whoever wants to move that line
out of the loop is aware that it is only executed ~10 times :) So I
hereby submit a second version of the patch, that includes a link to
the documentation and #defines the word SMAP (thanks to David Parsons
for that):


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


  Again, please copy any comments to me (mjoosen@us.ibm.com), since
I'm not subscribed to linux-kernel.


--
  Marc Joosen
  Communication Link Design
  IBM T.J. Watson Research Center
  Yorktown Heights, NY


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
