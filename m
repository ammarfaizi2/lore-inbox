Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319246AbSH2S5I>; Thu, 29 Aug 2002 14:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319251AbSH2S5I>; Thu, 29 Aug 2002 14:57:08 -0400
Received: from web40209.mail.yahoo.com ([66.218.78.70]:23893 "HELO
	web40209.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S319246AbSH2S5G>; Thu, 29 Aug 2002 14:57:06 -0400
Message-ID: <20020829171941.70780.qmail@web40209.mail.yahoo.com>
Date: Thu, 29 Aug 2002 10:19:41 -0700 (PDT)
From: mike heffner <mdheffner@yahoo.com>
Subject: Re: PROBLEM:  conflict between apm and system clock on Inspiron 8100
To: Stephen Rothwell <sfr@canb.auug.org.au>,
       Frank.Otto@tc.pci.uni-heidelberg.de
Cc: linux-kernel@vger.kernel.org, mdheffner@yahoo.com
In-Reply-To: <20020829121103.48b5920d.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

  I have timed the "cat /proc/apm" to take at least
36ms on my inspiron 8100 using an external clock.  I
shut down my ntp daemon so the clock is free running. 
I then did "ntpdate -q clock".  With no calls to apm
the number returned is rather stable over a few
minuites with multiple ntpdate calls.  I then execute
10 times "cat /proc/apm" and do "ntpdate -q clock"
again.  I take the difference and divide by 10.  That
gives me an average of about 36ms, or 3 to 4
interrupts missed for each call.
  Last night I also ran though all of Dell's BIOSs.  I
installed each of the 8 or so of them on there web
site.  A few of them broke apm, but none fixed this
problem.  If we are sure the BIOS is the problem, I
will continue to pester Dell.  So just to verify, you
are *not* disabling interrupts in the kernel for an
apm call?  I am still trying to understand the code.
  I have also tried kernel 2.4.2-2.  I don't remember
this problem with an earlier installation I had on
this laptop.  It turns out it is still a problem with
that kernel version.  I am currently using 2.4.18-10.

Thanks,
Mike

--- Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Frank,
> 
> On Wed, 28 Aug 2002 17:04:33 +0200
> Frank.Otto@tc.pci.uni-heidelberg.de wrote:
> >
> > Alan Cox wrote:
> > > On Mon, 2002-08-26 at 18:00, mike heffner wrote:
> > > > Well, isn't that a nice feature.  Is there a
> > > > workaround for this hardware?
> > >  
> > >  A thinkpad ;)
> > 
> > Unfortunately, that's not true -- I just got an
> IBM Thinkpad R32
> > which exhibits the same behaviour as Mike's Dell
> Inspiron 8100,
> > it's only a tad worse. When I have the
> battstat_applet running (which
> > checks the battery every second), kernel time runs
> about 3% slow
> > compared to the RTC (which seems to be half-way
> accurate on my machine).
> 
> Don't do that then.  Why would you need to check the
> battery status
> every second?  Check every 30 seconds.  Does your
> battery even update its
> status more often than that?
> 
> > The cause seems to be definitely APM. If I shut
> off battstat_applet
> > and apmd, kernel time and RTC are in sync. With
> only apmd, I lose about
> > 15 seconds per hour. With battstat_applet, I lose
> 2 minutes per hour.
> > With
> >   while true; do cat /proc/apm >/dev/null; done
> > the system runs at about 1/4 of the right speed.
> Using a kernel with ACPI
> > eliminates the problem (of course, you lose almost
> all power management
> > functionality too).
> 
> Interesting ... Howlong does "cat /proc/apm" take?
> On my Thinkpad T22 I get:
> 
> # time cat /proc/apm
> 1.16 1.2 0x03 0x01 0x00 0x01 99% -1 ?
> 
> real	0m0.009s
> user	0m0.000s
> sys	0m0.010s
> 
> while ...
> 
> # time ./tppow
> Battery 0 present power units mW[h] design capacity
> 38880 last full charge capacity 29260
> status 0x0 rate 0 cap 29172 voltage 12485
> 
> real	0m0.311s
> user	0m0.100s
> sys	0m0.000s
> 
> tppow is a C implementation of the disassembled APCI
> method for reading the
> battery status. It does not disable interrupts but
> does talk to the
> embedded controller in the Thinkpad.
> 
> > BTW, I have set CONFIG_APM_ALLOW_INT, and on
> startup the kernel even says
> > "IBM machine detected. Enabling interrupts during
> APM calls." Doesn't
> > seem to help, though.
> 
> This just means that we enter the BIOS with
> interrupts enabled, it doesn't
> stop the BIOS from disabling interrupts ...
> 
> -- 
> Cheers,
> Stephen Rothwell                   
> sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/


__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
