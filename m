Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276877AbRJQQWK>; Wed, 17 Oct 2001 12:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276933AbRJQQWA>; Wed, 17 Oct 2001 12:22:00 -0400
Received: from t2.redhat.com ([199.183.24.243]:18415 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S276877AbRJQQVp>; Wed, 17 Oct 2001 12:21:45 -0400
Message-ID: <3BCDB039.8F00D818@redhat.com>
Date: Wed, 17 Oct 2001 17:22:17 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-4smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.4.14prex and qlogicfc
In-Reply-To: <C5C45572D968D411A1B500D0B74FF4A80418D570@xfc01.fc.hp.com>
		<20011017081837.C3035@suse.de> <20011016.233534.48799017.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Jens Axboe <axboe@suse.de>
>    Date: Wed, 17 Oct 2001 08:18:37 +0200
> 
>    On Tue, Oct 16 2001, DICKENS,CARY (HP-Loveland,ex2) wrote:
>    > I'm seeing a problem on all the kernels that are 2.4.13pre1 and up.
> 
>    This smells like a bug in the pci64 conversion of qlogicfc. Maybe davem
>    has an idea, I'll take a look too.
> 
> Not if it broke in pre1 since the pci64 stuff went into pre2 :-)

since it broke as of pre2, the following things are suspect:

if  BITS_PER_LONG > 32
#define pci_dma_lo32(a) (a & 0xffffffff)
#define pci_dma_hi32(a) ((a >> 32) & 0xffffffff)
#else
#define pci_dma_lo32(a) (a & 0xffffffff)
#define pci_dma_hi32(a) 0
#endif


#if  BITS_PER_LONG <= 32
#define  VIRT_TO_BUS_LOW(a) (uint32_t)virt_to_bus(((void *)a))
#define  VIRT_TO_BUS_HIGH(a) (uint32_t)(0x0)
#else
#define  VIRT_TO_BUS_LOW(a) (uint32_t)(0xffffffff & virt_to_bus((void
*)(a)))
#define  VIRT_TO_BUS_HIGH(a) (uint32_t)(0xffffffff & (virt_to_bus((void
*)(a))>
#endif#

if BITS_PER_LONG > 32
        uint64_t request_dma;        /* Physical address. */
#else
        uint32_t request_dma;        /* Physical address. */
#endif

the later is abused instead of dma_addr_t and friends, and is used for
several other physical address
variables as well.
