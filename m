Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267624AbSKTFTL>; Wed, 20 Nov 2002 00:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267627AbSKTFTL>; Wed, 20 Nov 2002 00:19:11 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:3602 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267624AbSKTFS6>;
	Wed, 20 Nov 2002 00:18:58 -0500
Date: Tue, 19 Nov 2002 21:19:25 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcibios removal changes for 2.5.48
Message-ID: <20021120051925.GE21953@kroah.com>
References: <20021120051702.GB21953@kroah.com> <20021120051751.GC21953@kroah.com> <20021120051820.GD21953@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021120051820.GD21953@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.872.3.3, 2002/11/19 20:30:40-08:00, greg@kroah.com

PCI: removed pcibios_read_config_* and pcibios_write_config_* functions.


diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	Tue Nov 19 21:06:39 2002
+++ b/drivers/pci/Makefile	Tue Nov 19 21:06:39 2002
@@ -3,10 +3,10 @@
 #
 
 export-objs	:= access.o hotplug.o pci-driver.o pci.o pool.o \
-			probe.o proc.o search.o compat.o setup-bus.o
+			probe.o proc.o search.o setup-bus.o
 
 obj-y		+= access.o probe.o pci.o pool.o quirks.o \
-			compat.o names.o pci-driver.o search.o hotplug.o
+			names.o pci-driver.o search.o hotplug.o
 obj-$(CONFIG_PM)  += power.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
diff -Nru a/drivers/pci/compat.c b/drivers/pci/compat.c
--- a/drivers/pci/compat.c	Tue Nov 19 21:06:39 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,37 +0,0 @@
-/*
- *	$Id: compat.c,v 1.1 1998/02/16 10:35:50 mj Exp $
- *
- *	PCI Bus Services -- Function For Backward Compatibility
- *
- *	Copyright 1998--2000 Martin Mares <mj@ucw.cz>
- */
-
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/pci.h>
-
-/* Obsolete functions, these will be going away... */
-
-#define PCI_OP(rw,size,type)							\
-int pcibios_##rw##_config_##size (unsigned char bus, unsigned char dev_fn,	\
-				  unsigned char where, unsigned type val)	\
-{										\
-	struct pci_dev *dev = pci_find_slot(bus, dev_fn);			\
-	if (!dev) return PCIBIOS_DEVICE_NOT_FOUND;				\
-	return pci_##rw##_config_##size(dev, where, val);			\
-}
-
-PCI_OP(read, byte, char *)
-PCI_OP(read, word, short *)
-PCI_OP(read, dword, int *)
-PCI_OP(write, byte, char)
-PCI_OP(write, word, short)
-PCI_OP(write, dword, int)
-
-EXPORT_SYMBOL(pcibios_read_config_byte);
-EXPORT_SYMBOL(pcibios_read_config_word);
-EXPORT_SYMBOL(pcibios_read_config_dword);
-EXPORT_SYMBOL(pcibios_write_config_byte);
-EXPORT_SYMBOL(pcibios_write_config_word);
-EXPORT_SYMBOL(pcibios_write_config_dword);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Tue Nov 19 21:06:39 2002
+++ b/include/linux/pci.h	Tue Nov 19 21:06:39 2002
@@ -517,21 +517,6 @@
 void pcibios_update_irq(struct pci_dev *, int irq);
 void pcibios_fixup_pbus_ranges(struct pci_bus *, struct pbus_set_ranges_data *);
 
-/* Backward compatibility, don't use in new code! */
-
-int pcibios_read_config_byte (unsigned char bus, unsigned char dev_fn,
-			      unsigned char where, unsigned char *val);
-int pcibios_read_config_word (unsigned char bus, unsigned char dev_fn,
-			      unsigned char where, unsigned short *val);
-int pcibios_read_config_dword (unsigned char bus, unsigned char dev_fn,
-			       unsigned char where, unsigned int *val);
-int pcibios_write_config_byte (unsigned char bus, unsigned char dev_fn,
-			       unsigned char where, unsigned char val);
-int pcibios_write_config_word (unsigned char bus, unsigned char dev_fn,
-			       unsigned char where, unsigned short val);
-int pcibios_write_config_dword (unsigned char bus, unsigned char dev_fn,
-				unsigned char where, unsigned int val);
-
 /* Generic PCI functions used internally */
 
 int pci_bus_exists(const struct list_head *list, int nr);
@@ -668,8 +653,6 @@
 static inline int pci_present(void) { return 0; }
 
 #define _PCI_NOP(o,s,t) \
-	static inline int pcibios_##o##_config_##s (u8 bus, u8 dfn, u8 where, t val) \
-		{ return PCIBIOS_FUNC_NOT_SUPPORTED; } \
 	static inline int pci_##o##_config_##s (struct pci_dev *dev, int where, t val) \
 		{ return PCIBIOS_FUNC_NOT_SUPPORTED; }
 #define _PCI_NOP_ALL(o,x)	_PCI_NOP(o,byte,u8 x) \
