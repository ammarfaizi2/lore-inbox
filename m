Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265902AbRF1N4f>; Thu, 28 Jun 2001 09:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265921AbRF1N4Y>; Thu, 28 Jun 2001 09:56:24 -0400
Received: from t2.redhat.com ([199.183.24.243]:63728 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265902AbRF1N4K>; Thu, 28 Jun 2001 09:56:10 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E15FbuU-0006wH-00@the-village.bc.nu> 
In-Reply-To: <E15FbuU-0006wH-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dhowells@redhat.com (David Howells), linux-kernel@vger.kernel.org,
        arjanv@redhat.com
Subject: Re: [RFC] I/O Access Abstractions 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Jun 2001 14:55:38 +0100
Message-ID: <7040.993736538@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  PCI memory (and sometimes I/O) writes are posted, Since x86 memory
> writes are also parallelisable instructions and since the CPU merely
> has to retire the writes in order your stall basically doesnt exist.

True. I can envisage a situation where the overhead of the function call is
noticeable. It would be interesting to see if it actually happens in real
life. If so, and if we set up the abstraction properly, we can keep
the accesses inline for those architectures where it's a win.

	#ifdef CONFIG_VIRTUAL_BUS
	#define resource_readb(res, x) res->readb(res, x)
	#else
	#define resource_readb(res, x) readb(x)
	#endif

Having per-resource I/O methods would help us to remove some of the
cruft which is accumulating in various non-x86 code. Note that the below is
the _core_ routines for _one_ board - I'm not even including the extra
indirection through the machine vector here....

static inline volatile __u16 *
port2adr(unsigned int port)
{
        if (port > 0x2000)
                return (volatile __u16 *) (PA_MRSHPC + (port - 0x2000));
        else if (port >= 0x1000)
                return (volatile __u16 *) (PA_83902 + (port << 1));
        else if (sh_pcic_io_start <= port && port <= sh_pcic_io_stop)
                return (volatile __u16 *) (sh_pcic_io_wbase + (port &~ 1));
        else
                return (volatile __u16 *) (PA_SUPERIO + (port << 1));
}

static inline int
shifted_port(unsigned long port)
{
        /* For IDE registers, value is not shifted */
        if ((0x1f0 <= port && port < 0x1f8) || port == 0x3f6)
                return 0;
        else
                return 1;
}

unsigned char se_inb(unsigned long port)
{
        unsigned long pciiobrSet;
        volatile unsigned long pciIoArea;
        unsigned char pciIoData;

        if (PXSEG(port))
                return *(volatile unsigned char *)port;
#if defined(CONFIG_CPU_SUBTYPE_SH7751) && defined(CONFIG_PCI)
        else if((port >= PCIBIOS_MIN_IO) && (port <= PCIBIOS_MIN_IO + SH7751_PCI_IO_SIZE)) {
                pciiobrSet  = (port & 0xFFFC0000);
                *PCIIOBR    = pciiobrSet;
                pciIoArea   = port & 0x0003FFFF;
                pciIoArea  += PCI_IO_AREA;
                pciIoData   = *((unsigned char*)pciIoArea);   
                return (unsigned char)pciIoData;
        }
#endif /* defined(CONFIG_CPU_SUBTYPE_SH7751) && defined(CONFIG_PCI) */
        else if (sh_pcic_io_start <= port && port <= sh_pcic_io_stop)
                return *(__u8 *) (sh_pcic_io_wbase + 0x40000 + port); 
        else if (shifted_port(port))
                return (*port2adr(port) >> 8); 
        else
                return (*port2adr(port))&0xff; 
}




--
dwmw2


