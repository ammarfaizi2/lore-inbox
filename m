Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVAOABn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVAOABn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVAOABn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:01:43 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:3989
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262040AbVAOABW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:01:22 -0500
Subject: Re: 2.6.11-rc1-mm1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: karim@opersys.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41E85123.7080005@opersys.com>
References: <20050114002352.5a038710.akpm@osdl.org>
	 <1105740276.8604.83.camel@tglx.tec.linutronix.de>
	 <41E85123.7080005@opersys.com>
Content-Type: text/plain
Date: Sat, 15 Jan 2005 01:01:20 +0100
Message-Id: <1105747280.13265.72.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karim,

On Fri, 2005-01-14 at 18:09 -0500, Karim Yaghmour wrote:
> >> The "non-locking" claim is nice, but a do { } while loop in the slot
> >> reservation for every event including a do { } while loop in the slow
> >> path is just a replacement of locking without actually using a lock. I
> >> don't care whether this is likely or unlikely to happen, it's just bogus
> >> to add a non constant time path for debugging/tracing purposes.
> 
> relayfs implements two schemes: lockless and locking. The later uses
> standard linear locking mechanisms. If you need stringent constant
> time, you know what to do.

It's not only me, who needs constant time. Everybody interested in
tracing will need that. In my opinion its a principle of tracing.

The "lockless" mechanism is _FAKE_ as I already pointed out. It replaces
locks by do { } while loops. So what ?

> >> Default timestamp measuring with do_gettimeofday is also contrary to the
> >> non locking argument. There is
> >> a) a lock in there
> >> b) it might loop because it's a sequential lock.
>
> >> If you have no TSC you can do at least a jiffies + event-number based,
> >> not so finegrained tracing which gives you at least the timeline of the
> >> events.
> 
> Interesting. I've added this to the to-do list.

Interesting. I read this phrase more than once in the discussion of your
patch. When will the to-do list be done ? 

> >> There is also no need to do time diff calculations / conversions, this
> >> can be done in userspace postprocessing.
> 
> Ah yes, that's the kind of thing that you learn by getting bitten by it.
> The problem is the size of the data stream. Diffs are an easy and a
> rather inexpensive way of reducing trace sizes. Logging 2 or 4 more bytes
> per event when you've got tens of thousands of events occuring per second
> does have a noticeable impact. If this is really a sticking point, we
> could provide a way for writing full time-stamps.

I'm impressed of your sudden time constraints awareness. Allowing 8192
bytes of user event size, string printing with varags and XML tracing
is not biting you ? 

If you only store the low 32 bit of TSC you have a valid timeline when
you are able to do the math in your postprocessor. Depending on the
speed 16 bit are enough.

> >> you do. In space constraint systems relayfs is even worse as it needs
> >> more memory than the plain ringbuffer.
> 
> Don't get us wrong, we can strip this down to make this a stupid ring-
> buffer. But the fact of the matter is that in trying to use such a thing,
> you will find yourself reimplementing the exact things we did for the
> same purposes.

A ring buffer is not stupid at all. I have implemented tracing with ring
buffers already, so I know the limitations and the PITA. 

OTOH ringbuffers _ARE_ lockless, constant time comsuming and allow you
to implement the splitting and related functionality in userspace
postprocessing, which has to be done anyway. 

Do not tell me that streaming out data in a constant stream is worse
than putting them into nodes of a filesystem and retrieving them from
there.

Setting up a simple /dev/proc/sys interface and do a 
cat /xxx/trace/cpuX >file/interface/whatever
is not less efficient than the conversion of your data into a file.

> >> The ringbuffer has a nice advantage. In case the system crashes you can
> >> retrieve the last and therefor most interesting information from the
> >> ringbuffer without any hassle via BDI or in the worstcase via a serial
> >> dump. You can even copy the tail of the buffer into a permanent storage
> >> like buffered SRAM so it can be retrieved after reboot.
> 
> 
> And there's a reason why you can't do that with relayfs? We've looked at
> this and interfacing between relayfs and crashdump is trivial.

Sure, I have to grab stuff out of a filesystem instead of simply doing
for (....)
	sendserial(buffer[i]);

I know you can provide a nice function for doing so, but it will take
another xxx kB of code instead of a 10 line simple solution. 

