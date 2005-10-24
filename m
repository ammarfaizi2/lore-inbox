Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbVJXSHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbVJXSHQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 14:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVJXSHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 14:07:15 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:56505 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751212AbVJXSHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 14:07:13 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: "Jiri Slaby" <xslaby@fi.muni.cz>
Subject: Re: [PATCH] rocketport: make it work when statically linked into kernel
Date: Mon, 24 Oct 2005 12:06:57 -0600
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Wolfgang Denk <wd@denx.de>,
       support@comtrol.com, Andrew Morton <akpm@osdl.org>
References: <20051024174748.5B92822AEEF@anxur.fi.muni.cz>
In-Reply-To: <20051024174748.5B92822AEEF@anxur.fi.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510241206.57823.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 October 2005 11:47 am, Jiri Slaby wrote:
> >The driver had incorrectly wrapped module_init(rp_init) in #ifdef MODULE,
> >so it worked only when compiled as a module.
> >
> [snip]
> >
> >I also added the Comtrol support email address to MAINTAINERS.
> Nope, the e-mail in fact doesn't exist, I (or somebody?) removed it from
> MAINTAINERS.
> [They'll send you, that you can use web interface as an automatic answer.]

Yeah, you're right.  I got the same automated response to my post,
though the web site still mentions the email address.

I don't think a lame web-only contact should really qualify as
"maintained" though.  Anyway, attached is the same patch without
the MAINTAINERS update.




The driver had incorrectly wrapped module_init(rp_init) in #ifdef MODULE,
so it worked only when compiled as a module.

Tested by Wolfgang Denk with this device:

    00:0e.0 Communication controller: Comtrol Corporation RocketPort 8 port w/RJ11 connectors (rev 04)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 7000 [size=64]

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: denk/drivers/char/rocket.c
===================================================================
--- denk.orig/drivers/char/rocket.c	2005-10-24 10:49:03.000000000 -0600
+++ denk/drivers/char/rocket.c	2005-10-24 10:49:04.000000000 -0600
@@ -256,7 +256,6 @@
 static int sReadAiopID(ByteIO_t io);
 static int sReadAiopNumChan(WordIO_t io);
 
-#ifdef MODULE
 MODULE_AUTHOR("Theodore Ts'o");
 MODULE_DESCRIPTION("Comtrol RocketPort driver");
 module_param(board1, ulong, 0);
@@ -288,17 +287,14 @@
 module_param_array(pc104_4, ulong, NULL, 0);
 MODULE_PARM_DESC(pc104_4, "set interface types for ISA(PC104) board #4 (e.g. pc104_4=232,232,485,485,...");
 
-int rp_init(void);
+static int rp_init(void);
 static void rp_cleanup_module(void);
 
 module_init(rp_init);
 module_exit(rp_cleanup_module);
 
-#endif
 
-#ifdef MODULE_LICENSE
 MODULE_LICENSE("Dual BSD/GPL");
-#endif
 
 /*************************************************************************/
 /*                     Module code starts here                           */
@@ -2378,7 +2374,7 @@
 /*
  * The module "startup" routine; it's run when the module is loaded.
  */
-int __init rp_init(void)
+static int __init rp_init(void)
 {
 	int retval, pci_boards_found, isa_boards_found, i;
 
@@ -2502,7 +2498,6 @@
 	return 0;
 }
 
-#ifdef MODULE
 
 static void rp_cleanup_module(void)
 {
@@ -2530,7 +2525,6 @@
 	if (controller)
 		release_region(controller, 4);
 }
-#endif
 
 /***************************************************************************
 Function: sInitController
