Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263058AbVCXFzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263058AbVCXFzH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 00:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbVCXFyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 00:54:51 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:55789 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263049AbVCXFxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 00:53:30 -0500
Message-ID: <424255EA.9010905@in.ibm.com>
Date: Thu, 24 Mar 2005 11:23:46 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot <fastboot@lists.osdl.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH 2/7] Common code for the physmem map
References: <424254E0.6060003@in.ibm.com> <42425582.7040508@in.ibm.com>
In-Reply-To: <42425582.7040508@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------010302030109020906010406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010302030109020906010406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------010302030109020906010406
Content-Type: text/plain;
 name="physmem-common.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="physmem-common.patch"


---
This patch provides the arch independent code to create the
physmem view in the proc file system. /proc/physmem
reflects the entire RAM resources that present in the system.
Even if the system has been booted with mem= or memmap= options,
this view will reflect the complete physical memory map.

---

Signed-off-by: Hariprasad Nellitheertha <hari@in.ibm.com>
---

 linux-2.6.12-rc1-hari/kernel/resource.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+)

diff -puN kernel/resource.c~physmem-common kernel/resource.c
--- linux-2.6.12-rc1/kernel/resource.c~physmem-common	2005-03-23 17:48:02.000000000 +0530
+++ linux-2.6.12-rc1-hari/kernel/resource.c	2005-03-23 17:48:02.000000000 +0530
@@ -39,6 +39,15 @@ struct resource iomem_resource = {
 
 EXPORT_SYMBOL(iomem_resource);
 
+struct resource physmem_resource = {
+	.name	= "Phys mem",
+	.start	= 0ULL,
+	.end	= ~0ULL,
+	.flags	= IORESOURCE_MEM,
+};
+
+EXPORT_SYMBOL(physmem_resource);
+
 static DEFINE_RWLOCK(resource_lock);
 
 #ifdef CONFIG_PROC_FS
@@ -118,6 +127,16 @@ static int iomem_open(struct inode *inod
 	return res;
 }
 
+static int physmem_open(struct inode *inode, struct file *file)
+{
+	int res = seq_open(file, &resource_op);
+	if (!res) {
+		struct seq_file *m = file->private_data;
+		m->private = &physmem_resource;
+	}
+	return res;
+}
+
 static struct file_operations proc_ioports_operations = {
 	.open		= ioports_open,
 	.read		= seq_read,
@@ -132,6 +151,13 @@ static struct file_operations proc_iomem
 	.release	= seq_release,
 };
 
+static struct file_operations proc_physmem_operations = {
+	.open		= physmem_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 static int __init ioresources_init(void)
 {
 	struct proc_dir_entry *entry;
@@ -142,6 +168,9 @@ static int __init ioresources_init(void)
 	entry = create_proc_entry("iomem", 0, NULL);
 	if (entry)
 		entry->proc_fops = &proc_iomem_operations;
+	entry = create_proc_entry("physmem", 0, NULL);
+	if (entry)
+		entry->proc_fops = &proc_physmem_operations;
 	return 0;
 }
 __initcall(ioresources_init);
_

--------------010302030109020906010406--
