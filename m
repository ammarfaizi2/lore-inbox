Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265789AbUAUQEh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 11:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbUAUQEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 11:04:37 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:54992 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S265789AbUAUQEb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 11:04:31 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: kgdb 2.0.5
Date: Wed, 21 Jan 2004 21:34:21 +0530
User-Agent: KMail/1.5
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>, Steve Gonczi <steve@relicore.com>,
       Matt Mackall <mpm@selenic.com>, Jeff Garzik <jgarzik@mandrakesoft.com>
References: <200401201743.39640.amitkale@emsyssoft.com> <20040120203529.GC9691@elf.ucw.cz>
In-Reply-To: <20040120203529.GC9691@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401212134.21532.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 Jan 2004 2:05 am, Pavel Machek wrote:
> Hi!
>
> > kgdb 2.0.5 is available at
> > http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.0.5.tar.bz2
> >
> > ChangeLog
> > 2004-01-20 Amit S. Kale <amitkale@emsyssoft.com>
> >         * Created a ring buffer for kgdb ethernet packets. Several
> >         fixes and changes to kgdb on ethernet.
> >
> > 2004-01-20 TimeSys Corporation
> >         * Fixed a problem with not responding to Ctrl+C during priting of
> >         console messages through gdb.
> >
> > I have pasted below eth.patch for review. When using the ethernet
> > interface, gdb times out several times. It receives packets and junk
> > instead of acks. I see following type of messages out of 8139too.c on the
> > console
> > "eth0:Out-of-sync dirty pointer, 15 vs. 20."
> >
> > Any comments/suggestions/fixes on this patch are most welcome.
>
> Okay, so you wanted comments :-)

Done.
These will appear in 2.0.6

>
>
> @@ -2031,12 +2031,14 @@
>   obj-$(CONFIG_VORTEX) += 3c59x.o
>  Index: linux/drivers/net/kgdb_eth.c
>  ===================================================================
> ---- linux.orig/drivers/net/kgdb_eth.c	2004-01-17 14:58:20.000000000 +0100
> -+++ linux/drivers/net/kgdb_eth.c	2004-01-17 14:58:20.000000000 +0100
> -@@ -0,0 +1,588 @@
> +--- linux.orig/drivers/net/kgdb_eth.c	2004-01-20 14:29:19.000000000 +0100
> ++++ linux/drivers/net/kgdb_eth.c	2004-01-20 14:29:19.000000000 +0100
> +@@ -0,0 +1,704 @@
>  +/*
>  + * Network interface GDB stub
>  + *
> ++ * Copyright (C), 2004 Amit S. Kale
> ++ *
>  + * Written by San Mehat (nettwerk@biodome.org)
>  + * Based upon 'gdbserial' by David Grothe (dave@gcom.com)
>  + * and Scott Foehner (sfoehner@engr.sgi.com)
> @@ -2045,6 +2047,8 @@
>  + * and wangdi <wangdi@clusterfs.com>.
>  + *
>  + * Restructured for generic a gdb interface
> ++ * Reveral changes to make it free of device driver changes.
> ++ * Added internal buffers for this interface.
>  + * 	by Amit S. Kale <amitkale@emsyssoft.com>
>  + * Some cleanups by Pavel Machek <pavel@suse.cz>
>  + */
> @@ -2100,9 +2104,107 @@
>  +static int		kgdbeth_sendbufchars;
>  +static irqreturn_t	(*kgdbeth_irqhandler)(int, void *, struct pt_regs *) =
> NULL; +
> -+int		kgdbeth_is_trapped;
>  +struct net_device *kgdb_netdevice = NULL;
>  +
> ++/* Indicates dept of recursion for xmitlock hold */
> ++static int xlockholdcount = 0;
>
> This should be xlock_hold_count according to CodingStyle.
>
> ++/* Holds xmitlock of the ethernet device
> ++ * Recursive calls allowed */
> ++static void kgdbeth_holdxlock(void)
> ++{
>
> Why not calling it simply kgdbeth_lock()?
>
> ++	if (spin_is_locked(&kgdb_netdevice->xmit_lock)) {
> ++		if (kgdb_netdevice->xmit_lock_owner == smp_processor_id()) {
> ++			goto gotit;
> ++		}
> ++	}
> ++	spin_lock(&kgdb_netdevice->xmit_lock);
> ++	kgdb_netdevice->xmit_lock_owner = smp_processor_id();
> ++
> ++gotit:
> ++	xlockholdcount++;
> ++}
> ++
> ++/* releases xmitlock of the ethernet device
> ++ * Recursive calls allowed */
> ++static void kgdbeth_relxlock(void)
>
> kgdbeth_unlock()?
>
>  +int
>  +kgdbeth_hook(void)
>  +{
> -+	char kgdb_netdev[16];
>  +	extern void kgdb_respond_ok(void);
>  +	struct irqaction *ia_ptr;
> ++	int i;
>  +
> -+	sprintf(kgdb_netdev, "eth%d", kgdb_eth);
> ++	sprintf(kgdb_netdevname, "eth%d", kgdb_eth);
>
> kgdb_netdev_name?
>
> @@ -2183,11 +2283,11 @@
>  +	memcpy(eth->h_source, kgdb_localmac, kgdb_netdevice->addr_len);
>  +	memcpy(eth->h_dest, kgdb_remotemac, kgdb_netdevice->addr_len);
>  +
> -+	spin_lock(&kgdb_netdevice->xmit_lock);
> -+	kgdb_netdevice->xmit_lock_owner = smp_processor_id();
>  +	kgdb_netdevice->hard_start_xmit(skb, kgdb_netdevice);
> -+	kgdb_netdevice->xmit_lock_owner = -1;
> -+	spin_unlock(&kgdb_netdevice->xmit_lock);
> ++	if (atomic_read(&skb->users) != 1) {
> ++		BUG();
> ++	}
> ++	kgdbeth_relxlock();
>  +}
>  +
>  +static void kgdbeth_flush(void)
>
> BUG_ON(atomic_read() != 1)?
>
> 								Pavel

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

