Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbULQUwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbULQUwh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 15:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbULQUwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 15:52:36 -0500
Received: from mproxy.gmail.com ([216.239.56.242]:10092 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262155AbULQUwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 15:52:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=a5/7geLSjaTrlhi/+Ej3YXIJbS23dqFrwvOOhBrqR0e4RuWJlAerm+skuXBqoAUl9UEMpWy6pUtKQNCipvJmrHrt9KtrGrDKmMYACGgmRFZ1P6/Byzl/UQhu4B5rZRP/fLhVGDFknqIr/RTA75MtlB36C8czXCuD/3dl/GlBX80=
Message-ID: <8924577504121712527144a5cf@mail.gmail.com>
Date: Fri, 17 Dec 2004 14:52:11 -0600
From: Jon Mason <jdmason@gmail.com>
Reply-To: Jon Mason <jdmason@gmail.com>
To: Richard Ems <richard.ems@mtg-marinetechnik.de>
Subject: Re: PROBLEM: Network hang: "eth0: Tx timed out (f0080), is buffer full?" (Plain)
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <8924577504121710054331bb54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_129_31422703.1103316731896"
References: <200412171100.16601.richard.ems@mtg-marinetechnik.de>
	 <89245775041217090726eb2751@mail.gmail.com>
	 <41C31421.7090102@mtg-marinetechnik.de>
	 <8924577504121710054331bb54@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_129_31422703.1103316731896
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Richard,
Please give the patch below a try (I've also attached it for you
convienance), and send me the dmesg output from the next time you hit
the error.

--- dl2k.c      2004-09-10 10:46:34.000000000 -0500
+++ /tmp/dl2k.c 2004-12-17 14:37:40.644124080 -0600
@@ -565,8 +565,9 @@ rio_tx_timeout (struct net_device *dev)
 {
        long ioaddr =3D dev->base_addr;

-       printk (KERN_INFO "%s: Tx timed out (%4.4x), is buffer full?\n",
-               dev->name, readl (ioaddr + TxStatus));
+       printk (KERN_INFO "%s: Tx timed out (%4.4x) %d %d %x %x\n",
+               dev->name, readl (ioaddr + TxStatus), np->cur_tx, np->cur_r=
x,
+               readl (ioaddr + DMACtrl), readw(ioaddr + IntEnable));
        rio_free_tx(dev, 0);
        dev->if_port =3D 0;
        dev->trans_start =3D jiffies;
@@ -1007,8 +1008,9 @@ rio_error (struct net_device *dev, int i
        /* PCI Error, a catastronphic error related to the bus interface
           occurs, set GlobalReset and HostReset to reset. */
        if (int_status & HostError) {
-               printk (KERN_ERR "%s: HostError! IntStatus %4.4x.\n",
-                       dev->name, int_status);
+               printk (KERN_ERR "%s: HostError! IntStatus %4.4x. %d
%d %x %x\n",
+                       dev->name, int_status, np->cur_tx, np->cur_rx,
+                       readl (ioaddr + DMACtrl), readw(ioaddr + IntEnable)=
);
                writew (GlobalReset | HostReset, ioaddr + ASICCtrl + 2);
                mdelay (500);
        }


On Fri, 17 Dec 2004 12:05:21 -0600, Jon Mason <jdmason@gmail.com> wrote:
> It seems to me that the driver does not re-enable interrupts or the
> transmit and receive engines after it resets the adapter because of
> the PCI bus error.
>=20
> So, I would like to provide you with a patch which will log the state
> of these registers after the adapter reset and during the transmit
> timeout events to dmesg.  If you do not have the kernel source
> available, I can try and compile the module for you (it will just take
> a bit longer, as I will have to find the SuSE 9.2 source).
>=20
> Thanks,
> Jon
>=20
> On Fri, 17 Dec 2004 18:15:13 +0100, Richard Ems
> <richard.ems@mtg-marinetechnik.de> wrote:
> > Jon Mason wrote:
> > > It seems to me the cause of the tx timeouts is the "HostError", which
> > > is a PCI bus error.  This most likely caused the adapter to hang and
> > > then the transmits started timing out.
> > >
> > > As far as I can tell, the dl2k driver code is common between 2.4 and
> > > 2.6.  So, some other change in the kernel is causing the driver to
> > > behave differently and expose this problem.
> > >
> > > I am not the maintainer, but I can try to assist you. However, it wil=
l
> > > require running debug drivers (as I am not able to find any
> > > documentation on this adapter).  If you are not willing or able to do
> > > this, then I would suggest going back to the 2.4 kernel.
> >
> > Ok, yes, I'm willing to try your debug drivers. We'll see if I'm also
> > able ;-)
> >
> > What shall I do?
> >
> > Thanks ,Richard
> >
> > --
> > Richard Ems
> >
> > MTG Marinetechnik GmbH
> > Wandsbeker K=F6nigstr. 62
> > 22041 Hamburg
> > Telefon: +49 40 65803 312
> > TeleFax: +49 40 65803 392
> > mail: richard.ems@mtg-marinetechnik.de
> >
> >
>

------=_Part_129_31422703.1103316731896
Content-Type: text/x-patch; name="dl2k.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="dl2k.patch"

--- dl2k.c=092004-09-10 10:46:34.000000000 -0500
+++ /tmp/dl2k.c=092004-12-17 14:37:40.644124080 -0600
@@ -565,8 +565,9 @@ rio_tx_timeout (struct net_device *dev)
 {
 =09long ioaddr =3D dev->base_addr;
=20
-=09printk (KERN_INFO "%s: Tx timed out (%4.4x), is buffer full?\n",
-=09=09dev->name, readl (ioaddr + TxStatus));
+=09printk (KERN_INFO "%s: Tx timed out (%4.4x) %d %d %x %x\n",
+=09=09dev->name, readl (ioaddr + TxStatus), np->cur_tx, np->cur_rx,=20
+=09=09readl (ioaddr + DMACtrl), readw(ioaddr + IntEnable));
 =09rio_free_tx(dev, 0);
 =09dev->if_port =3D 0;
 =09dev->trans_start =3D jiffies;
@@ -1007,8 +1008,9 @@ rio_error (struct net_device *dev, int i
 =09/* PCI Error, a catastronphic error related to the bus interface=20
 =09   occurs, set GlobalReset and HostReset to reset. */
 =09if (int_status & HostError) {
-=09=09printk (KERN_ERR "%s: HostError! IntStatus %4.4x.\n",
-=09=09=09dev->name, int_status);
+=09=09printk (KERN_ERR "%s: HostError! IntStatus %4.4x. %d %d %x %x\n",
+=09=09=09dev->name, int_status, np->cur_tx, np->cur_rx,=20
+=09=09=09readl (ioaddr + DMACtrl), readw(ioaddr + IntEnable));
 =09=09writew (GlobalReset | HostReset, ioaddr + ASICCtrl + 2);
 =09=09mdelay (500);
 =09}

------=_Part_129_31422703.1103316731896--
