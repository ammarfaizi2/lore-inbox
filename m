Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276028AbRI1MaU>; Fri, 28 Sep 2001 08:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276027AbRI1MaK>; Fri, 28 Sep 2001 08:30:10 -0400
Received: from sushi.toad.net ([162.33.130.105]:44489 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S276025AbRI1M3z>;
	Fri, 28 Sep 2001 08:29:55 -0400
Message-ID: <3BB46D3F.E588050E@mail.com>
Date: Fri, 28 Sep 2001 08:29:51 -0400
From: Thomas Hood <jdthood@mail.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PnP BIOS + 2.4.9-ac16 = no boot
Content-Type: multipart/mixed;
 boundary="------------A3E73F8303699F606ACFB9DC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A3E73F8303699F606ACFB9DC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Stelian Pop wrote:
> When booting a 2.4.9-ac16 kernel on my Sony Vaio C1VE laptop
> the boot process hangs with something like:
> 	PnP: PNP BIOS installation structure at 0xc00f8120
> 	PnP: PNP BIOS version 1.0, entry ay f0000:b25f, dseg at 400
> 	general protection fault: 0000
> 	...
> 	Code: Bad EIP value
> 
> Adding nobiospnp to the kernel boot line solves the problem. The last
> -ac kernel I tried (2.4.9-ac10) does not need exhibit this problem.

Between 2.4.9-ac10 and 2.4.9-ac16 two small changes were made to
the PnP BIOS code.  One of them must be the cause of your troubles.

> Since this machine's BIOS is crap anyway (almost entirely ACPI - 
> APM suspend doesn't work etc), is it worth investigating this issue
> or should I blame the BIOS structures once again ?

Initial suspicion may fall on your BIOS.  However, if the
PnP BIOS driver worked before then that means that we ought
to be able to work around any bugs in it.

Please try this patch to drivers/pnp/pnp_bios.c (attached) and get
back to me.

It would be helpful too if you could track down (using printks)
where the fault occurs.

--
Thomas
--------------A3E73F8303699F606ACFB9DC
Content-Type: text/plain; charset=us-ascii;
 name="thood-pnpbiosvaio-patch-20010928-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="thood-pnpbiosvaio-patch-20010928-1"

--- pnp_bios.c_ORIG	Thu Sep 27 15:21:46 2001
+++ pnp_bios.c_vaiofix	Fri Sep 28 08:24:39 2001
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


--------------A3E73F8303699F606ACFB9DC--

