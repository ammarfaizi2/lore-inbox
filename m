Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316334AbSEOIye>; Wed, 15 May 2002 04:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316359AbSEOIyd>; Wed, 15 May 2002 04:54:33 -0400
Received: from mailg.telia.com ([194.22.194.26]:16375 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S316334AbSEOIya>;
	Wed, 15 May 2002 04:54:30 -0400
From: "Christer Nilsson" <christer.nilsson@kretskompaniet.se>
To: "Greg KH" <greg@kroah.com>
Cc: <lepied@xfree86.org>, "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.4.19-pre8  Fix for Intuos tablet in wacom.c
Date: Wed, 15 May 2002 10:54:18 +0200
Message-ID: <IBEJLIFNGHPKEKCKODPDIEFFDPAA.christer.nilsson@kretskompaniet.se>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0058_01C1FBFE.DC9B8850"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20020515024646.GA21582@kroah.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0058_01C1FBFE.DC9B8850
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Yes, when you removed the smoothing algorithm you forgot to make
the change my previous patch fixed. Anyway, I took a look at the code
and found that it could be cleaned up a little.
This patch works for me, but I can only test it with an Intuos tablet
although it should not break anything.

Christer Nilsson

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Wednesday, May 15, 2002 4:47 AM
> To: Christer Nilsson
> Cc: lepied@xfree86.org; Linux-Kernel
> Subject: Re: [PATCH] 2.4.19-pre8 Fix for Intuos tablet in wacom.c
> 
> 
> On Tue, May 14, 2002 at 08:56:14PM +0200, Christer Nilsson wrote:
> > Hi Frederic.
> > 
> > Can you take a look at this?
> > 
> > I've looked at the code at
> > http://people.mandrakesoft.com/~flepied/projects/wacom/ and found that
> > there's a couple of lines missing in the kernel driver. It seems that a
> > smoothing algorithm is left out
> > in the kernel source. My patch just circumvents that.
> 
> I took out the smoothing algorithm, as it does not belong in the kernel.
> That kind of stuff (filters, etc.) belongs in userspace.
> 
> Did my removing it break the current driver accidentally?
> 
> thanks,
> 
> greg k-h
> 
------=_NextPart_000_0058_01C1FBFE.DC9B8850
Content-Type: application/octet-stream;
	name="wacom.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="wacom.diff"

--- /usr/src/linux-2.4.19-pre8-ac2/drivers/usb/wacom.c.org	Wed May 15 =
10:28:42 2002=0A=
+++ /usr/src/linux-2.4.19-pre8-ac2/drivers/usb/wacom.c	Wed May 15 =
10:32:18 2002=0A=
@@ -111,7 +111,6 @@=0A=
 	struct wacom_features *features;=0A=
 	int tool[2];=0A=
 	int open;=0A=
-	int x, y;=0A=
 	__u32 serial[2];=0A=
 };=0A=
 =0A=
@@ -209,16 +208,16 @@=0A=
 			input_report_abs(dev, ABS_DISTANCE, data[7]);=0A=
 			input_report_rel(dev, REL_WHEEL, (signed char) data[6]);=0A=
 =0A=
-			input_report_abs(dev, ABS_X, wacom->x =3D x);=0A=
-			input_report_abs(dev, ABS_Y, wacom->y =3D y);=0A=
+			input_report_abs(dev, ABS_X, x);=0A=
+			input_report_abs(dev, ABS_Y, y);=0A=
 =0A=
 			input_event(dev, EV_MSC, MSC_SERIAL, data[1] & 0x01);=0A=
 			return;=0A=
 	}=0A=
 =0A=
 	if (data[1] & 0x80) {=0A=
-		input_report_abs(dev, ABS_X, wacom->x =3D x);=0A=
-		input_report_abs(dev, ABS_Y, wacom->y =3D y);=0A=
+		input_report_abs(dev, ABS_X, x);=0A=
+		input_report_abs(dev, ABS_Y, y);=0A=
 	}=0A=
 =0A=
 	input_report_abs(dev, ABS_PRESSURE, data[6] | ((__u32)data[7] << 8));=0A=
@@ -236,7 +235,6 @@=0A=
 	struct input_dev *dev =3D &wacom->dev;=0A=
 	unsigned int t;=0A=
 	int idx;=0A=
-	int x, y; =0A=
 =0A=
 	if (urb->status) return;=0A=
 =0A=
@@ -285,11 +283,8 @@=0A=
 		return;=0A=
 	}=0A=
 =0A=
-	x =3D ((__u32)data[2] << 8) | data[3];=0A=
-	y =3D ((__u32)data[4] << 8) | data[5];=0A=
-	=0A=
-	input_report_abs(dev, ABS_X, wacom->x);=0A=
-	input_report_abs(dev, ABS_Y, wacom->y);=0A=
+	input_report_abs(dev, ABS_X, ((__u32)data[2] << 8) | data[3]);=0A=
+	input_report_abs(dev, ABS_Y, ((__u32)data[4] << 8) | data[5]);=0A=
 	input_report_abs(dev, ABS_DISTANCE, data[9] >> 4);=0A=
 	=0A=
 	if ((data[1] & 0xb8) =3D=3D 0xa0) {						/* general pen packet */=0A=

------=_NextPart_000_0058_01C1FBFE.DC9B8850--


