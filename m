Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276051AbRI1NsM>; Fri, 28 Sep 2001 09:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276052AbRI1Nrx>; Fri, 28 Sep 2001 09:47:53 -0400
Received: from hermes.toad.net ([162.33.130.251]:27090 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S276051AbRI1Nrs>;
	Fri, 28 Sep 2001 09:47:48 -0400
Message-ID: <3BB47F7F.DE2FD301@mail.com>
Date: Fri, 28 Sep 2001 09:47:43 -0400
From: Thomas Hood <jdthood@mail.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Stelian Pop <stelian.pop@fr.alcove.com>
Subject: Re: PnP BIOS + 2.4.9-ac16 = no boot
Content-Type: multipart/mixed;
 boundary="------------DEE476D6014A04D3A430E450"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DEE476D6014A04D3A430E450
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Stelian:

In -ac15 the PnP BIOS driver was changed so that the proc interface
got the "current" and "boot" configurations the right way 'round.
As a side effect the change made the initialization routine
build its device list from the "current" configuration as opposed
to the "boot" configuration (... which seemed like the right thing
to do at the time, heh heh ... hmmmmm).

You wrote:
> With the patch a third line is printed before the oops:
> 	PnP: PNP BIOS 13 devices detected (or something like that).

The patch I sent you reverted the build_devlist function to looking
at the "boot" configuration.  Your output shows that the devlist
got built this time, which is good.  However you still got an oops,
which is bad.  My guess is that the oops now occurs in pnp_proc_init().
I attach a revised patch which cuts out proc support.  Hopefully
this will allow your kernel to boot.  This is just a hack; I'll
submit a proper fix to Alan later.

Alan (if you're listening): The patches I have already sent you are
still okay to go since they don't affect this issue.  What I need
to do is submit a patch that, for Sony laptops, (1) causes pnpbios
to build its devlist from the "boot" configuration, and (2) omits
the "current" configuration from /proc/bus/pnp.  I'll work on this
tonight.

Stelian: Your report made me go back and look at something Alan
told me earlier about Vaio laptops.  At the time I didn't fully 
understand what he meant when he said:
> If you query the current device status on a Vaio and some other boxes
> using the 32bit API your computer dies horribly shortly afterwards.
I didn't realize that he meant the "current" configuration as
opposed to the "boot" configuration.  Stupid of me.

--
Thomas
P.S. The attached patch is only a temporary hack!
--------------DEE476D6014A04D3A430E450
Content-Type: text/plain; charset=us-ascii;
 name="thood-pnpbiosvaio-patch-20010928-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="thood-pnpbiosvaio-patch-20010928-2"

--- pnp_bios.c_ORIG	Thu Sep 27 15:21:46 2001
+++ pnp_bios.c_vaiofix	Fri Sep 28 09:38:16 2001
@@ -614,11 +614,11 @@
 		pnp_bios_inst_struc = check;
 		break;
 	}
 	pnpbios_build_devlist();
 #ifdef CONFIG_PROC_FS
-	pnp_proc_init();
+	// pnp_proc_init();
 #endif
 #ifdef CONFIG_HOTPLUG	
 	init_completion(&unload_sem);
 	if(kernel_thread(pnp_dock_thread, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL)>0)
 		unloading = 0;
@@ -845,11 +845,11 @@
 	for(i=0;i<0xff;i++) {
 		dev =  kmalloc(sizeof (struct pci_dev), GFP_KERNEL);
 		if (!dev)
 			break;
 			
-                if (pnp_bios_get_dev_node((u8 *)&num, (char )0 , node))
+                if (pnp_bios_get_dev_node((u8 *)&num, (char )1 , node))
 			continue;
 
 		devs++;
 		pnpbios_rawdata_2_pci_dev(node,dev);
 		dev->devfn=num;

--------------DEE476D6014A04D3A430E450--

