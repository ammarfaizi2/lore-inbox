Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267916AbRHASky>; Wed, 1 Aug 2001 14:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267923AbRHASkp>; Wed, 1 Aug 2001 14:40:45 -0400
Received: from barney.blueskylabs.com ([64.0.135.181]:23541 "EHLO
	barney.intra.blueskylabs.com") by vger.kernel.org with ESMTP
	id <S267916AbRHASkf> convert rfc822-to-8bit; Wed, 1 Aug 2001 14:40:35 -0400
Subject: Memory Write Ordering Question
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Date: Wed, 1 Aug 2001 11:44:10 -0700
Message-ID: <32B25F556FCD9D418D73C742C9B2E36D0188CC@barney.intra.blueskylabs.com>
Thread-Topic: Memory Write Ordering Question
Thread-Index: AcEaufOUkKiFcU4jRJWBnrt3gc3qLA==
From: "James W. Lake" <jim@intra.blueskylabs.com>
To: "Linux Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I've run into a problem with memory write ordering on a PCI Device.  

The  card has 2 memory regions, pthis->pConfigMem (PCI Chip
Configuration), and pthis->pDspMem (A DSP's memory on the PCI Card)

The code sequence below doesn't work out as expected.  The
writel(temp,addr); at the bottom actually occurs in the middle of the
memcpy_toio() operation.

The slew of barrier, mb, wmb, rmb's seem to be completely ignored.  
If I uncomment the line: junk = readl(pthis->pDspMem);  everything
behaves as expected.

I'm wondering if anyone has any idea what exactly is causing this.  The
readl is a so-so work around.  I'd like to figure out how to do it
correctly.  Does anyone who knows more about Intel CPU's and write
ordering and PCI have any ideas?

I can very reliably monitor the code's behavior, so it's easy to tell if
its fixed.  :-)

Also,  the LSPAM() lines are simply printk macros.  If I have them
actually outputting, the code also works correctly.  If they are
suppressed, the bug still happens.

Thanks,
Jim Lake

// Code Snip it

static int DspDebugSpeed(Board *pthis, void *pbuf, u16 len)
{


    u32 temp;
    unsigned long addr;
    u32 junk;
    LDEBUG("Entry");

    memcpy_toio(pthis->pDspMem,pbuf,len);
//    junk = readl(pthis->pDspMem);
    
    LSPAM("Setting DSP Address to 0x%x",0x5001);
    
    mb();
    barrier();
    mb();
    wmb();
    rmb();


    addr = (unsigned long)pthis->pConfigMem + PLX_REG_GPIO;
    
    temp = readl(addr);
    LSPAM("Got Long (0x%x) from addr (0x%lx)",temp,addr);
   
    temp &= ~PLX_DSP_ADDR_DISABLE;
    temp |= PLX_DSP_ADDR_OUTPUT;
    temp &= ~PLX_DSP_ADDR_HIGH;
    
    mb();
    barrier();
    mb();
    wmb();
    rmb();

    addr = (unsigned long)pthis->pConfigMem + PLX_REG_GPIO;
    LSPAM("Writing Data (0x%x) to addr (0x%lx)",temp,addr);
    writel(temp,addr);
    return(0);
}
