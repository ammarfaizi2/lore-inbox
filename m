Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269851AbUJVGjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269851AbUJVGjw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 02:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269680AbUJVGjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 02:39:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29660 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269851AbUJVGgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 02:36:33 -0400
Date: Fri, 22 Oct 2004 08:36:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-ac3
Message-ID: <20041022063606.GB1820@suse.de>
References: <1098400086.18025.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098400086.18025.0.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22 2004, Alan Cox wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.6/2.6.9/

If you're collection ide patchlets for later inclusion, please include
this as well. It makes sure we remove the ideX directory in proc when an
interface is removed. With ide-cs and repeated insert/reject cycles, we
end up with tons of ide2 entries.

Signed-off-by: Jens Axboe <axboe@suse.de>

--- /opt/kernel/linux-2.6/include/linux/ide.h	2004-10-11 12:19:40.000000000 +0200
+++ linux-2.6.9/include/linux/ide.h	2004-10-20 17:25:05.000000000 +0200
@@ -1063,6 +1063,7 @@
 extern void proc_ide_create(void);
 extern void proc_ide_destroy(void);
 extern void destroy_proc_ide_drives(ide_hwif_t *);
+extern void destroy_proc_ide_interfaces(void);
 extern void create_proc_ide_interfaces(void);
 extern void ide_add_proc_entries(struct proc_dir_entry *, ide_proc_entry_t *, void *);
 extern void ide_remove_proc_entries(struct proc_dir_entry *, ide_proc_entry_t *);
--- /opt/kernel/linux-2.6/drivers/ide/ide.c	2004-10-11 12:19:29.000000000 +0200
+++ linux-2.6.9/drivers/ide/ide.c	2004-10-20 17:25:54.000000000 +0200
@@ -798,6 +798,7 @@
 
 #ifdef CONFIG_PROC_FS
 	destroy_proc_ide_drives(hwif);
+	destroy_proc_ide_interfaces();
 #endif
 
 	hwgroup = hwif->hwgroup;
--- /opt/kernel/linux-2.6/drivers/ide/ide-proc.c	2004-10-11 12:19:29.000000000 +0200
+++ linux-2.6.9/drivers/ide/ide-proc.c	2004-10-20 17:31:02.040529272 +0200
@@ -731,10 +731,9 @@
 	for (h = 0; h < MAX_HWIFS; h++) {
 		ide_hwif_t *hwif = &ide_hwifs[h];
 		int exist = (hwif->proc != NULL);
-#if 0
-		if (!hwif->present)
+
+		if (hwif->present)
 			continue;
-#endif
 		if (exist) {
 			destroy_proc_ide_drives(hwif);
 			ide_remove_proc_entries(hwif->proc, hwif_entries);

-- 
Jens Axboe

