Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314560AbSD0DA4>; Fri, 26 Apr 2002 23:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314561AbSD0DAz>; Fri, 26 Apr 2002 23:00:55 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:29889 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S314560AbSD0DAw>;
	Fri, 26 Apr 2002 23:00:52 -0400
Message-ID: <3CCA1462.9010405@acm.org>
Date: Fri, 26 Apr 2002 22:00:50 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH} SMBIOS support
Content-Type: multipart/mixed;
 boundary="------------010408010500070608050308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010408010500070608050308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The following patch adds support for reading the SMBIOS table (which 
contains system management information).  It's required for IPMI and has 
useful information in it.  But anyway, since I did the work, I thought I 
would post this.

It's relative to 2.5.9, but it should apply pretty cleanly to most other 
kernels.

-Corey

--------------010408010500070608050308
Content-Type: text/plain;
 name="linux-2.5.9-smbios.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.5.9-smbios.diff"

--- ./arch/i386/kernel/pci-pc.c.smbios	Fri Apr 26 10:59:55 2002
+++ ./arch/i386/kernel/pci-pc.c	Fri Apr 26 11:00:13 2002
@@ -1293,6 +1293,10 @@
 	return;
 }
 
+#ifdef CONFIG_SMBIOS
+extern void smbios_init(void);
+#endif
+
 void __init pcibios_init(void)
 {
 	int quad;
@@ -1322,6 +1326,10 @@
 
 	pcibios_fixup_irqs();
 	pcibios_resource_survey();
+
+#ifdef CONFIG_SMBIOS
+	smbios_init();
+#endif
 
 #ifdef CONFIG_PCI_BIOS
 	if ((pci_probe & PCI_BIOS_SORT) && !(pci_probe & PCI_NO_SORT))
--- ./arch/i386/kernel/smbios.c.smbios	Fri Apr 26 10:59:55 2002
+++ ./arch/i386/kernel/smbios.c	Fri Apr 26 21:54:49 2002
@@ -0,0 +1,228 @@
+/*
+ * smbios.c
+ *
+ * MontaVista SMBIOS implementation.
+ *
+ * Author: MontaVista Software, Inc.
+ *         Corey Minyard <minyard@mvista.com>
+ *         source@mvista.com
+ *
+ * Copyright 2002 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/smbios.h>
+
+#include <asm/page.h>
+typedef struct smbios_etable_s
+{
+	char anchor[4];
+	u8  csum;
+	u8  len;
+	u8  major_ver;
+	u8  minor_ver;
+	u16 max_struct_size;
+	u8  entry_point_rev;
+	u8  formatted_area[5];
+	u8  dmi_anchor_string[5];
+	u8  dmi_checksum;
+	u16 struct_table_len;
+	u32 struct_table_addr;
+	u16 num_struct_table_entries;
+	u8  smbios_bcd_rev;
+} smbios_etable_t;
+
+smbios_etable_t *smbios_etable;
+
+#define SMBIOS_SIGNATURE 0x5f4d535f /* "_SM_" */
+
+/* Return the next smbios structure following the given one. */
+static smbios_struct_t *next_entry(smbios_struct_t *curr)
+{
+	u8 *addr;
+
+	/* Skip over the structure first. */
+	addr = (u8 *) curr;
+	addr += curr->len;
+
+	/* Now skip over the string table.  It's terminated with two
+           zeros. */
+	if (*addr == 0)
+		addr++;
+	while (*addr != 0) {
+		addr++;
+		if (*addr == 0)
+			addr++;
+	}
+	addr++;
+
+	return (smbios_struct_t *) addr;
+}
+
+char *smbios_get_string_num(smbios_struct_t *smbstr, int strnum)
+{
+	u8 *addr;
+
+	/* Skip over the structure first. */
+	addr = (u8 *) smbstr;
+	addr += smbstr->len;
+
+	/* Check for an empty string table. */
+	if ((*addr == 0) && (*(addr+1) == 0))
+		return NULL;
+
+	/* Handle the first string special. */
+	if (strnum == 0)
+		return (char *) addr;
+
+	/* Now scan string table.  It's terminated with two zeros. */
+	while (*addr != 0) {
+		addr++;
+		if (*addr == 0) {
+			addr++;
+			strnum--;
+			if ((strnum == 0) && (*addr != 0))
+				return (char *) addr;
+		}
+	}
+
+	return NULL;
+}
+
+smbios_struct_t *smbios_find_struct_by_type(unsigned char type)
+{
+	smbios_struct_t *entry;
+	int             i;
+
+	if (smbios_etable == NULL)
+		return NULL;
+
+	entry = ((smbios_struct_t *) __va(smbios_etable->struct_table_addr));
+	for (i=0; i<smbios_etable->num_struct_table_entries; i++)
+	{
+		if (entry->type == type) {
+			return entry;
+		}
+		entry = next_entry(entry);
+	}
+
+	return NULL;
+}
+
+smbios_struct_t *smbios_next_struct_by_type(smbios_struct_t *old_entry)
+{
+	int             i;
+	int             found = 0;
+	int             type = old_entry->type;
+	smbios_struct_t *entry;
+
+	if (smbios_etable == NULL)
+		return NULL;
+
+	entry = ((smbios_struct_t *) __va(smbios_etable->struct_table_addr));
+	for (i=0; i<smbios_etable->num_struct_table_entries; i++)
+	{
+		if (entry == old_entry)
+			found = 1;
+		else if (found && (entry->type == type)) {
+			return entry;
+		}
+		entry = next_entry(entry);
+	}
+
+	return NULL;
+}
+
+void __init hexdump (u8 *data, int len)
+{
+	char str[80];
+	char *ptr;
+	int  i;
+
+	str[0] = ' ';
+	ptr = str + 1;
+	for (i=0; i<len; i++) {
+		ptr += sprintf(ptr, " %2.2x", *data);
+		data++;
+		if (((i%16) == 0) && (i != 0)) {
+			printk("%s\n", str);
+			data[0] = ' ';
+			ptr = str + 1;
+		}
+	}
+
+	if ((i%16) != 0) 
+		printk("%s\n", str);
+}
+
+void __init smbios_init(void)
+{
+	smbios_struct_t *entry;
+	u8              *addr, *summer;
+	u8              csum;
+	int             i;
+
+	smbios_etable = NULL;
+
+	for(addr = (u8 *) __va(0xf0000);
+	    addr < (u8 *) __va(0x100000);
+	    addr += 16)
+	{
+		if (*((u32 *) addr) == SMBIOS_SIGNATURE) {
+			summer = addr;
+			csum = 0;
+			for (i=0; i<*(addr+5); i++, summer++)
+				csum += *summer;
+			if (csum == 0) {
+				printk("Found SMBIOS entry table at %8.8lx\n",
+				       (unsigned long) addr);
+				smbios_etable = (smbios_etable_t *) addr;
+				break;
+			}
+		}
+	}
+
+#ifdef DEBUG
+	if (smbios_etable) {
+		int j;
+		char *str;
+		entry = ((smbios_struct_t *)
+			 __va(smbios_etable->struct_table_addr));
+		for (i=0; i<smbios_etable->num_struct_table_entries; i++)
+		{
+			printk(" Entry %d is type %d\n", i, entry->type);
+			hexdump((u8 *) entry, entry->len);
+			for (j=0; ; j++) {
+				str = smbios_get_string_num(entry, j);
+				if (str == NULL)
+					break;
+				printk("  string %d is '%s'\n", j, str);
+			}
+			entry = next_entry(entry);
+		}
+	}
+#endif
+}
--- ./arch/i386/kernel/Makefile.smbios	Fri Apr 26 10:59:55 2002
+++ ./arch/i386/kernel/Makefile	Fri Apr 26 11:00:13 2002
@@ -30,6 +30,9 @@
 obj-y			+= pci-pc.o pci-irq.o
 endif
 endif
+ifdef CONFIG_SMBIOS
+obj-y			+= smbios.o
+endif
 
 obj-$(CONFIG_MCA)		+= mca.o
 obj-$(CONFIG_MTRR)		+= mtrr.o
--- ./arch/i386/config.in.smbios	Fri Apr 26 10:59:55 2002
+++ ./arch/i386/config.in	Fri Apr 26 11:00:13 2002
@@ -236,6 +236,7 @@
          define_bool CONFIG_PCI_DIRECT y
       fi
    fi
+   bool 'SMBIOS support' CONFIG_SMBIOS
 fi
 
 source drivers/pci/Config.in
--- ./arch/i386/Config.help.smbios	Fri Apr 26 11:01:39 2002
+++ ./arch/i386/Config.help	Fri Apr 26 11:01:13 2002
@@ -936,3 +936,8 @@
 CONFIG_DEBUG_OBSOLETE
   Say Y here if you want to reduce the chances of the tree compiling,
   and are prepared to dig into driver internals to fix compile errors.
+
+CONFIG_SMBIOS
+  Look for the SM BIOS configuration tables in memory, and if they are
+  there record information about them.  Other things like IPMI use
+  these tables and require this to be set.
--- ./include/linux/smbios.h.smbios	Fri Apr 26 10:59:56 2002
+++ ./include/linux/smbios.h	Fri Apr 26 11:00:14 2002
@@ -0,0 +1,59 @@
+/*
+ * smbios.h
+ *
+ * MontaVista SMBIOS implementation.
+ *
+ * Author: MontaVista Software, Inc.
+ *         Corey Minyard <minyard@mvista.com>
+ *         source@mvista.com
+ *
+ * Copyright 2002 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __LINUX_SMBIOS_H
+#define __LINUX_SMBIOS_H
+
+#include <asm/types.h>
+
+/* Header for an SMBIOS structure. */
+typedef struct smbios_struct_s
+{
+	u8  type;
+	u8  len;
+	u16 handle;
+} smbios_struct_t;
+
+/* Get the string numbered strnum from the string table for the entry.
+   returns NULL if the string doesn't exist. */
+char *smbios_get_string_num(smbios_struct_t *smbstr, int strnum);
+
+/* Find the first structure with the given type in the SMBIOS table.
+   Returns NULL if the structure doesn't exist. */
+smbios_struct_t *smbios_find_struct_by_type(unsigned char type);
+
+/* Return the next structure after old_entry with the same type
+   as old_entry. */
+smbios_struct_t *smbios_next_struct_by_type(smbios_struct_t *old_entry);
+
+#endif /* __LINUX_SMBIOS_H */

--------------010408010500070608050308--

