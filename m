Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVANXPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVANXPg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 18:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVANXOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 18:14:16 -0500
Received: from opersys.com ([64.40.108.71]:15112 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261953AbVANXB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 18:01:57 -0500
Message-ID: <41E85123.7080005@opersys.com>
Date: Fri, 14 Jan 2005 18:09:23 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <1105740276.8604.83.camel@tglx.tec.linutronix.de>
In-Reply-To: <1105740276.8604.83.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[repost. first reply had wrong lkml CC.]

Hello Thomas,

First, thanks for the feedback, it's greatly appreciated.

Lots of stuff in here. I don't mean to drop any of your arguments, but
I'm going to reply to this in a way that makes this reply and further
responses as useful as possible to outsiders. Let me know if you
think I've dropped something important.

Thomas Gleixner wrote:

>> The "non-locking" claim is nice, but a do { } while loop in the slot
>> reservation for every event including a do { } while loop in the slow
>> path is just a replacement of locking without actually using a lock. I
>> don't care whether this is likely or unlikely to happen, it's just bogus
>> to add a non constant time path for debugging/tracing purposes.


relayfs implements two schemes: lockless and locking. The later uses
standard linear locking mechanisms. If you need stringent constant
time, you know what to do.


>> Default timestamp measuring with do_gettimeofday is also contrary to the
>> non locking argument. There is
>> a) a lock in there
>> b) it might loop because it's a sequential lock.


That's true, but that's not a limitation of relayfs per se. We'd gladly
use any timing facility available to us. We already use the TSC when
available.


>> If you have no TSC you can do at least a jiffies + event-number based,
>> not so finegrained tracing which gives you at least the timeline of the
>> events.


Interesting. I've added this to the to-do list.


>> There is also no need to do time diff calculations / conversions, this
>> can be done in userspace postprocessing.


Ah yes, that's the kind of thing that you learn by getting bitten by it.
The problem is the size of the data stream. Diffs are an easy and a
rather inexpensive way of reducing trace sizes. Logging 2 or 4 more bytes
per event when you've got tens of thousands of events occuring per second
does have a noticeable impact. If this is really a sticking point, we
could provide a way for writing full time-stamps.


>> you do. In space constraint systems relayfs is even worse as it needs
>> more memory than the plain ringbuffer.


Don't get us wrong, we can strip this down to make this a stupid ring-
buffer. But the fact of the matter is that in trying to use such a thing,
you will find yourself reimplementing the exact things we did for the
same purposes.


>> The ringbuffer has a nice advantage. In case the system crashes you can
>> retrieve the last and therefor most interesting information from the
>> ringbuffer without any hassle via BDI or in the worstcase via a serial
>> dump. You can even copy the tail of the buffer into a permanent storage
>> like buffered SRAM so it can be retrieved after reboot.


And there's a reason why you can't do that with relayfs? We've looked at
this and interfacing between relayfs and crashdump is trivial.


>> Splitting the trace into different paths is nice to have but I don't see
>> a single point which cannot be done by a userspace (hostside)
>> postprocessing tool. It adds another non time constant component to the
>> trace path. Even the per CPU ringbuffers can be nicely synchronized by a
>> userspace postprocessing tool without adding complex synchronization
>> functions.


Again life is a merciless teacher. LTT did initially start with a single
eat-your-breakfeast-dinner-and-supper-in-one-place buffer. But that just
doesn't scale. If you're doing flight-recording, for example, you need
to have a separate channel which contains process creation/exit,
otherwise you have a hard time interepreting the data.


>> In case of time related tracing it's just overkill. The printk
>> information is mostly a string, which can be replaced by the address on
>> which the printk is happening. The maybe available arguments can be
>> dumped in binary form. All this information can be converted into human
>> readable form by postprocessing.


I'm sorry, I don't understand your argument here.


>> I wonder whether the various formatting options of the trace are really
>> of any value. I need neither strings, HEX strings nor XML formatted
>> information from the kernel. Max. 8192 Byte of user information makes me
>> frown. Tracing is not a copy to userspace function or am I missing
>> something ?


Dynamically created custom events and events directed by the likes of
DProbes need something to write to, and user-space utilities must have
a way of determining what format this data was written in. That's all
there is to see here.


>> All tracepoints are unconditionally compiled into the kernel, whether
>> they are enabled or not. Why is it neccecary to check the enabled bit
>> for information I'm not interested in ? Why can't I compile this away by
>> not enabling the tracepoint at all.


But you can. Have a look at include/linux/ltt-events.h:
#else /* defined(CONFIG_LTT) */
#define ltt_ev(ID, DATA)
#define ltt_ev_trap_entry(ID, EIP)
#define ltt_ev_trap_exit()
#define ltt_ev_irq_entry(ID, KERNEL)
#define ltt_ev_irq_exit()
#define ltt_ev_schedchange(OUT, IN)
#define ltt_ev_soft_irq(ID, DATA)
#define ltt_ev_process(ID, DATA1, DATA2)
#define ltt_ev_process_exit(DATA1, DATA2)
#define ltt_ev_file_system(ID, DATA1, DATA2, FILE_NAME)
#define ltt_ev_timer(ID, SDATA, DATA1, DATA2)
#define ltt_ev_memory(ID, DATA)
#define ltt_ev_socket(ID, DATA1, DATA2)
#define ltt_ev_ipc(ID, DATA1, DATA2)
#define ltt_ev_network(ID, DATA)
#define ltt_ev_heartbeat()
#endif /* defined(CONFIG_LTT) */


>> I don't need to point out the various coding style issues again, but I
>> question if
>> 	atomic_set(&var), atomic_read(&var) | bit);
>> which can be found on several places is really doing what it's suggests
>> to do.


If there are actual code snippets you think are broken, we'll gladly
fix them.


>> I did a short test on a 300MHz PIII box and the maximum time spent in
>> the log path (interrupts disabled during measurement) is about 30us.
>> Extrapolated to a 74MHz ARM SoC it will sum up to ~ 90-120us, what makes
>> it purely useless.


Granted tracing is not free, but please avoid spreading FUD without
actually carrying out proper testing. We've done quite a large number
of tests and we've demonstrated over and over that LTT, and ltt-over-
relayfs, is actually very efficient. If you're interested in actual
test data, then you may want to check out the following:
http://www.opersys.com/ftp/pub/LTT/Documentation/ltt-usenix.ps.gz
http://lwn.net/Articles/13870/

We are aware of the cost of the various tracing components, as you
can see by my earlier posting about early-checking to minimize the
cost of the tracing hooks for kernel compiled with them, and are
open for any optimization. If you have any concrete suggestions, save
the scrap-everything-I-know-better (which is really unproductive as
you would anyway have to go down the same path we have), we are more
than willing to entertain them.

Karim
--
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
