Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280790AbRKBSv0>; Fri, 2 Nov 2001 13:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280788AbRKBSuE>; Fri, 2 Nov 2001 13:50:04 -0500
Received: from [63.231.122.81] ([63.231.122.81]:26178 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S280781AbRKBStr>;
	Fri, 2 Nov 2001 13:49:47 -0500
Date: Fri, 2 Nov 2001 11:48:33 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: linux-kernel@vger.kernel.org, J Sloan <jjs@lexus.com>,
        Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        george anzinger <george@mvista.com>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: [Patch] Re: Nasty suprise with uptime
Message-ID: <20011102114833.J746@lynx.no>
Mail-Followup-To: Tim Schmielau <tim@physik3.uni-rostock.de>,
	linux-kernel@vger.kernel.org, J Sloan <jjs@lexus.com>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	george anzinger <george@mvista.com>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Benjamin LaHaise <bcrl@redhat.com>
In-Reply-To: <20011101182334.P16554@lynx.no> <Pine.LNX.4.30.0111021744500.7256-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.30.0111021744500.7256-100000@gans.physik3.uni-rostock.de>; from tim@physik3.uni-rostock.de on Fri, Nov 02, 2001 at 06:18:00PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 02, 2001  18:18 +0100, Tim Schmielau wrote:
> I made up another patch as an RFC where this overflow is dealt with in the
> same way as the jiffies wraparound. This will prevent wrong display of
> idle time if /proc/uptime is read at least every 497 days.
> The CPU time of the idle task will still overflow as it will for every
> other process getting more than 497.1 days of CPU time, but I don't want
> to blow up every time variable. I believe this to be acceptable behavior.

I would agree.

> I think I have to give up on my stability problem. I see hard lockups on
> SMP as well as UP at random times after the jiffies wrap.
> Another problem surprises me: Sometimes I get quite an unresponsive system
> even before jiffie wrap, sometimes not. Seems as some important timing
> parameter sometimes gets detected wrong at boot time if INITIAL_JIFFIES is
> large. The bogomips value, however, is always correct.

This is an expected symptom of broken code not dealing with jiffies wrap
properly.  Something is waiting for a timeout that won't happen for another
1.3 years.

AFAIK, in the 2.1 kernel development days there was an audit
of all users of jiffies so that they properly used (there are macros
time_before() and time_after() which are supposed to handle jiffies wrap).
I imagine that if you did a grep on jiffies for the drivers you use, you
would find that lots of code is again doing "time + foo > jiffies" or
similar, which is broken for wrap.

> As suggested elsewhere, I made the pre-wrap INITIAL_JIFFIES value a config
> option, so anybody might decide by himself to hunt down these problems
> or not.  I kindly ask people to turn this on and help getting the issues
> sorted out, as I don't want to imply a false feeling of safety with this
> patch by hiding the jiffies wraparound from the user.

Maybe not in the 2.4 kernel, but definitely in the 2.5 kernel Linus will
enable this as a "no-option option", just like he did with SMP in older
development kernels.  It _may_ be that the Chief Penguin will put his
foot (flipper?) down and enable it for 2.4 as well, just to get it fixed
ASAP.  Otherwise it just means that there will be an upper bound on how
long a 2.4 kernel can run.

> I believe the ongoing discussion of a "real" 64 bit jiffie counter not to
> interfere with this goal, since this can also be done at any later time
> with the get_jiffies64() interface remaining unchanged.

I agree.  Do we need a 64-bit jiffies value for gettimeofday, or is this
handled by the CPU TSC these days?  I'm not really aware of other places
that would need a 64-bit value in a fast path (such that locking and a
function call to get_jiffies64() is unacceptable).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

