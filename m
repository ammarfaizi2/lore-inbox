Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVCHXWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVCHXWL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 18:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVCHXV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 18:21:58 -0500
Received: from isilmar.linta.de ([213.239.214.66]:27867 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262176AbVCHXQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:16:42 -0500
Date: Wed, 9 Mar 2005 00:16:36 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: jt@hpl.hp.com, linux-pcmcia@lists.infradead.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: PCMCIA product id strings -> hashes generation at compilation time? [Was: Re: [patch 14/38] pcmcia: id_table for wavelan_cs]
Message-ID: <20050308231636.GA20658@isilmar.linta.de>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, jt@hpl.hp.com,
	linux-pcmcia@lists.infradead.org,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>
References: <20050307232339.GA30057@isilmar.linta.de> <20050308191138.GA16169@isilmar.linta.de> <20050308123426.249fa934.akpm@osdl.org> <20050227161308.GO7351@dominikbrodowski.de> <20050307225355.GB30371@bougret.hpl.hp.com> <20050307230102.GA29779@isilmar.linta.de> <20050307150957.0456dd75.akpm@osdl.org> <20050307232339.GA30057@isilmar.linta.de> <20050308191138.GA16169@isilmar.linta.de> <Pine.LNX.4.58.0503081438040.13251@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308123426.249fa934.akpm@osdl.org> <Pine.LNX.4.58.0503081438040.13251@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> >
> > Most pcmcia devices are matched to drivers using "product ID strings"
> >  embedded in the devices' Card Information Structures, as "manufactor ID /
> >  card ID" matches are much less reliable. Unfortunately, these strings cannot
> >  be passed to userspace for easy userspace-based loading of appropriate
> >  modules (MODNAME -- hotplug), so my suggestion is to also store crc32 hashes
> >  of the strings in the MODULE_DEVICE_TABLEs, e.g.:
> > 
> >  PCMCIA_DEVICE_PROD_ID12("LINKSYS", "E-CARD", 0xf7cb0b07, 0x6701da11),
> 
> What is the difficulty in passing these strings via /sbin/hotplug arguments?

The difficulty is that extracting and evaluating them breaks the wonderful 
bus-independent MODNAME implementation for hotplug suggested by Roman Kagan
( http://article.gmane.org/gmane.linux.hotplug.devel/7039 ), and that these
strings may contain spaces and other "strange" characters. The latter may be 
worked around, but the former cannot. /etc/hotplug/pcmcia.agent looks really
clean because of this MODNAME implementation:

#!/bin/sh

cd /etc/hotplug
. ./hotplug.functions

if [ "$ACTION" = "" ]; then
    mesg Bad PCMCIA agent invocation, no action
    exit 1
fi

case $ACTION in

add)
        modprobe $MODNAME

	... work around some exotic buggy PCMCIA hardware ...
...

and I would very much like to avoid breaking the line "modprobe $MODNAME".

On Tue, Mar 08, 2005 at 02:54:57PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 8 Mar 2005, Dominik Brodowski wrote:
> >
> >				 Unfortunately, these strings cannot
> > be passed to userspace for easy userspace-based loading of appropriate
> > modules (MODNAME -- hotplug), so my suggestion is to also store crc32 hashes
> > of the strings in the MODULE_DEVICE_TABLEs, e.g.:
> > 
> > PCMCIA_DEVICE_PROD_ID12("LINKSYS", "E-CARD", 0xf7cb0b07, 0x6701da11),
> 
> Hmm.. I'm with Andrew on this one - I'd much rather really pass them to 
> user space as strings. We already pass a number of strings as environment 
> variables.
> 
> In fact, what's wrong with DEVPATH? Which we already expose as the
> NAME=xxx environment variable. So if the kboject associated with a device
> has has this string associated with its name (which it should)
drivers/base/core.c::device_add()
        kobject_set_name(&dev->kobj, "%s", dev->bus_id);
and the bus_id isn't the device's name for common buses.

Nontheless, the strings _are_ exported at DEVPATH/prod_id[1-4], but for the
reasons mentioned above I'd prefer not to use them.


On Tue, Mar 08, 2005 at 12:34:26PM -0800, Andrew Morton wrote:
> > ...
> >  To make the life easier for device driver authors,
> >  	- a big warning is put into dmesg if a pcmcia driver is inserted
> >  	  into the kernel and the hash mentioned in PCMCIA_DEVICE_PROD_ID()
> >  	  is incorrect,
> 
> As long as the kernel shouts loudly at the driver developer at
> development-time, and that shouting mentions a bit of documentation in
> Documentation/somewhere, I expect we'll be OK.

Andrew, please apply this patch on top of 2.6.11-mm2, if you and Linus still
agree:


Add some information useful for PCMCIA device driver authors to
Documentation/pcmcia/, and reference it in dmesg in case of hash mismatches.

Also add a reference to pcmciautils to Documentation/Changes. With recent
changes, you don't need to concern yourself with pcmcia-cs even if you have 
PCMCIA hardware, so the example above the list needed to be adapted as well.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowksi.net>
Index: 2.6.11+/Documentation/Changes
===================================================================
--- 2.6.11+.orig/Documentation/Changes	2005-03-08 23:23:30.000000000 +0100
+++ 2.6.11+/Documentation/Changes	2005-03-08 23:23:33.000000000 +0100
@@ -44,9 +44,9 @@
 
 Again, keep in mind that this list assumes you are already
 functionally running a Linux 2.4 kernel.  Also, not all tools are
-necessary on all systems; obviously, if you don't have any PCMCIA (PC
-Card) hardware, for example, you probably needn't concern yourself
-with pcmcia-cs.
+necessary on all systems; obviously, if you don't have any ISDN
+hardware, for example, you probably needn't concern yourself with 
+isdn4k-utils.
 
 o  Gnu C                  2.95.3                  # gcc --version
 o  Gnu make               3.79.1                  # make --version
