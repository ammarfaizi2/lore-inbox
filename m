Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266103AbUFEAEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266103AbUFEAEP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 20:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266105AbUFEAEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 20:04:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48538 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266103AbUFEAEL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 20:04:11 -0400
Date: Sat, 5 Jun 2004 01:04:10 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, perex@suse.cz
Subject: Re: [RFC] ASLA design, depth of code review and lack thereof
Message-ID: <20040605000410.GT12308@parcelfarce.linux.theplanet.co.uk>
References: <20040604230819.GR12308@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0406041622480.7010@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406041622480.7010@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 04:29:20PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 5 Jun 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> >
> > 
> >         case SNDRV_PCM_FORMAT_FLOAT_BE:
> >         {
> >                 union {
> >                         float f;
> >                         u_int32_t i;
> >                 } u;
> >                 u.f = 0.0;
> > #ifdef SNDRV_LITTLE_ENDIAN
> >                 return bswap_32(u.i);
> > #else
> >                 return u.i;
> > #endif
> 
> So what I wonder about is why anybody does something like this in the 
> first place?
> 
> Any IEEE format architecture will make 0.0 be all-zeroes, last I saw. In
> fact, any architecture (IEEE or not) where that isn't true will have
> serious problems with floating point values in bss (hint: the bss isn't
> initialzed to 0.0, it's initialized to the bit pattern 0).
> 
> So what the above boils dow to is a very very strange way of writing
> 
> 	return 0;
> 
> and it has absolutely _zero_ to do with "little-endian" or anything else 
> for that matter.

	While we are at it, the function in question
(sound/core/pcm_misc.::snd_pcm_format_silence_64())
is a plain and simple array in disguise - it should've been

u_int64_t snd_pcm_format_silence_64(snd_pcm_format_t format)
{
	unsigned index = snd_enum_to_int(format); /* just a cast, hopefully */
	return index < SNDRV_PCM_FORMAT_LAST ? filler[index] : -EINVAL;
}

And -EINVAL here, BTW, is a broken interface - none of its callers are
checking for -EINVAL and that's a hell of an odd error value when normal
values can be all over the place in u64 anyway.

Looking at those callers, I'd say that this guy should be

unsigned char * find_filler(snd_pcm_format_t format)

and return a pointer to a (8-element) row in array of patterns.  Because
callers end up truncating the result and then filling a large area with
repeated copies.  All we get from use of u_int64_t is extra PITA with
endianness - memcpy from 1/2/4/8 element array is no less efficient than
assignment from u8/u16/u32/u64.
