Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280404AbRJaSlM>; Wed, 31 Oct 2001 13:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280405AbRJaSlD>; Wed, 31 Oct 2001 13:41:03 -0500
Received: from [63.231.122.81] ([63.231.122.81]:61799 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S280404AbRJaSk4>;
	Wed, 31 Oct 2001 13:40:56 -0500
Date: Wed, 31 Oct 2001 11:40:02 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Re: Nasty suprise with uptime
Message-ID: <20011031114002.H16554@lynx.no>
Mail-Followup-To: Tim Schmielau <tim@physik3.uni-rostock.de>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	vda <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1011031092415.9270A-101000@chaos.analogic.com> <Pine.LNX.4.30.0110311902410.29481-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.30.0110311902410.29481-100000@gans.physik3.uni-rostock.de>; from tim@physik3.uni-rostock.de on Wed, Oct 31, 2001 at 07:16:44PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 31, 2001  19:16 +0100, Tim Schmielau wrote:
> The idea was that all drivers that use the 32 bit jiffies counter have to
> be aware of the wraparound anyways, and won't see a difference.

Agreed.  I also like the change that you initialize jiffies to a pre-wrap
value, so the jiffies wrap bugs can more easily be found/fixed.

> The race only happens for 64 bit accesses to jiffies, but hey, without
> the patch these values come out wrong _every_ time, so I believed a
> tiny window for a single wrong display of uptime every 497.1 days to be
> acceptable.

I would say that the race is so rare that it should not be handled, especially
since it adds extra code in the timer interrupt.

> +	/* We need to make sure jiffies_high does not change while
> +	 * reading jiffies and jiffies_high */
> +	do {
> +		jiffies_high_tmp = jiffies_high_shadow;
> +		barrier();
> +		jiffies_tmp = jiffies;
> +		barrier();
> +	} while (jiffies_high != jiffies_high_tmp);

Maybe this could be condensed into a macro/inline, so that people don't
screw it up (and it looks cleaner).  Like get_jiffies64() or so, for
those few places that really care about the full value and can't stand
a miniscule chance of a race (i.e. uptime output is not a candidate).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