@@ -57,6 +57,7 @@
 o  jfsutils               1.1.3                   # fsck.jfs -V
 o  reiserfsprogs          3.6.3                   # reiserfsck -V 2>&1|grep reiserfsprogs
 o  xfsprogs               2.6.0                   # xfs_db -V
+o  pcmciautils            001
 o  pcmcia-cs              3.1.21                  # cardmgr -V
 o  quota-tools            3.09                    # quota -V
 o  PPP                    2.4.0                   # pppd --version
@@ -186,13 +187,20 @@
 work correctly with this version of the XFS kernel code (2.6.0 or
 later is recommended, due to some significant improvements).
 
+PCMCIAutils
+-----------
+
+PCMCIAutils replaces pcmcia-cs (see below). It properly sets up
+PCMCIA sockets at system startup and loads the appropriate modules 
+for 16-bit PCMCIA devices if the kernel is modularized and the hotplug
+subsystem is used.
 
 Pcmcia-cs
 ---------
 
 PCMCIA (PC Card) support is now partially implemented in the main
-kernel source.  Pay attention when you recompile your kernel ;-).
-Also, be sure to upgrade to the latest pcmcia-cs release.
+kernel source. The "pcmciautils" package (see above) replaces pcmcia-cs
+for newest kernels.
 
 Quota-tools
 -----------
@@ -349,9 +357,13 @@
 --------
 o  <ftp://oss.sgi.com/projects/xfs/download/>
 
+Pcmciautils
+-----------
+o  <ftp://ftp.kernel.org/pub/linux/utils/kernel/pcmcia/>
+
 Pcmcia-cs
 ---------
-o  <ftp://pcmcia-cs.sourceforge.net/pub/pcmcia-cs/pcmcia-cs-3.1.21.tar.gz>
+o  <http://pcmcia-cs.sourceforge.net/>
 
 Quota-tools
 ----------
