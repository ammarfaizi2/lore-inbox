Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313346AbSDJRY4>; Wed, 10 Apr 2002 13:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313355AbSDJRY4>; Wed, 10 Apr 2002 13:24:56 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:14478 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S313346AbSDJRYz>; Wed, 10 Apr 2002 13:24:55 -0400
Date: Wed, 10 Apr 2002 10:23:12 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: 2.5.8-pre3: kernel BUG at usb.c:849!
 (preempt_count 1)
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: Kernel List <linux-kernel@vger.kernel.org>, rml@tech9.net,
        linux-usb-devel@lists.sourceforge.net,
        Johannes Erdfelt <johannes@erdfelt.com>
Message-id: <071e01c1e0b4$64f382e0$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: multipart/mixed; boundary="Boundary_(ID_0Jmv8O7EOzICJMIntLc7DA)"
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <E16vHsQ-0000Jy-00@baldrick> <20020410114144.N8314@sventech.com>
 <06da01c1e0ae$69106ce0$6800000a@brownell.org> <E16vLJx-00028n-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_0Jmv8O7EOzICJMIntLc7DA)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT

> > And what usb device driver(s) were supposed to have stopped
> > using "device 3"?  I've only noticed such device refcounting bugs
> > being caused by the USB device drivers with bad disconnect()
> > routines, not usbcore or any of the host controller drivers, but of
> > course that can change.
> 
> Ha!
> 
> $ cat /proc/bus/usb/drivers
>          usbfs
>          hub
> 
> There are no other drivers!  I have a USB webcam and a modem
> ... has a user space driver that works via usbfs.

... OK, this is sounding familiar.  "usbfs" has some recently noted
bugs in its disconnect() routine.  That SpeedTouch driver seems to
be triggering them with regularity, though more often with usb-ohci.

The ksymoops info you sent is compatible with the bug being in
the usbfs code:  exactly what I'd expect such a BUG() to show.

I hate to send around untested patches, but I think the one I've
attached is at least in the right direction.  (Attachment, to avoid
mangling by mailers...)  It's an update of what I sent around late
last month to address someone's SpeedTouch oopsing with
usb-ohci (!) on 2.4.19-pre2, redone against 2.5.8-pre3, which
compiles.  I hope it doesn't create new oopses.

If it works for you, let us know ...

- Dave



--Boundary_(ID_0Jmv8O7EOzICJMIntLc7DA)
Content-type: application/octet-stream; name=devio-0410.patch
Content-transfer-encoding: quoted-printable
Content-disposition: attachment; filename=devio-0410.patch

--- drivers/usb-dist/core/devio.c	Sat Apr  6 15:12:31 2002=0A=
+++ drivers/usb/core/devio.c	Wed Apr 10 10:11:38 2002=0A=
@@ -297,7 +297,9 @@=0A=
 }=0A=
 =0A=
 /*=0A=
- * interface claiming=0A=
+ * interface claims are made only at the request of user level code,=0A=
+ * which can also release them (explicitly or by closing files).=0A=
+ * they're also undone when devices disconnect.=0A=
  */=0A=
 =0A=
 static void *driver_probe(struct usb_device *dev, unsigned int intf,=0A=
@@ -310,8 +312,20 @@=0A=
 {=0A=
 	struct dev_state *ps =3D (struct dev_state *)context;=0A=
 =0A=
-	if (ps)=0A=
-		ps->ifclaimed =3D 0;=0A=
+	if (!ps)=0A=
+		return;=0A=
+=0A=
+	/* this waits till synchronous requests complete */=0A=
+	down_write (&ps->devsem);=0A=
+=0A=
+	/* prevent new I/O requests */=0A=
+	ps->dev =3D 0;=0A=
+	ps->ifclaimed =3D 0;=0A=
+=0A=
+	/* force async requests to complete */=0A=
+	destroy_all_async (ps);=0A=
+=0A=
+	up_write (&ps->devsem);=0A=
 }=0A=
 =0A=
 struct usb_driver usbdevfs_driver =3D {=0A=

--Boundary_(ID_0Jmv8O7EOzICJMIntLc7DA)--
