Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVBUE3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVBUE3U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 23:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVBUE3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 23:29:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21187 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261791AbVBUE3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 23:29:13 -0500
Message-ID: <42196387.2070505@pobox.com>
Date: Sun, 20 Feb 2005 23:28:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: slab corruption on 2.6.10-rc4-bk7
References: <20050219221624.GB803@redhat.com> <20050219144147.4c771d4f.akpm@osdl.org>
In-Reply-To: <20050219144147.4c771d4f.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------010702070100020207030600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010702070100020207030600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Dave Jones <davej@redhat.com> wrote:
> 
>>(This has actually been there for a while, but I only
>> noticed it in dmesg this morning).
>>During boot on a dual em64t I see ..
>>
>>scsi2 : ata_piix
>>isa bounce pool size: 16 pages
>>slab error in cache_free_debugcheck(): cache `size-2048': double free, or memory outside object was overwritten
>>
>>Call Trace:<ffffffff80163448>{cache_free_debugcheck+392} <ffffffff801646aa>{kfree+234}
>>       <ffffffff88065189>{:libata:ata_pci_init_one+937} <ffffffff801fe9ea>{pci_bus_read_config_word+122}
>>       <ffffffff880707f2>{:ata_piix:piix_init_one+498} <ffffffff80202926>{pci_device_probe+134}
>>       <ffffffff802691ad>{driver_probe_device+77} <ffffffff802692cb>{driver_attach+75}
>>       <ffffffff802696c9>{bus_add_driver+169} <ffffffff802025e3>{pci_register_driver+131}
>>       <ffffffff88074010>{:ata_piix:piix_init+16} <ffffffff80152c58>{sys_init_module+344}
>>       <ffffffff8010e52a>{system_call+126}
>>ffff81011e49f4a0: redzone 1: 0x5a2cf071, redzone 2: 0x5a2cf071.
>>
> 
> 
> It's plain to see how ata_pci_init_one() will free `probe_ent' twice.  Jeff
> wanna fix that up please?  A naive fix would be

Here's the initial fix...  about to test with some other fixes here. 
Anybody who is seeing this wanna give it a try?

	Jeff



--------------010702070100020207030600
Content-Type: text/x-patch;
 name="libata_probe_ent_free_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata_probe_ent_free_fix.patch"

===== drivers/scsi/libata-core.c 1.116 vs edited =====
--- 1.116/drivers/scsi/libata-core.c	2005-02-01 20:23:51 -05:00
+++ edited/drivers/scsi/libata-core.c	2005-02-20 23:25:52 -05:00
@@ -3751,8 +3751,8 @@
 			kfree(probe_ent2);
 	} else {
 		ata_device_add(probe_ent);
+		kfree(probe_ent);
 	}
-	kfree(probe_ent);
 
 	return 0;
 

--------------010702070100020207030600--