Index: 2.6.11+/Documentation/pcmcia/devicetable.txt
===================================================================
--- 2.6.11+.orig/Documentation/pcmcia/devicetable.txt	2005-03-08 22:41:21.540138608 +0100
+++ 2.6.11+/Documentation/pcmcia/devicetable.txt	2005-03-08 23:57:46.000000000 +0100
@@ -0,0 +1,64 @@
+Matching of PCMCIA devices to drivers is done using one or more of the 
+following criteria:
+
+- manufactor ID
+- card ID
+- product ID strings _and_ hashes of these strings
+- function ID
+- device function (actual and pseudo)
+
+You should use the helpers in include/pcmcia/device_id.h for generating the
+struct pcmcia_device_id[] entries which match devices to drivers.
+
+If you want to match product ID strings, you also need to pass the crc32
+hashes of the string to the macro, e.g. if you want to match the product ID
+string 1, you need to use
+
+PCMCIA_DEVICE_PROD_ID1("some_string", 0x(hash_of_some_string)),
+
+If the hash is incorrect, the kernel will inform you about this in "dmesg"
+upon module initialization, and tell you of the correct hash.
+
+You can determine the hash of the product ID strings by running
+"pcmcia-modalias %n.%m" [%n being replaced with the socket number and %m being
+replaced with the device function] from pcmciautils. It generates a string
+in the following form:
+pcmcia:m0149cC1ABf06pfn00fn00pa725B842DpbF1EFEE84pc0877B627pd00000000
+
+The hex value after "pa" is the hash of product ID string 1, after "pb" for
+string 2 and so on.
+
+Alternatively, you can use this small tool to determine the crc32 hash.
+simply pass the string you want to evaluate as argument to this program,
+e.g. 
+$ ./crc32hash "Dual Speed"
+
+-------------------------------------------------------------------------
+/* crc32hash.c - derived from linux/lib/crc32.c, GNU GPL v2 */
+#include <string.h>
+#include <stdio.h>
+#include <ctype.h>
+#include <stdlib.h>
+
+unsigned int crc32(unsigned char const *p, unsigned int len)
+{
+	int i;
+	unsigned int crc = 0;
+	while (len--)
+		crc ^= *p++;
+		for (i = 0; i < 8; i++)
+			crc = (crc >> 1) ^ ((crc & 1) ? 0xedb88320 : 0);
+	}
+	return crc;
+}
+
+int main(int argc, char **argv) {
+	unsigned int result;
+	if (argc != 2) {
+		printf("no string passed as argument\n");
+		return -1;
+	}
+	result = crc32(argv[1], strlen(argv[1]));
+	printf("0x%x\n", result);
+	return 0;
+}
Index: 2.6.11+/Documentation/pcmcia/driver-changes.txt
===================================================================
--- 2.6.11+.orig/Documentation/pcmcia/driver-changes.txt	2005-03-08 22:41:21.540138608 +0100
+++ 2.6.11+/Documentation/pcmcia/driver-changes.txt	2005-03-09 00:01:07.000000000 +0100
@@ -0,0 +1,51 @@
+This file details changes in 2.6 which affect PCMCIA card driver authors:
+
+* in-kernel device<->driver matching
+   PCMCIA devices and their correct drivers can now be matched in
+   kernelspace. See 'devicetable.txt' for details.
+
+* Device model integration (as of 2.6.11)
+   A struct pcmcia_device is registered with the device model core,
+   and can be used (e.g. for SET_NETDEV_DEV) by using
+   handle_to_dev(client_handle_t * handle).
+
+* Convert internal I/O port addresses to unsigned long (as of 2.6.11)
+   ioaddr_t should be replaced by kio_addr_t in PCMCIA card drivers.
+
+* irq_mask and irq_list parameters (as of 2.6.11)
+   The irq_mask and irq_list parameters should no longer be used in
+   PCMCIA card drivers. Instead, it is the job of the PCMCIA core to
+   determine which IRQ should be used. Therefore, link->irq.IRQInfo2
+   is ignored.
+
+* client->PendingEvents is gone (as of 2.6.11)
+   client->PendingEvents is no longer available.
+
+* client->Attributes are gone (as of 2.6.11)
+   client->Attributes is unused, therefore it is removed from all
+   PCMCIA card drivers
+
+* core functions no longer available (as of 2.6.11)
+   The following functions have been removed from the kernel source
+   because they are unused by all in-kernel drivers, and no external
+   driver was reported to rely on them:
+	pcmcia_get_first_region()
+	pcmcia_get_next_region()
+	pcmcia_modify_window()
+	pcmcia_set_event_mask()
+	pcmcia_get_first_window()
+	pcmcia_get_next_window()
+
+* device list iteration upon module removal (as of 2.6.10)
+   It is no longer necessary to iterate on the driver's internal
+   client list and call the ->detach() function upon module removal.
+
+* Resource management. (as of 2.6.8)
+   Although the PCMCIA subsystem will allocate resources for cards,
+   it no longer marks these resources busy. This means that driver
+   authors are now responsible for claiming your resources as per
+   other drivers in Linux. You should use request_region() to mark
+   your IO regions in-use, and request_mem_region() to mark your
+   memory regions in-use. The name argument should be a pointer to
+   your driver name. Eg, for pcnet_cs, name should point to the
+   string "pcnet_cs".
Index: 2.6.11+/drivers/pcmcia/ds.c
===================================================================
--- 2.6.11+.orig/drivers/pcmcia/ds.c	2005-03-08 23:23:30.000000000 +0100
+++ 2.6.11+/drivers/pcmcia/ds.c	2005-03-08 23:59:01.000000000 +0100
@@ -262,8 +262,6 @@
 }
 EXPORT_SYMBOL(cs_error);
 
-#ifdef CONFIG_PCMCIA_DEBUG
-
 
 static void pcmcia_check_driver(struct pcmcia_driver *p_drv)
 {
@@ -284,6 +282,9 @@
 			       "product string \"%s\": is 0x%x, should "
 			       "be 0x%x\n", p_drv->drv.name, did->prod_id[i],
 			       did->prod_id_hash[i], hash);
+			printk(KERN_DEBUG "pcmcia: see "
+				"Documentation/pcmcia/devicetable.txt for "
+				"details\n");
 		}
 		did++;
 	}
@@ -291,12 +292,6 @@
 	return;
 }
 
-#else
-static inline void pcmcia_check_driver(struct pcmcia_driver *p_drv) {
-	return;
-}
-#endif
-
 
 #ifdef CONFIG_PCMCIA_LOAD_CIS
 
