Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317577AbSFIIs4>; Sun, 9 Jun 2002 04:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317582AbSFIIsz>; Sun, 9 Jun 2002 04:48:55 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:29702 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317577AbSFIIsz>; Sun, 9 Jun 2002 04:48:55 -0400
Date: Sun, 9 Jun 2002 09:48:49 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Message-ID: <20020609094849.A30062@flint.arm.linux.org.uk>
In-Reply-To: <20020608.222942.111546622.davem@redhat.com> <200206090633.g596XZI472183@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2002 at 02:33:35AM -0400, Albert D. Cahalan wrote:
> For device --> memory DMA:
> 
> 1. write back cache lines that cross unaligned boundries

What if some of the cache lines inside the DMA region are dirty and...

> 2. start the DMA

get evicted now when the CPU is doing something else?

> 3. invalidate the above cache lines
> 4. invalidate cache lines that are fully inside the DMA

You really need to:

 1. write back cache lines that cross unaligned boundries
 3. invalidate the above cache lines
 2. start the DMA
 4. invalidate cache lines that are fully inside the DMA

which is precisely we do on ARM.

> For memory --> device DMA:
> 
> 1. write back all cache lines affected by the DMA
> 2. start the DMA
> 3. invalidate the above cache lines

What's the point of (3) ?  The data in memory hasn't been changed by DMA.
What if we were writing out a page that was mmaped into a process, and
the process wrote to that page while we were DMAing ?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

