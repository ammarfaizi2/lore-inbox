Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319104AbSHSXmB>; Mon, 19 Aug 2002 19:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319105AbSHSXmA>; Mon, 19 Aug 2002 19:42:00 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:35065 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319104AbSHSXl6>; Mon, 19 Aug 2002 19:41:58 -0400
Subject: Re: 2.4.20-pre2-ac4 oops at boot
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Samuel Flory <sflory@rackable.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1029797620.5308.73.camel@flory.corp.rackablelabs.com>
References: <1029797620.5308.73.camel@flory.corp.rackablelabs.com>
Content-Type: multipart/mixed; boundary="=-S/ZPZjtr2auJKUTN6AJV"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 Aug 2002 00:46:18 +0100
Message-Id: <1029800778.21212.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-S/ZPZjtr2auJKUTN6AJV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2002-08-19 at 23:53, Samuel Flory wrote:
>   I've been having problem with the ac kernels, and tyan 2720. (Dual
> xeon E7500 chipset.) Under 2.4.20-pre2-ac4 it spews a bunch of "Trying
> to free nonexistent resource" when initializing the ide interface, and

Those are on my fix list but harmless

> dies.  Under 2.4.19-ac4 the system netboots, but oops when I attempt to
> create a filesystem on a 3ware controller.  Under 2.4.19 the system

2.4.19-ac4 balancing oops is fixed (I turned it off)


> ksymoops 2.4.4 on i686 2.4.20-pre2-ac3.  Options used
>      -v /stuff/src/linux-2.4.20-pre2-ac4/vmlinux (specified)
>      -K (specified)
>      -L (specified)
>      -O (specified)
>      -m /boot/System.map-2.4.20-pre2-ac4 (specified)
> 

Ok random crap code. You had no pci_host_proc_list and that rather upset
things. This converts the failing code it into something resembling same
programming I hope and should fix your boot

Please let me know if it fixes the bug



--=-S/ZPZjtr2auJKUTN6AJV
Content-Disposition: attachment; filename=a1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=a1; charset=ISO-8859-15

--- drivers/ide/ide-proc.c~	2002-08-20 00:48:53.000000000 +0100
+++ drivers/ide/ide-proc.c	2002-08-20 00:48:53.000000000 +0100
@@ -914,11 +914,14 @@
 				proc_ide_read_drivers, NULL);
=20
 #ifdef CONFIG_BLK_DEV_IDEPCI
-	while ((p->name !=3D NULL) && (p->set) && (p->get_info !=3D NULL)) {
-		p->parent =3D proc_ide_root;
-		create_proc_info_entry(p->name, 0, p->parent, p->get_info);
-		p->set =3D 2;
-		if (p->next =3D=3D NULL) return;
+	while (p !=3D NULL)
+	{
+		if (p->name !=3D NULL && p->set && p->get_info !=3D NULL)=20
+		{
+			p->parent =3D proc_ide_root;
+			create_proc_info_entry(p->name, 0, p->parent, p->get_info);
+			p->set =3D 2;
+		}
 		p =3D p->next;
 	}
 #endif /* CONFIG_BLK_DEV_IDEPCI */

--=-S/ZPZjtr2auJKUTN6AJV--
