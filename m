Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWIGIbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWIGIbP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 04:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWIGIbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 04:31:15 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:4497 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751124AbWIGIbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 04:31:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=WpgZPSl57kRUPnuM/jrvt3yuLyf9pOYxLl38HG5P2au9qwr382FtXikHhF/KsSTDVrgUpS6hrvyIHt5n6LrWvPZ7S1HdAoZis0pKcV0Xl8QfL28BaQmYLuutD4lUQHFhfGo9Ky1mRvymSJsfL1tHGaBa29BLVLZA8fzw/q+SxOY=
Message-ID: <44FFD8C6.8080802@gmail.com>
Date: Thu, 07 Sep 2006 10:31:02 +0200
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: linux-pci@atrey.karlin.mff.cuni.cz
CC: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: question regarding cacheline size
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is for PCMCIA (cardbus) version of Silicon Image 3124 SerialATA 
controller.  When cacheline size is configured, the controller uses Read 
Multiple commands.

• Bit [07:00]: Cache Line Size (R/W). This bit field is used to specify 
the system cacheline size in terms of 32-bit words. The SiI3124, when 
initiating a read transaction, will issue the Read Multiple PCI command 
if empty space in its FIFO is greater than the value programmed in this 
register.

As the BIOS doesn't run after hotplugging cardbus card, the cache line 
isn't configured and the controller ends up having 0 cache line size and 
always using Read command.  When that happens, write performance drops 
hard - the throughput is < 2Mbytes/s.

http://thread.gmane.org/gmane.linux.ide/12908/focus=12908

So, sata_sil24 driver has to program CLS if it's not already set, but 
I'm not sure which number to punch in.  FWIW, sil3124 doesn't seem to 
put restrictions on the values which can be used for CLS.  There are 
several candidates...

* L1_CACHE_BYTES / 4 : this is used by init routine in yenta_socket.c. 
It seems to be a sane default but I'm not sure whether L1 cache line 
size always coincides with the size as seen from PCI bus.

* pci_cache_line_size in drivers/pci/pci.c : this is used for 
pci_generic_prep_mwi() and can be overridden by arch specific code. 
this seems more appropriate but is not exported.

For all involved commands - memory read line, memory read multiple and 
memory write and invalidate - a value larger than actual cacheline size 
doesn't hurt but a smaller value may.

I'm thinking of implementing a query function for pci_cache_line_size, 
say, int pci_cacheline_size(struct pci_dev *pdev), and use it in the 
device init routine.  Does this sound sane?

Thanks.

-- 
tejun
