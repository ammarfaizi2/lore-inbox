Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267289AbSLEL2V>; Thu, 5 Dec 2002 06:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267291AbSLEL2V>; Thu, 5 Dec 2002 06:28:21 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53772 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267289AbSLEL2U>; Thu, 5 Dec 2002 06:28:20 -0500
Date: Thu, 5 Dec 2002 11:35:46 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Gibson <david@gibson.dropbear.id.au>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021205113546.A22686@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	James Bottomley <James.Bottomley@steeleye.com>,
	linux-kernel@vger.kernel.org
References: <200212041747.gB4HlEF03005@localhost.localdomain> <20021205004744.GB2741@zax.zax> <1039086496.651.65.camel@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1039086496.651.65.camel@zion>; from benh@kernel.crashing.org on Thu, Dec 05, 2002 at 12:08:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 12:08:16PM +0100, Benjamin Herrenschmidt wrote:
> For things like ring descriptors of a net driver, I feel it's very much
> simpler (and possibly more efficient too) to also allocate non-cacheable
> space for consistent instead of continuously flushing/invalidating.
> Actually, flush/invalidate here can also have nasty side effects if
> several descriptors fit in the same cache line.

Indeed.  Think about a 16-byte descriptor in a 32-byte cache line.
The net chip has written status information to the first word, you've
just written to the 4th word of that cache line.

To access the status word written by the chip, you need to invalidate
(without writeback) that cache line.  For the chip to access the word
you've just written, you need to writeback that cache line.

In other words, you _will_ loose information in this case, guaranteed.
I'd rather keep our existing pci_* API than be forced into this crap
again.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

