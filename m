Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVD1OGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVD1OGu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 10:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVD1OGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 10:06:50 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:63386 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262140AbVD1OGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 10:06:44 -0400
Date: Thu, 28 Apr 2005 09:05:58 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc64-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 3/4] ppc64: Add driver for BPA iommu
Message-ID: <20050428140558.GB1023@austin.ibm.com>
References: <200504190318.32556.arnd@arndb.de> <200504280813.j3S8DNLc019256@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504280813.j3S8DNLc019256@post.webmailer.de>
User-Agent: Mutt/1.5.6+20040907i
From: olof@austin.ibm.com (Olof Johansson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some comments below.

On Thu, Apr 28, 2005 at 09:59:26AM +0200, Arnd Bergmann wrote:
> Index: linus-2.5/arch/ppc64/kernel/bpa_iommu.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linus-2.5/arch/ppc64/kernel/bpa_iommu.c	2005-04-22 07:01:39.000000000 +0200
> @@ -0,0 +1,433 @@

> +/* some constants */
> +enum {
> +	/* segment table entries */
[...]
> +};

Hmm. I thought the benefit of enum was to be able to do type checking
later on if it's a typed enum. Here you mix different definitions in
the same large untyped enum declaration. Can they be moved to a
bpa_iommu.h file and #defined instead?

> +/* cause link error for invalid use */
> +extern unsigned long __ioc_invalid_page_size;
[...]
> +	default: /* not a known compile time constant */
> +		ps = __ioc_invalid_page_size;
> +		break;
> +	}

Why do we need to detect this at link time?

> +	nnpt++; /* XXX is this right? */

Well, does it work?  :-)

> +	return (ioste) {
> +		.val = IOST_VALID_MASK
> +			| (iostep & IOST_PT_BASE_MASK)
> +			| ((nnpt << 5) & IOST_NNPT_MASK)
> +			| (ps & IOST_PS_MASK)
> +		};

Can you create a mk_ioste() inline instead of doing this construct?

> +static inline unsigned long
> +get_ioptep(ioste iost_entry, unsigned long io_address)
> +{
> +	unsigned long iopt_base;
> +	unsigned long ps;
> +	unsigned long iopt_offset;
> +
> +	iopt_base = iost_entry.val & IOST_PT_BASE_MASK;
> +	ps        = iost_entry.val & IOST_PS_MASK;
> +
> +	iopt_offset = ((io_address & 0x0fffffff) >> (7 + 2 * ps)) & 0x7fff8ul;

Magic. Can we get it explained either by defines instead of constants
or by a comment?

> +/* compute the hashed 6 bit index for the 4-way associative pte cache */
> +static inline unsigned long
> +get_ioc_hash(ioste iost_entry, unsigned long io_address)
> +{
> +	unsigned long iopte = get_ioptep(iost_entry, io_address);
> +
> +	return ((iopte & 0x000000000000001f8ul) >> 3)
> +	     ^ ((iopte & 0x00000000000020000ul) >> 17)
> +	     ^ ((iopte & 0x00000000000010000ul) >> 15)
> +	     ^ ((iopte & 0x00000000000008000ul) >> 13)
> +	     ^ ((iopte & 0x00000000000004000ul) >> 11)
> +	     ^ ((iopte & 0x00000000000002000ul) >> 9)
> +	     ^ ((iopte & 0x00000000000001000ul) >> 7);

Can't you reverse the subword by just doing one XOR instead of 6?
That's what I did for the ext2 bitops on ppc64. See
http://www.ussg.iu.edu/hypermail/linux/kernel/0408.2/1321.html

> +static inline ioste
> +get_iost_cache(void __iomem *base, unsigned long index)
> +{
> +	unsigned long __iomem *p = (base + IOC_ST_CACHE_DIR);
> +	return (ioste) { in_be64(&p[index]) };

mk_ioste() would be nice here too.

> +#ifdef __KERNEL__

Are we ever not __KERNEL__?

> +/* initialize the iommu to support a simple linear mapping */
> +static void bpa_map_iommu(void)
> +{
[...]
> +	for (address = 0; address < 0x100000000ul; address += io_page_size) {

This looks like way more than the 512MB DMA window you mentioned in the
beginning. 




-Olof
