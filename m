Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbTENGDp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 02:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTENGDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 02:03:45 -0400
Received: from holomorphy.com ([66.224.33.161]:53440 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262073AbTENGDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 02:03:40 -0400
Date: Tue, 13 May 2003 23:16:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org, axel@pearbough.net
Subject: Re: drivers/scsi/aic7xxx/aic7xxx_osm.c: warning is error
Message-ID: <20030514061620.GL8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
	axel@pearbough.net
References: <20030514004009.GA20914@neon.pearbough.net> <20030514031826.GB29926@holomorphy.com> <493702704.1052892304@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <493702704.1052892304@aslan.scsiguy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 12:05:04AM -0600, Justin T. Gibbs wrote:
> I mind.  The replacement code is still wrong.

Let's see.


>>  	consumed = 1;
>> -	sg->addr = ahc_htole32(addr & 0xFFFFFFFF);
>> +	sg->addr = ahc_htole32(addr & ~0U);

On Wed, May 14, 2003 at 12:05:04AM -0600, Justin T. Gibbs wrote:
> This assumes that an unsigned int is 32bits.  The old code assumed
> that a long is at least 32bits.  Constants are promoted up to long
> if they will not fit in an int.

gcc never uses that model; hence it's fine for Linux. unsigned int is
32-bit on 64-bit and 32-bit, and it's actually guaranteed enough to
trip up others creating constant initializer bitmasks like
task->cpus_allowed and for other parts of the kernel to rely on it
for correctness. ILP64 is not supported by Linux.


On Wed, May 14, 2003 at 12:05:04AM -0600, Justin T. Gibbs wrote:
>>  	scb->platform_data->xfer_len += len;
>> -	if (sizeof(bus_addr_t) > 4
>> -	 && (ahc->flags & AHC_39BIT_ADDRESSING) != 0) {
>> +	if (sizeof(bus_addr_t) > 4 &&
>> +			(ahc->flags & AHC_39BIT_ADDRESSING) != 0) {

On Wed, May 14, 2003 at 12:05:04AM -0600, Justin T. Gibbs wrote:
> Superfluous style change.  The original style is intended and you will
> see that this style is consistently used throughout the driver.

Linux style conformance would be better.


> >  		/*
> > -		 * Due to DAC restrictions, we can't
> > -		 * cross a 4GB boundary.
> > +		 * Due to DAC restrictions, we can't cross 4GB boundaries.
> > +		 * Right shift by 30 to find GB-granularity placement
> > +		 * without getting tripped up by anal compilers.
> >  		 */
> > -		if ((addr ^ (addr + len - 1)) & ~0xFFFFFFFF) {
> > +		if ((addr >> 30) < 4 && ((addr + len - 1) >> 30) >= 4) {

On Wed, May 14, 2003 at 12:05:04AM -0600, Justin T. Gibbs wrote:
> What happens if the starting address is 0x00000070XXXXXXXX?  We cannot
> cross any 4GB boundary in the entire 64bit address space.  The previous
> code did that with the exception that the constant must be promoted
> to ULL:
> 		if ((addr ^ (addr + len - 1)) & 0xFFFFFFFF00000000ULL) {
> In other words, the high 32bits of the starting and ending address had 
> better be the same (x ^ x == 0).

The constant is never promoted to ULL by gcc. I've demonstrated that in
another post.


> > @@ -764,12 +766,22 @@ ahc_linux_map_seg(struct ahc_softc *ahc,
> >  			consumed++;
> >  			next_sg = sg + 1;
> >  			next_sg->addr = 0;
> > -			next_len = 0x100000000 - (addr & 0xFFFFFFFF);
> > +
> > +			/*
> > +			 * 2's complement arithmetic assumed.
> > +			 * We want: 4GB - low 32 bits of addr
> > +			 * to find the length of the low segment
> > +			 * and to subtract it out from the high
> > +			 */
> > +			next_len = -((uint32_t)addr);
> >  			len -= next_len;

On Wed, May 14, 2003 at 12:05:04AM -0600, Justin T. Gibbs wrote:
> This still leaves a bug. next_len and len are reversed.  I also feel
> that the previous code, if properly promoted, is clearer.  There is no
> need for a comment and the compiler should do the same truncation as
> is performed in the above code.

It is never promoted. There is also no difference between what
changed it to and what it did before besides the compile error.


>> -			next_len |= ((addr >> 8) + 0x1000000) & 0x7F000000;
>> +
>> +			/* c.f. struct ahc_dma_seg for meaning of high byte */
>> +			next_len |= ((addr >> 8) + AHC_SG_LEN_MASK + 1)
>> +						& AHC_SG_HIGH_ADDR_MASK;

On Wed, May 14, 2003 at 12:05:04AM -0600, Justin T. Gibbs wrote:
> Using (AHC_SG_LEN_MASK + 1) to mean 4GB >> 8 is not a way to make the
> code more readable.
> My patch for these issues follows.  A more formal BK submission will
> follow tomorrow.

I hadn't the foggiest idea you had that in mind. The best I could
reverse-engineer it to was the above.


On Wed, May 14, 2003 at 12:05:04AM -0600, Justin T. Gibbs wrote:
> Comments have indicated since the 2.4.X days that Linux will never allocate
> segments that cross a 4GB boundary.  If this is truely enforced, then this
> code can just be removed.  It was only added out of paranoia (hence the
> printf) while adding high address support to the driver.

I've heard the same from others.

All the above defense of my patch aside I don't have any issues with
your patch to resolve the compile errors and am fine with your
including it instead of my own.


-- wli
