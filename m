Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312581AbSEPNSo>; Thu, 16 May 2002 09:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312582AbSEPNSo>; Thu, 16 May 2002 09:18:44 -0400
Received: from srexchimc2.lss.emc.com ([168.159.40.71]:22797 "EHLO
	srexchimc2.lss.emc.com") by vger.kernel.org with ESMTP
	id <S312581AbSEPNSn>; Thu, 16 May 2002 09:18:43 -0400
Message-ID: <FA2F59D0E55B4B4892EA076FF8704F553D1A61@srgraham.eng.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'Oliver Xymoron'" <oxymoron@waste.org>
Cc: "'Jes Sorensen'" <jes@wildopensource.com>,
        "'Steve Whitehouse'" <Steve@ChyGwyn.com>, linux-kernel@vger.kernel.org,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: RE: Kernel deadlock using nbd over acenic driver.
Date: Thu, 16 May 2002 09:18:38 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can imagine iSCSI projects to have similar problems. But how to
let NBD reserve memory for packets, cause sk_buff is allocated in
the network layer. How can NBD pass reserved memory to the network
layer? Unless there are some kind zero copying networking scheme 
allowing data in buffer cache being directly used in network buffer,
probably the network layer relieves its pain in allocating big sk_buff.

xiangping

-----Original Message-----
From: Oliver Xymoron [mailto:oxymoron@waste.org]
Sent: Wednesday, May 15, 2002 6:32 PM
To: chen, xiangping
Cc: 'Jes Sorensen'; 'Steve Whitehouse'; linux-kernel@vger.kernel.org
Subject: RE: Kernel deadlock using nbd over acenic driver.


On Tue, 14 May 2002, chen, xiangping wrote:

> But how to avoid system hangs due to running out of memory?
> Is there a safe guide line? Generally slow is tolerable, but
> crash is not.

If the system runs out of memory, it may try to flush pages that are
queued to your NBD device. That will try to allocate more memory for
sending packets, which will fail, meaning the VM can never make progress
freeing pages. Now your box is dead.

The only way to deal with this is to have a scheme for per-socket memory
reservations in the network layer and have NBD reserve memory for sending
and acknowledging packets. NFS and iSCSI also need this, though it's a
bit harder to tickle for NFS. SCSI has DMA reserved memory for analogous
reasons.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."
