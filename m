Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWALAEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWALAEx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWALAEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:04:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5019 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751207AbWALAEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:04:52 -0500
Date: Wed, 11 Jan 2006 16:01:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, edwardsg@sgi.com, linux-altix@sgi.com
Subject: Re: 2.6.15-mm3: arch/ia64/sn/kernel/sn2/sn_proc_fs.c compile error
Message-Id: <20060111160121.77d57626.akpm@osdl.org>
In-Reply-To: <20060111234133.GI29663@stusta.de>
References: <20060111042135.24faf878.akpm@osdl.org>
	<20060111234133.GI29663@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> Arjan, it seems the following compile error on ia64 is caused by a patch 
>  of you that makes some stuff static:
> 
>  <--  snip  -->
> 
>  ...
>    CC      arch/ia64/sn/kernel/sn2/sn_proc_fs.o
>  arch/ia64/sn/kernel/sn2/sn_proc_fs.c: In function 'sn_procfs_create_entry':
>  arch/ia64/sn/kernel/sn2/sn_proc_fs.c:104: warning: passing argument 1 of 'memset' discards qualifiers from pointer target type
>  arch/ia64/sn/kernel/sn2/sn_proc_fs.c:105: error: assignment of read-only member 'open'
>  arch/ia64/sn/kernel/sn2/sn_proc_fs.c:106: error: assignment of read-only member 'read'
>  arch/ia64/sn/kernel/sn2/sn_proc_fs.c:107: error: assignment of read-only member 'llseek'
>  arch/ia64/sn/kernel/sn2/sn_proc_fs.c:108: error: assignment of read-only member 'release'
>  arch/ia64/sn/kernel/sn2/sn_proc_fs.c: In function 'register_sn_procfs':
>  arch/ia64/sn/kernel/sn2/sn_proc_fs.c:140: error: assignment of read-only member 'write'

This?

--- devel/arch/ia64/sn/kernel/sn2/sn_proc_fs.c~ia64-const-f_ops-fix	2006-01-11 15:58:41.000000000 -0800
+++ devel-akpm/arch/ia64/sn/kernel/sn2/sn_proc_fs.c	2006-01-11 16:00:50.000000000 -0800
@@ -98,14 +98,15 @@ static struct proc_dir_entry *sn_procfs_
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
+			e->proc_fops = f;
 		}
 	}
 
_

