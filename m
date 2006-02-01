Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422893AbWBATfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422893AbWBATfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 14:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422894AbWBATfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 14:35:21 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43025 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1422893AbWBATfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 14:35:20 -0500
Date: Wed, 1 Feb 2006 19:35:10 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Christoph Hellwig'" <hch@infradead.org>,
       "'Akinobu Mita'" <mita@miraclelinux.com>,
       Grant Grundler <iod00d@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH 1/12] generic *_bit()
Message-ID: <20060201193510.GH3072@flint.arm.linux.org.uk>
Mail-Followup-To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	'Christoph Hellwig' <hch@infradead.org>,
	'Akinobu Mita' <mita@miraclelinux.com>,
	Grant Grundler <iod00d@hp.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	linux-ia64@vger.kernel.org
References: <20060201191957.GG3072@flint.arm.linux.org.uk> <200602011925.k11JPYg22845@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602011925.k11JPYg22845@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 11:25:25AM -0800, Chen, Kenneth W wrote:
> Russell King wrote on Wednesday, February 01, 2006 11:20 AM
> > > I think these should be defined to operate on arrays of unsigned int.
> > > Bit is a bit, no matter how many byte you load (8/16/32/64), you can
> > > only operate on just one bit.
> > 
> > Invalid assumption, from the point of view of endianness across different
> > architectures.  Consider where bit 0 is for a LE and BE unsigned long *
> > vs a LE and BE unsigned char *.
> 
> Where the bit end up in LE or BE is irrelevant. As long as one always
> use the same bit numbering and same address pointer type, you always
> get the same bit.  Or am I missing something?

>From a 32-bit long perspective, bit 0 of a long is always the bit which
represents odd numbers.  Where this falls depends on the endianness:

                       MSB                    LSB
big-endian long0:      byte0  byte1  byte2  byte3
little-endian long0:   byte3  byte2  byte1  byte0

Bit 0 of a BE long ends up at byte 3 bit 0.
Bit 0 of a LE long ends up at byte 0 bit 0.

However, bit 0 of a byte stream is always byte 0 bit 0.

Hence, converting the bitops to take a different sized pointer from
the one we presently pass changes the semantics of the function for
big endian machines - by the fact that you change the order of bits
in memory.

Whether this matters or not is up to how the bitops are used.  If
it's something which only bitops operate on, it probably doesn't
make that much difference.  If it's some external data or some
data which is accessed in other ways, it most certainly does matter.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
