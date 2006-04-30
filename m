Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWD3OzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWD3OzU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 10:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWD3OzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 10:55:20 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:28033 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751140AbWD3OzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 10:55:19 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4454CF35.7010803@s5r6.in-berlin.de>
Date: Sun, 30 Apr 2006 16:52:37 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-scsi@vger.kernel.org
Subject: How to replace bus_to_virt()?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.867) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

is there a *direct* future-proof replacement for bus_to_virt()?

It appears there are already architectures which do not define a 
bus_to_virt() funtion or macro. If there isn't a direct replacement, is 
there at least a way to detect at compile time whether bus_to_virt() exists?

I am asking because the sbp2 driver uses bus_to_virt() if 
CONFIG_IEEE1394_SBP2_PHYS_DMA=y. I would like to replace this option by 
an automatic detection when the respective code in sbp2 is actually 
required.

The current implementation is this: Sbp2 uses bus_to_virt() to map from 
1394 bus addresses (which are currently identical to local host bus 
addresses) to virtual addresses. These addresses are supplied by SBP-2 
target devices and point to *arbitrary* locations within buffers. These 
buffers are supplied by the SCSI subsystem/ block IO subsystem. That is, 
sbp2 has no influence on the location of the buffers, nor has it 
influence on the location of the chunk of data which an SBP-2 target is 
reading or writing at a particular moment. But thanks to bus_to_virt(), 
sbp2 does not need to know which SCSI command buffer (and to which 
scatter/gather element in the buffer) a particular data transfer belongs to.

 From what I found out so far, I am afraid I have to implement a totally 
different address mapping scheme for the cases where physical DMA is not 
available; i.e. a scheme that enables sbp2 to look up the s/g element to 
which a transfer is directed, based on the 1394 bus address of the transfer.
-- 
Stefan Richter
-=====-=-==- -=-- ====-
http://arcgraph.de/sr/
