Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316619AbSEPKCg>; Thu, 16 May 2002 06:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316620AbSEPKCf>; Thu, 16 May 2002 06:02:35 -0400
Received: from exchsmtp.via.com.tw ([61.13.36.4]:36620 "EHLO
	exchsmtp.via.com.tw") by vger.kernel.org with ESMTP
	id <S316619AbSEPKCe>; Thu, 16 May 2002 06:02:34 -0400
Message-ID: <369B0912E1F5D511ACA5003048222B75A3C06B@EXCHANGE2>
From: Shing Chuang <ShingChuang@via.com.tw>
To: "'Roger Luethi'" <rl@hellgate.ch>, Urban Widmark <urban@teststation.com>,
        "Ivan G." <ivangurdiev@linuxfreemail.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, AJ Jiang <AJJiang@via.com.tw>
Subject: RE: [PATCH] #2 VIA Rhine stalls: TxAbort handling
Date: Thu, 16 May 2002 18:03:25 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="BIG5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

     As following three error conditions occurred,   the VT6102 & VT86C100A
chip are designed to shutdown TX for driver to examine the error frame.

     1. Tx fifo underrun.                   

     2. Tx Abort (Too many collisions occurred).

     3. TxDescriptors status write back  error. (Only on VT6102 chip)

     All the three conditions caused the TXON bit of CR1 went off. the
driver must wait  a little while until the bit go off, reset the pointer of
current Tx descriptor, and  then turn on TXON bit of CR1 again. Those may be
the reasons why the  via-rhine sometimes hangs, or the watchdog timeout. 
     
     The following are codes of our new driver to handle those errors. 
      (The new driver is under testing now, and will be release very sooner)

     1. For Tx fifo underrun.

          Increase_tx_threshold();

          do {} while (BYTE_REG_BITS_IS_ON(CR0_TXON,&pMacRegs->byCR0));
          writel(cpu_to_le32(pTD->pInfo->curr_desc),
		&pMacRegs->CurrTxDescAddr);
           //Re-send the packet
           pTD->tdesc0.f1Owner=OWNED_BY_NIC;
           BYTE_REG_BITS_ON(CR0_TXON,&pMacRegs->byCR0); 
           BYTE_REG_BITS_ON(CR1_TDMD1,&pMacRegs->byCR1);

     2. For Tx Abort (Too many collisions occurred).

          do {}  while (BYTE_REG_BITS_IS_ON(CR0_TXON,&pMacRegs->byCR0));

           //Drop the frame
           pCurrTD=pCurrTD->next;	
           writel(cpu_to_le32(pCurrTD->pInfo->curr_desc),
		&pMacRegs->CurrTxDescAddr);
			
           BYTE_REG_BITS_ON(CR0_TXON,&pMacRegs->byCR0);           	

           BYTE_REG_BITS_ON(CR1_TDMD1,&pMacRegs->byCR1);

     3. For Tx Descripts status write back  error.        
          do {}
          while (BYTE_REG_BITS_IS_ON(CR0_TXON,&pMacRegs->byCR0));

         // As Tx descriptors status write back error occurred, the status
of transmited Tx descriptor is incorrect. 
         //So, all frame must be droped.
          drop_all_transmited_frame();

          BYTE_REG_BITS_ON(CR0_TXON,&pMacRegs->byCR0);           	

          BYTE_REG_BITS_ON(CR1_TDMD1,&pMacRegs->byCR1);

         

Shing,

> -----Original Message-----
> From: Roger Luethi [mailto:rl@hellgate.ch]
> Sent: Thursday, May 16, 2002 11:14 AM
> To: Urban Widmark; Ivan G.; Jeff Garzik
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH] #2 VIA Rhine stalls: TxAbort handling
> 
> 
> This patch is against 2.4.19-pre8.
> 
> Patch description (changes over previous patch marked *):
> * Recover gracefully from TxAbort (the actual fix, new version)
> * Be more quiet about aborts, no need to fill log files or 
> scare people
> - Explicitly pick a backoff algorithm (alternative "fix")
> * Rename backoff bits
> - Remove full_duplex, duplex_lock, and advertising from netdev_private
> - Make use of MII register names somewhat more consistent
> - Update comment regarding config information at 0x78
> - Move comment on *_desc_status where it belongs
> * Remove DescEndPacket, DescIntr; unused and hardly correct
> - More comment details
> * Add TXDESC plus comments for desc_length
> * Reverted comment change "Tune configuration???". I am 
> genuinely puzzled
>   by that line. It sets "store & forward" in a way that 
> according to the
>   documentation is bound to be overriden by the threshold values set
>   elsewhere.
> 
> Note that the abort recovery piece is down to one additional 
> line of code
> compared to vanilla 2.4.19-pre8.
> 
> The summary of what happens: when an abort occurs at frame n, 
> the TxRingPtr
> has already been upped to n+2. Frame n will have a status 
> indicating an
> abort, whereas frame n+1 and following are still owned by the NIC. The
> problem is that the NIC forgets about that. When the driver issues a
> TxDemand after an abort, the NIC won't go back to update the 
> status for
> frame n+1. It will happily continue and send all the remaining frames
> starting with n+2. The driver will receive a bunch of 
> interrupts for sent
> frames, but it will never again scavenge another slot because the chip
> skipped one. Until a time out resets the chip, that is.
> 
> With the new patch, we don't break out to retransmit an aborted frame.
> Instead we scavenge all finished slots after the aborted one 
> (not that I
> think there will be any, but it doesn't hurt to be safe). So 
> once we enter
> the error handler, the aborted frame is reaped, and we _know_ 
> what the next
> frame we need to have sent is -- we just failed to scavenge 
> it because it's
> still owned by the NIC. And that's what we hammer into TxRingPtr. Now
> either the NIC was right (hypothetically speaking, it seems 
> to be wrong
> always), then the writel() is a nop. Or the NIC was confused, 
> then it's
> back on track again.
> 
> While TxAbort is the only error I have encountered 
> frequently, it is still
> tempting to think that the same problem hits us with other 
> errors as well,
> TxUnderrun being the most obvious candidate.
> 
> If this patch brings no improvement for the VT86C100A, you may want to
> watch the state of the rx/tx descriptors and the associated pointers.
> 
> The numbers haven't changed, by the way: I am still seeing 
> about 20% higher
> troughput with what is now called BackModify, despite the aborts it
> produces. Abort handling and resends are cheap compared to 
> the benefits of
> flooding the network with traffic, it seems. YMMV, as always.
> 
> Roger
> 
