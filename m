Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280526AbRJaVRV>; Wed, 31 Oct 2001 16:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280524AbRJaVRM>; Wed, 31 Oct 2001 16:17:12 -0500
Received: from chaos.analogic.com ([204.178.40.224]:30081 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S280523AbRJaVRD>; Wed, 31 Oct 2001 16:17:03 -0500
Date: Wed, 31 Oct 2001 16:17:36 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andreas Dilger <adilger@turbolabs.com>
cc: Gerhard Mack <gmack@innerfire.net>,
        Tim Schmielau <tim@physik3.uni-rostock.de>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <20011031135215.O16554@lynx.no>
Message-ID: <Pine.LNX.3.95.1011031161340.21906B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Andreas Dilger wrote:

> On Oct 31, 2001  12:11 -0800, Gerhard Mack wrote:
> > Yes that I understand and it works right up until the jiffie count wraps.
> > But now we have people adding cost to everything else just so we can all
> > have good uptime values.  Since AFIK the drivers handle the wrap cleanly
> > the only thing that it bothers is the uptime stats.
> > 
> > Now we have people making jiffies more expensive just to deal with uptime.
> > At least as far as I can see it should just be easier/better to make
> > uptime use something else.
> 
> What about the following.  Since jiffies wraps are extremely rare, it
> should be enough to have something along the lines of the following
> in the uptime code only (or globally accessible for any code that
> needs to use a full 64-bit jiffies value):
> 
> u64 get_jiffies64(void)
> {
> 	static unsigned long jiffies_hi = 0;
> 	static unsigned long jiffies_last = INITIAL_JIFFIES;
> 
> 	/* probably need locking for this part */
> 	if (jiffies < jiffies_last) {	/* We have a wrap */
> 		jiffies_hi++;
> 		jiffies_last = jiffies;
> 	}
> 
> 	return (jiffies | ((u64)jiffies_hi) << LONG_SHIFT));
> }
> 
> This means you need to call something that _checks_ the uptime
> (or needs the 64-bit jiffies value) at least once every 1.3 years.
> If you don't do it at least that often, you probably don't care
> about the uptime anyways.
> 
> This only impacts anything that really needs a 64-bit jiffies count,
> and has zero impact everywhere else.
> 
> Cheers, Andreas

Ah, yes. It's perfect. It could be put right in the 'uptime' code.
It has zero overhead otherwise. Just check the uptime every year
or so and it's always correct. A dummy call to your procedure
every time the system time is set would make it robust.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


