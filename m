Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWHSQuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWHSQuk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 12:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWHSQuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 12:50:39 -0400
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:58718 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751371AbWHSQuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 12:50:39 -0400
From: David Brownell <david-b@pacbell.net>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC][PATCH] Unify interface to persistent CMOS/RTC/whatever clock
Date: Sat, 19 Aug 2006 09:39:10 -0700
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alessandro Zummo <alessandro.zummo@towertech.it>
References: <200608162247.41632.david-b@pacbell.net> <200608171838.05527.david-b@pacbell.net> <1155944198.5361.81.camel@localhost.localdomain>
In-Reply-To: <1155944198.5361.81.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608190939.11421.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 August 2006 4:36 pm, john stultz wrote:

> No, I'm sorry, I realize the RTC interface has the potential to be more
> widely used. I'm just a bit frustrated that in order to utilize the RTC
> framework for what I'm trying to do, I have to first implement RTC
> drivers for 90% of the arches. :(

Maybe not ... you could do a lot with just a hook function.  Your original
patch provided one hook (an arch-level function call) assuming the RTC is
always accessible with IRQs blocked.  The RTC framework could provide such
a similar hook too ... best done through a function pointer, though.  It
shouldn't be a kernel build error if there's no RTC; userspace can use an
external one via NTP, load a module later than you'd like, etc.

Then be sure to call that hook from some can-sleep context, and you're as
set for the boot/init issue as possible.  (That is, no luck if the RTC is
in a module loaded after init starts.)


> Also the "RTC might not be available when you need it" issue makes it
> uh.. difficult to use. :)

I can't see that "when you need it" thing.  Especially since you had
proposed that "late" wall clock init was not a problem ...


> So if we go w/  the "it may not be available, so always assume it isn't"
> way of thinking, it forces us to rely upon the RTC driver(s) to resume
> time (which means every RTC, no matter how simple has to have
> suspend/resume hooks and call settimeofday at least). 

No, that was the point of my comment about using the new class level
suspend/resume calls.  The RTC drivers wouldn't be responsible for
that; the RTC framework would be.  RTC drivers may still want the
suspend/resume hooks to make sure they issue system wakeup events,
and so on, but no longer for maintaining the wall clock.  I'll send
a patch (of the "it compiles" type) later.

 
> I don't really like that uses-graph (I can imagine someone system not
> resuming properly because they forgot to compile in the right RTC
> driver).

Without the right RTC support, they'd not be getting initial clock
setup right either ... same difference, same userspace fix (using
external RTC, via NTP etc).


> Also it doesn't resolve the timekeeping resume ordering issue 
> I'm trying to address.

Worth exploring that a bit more.  Exactly what is the issue?  I'm
not sure your first explanation came across in enough depth...


> But we might have to deal with it. Just to make sure we can balance this
> properly, what is the percentage of RTC drivers where the might not be
> available at timekeeping_resume()?  If it is small, it might be
> reasonable to special case them (and by "special case", i *don't* mean
> ignore :)

Basically 100%.  It's because timekeeping_resume() applies to a (fake)
sys_device, and the sys_device resume phase kicks in before "real"
drivers resume, and with IRQs blocked ... ergo before sleeping calls
can be issued (e.g. waiting for I2C or SPI access to complete).

The RTC drivers are all "real" device drivers, and the RTC framework
itself issues sleeping calls, like mutex_lock.


> > The RTC framework is no more ARM-only than the generic TOD framework
> > is x86-only.  But those changes did start from different corners of the
> > Linux market, which likely explains some of the surprise associated with
> > this little collision.  (If rtc-acpi got a bit more attention, that'd
> > surely help raise awareness outside the embedded space...)
> 
> Looking at the rtc-acpi code, it describes itself as being AT compatible
> (ie: The old CMOS clock), but its not clear if it requires ACPI or not
> to work. Further, does it work on x86_64, or ia64 as well?

It's called "rtc-acpi" since it requires ACPI ... in fact, PNPACPI is
what provides the driver model device it binds to.  Plus it hooks into
ACPI to get the wakeup function, and the extra register options.  I'm
running it on both i386 and x86_64.  So like I said, most modern PCs
should be able to run it just fine.  IA64 uses ACPI, so presumably it
should be able to use the driver too.

The core of the driver could be reused on some non-PC platforms, some
not-modern PCs, and on ACPI platforms without PNPACPI ... given the
addition of platform code to register a platform_device.  And for the
ACPI-but-not-PNPCACPI configs, wakeup and the extra registers could
still be used.

Someone would have to provide the relevant patches; I'd not mind if
the driver were renamed to e.g. "rtc-cmos" at that point.


