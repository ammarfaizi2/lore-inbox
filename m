Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVD2Eqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVD2Eqz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 00:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVD2Eqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 00:46:54 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:30442 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262116AbVD2Eqo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 00:46:44 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Olof Johansson <olof@austin.ibm.com>
Subject: Re: [PATCH 3/4] ppc64: Add driver for BPA iommu
Date: Fri, 29 Apr 2005 06:35:43 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>
References: <200504190318.32556.arnd@arndb.de> <200504280813.j3S8DNLc019256@post.webmailer.de> <20050428140558.GB1023@austin.ibm.com>
In-Reply-To: <20050428140558.GB1023@austin.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200504290635.44965.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dunnersdag 28 April 2005 16:05, Olof Johansson wrote:

> On Thu, Apr 28, 2005 at 09:59:26AM +0200, Arnd Bergmann wrote:
> > +/* some constants */
> > +enum {
> > +	/* segment table entries */
> [...]
> > +};
> 
> Hmm. I thought the benefit of enum was to be able to do type checking
> later on if it's a typed enum. Here you mix different definitions in
> the same large untyped enum declaration. Can they be moved to a
> bpa_iommu.h file and #defined instead?

I prefer to avoid macros altogether, and this is one of the ways to
do it. We have had the discussion about how to define constants
a few times before on lkml without reaching a conclusion.

> > +/* cause link error for invalid use */
> > +extern unsigned long __ioc_invalid_page_size;
> [...]
> > +	default: /* not a known compile time constant */
> > +		ps = __ioc_invalid_page_size;
> > +		break;
> > +	}
> 
> Why do we need to detect this at link time?

I want to avoid doing BUG() or something similar, so I
try to detect a user error as early as possible.

> > +	nnpt++; /* XXX is this right? */
> 
> Well, does it work?  :-)

Yes, but it seems to contradict the specs...

> > +	return (ioste) {
> > +		.val = IOST_VALID_MASK
> > +			| (iostep & IOST_PT_BASE_MASK)
> > +			| ((nnpt << 5) & IOST_NNPT_MASK)
> > +			| (ps & IOST_PS_MASK)
> > +		};
> 
> Can you create a mk_ioste() inline instead of doing this construct?

ok.
 
> > +static inline unsigned long
> > +get_ioptep(ioste iost_entry, unsigned long io_address)
> > +{
> > +	unsigned long iopt_base;
> > +	unsigned long ps;
> > +	unsigned long iopt_offset;
> > +
> > +	iopt_base = iost_entry.val & IOST_PT_BASE_MASK;
> > +	ps        = iost_entry.val & IOST_PS_MASK;
> > +
> > +	iopt_offset = ((io_address & 0x0fffffff) >> (7 + 2 * ps)) & 0x7fff8ul;
> 
> Magic. Can we get it explained either by defines instead of constants
> or by a comment?

This comes from a graphical representation in the specs. I'll add a comment
to point to that image.

> > +static inline ioste
> > +get_iost_cache(void __iomem *base, unsigned long index)
> > +{
> > +	unsigned long __iomem *p = (base + IOC_ST_CACHE_DIR);
> > +	return (ioste) { in_be64(&p[index]) };
> 
> mk_ioste() would be nice here too.

ok.

> > +#ifdef __KERNEL__
> 
> Are we ever not __KERNEL__?

Sorry, I thought I had removed that code already. This does not belong
there.

> > +/* initialize the iommu to support a simple linear mapping */
> > +static void bpa_map_iommu(void)
> > +{
> [...]
> > +	for (address = 0; address < 0x100000000ul; address += io_page_size) {
> 
> This looks like way more than the 512MB DMA window you mentioned in the
> beginning. 

True. This is probably a bug in the comment. The code will change as soon
as the firmware provides the correct dma-window properties.

	Arnd <><

