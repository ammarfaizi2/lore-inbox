Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUF3JtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUF3JtU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 05:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266605AbUF3JtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 05:49:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37134 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266603AbUF3JtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 05:49:17 -0400
Date: Wed, 30 Jun 2004 10:49:00 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: [RFC] Buggy e100.c on ARM / DMA sync interfaces
Message-ID: <20040630104900.A11109@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	James Bottomley <James.Bottomley@steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a report which indicates that the e100.c driver does not work on
ARM when caches are in writeback mode.  The symptoms indicate that the
card is unable to communicate properly.

Looking up port of RPC 100003/2 on 10.2.40.5
portmap: server 10.2.40.5 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 10.2.40.5
portmap: server 10.2.40.5 not responding, timed out

Looking over the e100.c code, I find the following in e100_rx_alloc_skb():

        rx->skb->dev = nic->netdev;
        skb_reserve(rx->skb, rx_offset);
        memcpy(rx->skb->data, &nic->blank_rfd, sizeof(struct rfd));
        rx->dma_addr = pci_map_single(nic->pdev, rx->skb->data,
                RFD_BUF_LEN, PCI_DMA_BIDIRECTIONAL);

        /* Link the RFD to end of RFA by linking previous RFD to
         * this one, and clearing EL bit of previous.  */
        if(rx->prev->skb) {
                struct rfd *prev_rfd = (struct rfd *)rx->prev->skb->data;
                put_unaligned(cpu_to_le32(rx->dma_addr),
                        (u32 *)&prev_rfd->link);
                wmb();
                prev_rfd->command &= ~cpu_to_le16(cb_el);
                pci_dma_sync_single_for_device(nic->pdev, rx->prev->dma_addr,
                        sizeof(struct rfd), PCI_DMA_TODEVICE);
        }

This can't work - and I suspect anyone using the *dma_sync* functions
will be in for the same problem.  Why?

Cache lines.  They have a defined size and are not merely a single byte
or a single word.  If you modify even one single bit, you stand the
chance of writing back the whole cache line, possibly overwriting data
which the device has updated since the cache line was read.

Therefore, if you're going to use the dma_sync functions to modify data
owned by the remote device, you _must_ stop the remote device accessing
the surrounding data _before_ touching it.

With the above code on ARM, it effectively means that we will read the
whole struct rfd and some other data into cache, modify the command
field, and then write _at least_ the whole struct rfd back out, all
with the chip's DMA still running.

_That_ can't be good.

Note - I'm not saying that this is the cause of the above problem, but
that this is something I have spotted while reading through the driver
to ascertain why it possibly could not be working.

Comments?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
