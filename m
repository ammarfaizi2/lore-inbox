Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVBSWm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVBSWm0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 17:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVBSWm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 17:42:26 -0500
Received: from fire.osdl.org ([65.172.181.4]:42375 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262114AbVBSWmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 17:42:10 -0500
Date: Sat, 19 Feb 2005 14:41:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: slab corruption on 2.6.10-rc4-bk7
Message-Id: <20050219144147.4c771d4f.akpm@osdl.org>
In-Reply-To: <20050219221624.GB803@redhat.com>
References: <20050219221624.GB803@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> (This has actually been there for a while, but I only
>  noticed it in dmesg this morning).
> During boot on a dual em64t I see ..
> 
> scsi2 : ata_piix
> isa bounce pool size: 16 pages
> slab error in cache_free_debugcheck(): cache `size-2048': double free, or memory outside object was overwritten
> 
> Call Trace:<ffffffff80163448>{cache_free_debugcheck+392} <ffffffff801646aa>{kfree+234}
>        <ffffffff88065189>{:libata:ata_pci_init_one+937} <ffffffff801fe9ea>{pci_bus_read_config_word+122}
>        <ffffffff880707f2>{:ata_piix:piix_init_one+498} <ffffffff80202926>{pci_device_probe+134}
>        <ffffffff802691ad>{driver_probe_device+77} <ffffffff802692cb>{driver_attach+75}
>        <ffffffff802696c9>{bus_add_driver+169} <ffffffff802025e3>{pci_register_driver+131}
>        <ffffffff88074010>{:ata_piix:piix_init+16} <ffffffff80152c58>{sys_init_module+344}
>        <ffffffff8010e52a>{system_call+126}
> ffff81011e49f4a0: redzone 1: 0x5a2cf071, redzone 2: 0x5a2cf071.
> 

It's plain to see how ata_pci_init_one() will free `probe_ent' twice.  Jeff
wanna fix that up please?  A naive fix would be

--- 25/drivers/scsi/libata-core.c~a	2005-02-19 14:41:08.000000000 -0800
+++ 25-akpm/drivers/scsi/libata-core.c	2005-02-19 14:41:24.000000000 -0800
@@ -3743,8 +3743,6 @@ int ata_pci_init_one (struct pci_dev *pd
 	if (legacy_mode) {
 		if (legacy_mode & (1 << 0))
 			ata_device_add(probe_ent);
-		else
-			kfree(probe_ent);
 		if (legacy_mode & (1 << 1))
 			ata_device_add(probe_ent2);
 		else
_

> 
> 
> SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
> Slab corruption: start=ffff81011e49f4a8, len=2048
> Redzone: 0x170fc2a5/0x170fc2a5.
> Last user: [<ffffffff8015290c>](load_module+0x180c/0x1a00)
> 000: 38 e0 35 80 ff ff ff ff b8 f9 49 1e 01 81 ff ff
> 010: e0 f4 49 1e 01 81 ff ff 80 e7 08 88 ff ff ff ff
> 020: 24 01 00 00 5a 5a 5a 5a 10 0b 15 80 ff ff ff ff
> 030: 00 00 00 00 00 00 00 00 2e 74 65 78 74 00 5a 5a
> 040: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> 050: 5a 5a 5a 5a 5a 5a 5a 5a 00 e0 07 88 ff ff ff ff
> Prev obj: start=ffff81011e49ec90, len=2048
> Redzone: 0x170fc2a5/0x170fc2a5.
> Last user: [<ffffffff88064c79>](ata_probe_ent_alloc+0x29/0xc0 [libata])
> 000: 90 ec 49 1e 01 81 ff ff 90 ec 49 1e 01 81 ff ff
> 010: 80 8e 26 08 00 81 ff ff 60 24 07 88 ff ff ff ff
> slab error in cache_alloc_debugcheck_after(): cache `size-2048': double free, or memory outside object was overwritten
> 
> Call Trace:<ffffffff802d52c1>{alloc_skb+81} <ffffffff8016375a>{cache_alloc_debugcheck_after+186}
>        <ffffffff801638e8>{__kmalloc+216} <ffffffff802d52c1>{alloc_skb+81}
>        <ffffffff801f66e4>{send_uevent+84} <ffffffff801f6bb0>{kobject_hotplug+592}
>        <ffffffff801f635d>{kobject_add+349} <ffffffff8026a377>{class_device_add+135}
>        <ffffffff8026ab0d>{class_simple_device_add+317} <ffffffff80133a53>{__wake_up+67}
>        <ffffffff8023ab8d>{init_dev+1197} <ffffffff80243f3b>{vcs_make_devfs+43}
>        <ffffffff8024941e>{con_open+158} <ffffffff8023bebe>{tty_open+574}
>        <ffffffff801e51ea>{selinux_file_alloc_security+42}
>        <ffffffff80188d79>{chrdev_open+393} <ffffffff801e51ea>{selinux_file_alloc_security+42}
>        <ffffffff8017ef46>{dentry_open+246} <ffffffff8017f09e>{filp_open+62}
>        <ffffffff8017f18b>{get_unused_fd+219} <ffffffff8017f2dc>{sys_open+76}
>        <ffffffff8010e52a>{system_call+126}
> ffff81011e49f4a0: redzone 1: 0x170fc2a5, redzone 2: 0x170fc2a5.
> SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
> 

Last user: ata_probe_ent_alloc().   Hopefully that's the same bug.
