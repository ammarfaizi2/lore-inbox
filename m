Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVANWsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVANWsk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 17:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVANWrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 17:47:43 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:2197
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261398AbVANWqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 17:46:33 -0500
Subject: Re: 2.6.11-rc1-mm1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050114002352.5a038710.akpm@osdl.org>
References: <20050114002352.5a038710.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 23:46:31 +0100
Message-Id: <1105742791.13265.3.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-14 at 00:23 -0800, Andrew Morton wrote:
> - Added the Linux Trace Toolkit (and hence relayfs).  Mainly because I
>   haven't yet taken as close a look at LTT as I should have.  Probably neither
>   have you.

I have. Maybe you should have. I really don't see a good argument to
include this code. 

The "non-locking" claim is nice, but a do { } while loop in the slot
reservation for every event including a do { } while loop in the slow
path is just a replacement of locking without actually using a lock. I
don't care whether this is likely or unlikely to happen, it's just bogus
to add a non constant time path for debugging/tracing purposes. 

Default timestamp measuring with do_gettimeofday is also contrary to the
non locking argument. There is 
a) a lock in there 
b) it might loop because it's a sequential lock. 

If you have no TSC you can do at least a jiffies + event-number based,
not so finegrained tracing which gives you at least the timeline of the
events.

There is also no need to do time diff calculations / conversions, this
can be done in userspace postprocessing. 

Adding 150k relayfs source in order to do tracing is scary. I don't see
any real advantage over a nice implemented per cpu ringbuffer, which is
lock free and does not add variable timed delays in the log path. Don't
tell me that a ringbuffer is not suitable, it's a question of size and
it is the same problem for relayfs. If you don't have enough buffers it
does not work. This applies for every implementation of tracebuffering
you do. In space constraint systems relayfs is even worse as it needs
more memory than the plain ringbuffer.
The ringbuffer has a nice advantage. In case the system crashes you can
retrieve the last and therefor most interesting information from the
ringbuffer without any hassle via BDI or in the worstcase via a serial
dump. You can even copy the tail of the buffer into a permanent storage
like buffered SRAM so it can be retrieved after reboot. 

Splitting the trace into different paths is nice to have but I don't see
a single point which cannot be done by a userspace (hostside)
postprocessing tool. It adds another non time constant component to the
trace path. Even the per CPU ringbuffers can be nicely synchronized by a
userspace postprocessing tool without adding complex synchronization
functions.

Replacing printk by a varags print into an event buffer is a nice idea
to replace serial logging of long lasting debug features. Must we really
include 150k source for this or can we just increase the log buffer size
or improve the printk itself?
In case of time related tracing it's just overkill. The printk
information is mostly a string, which can be replaced by the address on
which the printk is happening. The maybe available arguments can be
dumped in binary form. All this information can be converted into human
readable form by postprocessing. 

I wonder whether the various formatting options of the trace are really
of any value. I need neither strings, HEX strings nor XML formatted
information from the kernel. Max. 8192 Byte of user information makes me
frown. Tracing is not a copy to userspace function or am I missing
something ?

All tracepoints are unconditionally compiled into the kernel, whether
they are enabled or not. Why is it neccecary to check the enabled bit
for information I'm not interested in ? Why can't I compile this away by
not enabling the tracepoint at all.

I don't need to point out the various coding style issues again, but I
question if 
	atomic_set(&var), atomic_read(&var) | bit);
which can be found on several places is really doing what it's suggests
to do.

I did a short test on a 300MHz PIII box and the maximum time spent in
the log path (interrupts disabled during measurement) is about 30us.
Extrapolated to a 74MHz ARM SoC it will sum up to ~ 90-120us, what makes
it purely useless. 

Summary:

1. The code is not doing what it claims to do.
2. The code adds unnecessary overhead
3. It's not useful for low speed systems.

Question:
Why is the code included ?	

tglx



