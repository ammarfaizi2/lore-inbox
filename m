Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280510AbRJaVJV>; Wed, 31 Oct 2001 16:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280516AbRJaVJO>; Wed, 31 Oct 2001 16:09:14 -0500
Received: from [63.231.122.81] ([63.231.122.81]:16752 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S280510AbRJaVIz>;
	Wed, 31 Oct 2001 16:08:55 -0500
Date: Wed, 31 Oct 2001 14:07:43 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch] Re: Nasty suprise with uptime
Message-ID: <20011031140743.P16554@lynx.no>
Mail-Followup-To: Tim Schmielau <tim@physik3.uni-rostock.de>,
	vda <vda@port.imtp.ilyichevsk.odessa.ua>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <01103121070200.01262@nemo> <Pine.LNX.4.30.0110312138040.30038-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.30.0110312138040.30038-100000@gans.physik3.uni-rostock.de>; from tim@physik3.uni-rostock.de on Wed, Oct 31, 2001 at 09:47:52PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 31, 2001  21:47 +0100, Tim Schmielau wrote:
> OK, I introduced get_jiffies64, corrected my 64 bit mistake and
> subtract INITIAL_JIFFIES to obtain uptime, while leaving it at at pre-wrap
> value for error-chasing.
> Still this patch introduces jiffies_high on 64 bit platforms which will be
> useless until the year 571234830.

It probably won't be accepted until the whole thing disappears for 64-bit
systems.

> btw.: can someone please explain to me why do_timer uses
> 	(*(unsigned long *)&jiffies)++;
> instead of just doing jiffies++ ?

Can't say for sure, but it may be a compiler issue, maybe historical.


>  	 */
>  #if HZ!=100
>  	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
> -		uptime / HZ,
> -		(((uptime % HZ) * 100) / HZ) % 100,
> +		(unsigned long) uptime,
> +		((remainder * 100) / HZ) % 100,
>  		idle / HZ,
>  		(((idle % HZ) * 100) / HZ) % 100);

Given that uptime is now 64-bits, do we need this mathematical hoop jumping?
Also, won't the remainder already be modulus HZ in this case?

>  void do_timer(struct pt_regs *regs)
>  {
> -	(*(unsigned long *)&jiffies)++;
> +	/* we assume that two calls to do_timer can never overlap
> +	 * since they are one jiffie apart in time */
> +	if (jiffies != (unsigned long)(-1)) {
> +		jiffies++;
> +	} else {
> +		/* We still need to care about the race with readers of
> +		 * jiffies_hi. Readers have to discard the values if
> +		 * jiffies_hi != jiffies_hi_shadow when read with
> +		 * proper barriers in between. */
> +		jiffies_hi++;
> +		barrier();
> +		jiffies++;
> +		barrier();
> +		jiffies_hi_shadow = jiffies_hi;
> +		barrier();
> +	}

I think this is the part of the patch that people object to.  See my
other posting of how to handle 64-bit jiffies with only an impact to
users of the 64-bit value.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

