Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWCXOn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWCXOn0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 09:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWCXOn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 09:43:26 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:24741 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751502AbWCXOnZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 09:43:25 -0500
Date: Fri, 24 Mar 2006 09:43:07 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, galak@kernel.crashing.org,
       gregkh@suse.de, bcrl@kvack.org, Dave Jiang <dave.jiang@gmail.com>,
       arjan@infradead.org, Maneesh Soni <maneesh@in.ibm.com>,
       Murali <muralim@in.ibm.com>
Subject: Re: [RFC][PATCH 3/10] 64 bit resources drivers ide changes
Message-ID: <20060324144307.GB4406@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060323195752.GD7175@in.ibm.com> <20060323195944.GE7175@in.ibm.com> <20060323200119.GF7175@in.ibm.com> <20060323200227.GG7175@in.ibm.com> <1143202502.18986.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <1143202502.18986.2.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 24, 2006 at 12:15:01PM +0000, Alan Cox wrote:
> On Iau, 2006-03-23 at 15:02 -0500, Vivek Goyal wrote:
> >  		pci_write_config_dword(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
> > -		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
> > +		printk(KERN_INFO "%s: ROM enabled at 0x%016llx\n", name,
> > +			(unsigned long long)dev->resource[PCI_ROM_RESOURCE].start);
> 
> NAK - if the resource is 64bit then the pci_write_config_dword is also
> insufficient. Ditto for each other example.
> 
> We actually know the PCI resources for these are 32bit so this change
> shouldn't be needed. You might want to stick a (u32) or (unsigned long)
> cast in and leave it at that.
> 

Done. Please find attached the modified patch.

Thanks
Vivek

--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="64bit-resources-drivers-ide-changes.patch"


o Changes required under drivers/ide/* for 64bit resources.

Signed-off-by: Dave Jiang <dave.jiang@gmail.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 drivers/ide/pci/aec62xx.c      |    3 ++-
 drivers/ide/pci/cmd64x.c       |    3 ++-
 drivers/ide/pci/hpt34x.c       |    2 +-
 drivers/ide/pci/pdc202xx_new.c |    4 ++--
 drivers/ide/pci/pdc202xx_old.c |    4 ++--
 5 files changed, 9 insertions(+), 7 deletions(-)

diff -puN drivers/ide/pci/aec62xx.c~64bit-resources-drivers-ide-changes drivers/ide/pci/aec62xx.c
--- linux-2.6.16-mm1/drivers/ide/pci/aec62xx.c~64bit-resources-drivers-ide-changes	2006-03-24 09:07:36.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/ide/pci/aec62xx.c	2006-03-24 09:09:55.000000000 -0500
@@ -254,7 +254,8 @@ static unsigned int __devinit init_chips
 
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
+		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name,
+			(unsigned long)dev->resource[PCI_ROM_RESOURCE].start);
 	}
 
 	if (bus_speed <= 33)
diff -puN drivers/ide/pci/cmd64x.c~64bit-resources-drivers-ide-changes drivers/ide/pci/cmd64x.c
--- linux-2.6.16-mm1/drivers/ide/pci/cmd64x.c~64bit-resources-drivers-ide-changes	2006-03-24 09:07:36.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/ide/pci/cmd64x.c	2006-03-24 09:10:42.000000000 -0500
@@ -609,7 +609,8 @@ static unsigned int __devinit init_chips
 #ifdef __i386__
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
+		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name,
+			(unsigned long)dev->resource[PCI_ROM_RESOURCE].start);
 	}
 #endif
 
diff -puN drivers/ide/pci/hpt34x.c~64bit-resources-drivers-ide-changes drivers/ide/pci/hpt34x.c
--- linux-2.6.16-mm1/drivers/ide/pci/hpt34x.c~64bit-resources-drivers-ide-changes	2006-03-24 09:07:36.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/ide/pci/hpt34x.c	2006-03-24 09:11:17.000000000 -0500
@@ -176,7 +176,7 @@ static unsigned int __devinit init_chips
 			pci_write_config_dword(dev, PCI_ROM_ADDRESS,
 				dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
 			printk(KERN_INFO "HPT345: ROM enabled at 0x%08lx\n",
-				dev->resource[PCI_ROM_RESOURCE].start);
+				(unsigned long)dev->resource[PCI_ROM_RESOURCE].start);
 		}
 		pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0xF0);
 	} else {
diff -puN drivers/ide/pci/pdc202xx_new.c~64bit-resources-drivers-ide-changes drivers/ide/pci/pdc202xx_new.c
--- linux-2.6.16-mm1/drivers/ide/pci/pdc202xx_new.c~64bit-resources-drivers-ide-changes	2006-03-24 09:07:36.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/ide/pci/pdc202xx_new.c	2006-03-24 09:11:57.000000000 -0500
@@ -313,8 +313,8 @@ static unsigned int __devinit init_chips
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
 			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n",
-			name, dev->resource[PCI_ROM_RESOURCE].start);
+		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name,
+			(unsigned long)dev->resource[PCI_ROM_RESOURCE].start);
 	}
 
 #ifdef CONFIG_PPC_PMAC
diff -puN drivers/ide/pci/pdc202xx_old.c~64bit-resources-drivers-ide-changes drivers/ide/pci/pdc202xx_old.c
--- linux-2.6.16-mm1/drivers/ide/pci/pdc202xx_old.c~64bit-resources-drivers-ide-changes	2006-03-24 09:07:36.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/ide/pci/pdc202xx_old.c	2006-03-24 09:12:31.000000000 -0500
@@ -580,8 +580,8 @@ static unsigned int __devinit init_chips
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
 			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n",
-			name, dev->resource[PCI_ROM_RESOURCE].start);
+		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name,
+			(unsigned long)dev->resource[PCI_ROM_RESOURCE].start);
 	}
 
 	/*
_

--JYK4vJDZwFMowpUq--
