Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbUEFVGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbUEFVGb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 17:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263027AbUEFVGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 17:06:31 -0400
Received: from omr2.netsolmail.com ([216.168.230.163]:41915 "EHLO
	omr2.netsolmail.com") by vger.kernel.org with ESMTP id S263024AbUEFVGS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 17:06:18 -0400
Message-Id: <200405062105.BLI83826@ms6.netsolmail.com>
Reply-To: <shai@ftcon.com>
From: "Shai Fultheim" <shai@ftcon.com>
To: "'Vojtech Pavlik'" <vojtech@suse.cz>,
       "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Multiple (ICH3) IDE-controllers in a system
Date: Thu, 6 May 2004 14:05:56 -0700
Organization: FT Consulting
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00D1_01C43373.41072760"
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcQzNeC9mwL4bqI5RKyDnC4MX905GQAX7NKAAAXenhA=
In-Reply-To: <200405061918.BLI57844@ms6.netsolmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_00D1_01C43373.41072760
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vojtech and Bartlomiej,

Attached patch that fix the problem according to (2) below.  Let me know if
you can apply it.

Thanks. 


--- linux-2.6.5-mm6.orig/arch/i386/pci/fixup.c  2004-04-29
05:23:35.000000000 -0700
+++ linux-2.6.5-mm6/arch/i386/pci/fixup.c       2004-05-07
01:45:31.000000000 -0700
@@ -92,6 +92,15 @@
        int i;
 
        /*
+        * Runs the fixup only for the first IDE controller
+        * (Shai Fultheim - shai@ftcon.com)
+        */
+       static int called = 0;
+       if (called)
+               return;
+       called = 1;
+
+       /*
         * There exist PCI IDE controllers which have utter garbage
         * in first four base registers. Ignore that.
         */



--Shai


-----Original Message-----
From: linux-ide-owner@vger.kernel.org
[mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Shai Fultheim
Sent: Thursday, May 06, 2004 12:19
To: 'Vojtech Pavlik'; 'Bartlomiej Zolnierkiewicz'
Cc: linux-ide@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: RE: Multiple (ICH3) IDE-controllers in a system

Ok.
I would suggest one of the followings:
1. If we can't identify those machine, I would recommend to drop that patch,
since probably the BIOS is taking care of it nowadays.
2. If we believe we can't do (1) above, lets have it rest only the first
controller it is being called for.  This will make any of the other
controllers usable if their ports are set right.

Any comments?
 

--Shai


-----Original Message-----
From: linux-ide-owner@vger.kernel.org
[mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Vojtech Pavlik
Sent: Wednesday, May 05, 2004 23:46
To: Bartlomiej Zolnierkiewicz
Cc: shai@ftcon.com; linux-ide@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: Multiple (ICH3) IDE-controllers in a system

On Wed, May 05, 2004 at 05:16:43PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi Vojtech,
> 
> Do I correctly assume that these fixups for Intel chipsets are from you?

Yes.

>
http://linus.bkbits.net:8080/linux-2.5/cset@3cfbacdfzHvfqp0Sa45QXt9pNn3LNg?n
av=index.html|src/|src/arch|src/arch/i386|src/arch/i386/pci|related/arch/i38
6/pci/fixup.c
>
http://linus.bkbits.net:8080/linux-2.5/cset@3cfcec0fOJreGFyCWkPeT7EWiydYFw?n
av=index.html|src/|src/arch|src/arch/i386|src/arch/i386/pci|related/arch/i38
6/pci/fixup.c
> 
> Care to explain why 'trash' fixup is needed in 2.6 but not in 2.4?

Because 2.4 was never used on the affected machines, where this fixup
was needed - those machines sere putting nonsense into the BARs. I don't
recall exactly what model they were, though I remember they were one of
the first machines with ICH MMIO support.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

------=_NextPart_000_00D1_01C43373.41072760
Content-Type: application/octet-stream;
	name="pci-ide-fixup.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pci-ide-fixup.patch"

--- linux-2.6.5-mm6.orig/arch/i386/pci/fixup.c	2004-04-29 =
05:23:35.000000000 -0700=0A=
+++ linux-2.6.5-mm6/arch/i386/pci/fixup.c	2004-05-07 01:45:31.000000000 =
-0700=0A=
@@ -92,6 +92,15 @@=0A=
 	int i;=0A=
 =0A=
 	/*=0A=
+	 * Runs the fixup only for the first IDE controller=0A=
+	 * (Shai Fultheim - shai@ftcon.com)=0A=
+	 */=0A=
+	static int called =3D 0;=0A=
+	if (called)=0A=
+		return;=0A=
+	called =3D 1;=0A=
+=0A=
+	/*=0A=
 	 * There exist PCI IDE controllers which have utter garbage=0A=
 	 * in first four base registers. Ignore that.=0A=
 	 */=0A=

------=_NextPart_000_00D1_01C43373.41072760--

