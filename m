Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314485AbSEPSGA>; Thu, 16 May 2002 14:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314487AbSEPSF7>; Thu, 16 May 2002 14:05:59 -0400
Received: from mta3n.bluewin.ch ([195.186.1.212]:58771 "EHLO mta3n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S314485AbSEPSF6>;
	Thu, 16 May 2002 14:05:58 -0400
Date: Thu, 16 May 2002 20:03:54 +0200
From: "'Roger Luethi'" <rl@hellgate.ch>
To: Shing Chuang <ShingChuang@via.com.tw>
Cc: Urban Widmark <urban@teststation.com>,
        "Ivan G." <ivangurdiev@linuxfreemail.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        AJ Jiang <AJJiang@via.com.tw>
Subject: Re: [PATCH] #2 VIA Rhine stalls: TxAbort handling
Message-ID: <20020516180354.GA9151@k3.hellgate.ch>
In-Reply-To: <369B0912E1F5D511ACA5003048222B75A3C06B@EXCHANGE2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.19-pre8 on i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2002 18:03:25 +0800, Shing Chuang wrote:
>      As following three error conditions occurred,   the VT6102 & VT86C100A
> chip are designed to shutdown TX for driver to examine the error frame.
> 
>      1. Tx fifo underrun.                   
> 
>      2. Tx Abort (Too many collisions occurred).
> 
>      3. TxDescriptors status write back  error. (Only on VT6102 chip)

Hey, thanks! That's exactly the piece of information I've been looking for.

>      All the three conditions caused the TXON bit of CR1 went off. the
> driver must wait  a little while until the bit go off, reset the pointer of
> [...]
>           do {} while (BYTE_REG_BITS_IS_ON(CR0_TXON,&pMacRegs->byCR0));

The driver "waits a little" in the interrupt handler? How long can that
take, worst case? I don't know of many places where the kernel stops to
wait for an external device to change some value.

I have no numbers on the expected number of iterations, but I'd rather drop
out of the handler after a few failed checks and try again later (or just
reset the chip and log an error, if dropping out is rare enough :-)).

> current Tx descriptor, and  then turn on TXON bit of CR1 again. Those may be

ITYM the TXON bit of CR0. TDMD1 is the one you are setting in CR1. Which
takes me to the next question:

According to my docs, internal registers are like this:

VT86C100A
Byte Bit
0x08 (CR0) 5   TDMD
0x08 (CR0) 6   RDMD
0x09 (CR1) 5   Reserved
0x09 (CR1) 6   Reserved

VT6102
Byte Bit
0x08 (CR0) 5   TDMD
0x08 (CR0) 6   RDMD
0x09 (CR1) 5   TDMD1
0x09 (CR1) 6   RDMD1

The descriptions in both data sheets are somewhat unclear, so maybe you
could enlighten me about why you chose to set TDMD1 instead of TDMD (which
is what the LK driver does)?

Roger
