Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268966AbTBWUXQ>; Sun, 23 Feb 2003 15:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268968AbTBWUXQ>; Sun, 23 Feb 2003 15:23:16 -0500
Received: from franka.aracnet.com ([216.99.193.44]:62423 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268966AbTBWUXO>; Sun, 23 Feb 2003 15:23:14 -0500
Date: Sun, 23 Feb 2003 12:33:19 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mike Anderson <andmike@us.ibm.com>, Patrick Mochel <mochel@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bug with (maybe not *in*) sysfs
Message-ID: <12070000.1046032398@[10.10.2.4]>
In-Reply-To: <20030223202401.GA1452@beaverton.ibm.com>
References: <5480000.1046028715@[10.10.2.4]>
 <Pine.LNX.4.33.0302231310500.923-100000@localhost.localdomain>
 <20030223202401.GA1452@beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This is typically caused by the same object being added twice at the
>> same  level in the hierarchy, which appears to be happening. Is the ips
>> driver  calling pci_register_driver() twice? 
>> 
>> 	-pat
> 
> It was possible in the past that pci_module_init could be called more
> than once with non-unique pci_driver names. It is fixed in the current
> trees, but I do not have the date when it was pushed. Here is some
> context mail links.
> 
> http://marc.theaimsgroup.com/?l=linux-scsi&m=104275858704733&w=2
> 
> http://marc.theaimsgroup.com/?l=linux-scsi&m=104455557710731&w=2

OK, so two similar, but not identical cards using the same driver?
First patch mentioned looks very simple, but won't apply to 2.5.62
There's now just:

   static char ips_hot_plug_name[] = "ips";

   static int __devinit  ips_insert_device(struct pci_dev *pci_dev, const
struct pci_device_id *ent);
   static void __devexit ips_remove_device(struct pci_dev *pci_dev);

   struct pci_driver ips_pci_driver = {
       .name            = ips_hot_plug_name,
       .id_table        = ips_pci_table,
       .probe           = ips_insert_device,
       .remove          = __devexit_p(ips_remove_device),
   };

Second patch looks a little intimidating ... more like a full blown update
of the driver ... I'd rather not go there unless I really have to.

M.

