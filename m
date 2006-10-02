Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965137AbWJBROm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbWJBROm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965139AbWJBROl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:14:41 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:25492 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965131AbWJBROk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:14:40 -0400
Date: Mon, 2 Oct 2006 12:14:38 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: jeff@garzik.org, akpm@osdl.org, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/6]: powerpc/cell spidernet ethtool -i version number info.
Message-ID: <20061002171438.GC4546@austin.ibm.com>
References: <20060929230552.GG6433@austin.ibm.com> <20060929232139.GL6433@austin.ibm.com> <200609301233.45871.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200609301233.45871.arnd@arndb.de>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2006 at 12:33:45PM +0200, Arnd Bergmann wrote:
> Am Saturday 30 September 2006 01:21 schrieb Linas Vepstas:
> >
> >  static int __init spider_net_init(void)
> >  {
> > +       printk("spidernet Version %s.\n",VERSION);
> > +
> 
> This is missing a printk level and a space character. 

Revised patch below.

> More importantly,
> you should not print the presence of the driver to the syslog, but
> the presence of a device driven by it.

Most device drivers seem to print version numbers in the module_init 
routines (i.e. right before calling pci_register_driver), rather than 
in the probe routines; so this patch follows this convention.

--linas

This patch adds version information as reported by
ethtool -i to the Spidernet driver.

From: James K Lewis <jklewis@us.ibm.com>
Signed-off-by: James K Lewis <jklewis@us.ibm.com>
Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>


----
 drivers/net/spider_net.c         |    3 +++
 drivers/net/spider_net.h         |    2 ++
 drivers/net/spider_net_ethtool.c |    2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-09-29 16:44:17.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-02 12:00:15.000000000 -0500
@@ -55,6 +55,7 @@ MODULE_AUTHOR("Utz Bacher <utz.bacher@de
 	      "<Jens.Osterkamp@de.ibm.com>");
 MODULE_DESCRIPTION("Spider Southbridge Gigabit Ethernet driver");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(VERSION);
 
 static int rx_descriptors = SPIDER_NET_RX_DESCRIPTORS_DEFAULT;
 static int tx_descriptors = SPIDER_NET_TX_DESCRIPTORS_DEFAULT;
@@ -2303,6 +2304,8 @@ static struct pci_driver spider_net_driv
  */
 static int __init spider_net_init(void)
 {
+	printk(KERN_INFO "Spidernet version %s.\n", VERSION);
+
 	if (rx_descriptors < SPIDER_NET_RX_DESCRIPTORS_MIN) {
 		rx_descriptors = SPIDER_NET_RX_DESCRIPTORS_MIN;
 		pr_info("adjusting rx descriptors to %i.\n", rx_descriptors);
Index: linux-2.6.18-mm2/drivers/net/spider_net.h
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.h	2006-09-29 16:44:17.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.h	2006-10-02 11:57:32.000000000 -0500
@@ -24,6 +24,8 @@
 #ifndef _SPIDER_NET_H
 #define _SPIDER_NET_H
 
+#define VERSION "1.1 A"
+
 #include "sungem_phy.h"
 
 extern int spider_net_stop(struct net_device *netdev);
Index: linux-2.6.18-mm2/drivers/net/spider_net_ethtool.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net_ethtool.c	2006-09-29 16:33:43.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net_ethtool.c	2006-09-29 16:44:18.000000000 -0500
@@ -76,7 +76,7 @@ spider_net_ethtool_get_drvinfo(struct ne
 	/* clear and fill out info */
 	memset(drvinfo, 0, sizeof(struct ethtool_drvinfo));
 	strncpy(drvinfo->driver, spider_net_driver_name, 32);
-	strncpy(drvinfo->version, "0.1", 32);
+	strncpy(drvinfo->version, VERSION, 32);
 	strcpy(drvinfo->fw_version, "no information");
 	strncpy(drvinfo->bus_info, pci_name(card->pdev), 32);
 }

