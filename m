Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281438AbRKFAVh>; Mon, 5 Nov 2001 19:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281440AbRKFAV2>; Mon, 5 Nov 2001 19:21:28 -0500
Received: from ilm.mech.unsw.EDU.AU ([129.94.171.100]:48906 "EHLO
	ilm.mech.unsw.edu.au") by vger.kernel.org with ESMTP
	id <S281438AbRKFAVJ>; Mon, 5 Nov 2001 19:21:09 -0500
Date: Tue, 6 Nov 2001 11:20:52 +1100
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, Ian Maclaine-cross <iml@debian.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <20011106112052.A10721@ilm.mech.unsw.edu.au>
In-Reply-To: <20011031113312.A8738@ilm.mech.unsw.edu.au> <20011102121602.A45@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011102121602.A45@toy.ucw.cz>
User-Agent: Mutt/1.3.23i
From: Ian Maclaine-cross <iml@ilm.mech.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,
On Fri, Nov 02, 2001 at 12:16:03PM +0000, Pavel Machek wrote:
> Hi!
> 
> > PROBLEM: Linux updates RTC secretly when clock synchronizes.
> > 
> > Please CC replies etc to Ian Maclaine-cross <iml@debian.org>.
> > 
> > When /usr/sbin/ntpd synchronizes the Linux kernel (or system) clock
> > using the Network Time Protocol the kernel time is accurate to a few
> > milliseconds. Linux then sets the Real Time (or Hardware or CMOS)
> > Clock to this time at approximately 11 minute intervals. Typical RTCs
> > drift less than 10 s/day so rebooting causes only millisecond errors.
> > 
> > Linux currently does not record the 11 minute updates to a log file.
> > Clock programs (like hwclock) cannot correct RTC drift at boot without
> > knowing when the RTC was last set. If NTP service is available after a
> > long shutdown, ntpd may step the time.  Worse after a longer shutdown
> > ntpd may drop out or even synchronize to the wrong time zone.  The
> > workarounds are clumsy.
> > 
> > Please find following my small patch for linux/arch/i386/kernel/time.c
> > which adds a KERN_NOTICE of each 11 minute update to the RTC. This is
> > just for i386 machines at present. A script can search the logs for
> > the last set time of the RTC and update /etc/adjtime.  Hwclock can
> > then correct the RTC for drift and set the kernel clock.
> 
> That seems as very wrong solution.
> 
> What about just making kernel only _read_ system clock, and never set it? 
> That looks way cleaner to me.

QUESTION: What results in best timekeeping by the RTC, constant
updates or logging the offset?

ANSWER: 

The Linux kernel code for the 11 minute update in
arch/i386/kernel/time.c has an RTC setting error of +-0.005 s.  The
adjtimex source suggests an RTC reading error of +-0.000025 s.

Accurate RTC timekeeping also requires an accurate value of average
drift rate for typical use. Measuring this requires timing over a long
unset period such as one month.

Logging the offset is more accurate per reading and allows
more accurate measurement of drift than 11 minute updates.

END ANSWER.

RTC accuracy supports optionalizing the 11 minute update.

Other reasons to optionalize the 11 minute update which various people
suggest:

1. The kernel should not dictate OS policy;

2. Simplifies programming with /dev/rtc;

3. Improves performance of /dev/rtc;

4. Slightly reduced kernel size;

5. Slightly faster timer_interrupt;

6. Easier to use utilities like hwclock.

I agree with you, Pavel. Commenting out the 11 minute update
code is a better solution. :)

> 								Pavel
> -- 
> Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
> details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.
> 

-- 
Regards,
Ian Maclaine-cross (iml@debian.org)