> >> Splitting the trace into different paths is nice to have but I don't see
> >> a single point which cannot be done by a userspace (hostside)
> >> postprocessing tool. It adds another non time constant component to the
> >> trace path. Even the per CPU ringbuffers can be nicely synchronized by a
> >> userspace postprocessing tool without adding complex synchronization
> >> functions.
> 
> 
> Again life is a merciless teacher. LTT did initially start with a single
> eat-your-breakfeast-dinner-and-supper-in-one-place buffer. But that just
> doesn't scale. If you're doing flight-recording, for example, you need
> to have a separate channel which contains process creation/exit,
> otherwise you have a hard time interepreting the data.

Haha. If you have eventstamps and timestamps (even the jiffie + event
based ones) nothing is hard to interpret. I guess the ethereal guys are
rolling on the floor and laughing. 

The kernel is not the place to fix your postprocessing problems. Sure
you have to do more complicated stuff, but you move the burden from
kernel to a place where it does not hurt.

What's hard on interpreting and filtering a stream of data ?

> >> In case of time related tracing it's just overkill. The printk
> >> information is mostly a string, which can be replaced by the address on
> >> which the printk is happening. The maybe available arguments can be
> >> dumped in binary form. All this information can be converted into human
> >> readable form by postprocessing.
> 
> I'm sorry, I don't understand your argument here.

What's complicated ? In case I want to have timing related tracing which
includes printks, then storing the address where the printk is coming
from is enough instead of a various length string. Storing some args in
binary form with this address should not be too hard to achieve.

Again its a postprocessing problems. 

> >> I wonder whether the various formatting options of the trace are really
> >> of any value. I need neither strings, HEX strings nor XML formatted
> >> information from the kernel. Max. 8192 Byte of user information makes me
> >> frown. Tracing is not a copy to userspace function or am I missing
> >> something ?
> Dynamically created custom events and events directed by the likes of
> DProbes need something to write to, and user-space utilities must have
> a way of determining what format this data was written in. That's all
> there is to see here.

And therefor I need strings, HEX strings, XML ? A simple number and the
data behind gives you all you need.

Again its a postprocessing problems. 

> >> All tracepoints are unconditionally compiled into the kernel, whether
> >> they are enabled or not. Why is it neccecary to check the enabled bit
> >> for information I'm not interested in ? Why can't I compile this away by
> >> not enabling the tracepoint at all.

> But you can. Have a look at include/linux/ltt-events.h:
> #else /* defined(CONFIG_LTT) */
> #define ltt_ev(ID, DATA)
> #define ltt_ev_trap_entry(ID, EIP)
> #define ltt_ev_trap_exit()

Sure I'm aware that I can switch off all, but I can not deselect
specific tracepoints during compile time to reduce the overhead. 

If I want to have custom tracepoints for my specific problem, then why I
need the overhead of the other stuff ?

> >> I don't need to point out the various coding style issues again, but I
> >> question if
> >> 	atomic_set(&var), atomic_read(&var) | bit);
> >> which can be found on several places is really doing what it's suggests
> >> to do.
> 
> If there are actual code snippets you think are broken, we'll gladly
> fix them.

If you consider the above example, which is taken of your code, as sane
then we can stop talkin about this.

> >> I did a short test on a 300MHz PIII box and the maximum time spent in
> >> the log path (interrupts disabled during measurement) is about 30us.
> >> Extrapolated to a 74MHz ARM SoC it will sum up to ~ 90-120us, what makes
> >> it purely useless
> 
> Granted tracing is not free, but please avoid spreading FUD without
> actually carrying out proper testing. We've done quite a large number
> of tests and we've demonstrated over and over that LTT, and ltt-over-
> relayfs, is actually very efficient. If you're interested in actual
> test data, then you may want to check out the following:
> http://www.opersys.com/ftp/pub/LTT/Documentation/ltt-usenix.ps.gz
> http://lwn.net/Articles/13870/

Karim, please do not use the FUD argument. 

I do not doubt that it is  efficient from your point of view. 

But if short tests show this and I'm able to prove that numbers, you can
barely deny that the scaling of 300MHZ PIII to ARM 74MHz SoC is wrong.
It's simple math. 

> We are aware of the cost of the various tracing components, as you
> can see by my earlier posting about early-checking to minimize the
> cost of the tracing hooks for kernel compiled with them, and are
> open for any optimization. If you have any concrete suggestions, save
> the scrap-everything-I-know-better (which is really unproductive as
> you would anyway have to go down the same path we have), we are more
> than willing to entertain them.

Yes, the "you would anyway have to go down the same path we have"
argument really scares me away from doing so. 

I don't buy this kind of arguments. 

tglx


