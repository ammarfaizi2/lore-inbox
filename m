Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVEQPzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVEQPzE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 11:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVEQPum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 11:50:42 -0400
Received: from graphe.net ([209.204.138.32]:16138 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261746AbVEQPsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 11:48:33 -0400
Date: Tue, 17 May 2005 08:48:16 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: "Sy, Dely L" <dely.l.sy@intel.com>
cc: Greg KH <greg@kroah.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       shai@scalex86.org, torvalds@osdl.org
Subject: [PATCH] fix memory scribble in arch/i386/pci/fixup.c
In-Reply-To: <468F3FDA28AA87429AD807992E22D07E054DA776@orsmsx408>
Message-ID: <Pine.LNX.4.62.0505170846330.8002@graphe.net>
References: <468F3FDA28AA87429AD807992E22D07E054DA776@orsmsx408>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2005, Sy, Dely L wrote:

> On Friday, May 13, 2005 3:36 PM, Greg KH wrote:
> > > The definition of GET_INDEX is suspect:
> > > 
> > > #define GET_INDEX(a, b) (((a - PCI_DEVICE_ID_INTEL_MCH_PA) << 3) + b)
> > > should this not be
> > > #define GET_INDEX(a, b) ((((a) - PCI_DEVICE_ID_INTEL_MCH_PA) << 3) + \
> > > 				((b) & 7))
> > Dely, any thoughts about this, or know who would know about it?
> 
> I looked at the code and talked with Steve on this.  The fix is correct;
> i.e. b has to be masked with 7.  Would Christoph or you send out a 
> patch for the fix or would you like us to do so?  Thanks for finding out
> the problem.

Ok. Here is the patch:

Index: linux-2.6.12-rc4/arch/i386/pci/fixup.c
===================================================================
--- linux-2.6.12-rc4.orig/arch/i386/pci/fixup.c	2005-05-12 16:39:39.000000000 +0000
+++ linux-2.6.12-rc4/arch/i386/pci/fixup.c	2005-05-17 15:45:05.000000000 +0000
@@ -253,7 +253,7 @@
 #define MAX_PCIEROOT	6
 static int quirk_aspm_offset[MAX_PCIEROOT << 3];
 
-#define GET_INDEX(a, b) (((a - PCI_DEVICE_ID_INTEL_MCH_PA) << 3) + b)
+#define GET_INDEX(a, b) ((((a) - PCI_DEVICE_ID_INTEL_MCH_PA) << 3) + ((b) & 7))
 
 static int quirk_pcie_aspm_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
