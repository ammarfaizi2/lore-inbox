Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263052AbVCXGK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263052AbVCXGK5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 01:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbVCXGJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 01:09:45 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:60067 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263052AbVCXF5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 00:57:05 -0500
Message-ID: <424256BA.2060901@in.ibm.com>
Date: Thu, 24 Mar 2005 11:27:14 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot <fastboot@lists.osdl.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH 5/7] Common code for the activemem map
References: <424254E0.6060003@in.ibm.com> <42425582.7040508@in.ibm.com> <424255EA.9010905@in.ibm.com> <42425635.30808@in.ibm.com> <4242567A.5060104@in.ibm.com>
In-Reply-To: <4242567A.5060104@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------010308080506060401040907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010308080506060401040907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Regards, Hari

--------------010308080506060401040907
Content-Type: text/plain;
 name="activemem-common.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="activemem-common.patch"


---

This patch provides the arch independent code to create the
activemem view in the proc file system. /proc/activemem
reflects the RAM resources that are in use by the kernel. If
the system has been booted with mem= or memmap= options, then
this view will reflect the truncated map.
---

Signed-off-by: Hariprasad Nellitheertha <hari@in.ibm.com>
---

 linux-2.6.12-rc1-hari/kernel/resource.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+)

diff -puN kernel/resource.c~activemem-common kernel/resource.c
--- linux-2.6.12-rc1/kernel/resource.c~activemem-common	2005-03-23 17:48:12.000000000 +0530
+++ linux-2.6.12-rc1-hari/kernel/resource.c	2005-03-23 17:48:12.000000000 +0530
@@ -48,6 +48,15 @@ struct resource physmem_resource = {
 
 EXPORT_SYMBOL(physmem_resource);
 
+struct resource activemem_resource = {
+	.name	= "Active mem",
+	.start	= 0ULL,
+	.end	= ~0ULL,
+	.flags	= IORESOURCE_MEM,
+};
+
+EXPORT_SYMBOL(activemem_resource);
+
 static DEFINE_RWLOCK(resource_lock);
 
 #ifdef CONFIG_PROC_FS
@@ -137,6 +146,16 @@ static int physmem_open(struct inode *in
 	return res;
 }
 
+static int activemem_open(struct inode *inode, struct file *file)
+{
+	int res = seq_open(file, &resource_op);
+	if (!res) {
+		struct seq_file *m = file->private_data;
+		m->private = &activemem_resource;
+	}
+	return res;
+}
+
 static struct file_operations proc_ioports_operations = {
 	.open		= ioports_open,
 	.read		= seq_read,
@@ -158,6 +177,13 @@ static struct file_operations proc_physm
 	.release	= seq_release,
 };
 
+static struct file_operations proc_activemem_operations = {
+	.open		= activemem_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 static int __init ioresources_init(void)
 {
 	struct proc_dir_entry *entry;
@@ -171,6 +197,9 @@ static int __init ioresources_init(void)
 	entry = create_proc_entry("physmem", 0, NULL);
 	if (entry)
 		entry->proc_fops = &proc_physmem_operations;
+	entry = create_proc_entry("activemem", 0, NULL);
+	if (entry)
+		entry->proc_fops = &proc_activemem_operations;
 	return 0;
 }
 __initcall(ioresources_init);
_

--------------010308080506060401040907--
