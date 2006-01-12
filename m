Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932677AbWALA06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbWALA06 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932674AbWALA06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:26:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27040 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932673AbWALA05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:26:57 -0500
Date: Wed, 11 Jan 2006 16:23:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, edwardsg@sgi.com, linux-altix@sgi.com
Subject: Re: 2.6.15-mm3: arch/ia64/sn/kernel/sn2/sn_proc_fs.c compile error
Message-Id: <20060111162319.5aecc314.akpm@osdl.org>
In-Reply-To: <20060112001726.GK29663@stusta.de>
References: <20060111042135.24faf878.akpm@osdl.org>
	<20060111234133.GI29663@stusta.de>
	<20060111160121.77d57626.akpm@osdl.org>
	<20060112001726.GK29663@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> > >  arch/ia64/sn/kernel/sn2/sn_proc_fs.c:140: error: assignment of read-only member 'write'
>  > 
>  > This?
>  >...
> 
>  Nearly.
> 
>  The last compile error (line 140) is still present.

Bah.


diff -puN arch/ia64/sn/kernel/sn2/sn_proc_fs.c~ia64-const-f_ops-fix arch/ia64/sn/kernel/sn2/sn_proc_fs.c
--- devel/arch/ia64/sn/kernel/sn2/sn_proc_fs.c~ia64-const-f_ops-fix	2006-01-11 16:04:18.000000000 -0800
+++ devel-akpm/arch/ia64/sn/kernel/sn2/sn_proc_fs.c	2006-01-11 16:22:38.000000000 -0800
@@ -93,19 +93,22 @@ static int coherence_id_open(struct inod
 static struct proc_dir_entry *sn_procfs_create_entry(
 	const char *name, struct proc_dir_entry *parent,
 	int (*openfunc)(struct inode *, struct file *),
-	int (*releasefunc)(struct inode *, struct file *))
+	int (*releasefunc)(struct inode *, struct file *),
+	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *))
 {
 	struct proc_dir_entry *e = create_proc_entry(name, 0444, parent);
 
 	if (e) {
-		e->proc_fops = (struct file_operations *)kmalloc(
-			sizeof(struct file_operations), GFP_KERNEL);
-		if (e->proc_fops) {
-			memset(e->proc_fops, 0, sizeof(struct file_operations));
-			e->proc_fops->open = openfunc;
-			e->proc_fops->read = seq_read;
-			e->proc_fops->llseek = seq_lseek;
-			e->proc_fops->release = releasefunc;
+		struct file_operations *f;
+
+		f = kzalloc(sizeof(*f), GFP_KERNEL);
+		if (f) {
+			f->open = openfunc;
+			f->read = seq_read;
+			f->llseek = seq_lseek;
+			f->release = releasefunc;
+			f->write = write;
+			e->proc_fops = f;
 		}
 	}
 
@@ -119,31 +122,29 @@ extern int sn_topology_release(struct in
 void register_sn_procfs(void)
 {
 	static struct proc_dir_entry *sgi_proc_dir = NULL;
-	struct proc_dir_entry *e;
 
 	BUG_ON(sgi_proc_dir != NULL);
 	if (!(sgi_proc_dir = proc_mkdir("sgi_sn", NULL)))
 		return;
 
 	sn_procfs_create_entry("partition_id", sgi_proc_dir,
-		partition_id_open, single_release);
+		partition_id_open, single_release, NULL);
 
 	sn_procfs_create_entry("system_serial_number", sgi_proc_dir,
-		system_serial_number_open, single_release);
+		system_serial_number_open, single_release, NULL);
 
 	sn_procfs_create_entry("licenseID", sgi_proc_dir, 
-		licenseID_open, single_release);
+		licenseID_open, single_release, NULL);
 
-	e = sn_procfs_create_entry("sn_force_interrupt", sgi_proc_dir, 
-		sn_force_interrupt_open, single_release);
-	if (e) 
-		e->proc_fops->write = sn_force_interrupt_write_proc;
+	sn_procfs_create_entry("sn_force_interrupt", sgi_proc_dir,
+		sn_force_interrupt_open, single_release,
+		sn_force_interrupt_write_proc);
 
 	sn_procfs_create_entry("coherence_id", sgi_proc_dir, 
-		coherence_id_open, single_release);
+		coherence_id_open, single_release, NULL);
 	
 	sn_procfs_create_entry("sn_topology", sgi_proc_dir,
-		sn_topology_open, sn_topology_release);
+		sn_topology_open, sn_topology_release, NULL);
 }
 
 #endif /* CONFIG_PROC_FS */
_

