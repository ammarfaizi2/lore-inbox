Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265230AbUHMJmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUHMJmL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 05:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269045AbUHMJmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 05:42:11 -0400
Received: from cantor.suse.de ([195.135.220.2]:54721 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265230AbUHMJl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 05:41:58 -0400
Date: Fri, 13 Aug 2004 11:40:40 +0200
From: Olaf Hering <olh@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Hollis Blanchard <hollisb@us.ibm.com>, Dave Boutcher <boutcher@us.ibm.com>,
       linuxppc64-dev@lists.linuxppc.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: module.viomap support for ppc64
Message-ID: <20040813094040.GA1769@suse.de>
References: <20040812173751.GA30564@suse.de> <1092339278.19137.8.camel@localhost> <1092354195.25196.11.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1092354195.25196.11.camel@bach>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Aug 13, Rusty Russell wrote:

> 2) Please modify scripts/mod/file2alias.c in the kernel source, not the
> module tools.  The modules.XXXmap files are deprecated: device tables
> are supposed to be converted to aliases in the build process, and that
> is how userspace tools like hotplug are to find them.

I found no user of the modules.alias file. Hotplug still uses the map
files. Parsing one big file will not improve performance, but thats a
different story.

A hack for 2.6.8-rc4 is below. Can I read the alias file via 
while read a b c ; do : done < modules.alias ?
Is b supposed to contain not spaces? What special delimiter chars are
allowed? The 'name' and 'compat' property can contain almost any char.
I used '^' for the time being.


> 3) I will still accept patches to module-init-tools if required for 2.4
> compatibility, but they will be going away at some point!

Noone cares about that old junk.



diff -purNX /suse/olh/kernel/kernel_exclude.txt linux-2.6.7/drivers/char/hvcs.c linux-2.6.8-rc4/drivers/char/hvcs.c
--- linux-2.6.7/drivers/char/hvcs.c	2004-08-13 11:03:00.798522189 +0200
+++ linux-2.6.8-rc4/drivers/char/hvcs.c	2004-08-13 10:32:50.049696245 +0200
@@ -502,7 +502,7 @@ static int khvcsd(void *unused)
 
 static struct vio_device_id hvcs_driver_table[] __devinitdata= {
 	{"serial-server", "hvterm2"},
-	{ 0, }
+	{ "", ""}
 };
 MODULE_DEVICE_TABLE(vio, hvcs_driver_table);
 
diff -purNX /suse/olh/kernel/kernel_exclude.txt linux-2.6.7/drivers/net/ibmveth.c linux-2.6.8-rc4/drivers/net/ibmveth.c
--- linux-2.6.7/drivers/net/ibmveth.c	2004-06-16 07:18:37.000000000 +0200
+++ linux-2.6.8-rc4/drivers/net/ibmveth.c	2004-08-13 10:32:50.052695761 +0200
@@ -1119,7 +1119,7 @@ static void ibmveth_proc_unregister_driv
 
 static struct vio_device_id ibmveth_device_table[] __devinitdata= {
 	{ "network", "IBM,l-lan"},
-	{ 0,}
+	{ "",""}
 };
 
 MODULE_DEVICE_TABLE(vio, ibmveth_device_table);
diff -purNX /suse/olh/kernel/kernel_exclude.txt linux-2.6.7/include/asm-ppc64/vio.h linux-2.6.8-rc4/include/asm-ppc64/vio.h
--- linux-2.6.7/include/asm-ppc64/vio.h	2004-08-13 11:03:10.080494206 +0200
+++ linux-2.6.8-rc4/include/asm-ppc64/vio.h	2004-08-13 10:58:02.418290902 +0200
@@ -86,9 +86,10 @@ static inline int vio_set_dma_mask(struc
 
 extern struct bus_type vio_bus_type;
 
+#define VIO_DEVTABLE_PROPERTY_LENGTH 32
 struct vio_device_id {
-	char *type;
-	char *compat;
+	char type[VIO_DEVTABLE_PROPERTY_LENGTH];
+	char compat[VIO_DEVTABLE_PROPERTY_LENGTH];
 };
 
 struct vio_driver {
diff -purNX /suse/olh/kernel/kernel_exclude.txt linux-2.6.7/include/linux/mod_devicetable.h linux-2.6.8-rc4/include/linux/mod_devicetable.h
--- linux-2.6.7/include/linux/mod_devicetable.h	2004-06-16 07:20:19.000000000 +0200
+++ linux-2.6.8-rc4/include/linux/mod_devicetable.h	2004-08-13 10:58:38.577104617 +0200
@@ -164,5 +164,10 @@ struct pnp_card_device_id {
 	} devs[PNP_MAX_DEVICES];
 };
 
+#define VIO_DEVTABLE_PROPERTY_LENGTH 32
+struct VIO_device_id {
+	char name[VIO_DEVTABLE_PROPERTY_LENGTH];
+	char compat[VIO_DEVTABLE_PROPERTY_LENGTH];
+};
 
 #endif /* LINUX_MOD_DEVICETABLE_H */
diff -purNX /suse/olh/kernel/kernel_exclude.txt linux-2.6.7/scripts/mod/file2alias.c linux-2.6.8-rc4/scripts/mod/file2alias.c
--- linux-2.6.7/scripts/mod/file2alias.c	2004-08-13 11:03:12.329397812 +0200
+++ linux-2.6.8-rc4/scripts/mod/file2alias.c	2004-08-13 11:29:25.203744273 +0200
@@ -198,6 +198,13 @@ static int do_pnp_card_entry(const char 
 	}
 	return 1;
 }
+/* looks like: "vio:cCdD..." */
+static int do_vio_entry(const char *filename,
+			struct VIO_device_id *id, char *alias)
+{
+	sprintf(alias, "vio:%s^%s", id->name, id->compat);
+	return 1;
+}
 
 /* Ignore any prefix, eg. v850 prepends _ */
 static inline int sym_is(const char *symbol, const char *name)
@@ -271,6 +278,9 @@ void handle_moddevtable(struct module *m
 	else if (sym_is(symname, "__mod_pnp_card_device_table"))
 		do_table(symval, sym->st_size, sizeof(struct pnp_card_device_id),
 			 do_pnp_card_entry, mod);
+	else if (sym_is(symname, "__mod_vio_device_table"))
+		do_table(symval, sym->st_size, sizeof(struct VIO_device_id),
+			 do_vio_entry, mod);
 }
 
 /* Now add out buffered information to the generated C source */

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
