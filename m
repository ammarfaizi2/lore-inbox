Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbVAESGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbVAESGE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 13:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbVAESFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 13:05:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49078 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262519AbVAESE6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 13:04:58 -0500
Date: Wed, 5 Jan 2005 18:04:57 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, linux-scsi@vger.kernel.org
Subject: [PATCH] Re: Oops on megaraid.
Message-ID: <20050105180457.GK26051@parcelfarce.linux.theplanet.co.uk>
References: <20050105174752.GA6859@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105174752.GA6859@animx.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 12:47:52PM -0500, Wakko Warner wrote:
> Kernel: 2.6.8.1 vanilla
> Card: Dell PERC DC/2 (megaraid)
> 
> The oops happened when I attempted to unload the megaraid module.  Before
> doing this, I ran the dellmgr program to reconfigure the raid.
> 
> Before the "oops" text, I saw:
> Badness in remove_proc_entry at fs/proc/generic.c:688
>  [<c017c3fa>] remove_proc_entry+0x10a/0x150
>  [<d88f6e3e>] megaraid_exit+0x2e/0x3e [megaraid]
>  [<c012c690>] sys_delete_module+0x150/0x1a0
>  [<c0142a00>] do_munmap+0x140/0x190
>  [<c010513b>] syscall_call+0x7/0xb

Someone's removing non-empty directory in procfs.  Let's see...
Indeed.
#ifdef CONFIG_PROC_FS
        remove_proc_entry("megaraid", &proc_root);
#endif

        pci_unregister_driver(&megaraid_pci_driver);
so we remove /proc/megaraid and then procees to remove controllers found
by driver.  Each of those has a subdirectory in /proc/megaraid...

Fix is trivial:

diff -urN RC10-bk6-base/drivers/scsi/megaraid.c RC10-bk6-current/drivers/scsi/megaraid.c
--- RC10-bk6-base/drivers/scsi/megaraid.c	2004-12-25 01:04:29.000000000 -0500
+++ RC10-bk6-current/drivers/scsi/megaraid.c	2005-01-05 13:03:51.609698587 -0500
@@ -5109,11 +5109,11 @@
 	 */
 	unregister_chrdev(major, "megadev");
 
+	pci_unregister_driver(&megaraid_pci_driver);
+
 #ifdef CONFIG_PROC_FS
 	remove_proc_entry("megaraid", &proc_root);
 #endif
-
-	pci_unregister_driver(&megaraid_pci_driver);
 }
 
 module_init(megaraid_init);
