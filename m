Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293466AbSCAR6Z>; Fri, 1 Mar 2002 12:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293462AbSCAR6O>; Fri, 1 Mar 2002 12:58:14 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:7152 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S293460AbSCAR6E>;
	Fri, 1 Mar 2002 12:58:04 -0500
Date: Fri, 1 Mar 2002 10:57:53 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] enable uptime display > 497 days on 32 bit (1/2)
Message-ID: <20020301105753.O22608@lynx.adilger.int>
Mail-Followup-To: Tim Schmielau <tim@physik3.uni-rostock.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0203010339240.3946-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0203010339240.3946-100000@gans.physik3.uni-rostock.de>; from tim@physik3.uni-rostock.de on Fri, Mar 01, 2002 at 03:55:25AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 01, 2002  03:55 +0100, Tim Schmielau wrote:
> rediffed to 2.4.19-pre2 and three micro-optimizations:
> 
>   move jiffies_hi etc. to same cacheline as jiffies
>     (suggested by George Anzinger)
>   avoid turning off interrupts (suggested by Andreas Dilger)
>   use unlikely() (suggested by Andreas Dilger)
> 
> As no other comments turned up, this will go to Marcelo RSN.
> (wondered why noone vetoed this as overkill...)

Minor nit - the indenting of #ifdefs is not really used in the kernel.

> +u64 get_jiffies64(void)
> +{
> +	unsigned long jiffies_tmp, jiffies_hi_tmp;
> +
> +	spin_lock(&jiffies64_lock);
> +	jiffies_tmp = jiffies;   /* avoid races */
> +	jiffies_hi_tmp = jiffies_hi;
> +	if (unlikely(jiffies_tmp < jiffies_last))   /* We have a wrap */
> +		jiffies_hi++;
> +	jiffies_last = jiffies_tmp;
> +	spin_unlock(&jiffies64_lock);
> +
> +	return (jiffies_tmp | ((u64)jiffies_hi_tmp) << BITS_PER_LONG);
> +}

If jiffies_hi is incremented, then jiffies_hi_tmp will be wrong on return.

> +static void check_jiffieswrap(unsigned long data)
> +{
> +	unsigned long jiffies_tmp;
> +	mod_timer(&jiffieswrap_timer, jiffies + CHECK_JIFFIESWRAP_INTERVAL);
> +
> +	if (spin_trylock(&jiffies64_lock)) {
> +		/* If we don't get the lock, we can just give up.
> +		   The current holder of the lock will check for wraps */
> +		jiffies_tmp = jiffies;   /* avoid races */
> +		if (jiffies_tmp < jiffies_last)   /* We have a wrap */
> +			jiffies_hi++;
> +		jiffies_last = jiffies_tmp;
> +		spin_unlock(&jiffies64_lock);
> +	}                                                                  }
note:----------------------------------------------------------------------^

Since check_jiffieswrap() and get_jiffies64() are substantially the same,
you may want to define a function _inc_jiffies64() which does:

+#ifdef NEEDS_JIFFIES64
+/* jiffies_hi and jiffies_last are protected by jiffies64_lock */
+static unsigned long jiffies_hi, jiffies_last;
+static spinlock_t jiffies64_lock = SPIN_LOCK_UNLOCKED;
+#endif

static inline void _inc_jiffies64(unsigned long jiffies_tmp)
{
	jiffies_tmp = jiffies;   /* avoid races */
	if (jiffies_tmp < jiffies_last)   /* We have a wrap */
		jiffies_hi++;
	jiffies_last = jiffies_tmp;
}

static void get_jiffies64()
{
	unsigned long jiffies_tmp, jiffies_hi_tmp;

	spin_lock(&jiffies64_lock);
	_inc_jiffies64(jiffies_tmp);
	jiffies_hi_tmp = jiffies_hi;
	spin_unlock(&jiffies64_lock);

	return (jiffies_tmp | ((u64)jiffies_hi_tmp) << BITS_PER_LONG);
}

static void check_jiffieswrap(unsigned long data)
{
	unsigned long jiffies_tmp;
	mod_timer(&jiffieswrap_timer, jiffies + CHECK_JIFFIESWRAP_INTERVAL);

	/*
	 * If we don't get the lock, we can just give up.
	 * The current holder of the lock will check for wraps
	 */
	if (spin_trylock(&jiffies64_lock)) {
		_inc_jiffies64(jiffies_tmp);
		spin_unlock(&jiffies64_lock);
	}
}

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