> Another comment, drivers/rtc/ is a bit overwhelming. Same with the
> Kconfig. Is there any way it could be broken up so arch-specific RTCs
> aren't shown on arches that do not support them?

They aren't.  You won't see the various SOC's RTC unless configuring
a kernel for that SOC ...


> Or maybe there should 
> be two classes, the arch-defined RTCs and then the generic ones?
> 
> Your thoughts?

I CC'd Allesandro Zummo, maintaining the RTC framework ... I'm sure
he's noticed the explosion of drivers!  It's not so overwhelming as
drivers/net though... :)

Sectioning Kconfig seems to me like a reasonable and simple change,
first the integrated/arch RTCs (link them first too, so they'll be
"rtc0" when not modular) then the discrete ones ... maybe the I2C
ones first (in alphabetical order), then SPI ones, memory mapped
ones, etc.  Any janitors reading this thread?

But I don't see a need for multiple classes; they're still all just
RTCs, the type of implementation isn't supposed to matter at all.


> > > > {save,restore}_time_delta() in
> > > > 
> > > > 	include/asm-arm/mach/time.h
> > > > 	arch/arm/kernel/time.c
> > > > 
> > > > The rtc-at91.c code is layered classically ... RTC is the first platform
> > > > device registered, and thus resumed, but it's resumed after the jiffies
> > > > timer sysdev (thus with IRQs enabled).  So it will restore the time delta
> > > > very early in the resume sequence.  (PXA uses a different approach.)
> > > 
> > > Hmmm. So looking at the code, ARM doesn't update jiffies on resume?
> > 
> > Now that you mention it ... that's right.  Just the wall clocks.  If you
> > want to argue that's buglike, take it up with Russell King.  Presumably
> > some other architectures do advance jiffies, not just the wall clock?
> 
> Well, its a "some arches do, some arches don't" discrepancy, rather then
> a specific bug. It was my hope that by putting the logic in generic code
> we would get consistent behavior across arches.

I'm all for that!


> > > > Presumably this is stuff that should be done by the RTC class resume()
> > > > method, probably for the CONFIG_RTC_HCTOSYS_DEVICE clock (though there
> > > > could be a better RTC ... one that's being NTP-corrected).  That'd
> > > > be no sooner than 2.6.19, which adds new class-level suspend()/resume()
> > > > calls to help offload individual drivers.
> > > 
> > > Hrm. I'm a bit skeptical that the RTC resume code should update the
> > > timekeeping code instead of the timekeeping code doing it. It seems that
> > > it would cause additional complexity (what if there are two RTC
> > > devices?) and would still have some of the suspend/resume ordering
> > > issues I'm worried about.
> > 
> > Could be.  "Two RTCs" scenarios are real, as I've mentioned before.  I'll
> > leave it to you to sort this stuff out, you seem to have a good handle
> > on it all ... I was mostly concerned that you incorporate the RTC class
> > support into your updates.  Neither of us created the mess surrounding
> > persistent wall clocks, but if you want to unify things, then you should
> > build on the existing RTC framework or else come up with a better one ...
> 
> I do appreciate you bringing these point up. I do think the RTC class
> looks promising, but until its widely implemented, its difficult to
> use/rely upon generically.

Every Linux system I work on today -- x86, x86_64, multiple ARMs -- supports
the RTC framework though.  To me it's *already* "widely implemented" ... :)


> A thought: The approach taken w/ the generic timekeeping was that by
> using the jiffies clocksource, we could stagger the transition. So the
> clocksource code can be used generically, because all arches are
> guaranteed to have atleast one clocksource. 
> 
> Is there some way we can take a similar approach, by combining the
> read_persistent_clock() and the RTC framework? Basically creating a
> dummy RTC that would be on every arch, implementing only the read method
> which would call something like read_persistent_clock(). This way the
> RTC infrastructure could be used on all arches, while the conversion was
> still happening.

What I sketched above is somewhat similar ... there couldn't be an
RTC framework driver, since the platform would need to provide a
driver model device in order to use the RTC framework.  And as I've
already noted, "every arch" can't implement such a method...

But it would be easy for read_persistent_clock() to be a pointer to a
function that's filled in by whatever -- non-RTC arch code, or the RTC
framework -- and called some appropriate can-sleep place.


> Alternatively it may be that the real solution is to either introduce
> resume ordering levels or explicitly call timekeeping resume, instead of
> leaving it to the sysclass logic.

The fact that timekeeping_resume ignores its parameter is IMNSHO a good
hint that it shouldn't be shoehorned into the driver model in that way.
Now, the RTC framework _does_ fit well into the driver model ... :)

- Dave

