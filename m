Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312987AbSD3QTT>; Tue, 30 Apr 2002 12:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313014AbSD3QTS>; Tue, 30 Apr 2002 12:19:18 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:43202 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S312987AbSD3QTQ>; Tue, 30 Apr 2002 12:19:16 -0400
Date: Tue, 30 Apr 2002 11:19:14 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: =?ISO-8859-1?Q?Jos=E9?= Fonseca <j_r_fonseca@yahoo.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to write portable MMIO code?
In-Reply-To: <20020430142212.GR18163@localhost>
Message-ID: <Pine.LNX.4.44.0204301112520.32217-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2002, José Fonseca wrote:

> I'm currently trying to get the Mach64 DRI driver to run on PowerPC. It's 
> mostly working but there are some strange behaviors (DMA works, MMIO not 
> really unless you make long waits when submiting, etc.). This is most 
> likely related with the MMIO programming macros in the kernel module.
> 
> My question is: How to code MMIO to be portable across all platforms, 
> i.e., taking in consideration the endian format and memory caches?
> 
> I've search thorougly the answer to this question but found 
> incomplete/contraditory answers:
> 
>   - should one use readl/writel or dereference the address directly?

Use readl/writel, that's why they exist.

>   - is the use of readl/writel macros suficient to account for endian 
> correctness or it's also needed to use the cpu_to_le32/le32_to_cpu macros?

They'll give you little endian always (i.e. they byteswap on big endian 
archs), so normally (register accesses) you shouldn't need additional 
swapping.

>   - should one in general (i.e., assuming the worst case) do wmb() on 
> writes, and mb() on reads?

I don't think mb() will help you. You're probably experiencing PCI posting 
problems - when a writel() has executed, that doesn't necessarily mean 
that the transaction has actually happened it may (and will) be buffered 
for a potentially long time.

However, PCI won't reorder reads vs. writes, so you when you want to be 
sure that a write() actually reached the hardware, do a dummy read() 
afterwards, that'll flush the write buffer.

--Kai


