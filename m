Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVAOBY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVAOBY2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVAOBIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:08:35 -0500
Received: from opersys.com ([64.40.108.71]:58120 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262090AbVAOBHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:07:06 -0500
Message-ID: <41E86E6F.6090004@opersys.com>
Date: Fri, 14 Jan 2005 20:14:23 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org>	 <1105740276.8604.83.camel@tglx.tec.linutronix.de>	 <41E85123.7080005@opersys.com> <1105747280.13265.72.camel@tglx.tec.linutronix.de>
In-Reply-To: <1105747280.13265.72.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Thomas,

Gee Thomas, I guess you really want to take this one until the last
man is standing. Feel free to use the ad-hominem tone if it suits
you. Don't hold it against me though if I don't bite :)

Thomas Gleixner wrote:
> It's not only me, who needs constant time. Everybody interested in
> tracing will need that. In my opinion its a principle of tracing.

relayfs is a generalized buffering mechanism. Tracing is one application
it serves. Check out the web site: "high-speed data-relay filesystem."
Fancy name huh ...

> The "lockless" mechanism is _FAKE_ as I already pointed out. It replaces
> locks by do { } while loops. So what ?

Well for one thing, a portion of code running in user-context won't
disable interrupts while it's attempting to get buffer space, and
therefore won't impact on interrupt delivery.

> Interesting. I read this phrase more than once in the discussion of your
> patch. When will the to-do list be done ? 

Well of course you hear it more than once, we are getting _a lot_ of
interesting feedback. Forgive me if I actually take the time to wait
a day or two for most everyone's feedback to come in and carry out
recommendations properly. Don't worry, I won't hold the changes too
long :)

> I'm impressed of your sudden time constraints awareness. Allowing 8192
> bytes of user event size, string printing with varags and XML tracing
> is not biting you ? 

Use of these is by definition lacking performance. It's there because
some people actually need it. Again, if you have some concrete advice
as to what needs to be changed, we'll gladly hear it.

> If you only store the low 32 bit of TSC you have a valid timeline when
> you are able to do the math in your postprocessor. Depending on the
> speed 16 bit are enough.

We're already storing the low 32 bit of the TSC where available.

> A ring buffer is not stupid at all. I have implemented tracing with ring
> buffers already, so I know the limitations and the PITA. 
> 
> OTOH ringbuffers _ARE_ lockless, constant time comsuming and allow you
> to implement the splitting and related functionality in userspace
> postprocessing, which has to be done anyway. 

We've had this debate before if you're interested to dig in the archives.
Here's a suggested implementation by Ingo:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103273730326318&w=2
And here are some reasons why this is incomplete:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103273967727564&w=2

> Do not tell me that streaming out data in a constant stream is worse
> than putting them into nodes of a filesystem and retrieving them from
> there.
> 
> Setting up a simple /dev/proc/sys interface and do a 
> cat /xxx/trace/cpuX >file/interface/whatever
> is not less efficient than the conversion of your data into a file.

Clearly you haven't read the implementation and/or aren't familiar with
its use. Usually, what you want to do is open(), mmap(), write(), there
is no "conversion" to a file. The filesystem abstraction is just a
namespace holder for us.

> Sure, I have to grab stuff out of a filesystem instead of simply doing
> for (....)
> 	sendserial(buffer[i]);
> 
> I know you can provide a nice function for doing so, but it will take
> another xxx kB of code instead of a 10 line simple solution. 

Again, you haven't read the implementation and aren't familiar with its
mechanics. Basically, you should just need to provide the pointer to
the begining of the relayfs buffer and do what you suggest above.

> Haha. If you have eventstamps and timestamps (even the jiffie + event
> based ones) nothing is hard to interpret. I guess the ethereal guys are
> rolling on the floor and laughing. 
> 
> The kernel is not the place to fix your postprocessing problems. Sure
> you have to do more complicated stuff, but you move the burden from
> kernel to a place where it does not hurt.
> 
> What's hard on interpreting and filtering a stream of data ?

Umm, not having enough information in order for interpreting the data?

There is no postprocessing done in the kernel, please stop making
false claims. What is done is provide enough information to allow
simpler post-processing later. Spliting the stream on a per-cpu basis
is certainly not without merit. Plus, there is no cost in doing this,
each channel has a different ID and logging to it does not require
any form of string lookup (currently we're just checking a table to
make sure the ID is valid, but Roman suggested we dump this for pure
pointers instead and we've added this to our list.)

> What's complicated ? In case I want to have timing related tracing which
> includes printks, then storing the address where the printk is coming
> from is enough instead of a various length string. Storing some args in
> binary form with this address should not be too hard to achieve.
> 
> Again its a postprocessing problems. 

Sorry, I don't see how this is relevant to either relayfs or LTT.

> And therefor I need strings, HEX strings, XML ? A simple number and the
> data behind gives you all you need.
> 
> Again its a postprocessing problems. 

But that's exactly what we got already. Here's from include/linux/ltt-events.h:
/* Custom declared events */
/* ***WARNING*** These structures should never be used as is, use the
   provided custom event creation and logging functions. */
typedef struct _ltt_new_event {
	/* Basics */
	u32 id;					/* Custom event ID */
	char type[LTT_CUSTOM_EV_TYPE_STR_LEN];	/* Event type description */
	char desc[LTT_CUSTOM_EV_DESC_STR_LEN];	/* Detailed event description */

	/* Custom formatting */
	u32 format_type;			/* Type of formatting */
	char form[LTT_CUSTOM_EV_FORM_STR_LEN];	/* Data specific to format */
} LTT_PACKED_STRUCT ltt_new_event;
typedef struct _ltt_custom {
	u32 id;			/* Event ID */
	u32 data_size;		/* Size of data recorded by event */
	void *data;		/* Data recorded by event */
} LTT_PACKED_STRUCT ltt_custom;

The ltt_new_event struct is only used once when the event is created.
Everything afterwards goes through an ltt_custom struct.

> Sure I'm aware that I can switch off all, but I can not deselect
> specific tracepoints during compile time to reduce the overhead. 
> 
> If I want to have custom tracepoints for my specific problem, then why I
> need the overhead of the other stuff ?

Ah, ok, you weren't as clear earlier. I don't see anything that precludes
us from adding the appropriate kconfig/#ifdef machinery to allow this. I'll
gladly take a patch from you.

> If you consider the above example, which is taken of your code, as sane
> then we can stop talkin about this.

That's not the point. You're bending backwards as far as you can reach
trying to raise as much mud as you can, but when pressed for actual
constructive input you hide behind a strawman argument. If you don't
have anything to say, then stop whining.

> Karim, please do not use the FUD argument. 
> 
> I do not doubt that it is  efficient from your point of view. 
> 
> But if short tests show this and I'm able to prove that numbers, you can
> barely deny that the scaling of 300MHZ PIII to ARM 74MHz SoC is wrong.
> It's simple math. 

I like calling things by their name. You can say what you will but I
will bet on the casual observer's sense of reality to differentiate
between your "short tests" and the rounds of benchmarks we ran and
the results that we documented.

> Yes, the "you would anyway have to go down the same path we have"
> argument really scares me away from doing so. 
> 
> I don't buy this kind of arguments. 

You have every right to contest what I'm saying. But if you do wish
to enforce that right, it seems to me that I have the right to not
have my time wasted by having to parse through your unnecessary
ad-hominem attacks. There are justifications for our choices, and I
will do my best to present them to you.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
