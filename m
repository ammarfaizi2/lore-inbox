Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVCTXXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVCTXXi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 18:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVCTXTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 18:19:49 -0500
Received: from gum.itee.uq.edu.au ([130.102.66.1]:30183 "EHLO
	gum.itee.uq.edu.au") by vger.kernel.org with ESMTP id S261350AbVCTXSl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 18:18:41 -0500
Message-ID: <423E0522.8050600@itee.uq.edu.au>
Date: Mon, 21 Mar 2005 09:20:02 +1000
From: John Williams <jwilliams@itee.uq.edu.au>
Reply-To: jwilliams@itee.uq.edu.au
Organization: School of ITEE, UQ
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [SATA] non-PCI SATA devices and libata
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checked: This message probably not SPAM
X-Spam-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am looking into developing a driver for a custom, non-PCI SATA 
controller.  The target arch is Microblaze, an FPGA-based NOMMU target 
on a 2.4.29-uc0 kernel.

It seems that Jeff Garzik's libata is the way to go for SATA, however 
there seems to be some degree of coupling between libata and PCI support.

Some comments/observations, please correct me if I am wrong:

  - include/linux/libata.h appears to recognise that CONFIG_PCI may not 
be set, however libata-compat.h is entirely PCI-specific.  Indeed, it 
effectively maps generic bus/dma operations onto their pci-specific 
equivalents.  Also, libata.h unconditionally includes pci.h.

  - All of the drivers/scsi/sata_XXX drivers target PCI devices only.

It seems I have a few choices here.

Option 1 is to just hack together stubbed PCI support for my arch, 
making our on-chip bus pretend to be PCI for the purposes of libata (and 
indeed many other bus subsystems, like USB).  This is pretty unclean, 
particularly since it is entirely likely that someone will build a 
microblaze system with a true PCI bridge and bus, meaning that this 
temporary hack would certainly come back to haunt me[1].

Option 2 is to try to decouple libata from PCI support.  This may be as 
simple as a conditional inclusion of libata-compat.h from libata.h, 
however I am not yet familiar enough with libata to be sure.

For now this will be staying in the NOMMU 2.4 kernel (uClinux), but if I 
choose option (2) I would like to work with libata, not against it.  It 
may well be that non-PCI SATA support is a Good Thing in a broader 
sense, so perhaps this is a good discussion to have anyway.

All input, suggestions and comments welcome.

Thanks,

John

[1] There is a bigger picture here, that with FPGA-based CPUs like 
Microblaze, we can build systems with arbitrary CPU/memory/IO bus 
topologies.  Indeed, we do so on a daily basis.  In the back of my mind 
I am envisioning some kind of generic bus abstraction API, of which PCI, 
USB etc would be mere instances.
-- 
John Williams, Research Fellow,
Embedded Systems Group / Reconfigurable Computing
School of ITEE, The University of Queensland, Brisbane, Australia

