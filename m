Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293478AbSCASWC>; Fri, 1 Mar 2002 13:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293479AbSCASVy>; Fri, 1 Mar 2002 13:21:54 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:5139 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S293478AbSCASVt>; Fri, 1 Mar 2002 13:21:49 -0500
Date: Fri, 1 Mar 2002 19:21:45 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andreas Dilger <adilger@clusterfs.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] enable uptime display > 497 days on 32 bit (1/2)
In-Reply-To: <20020301105753.O22608@lynx.adilger.int>
Message-ID: <Pine.LNX.4.33.0203011903110.9974-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002, Andreas Dilger wrote:

> On Mar 01, 2002  03:55 +0100, Tim Schmielau wrote:
[...]
> > As no other comments turned up, this will go to Marcelo RSN.
> > (wondered why noone vetoed this as overkill...)
> 
> Minor nit - the indenting of #ifdefs is not really used in the kernel.
> 
> > +u64 get_jiffies64(void)
> > +{
> > +	unsigned long jiffies_tmp, jiffies_hi_tmp;
> > +
> > +	spin_lock(&jiffies64_lock);
> > +	jiffies_tmp = jiffies;   /* avoid races */
> > +	jiffies_hi_tmp = jiffies_hi;
> > +	if (unlikely(jiffies_tmp < jiffies_last))   /* We have a wrap */
> > +		jiffies_hi++;
> > +	jiffies_last = jiffies_tmp;
> > +	spin_unlock(&jiffies64_lock);
> > +
> > +	return (jiffies_tmp | ((u64)jiffies_hi_tmp) << BITS_PER_LONG);
> > +}
> 
> If jiffies_hi is incremented, then jiffies_hi_tmp will be wrong on return.

Thanks!
I thought I had corrected this but somehow must have posted a previous
version. I will probably soon be known as a sloppy coder :-(

> note:----------------------------------------------------------------------^
> 
> Since check_jiffieswrap() and get_jiffies64() are substantially the same,
> you may want to define a function _inc_jiffies64() which does:
> 
> +#ifdef NEEDS_JIFFIES64
> +/* jiffies_hi and jiffies_last are protected by jiffies64_lock */
> +static unsigned long jiffies_hi, jiffies_last;
> +static spinlock_t jiffies64_lock = SPIN_LOCK_UNLOCKED;
> +#endif
> 
> static inline void _inc_jiffies64(unsigned long jiffies_tmp)
> {
> 	jiffies_tmp = jiffies;   /* avoid races */
> 	if (jiffies_tmp < jiffies_last)   /* We have a wrap */
> 		jiffies_hi++;
> 	jiffies_last = jiffies_tmp;
> }

Shouldn't this be 

static inline void _inc_jiffies64(unsigned long *jiffies_tmp)
{
	*jiffies_tmp = jiffies;   /* avoid races */
	if (*jiffies_tmp < jiffies_last)   /* We have a wrap */
		jiffies_hi++;
	jiffies_last = *jiffies_tmp;
}

?
So that we'd then need

static u64 get_jiffies64(void)
{
	unsigned long jiffies_tmp, jiffies_hi_tmp;

	spin_lock(&jiffies64_lock);
	_inc_jiffies64(&jiffies_tmp);
	jiffies_hi_tmp = jiffies_hi;
	spin_unlock(&jiffies64_lock);

	return (jiffies_tmp | ((u64)jiffies_hi_tmp) << BITS_PER_LONG);
}
...

And I'm still thinking of a better name that _inc_jiffies64(), since
we most of the time don't increment anything.

Tim

