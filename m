Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280496AbRJaUxk>; Wed, 31 Oct 2001 15:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280503AbRJaUxb>; Wed, 31 Oct 2001 15:53:31 -0500
Received: from [63.231.122.81] ([63.231.122.81]:2416 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S280496AbRJaUxS>;
	Wed, 31 Oct 2001 15:53:18 -0500
Date: Wed, 31 Oct 2001 13:52:15 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Gerhard Mack <gmack@innerfire.net>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Tim Schmielau <tim@physik3.uni-rostock.de>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Re: Nasty suprise with uptime
Message-ID: <20011031135215.O16554@lynx.no>
Mail-Followup-To: Gerhard Mack <gmack@innerfire.net>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	vda <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1011031141239.20901A-100000@chaos.analogic.com> <Pine.LNX.4.10.10110311206020.6571-100000@innerfire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.10.10110311206020.6571-100000@innerfire.net>; from gmack@innerfire.net on Wed, Oct 31, 2001 at 12:11:18PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 31, 2001  12:11 -0800, Gerhard Mack wrote:
> Yes that I understand and it works right up until the jiffie count wraps.
> But now we have people adding cost to everything else just so we can all
> have good uptime values.  Since AFIK the drivers handle the wrap cleanly
> the only thing that it bothers is the uptime stats.
> 
> Now we have people making jiffies more expensive just to deal with uptime.
> At least as far as I can see it should just be easier/better to make
> uptime use something else.

What about the following.  Since jiffies wraps are extremely rare, it
should be enough to have something along the lines of the following
in the uptime code only (or globally accessible for any code that
needs to use a full 64-bit jiffies value):

u64 get_jiffies64(void)
{
	static unsigned long jiffies_hi = 0;
	static unsigned long jiffies_last = INITIAL_JIFFIES;

	/* probably need locking for this part */
	if (jiffies < jiffies_last) {	/* We have a wrap */
		jiffies_hi++;
		jiffies_last = jiffies;
	}

	return (jiffies | ((u64)jiffies_hi) << LONG_SHIFT));
}

This means you need to call something that _checks_ the uptime
(or needs the 64-bit jiffies value) at least once every 1.3 years.
If you don't do it at least that often, you probably don't care
about the uptime anyways.

This only impacts anything that really needs a 64-bit jiffies count,
and has zero impact everywhere else.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

