Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbVAPPU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbVAPPU2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 10:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbVAPPU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 10:20:28 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:28631 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S262525AbVAPPTu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 10:19:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sun, 16 Jan 2005 10:19:37 -0500 (EST)
To: karim@opersys.com
Cc: tglx@linutronix.de, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Robert Wisniewski <bob@watson.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <41E9E9D0.1060401@opersys.com>
References: <20050114002352.5a038710.akpm@osdl.org>
	<1105740276.8604.83.camel@tglx.tec.linutronix.de>
	<41E85123.7080005@opersys.com>
	<1105747280.13265.72.camel@tglx.tec.linutronix.de>
	<20050114162652.73283f2e.akpm@osdl.org>
	<1105750810.13265.126.camel@tglx.tec.linutronix.de>
	<41E87102.2090502@opersys.com>
	<1105784445.13265.222.camel@tglx.tec.linutronix.de>
	<41E9E9D0.1060401@opersys.com>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <16874.33548.460605.157157@kix.watson.ibm.com>
From: Robert Wisniewski <bob@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour writes:
 > 
 > Hello Thomas,
 > 
 > In the interest of avoiding expanding the thread too thin, I'm replying to
 > both emails in the same time.
 > 
 > Thomas Gleixner wrote:
 > >>relayfs is a generalized buffering mechanism. Tracing is one application
 > >>it serves. Check out the web site: "high-speed data-relay filesystem."
 > >>Fancy name huh ...
 > >
 > >
 > > I do not doubt that.
 > >
 > > But hardwiring an instrumentation framework on it is also hardwiring
 > > implicit restrictions on the usability of the instrumentation for
 > > certain purposes.
 > 
 > To a certain extent this is true. Please refer to my reply to your RFC
 > for a discussion of this.
 > 
 > >>Well for one thing, a portion of code running in user-context won't
 > >>disable interrupts while it's attempting to get buffer space, and
 > >>therefore won't impact on interrupt delivery.
 > >
 > >
 > > The do {} while loops are in the fast ltt_log_event path

As Greg's comments implicitly involved this issue as well, maybe it's worth
expanding on what is going on here.  The idea behind the lockless tracing
is for each process/thread to atomically reserve space in the buffer, then
write in the events.  Also note that buffers are per-processor.  So the do
{} while loop loads the current index, does a calculation and attempts to
use the calculated value (which is the old index + length of current event)
to atomically compare_and_swap with the actual index pointer.  As Karim
correctly notes, the only way this will fail is if an interrupt occurred
during the couple of instruction calculation, i.e., between when the old
value was loaded and when we do the CAS, so it's unlikely, but even much
more unlikely that, as he notes, this process would be woken up only for a
couple of instructions and re-interrupted.  Back to Greg's volatile issue:
The reason the index needs to be volatile (or as was originally coded the
reason we clobbered the registers) is to make sure the compiler knows the
index value needs to get reloaded from memory each time around the loop.

Hope this helps.  I'm certainly happy to discuss in more length if there's
any concerns/questions.

-bob

Robert Wisniewski
The K42 MP OS Project
http://www.research.ibm.com/K42/
bob@watson.ibm.com

 > 
 > You mean that it would impact on interrupt deliver? This code's behavior
 > has actually been carefully studied, and what has been seen is that
 > there code almost never loops, and when it does, it very rarely does
 > it more than twice. In the case of an interrupt, you'd have to receive
 > an interrupt while reserving space for logging a current's interrupt
 > occurrence for the loop to be done twice. I've CC'ed Bob Wisniewski
 > on this as he's the one that implemented this code and studied its
 > behavior in depth.
 > 
 > > Yeah, did you answer one of my arguments except claiming that I'm to
 > > stupid to understand how it works ? 
 > 
 > If I miss-spoke, then I appologize. For one thing, I've never thought
 > of you as stupid. I'm just trying to get specifics here.
 > 
 > > I just dont like the idea, that instrumentation is bound on relayfs and
 > > adds a feature to the kernel which fits for a restricted set of problems
 > > rather than providing a generic optimized instrumentation framework,
 > > where one can use relayfs as a backend, if it fits his needs. Making
 > > this less glued together leaves the possibility to use other backends. 
 > 
 > Yes, I understand and I hope my other mail properly addresses this issue.
 > 
 > > There is a loop in ltt_log_event, which enforces the processing of each
 > > event twice. Spliting traces is postprocessing and can be done
 > > elsewhere.
 > 
 > Sorry, this is not postprocessing. Let me explain:
 > 
 > Basically, the ltt framework allows only one tracing session to be active
 > at all times. IOW, if you were planning on starting a 2 week trace and
 > after doing so wanted to trace a short 10s on an application then you are
 > screwed, LTT won't allow you to do that. Currently this is a limitation
 > which we haven't heard any complaints about, so we're not going to
 > generalize it until there is proof that people really need this.
 > 
 > However, there are cases where you want to have tracing running at _all_
 > times in what is refered to as flight-recorder mode and only dump the
 > content of the buffers when something special happens. Yet, those who
 > are interested in having this 24x7 mode also know enough about tracing
 > that they do need to actually trace other things for short periods
 > without disrupting their flight-recording. That's why there's a loop.
 > An event will be processed twice only if you're tracing AND flight-
 > recording in the same time.
 > 
 > There is no way to do an equivalent of what I just described with any
 > form of postprocessing.
 > 
 > Here's the proper snippet from include/linux/ltt-events.h:
 > /* We currently support 2 traces, normal trace and flight recorder */
 > #define NR_TRACES			2
 > #define TRACE_HANDLE			0
 > #define FLIGHT_HANDLE			1
 > 
 > > In _ltt_log_event lives quite a bunch of if(...) processing decisions
 > > which have to be evaluated for _each_ event.
 > 
 > Correct, and I'm honest enough with myself to admit that this is the bit
 > of code that I think needs the most reviewing. So, in order to help
 > you help me, here's the various code snippets and things I can think
 > of which would help make the code faster/simpler:
 > 
 > Here's the preamble where we check some make some basic sanity checks:
 > 
 > 	if (!trace)
 > 		return -ENOMEDIUM;
 > 
 > 	if (trace->paused)
 > 		return -EBUSY;
 > 
 > 	tracer_handle = trace->trace_handle;
 > 
 > 	if (!trace->flight_recorder && (trace->daemon_task_struct == NULL))
 > 		return -ENODEV;
 > 
 > 	channel_handle = trace_channel_handle(tracer_handle, cpu_id);
 > 
 > 	if ((trace->tracer_started == 1) || (event_id == LTT_EV_START) || (event_id == LTT_EV_BUFFER_START))
 > 		goto trace_event;
 > 
 > 	return -EBUSY;
 > 
 > trace_event:
 > 	if (!ltt_test_bit(event_id, &trace->traced_events))
 > 		return 0;
 > 
 > Basically, unless we've succeeded in all those if's, we're not going to
 > write anything. I think we could get rid of the first 4 ones by simply
 > maintaining a state-machine for the tracer. Then we could either have
 > a single if or even use function pointers (though I think this costs
 > more) to call or not call _ltt_log_event. As for checking whether the
 > event has a certain ID (EV_START or EV_BUFFER_START and ltt_test_bit),
 > we could do the testing at the event's occurrence (i.e. as soon as the
 > event occurs, check whether it's being monitored right there and drop
 > it otherwise.)
 > 
 > Here's the part where we check if some basic filtering requirements
 > have been made:
 > 
 > 	if ((event_id != LTT_EV_START) && (event_id != LTT_EV_BUFFER_START)) {
 > 		if (event_id == LTT_EV_SCHEDCHANGE)
 > 			incoming_process = (struct task_struct *) (((ltt_schedchange *) event_struct)->in);
 > 		if ((trace->tracing_pid == 1) && (current->pid != trace->traced_pid)) {
 > 			if (incoming_process == NULL)
 > 				return 0;
 > 			else if (incoming_process->pid != trace->traced_pid)
 > 				return 0;
 > 		}
 > 		if ((trace->tracing_pgrp == 1) && (process_group(current) != trace->traced_pgrp)) {
 > 			if (incoming_process == NULL)
 > 				return 0;
 > 			else if (process_group(incoming_process) != trace->traced_pgrp)
 > 				return 0;
 > 		}
 > 		if ((trace->tracing_gid == 1) && (current->egid != trace->traced_gid)) {
 > 			if (incoming_process == NULL)
 > 				return 0;
 > 			else if (incoming_process->egid != trace->traced_gid)
 > 				return 0;
 > 		}
 > 		if ((trace->tracing_uid == 1) && (current->euid != trace->traced_uid)) {
 > 			if (incoming_process == NULL)
 > 				return 0;
 > 			else if (incoming_process->euid != trace->traced_uid)
 > 				return 0;
 > 		}
 > 		if (event_id == LTT_EV_SCHEDCHANGE)
 > 			(((ltt_schedchange *) event_struct)->in) = incoming_process->pid;
 > 	}
 > 
 > First, the first inner if (LTT_EV_SCHEDCHANGE) really ought to be outside.
 > Instead we should modify ltt_log_event from:
 > int ltt_log_event(u8 event_id,
 > 		void *event_struct)
 > to:
 > int ltt_log_event(u8 event_id,
 > 		void *event_struct,
 > 		void *data,
 > 		int data_len)
 > 
 > where data is used to pass the pointer to the incoming process' task struct,
 > and reused below in conjunction with data_len for other purposes.
 > 
 > and have something like this instead in the code:
 > if ((any_filtering) && !(ltt_filter(event_id, event_struct, data)))
 > 	return -EINVAL;
 > 
 > where ltt_filter is the filtering function, called only when there is any
 > sort of filtering being done.
 > 
 > The we calculate the size of this event:
 > 	data_size = sizeof(event_id) + sizeof(time_delta) + sizeof(data_size);
 > 
 > 
 > 	if (ltt_test_bit(event_id, &trace->log_event_details_mask)) {
 > 		data_size += event_struct_size[event_id];
 > 		switch (event_id) {
 > 		case LTT_EV_FILE_SYSTEM:
 > 			if ((((ltt_file_system *) event_struct)->event_sub_id == LTT_EV_FILE_SYSTEM_EXEC)
 > 			    || (((ltt_file_system *) event_struct)->event_sub_id == LTT_EV_FILE_SYSTEM_OPEN)) {
 > 				var_data_beg = ((ltt_file_system *) event_struct)->file_name;
 > 				var_data_len = ((ltt_file_system *) event_struct)->event_data2 + 1;
 > 				data_size += (uint16_t) var_data_len;
 > 			}
 > 			break;
 > 		case LTT_EV_CUSTOM:
 > 			var_data_beg = ((ltt_custom *) event_struct)->data;
 > 			var_data_len = ((ltt_custom *) event_struct)->data_size;
 > 			data_size += (uint16_t) var_data_len;
 > 			break;
 > 		}
 > 	}
 > 
 > Here we reuse data and data_len, and remove the checking for whether the
 > user wants to log event details or not in order to remove this if/switch
 > altogether. The log_event_details_mask was a feature I added early on
 > in LTT's life and I don't know of anyone for whom this was really crucial.
 > We could revive it later if it became important.
 > 
 > Then we check whether we should be logging the CPU-ID:
 > 	if ((trace->log_cpuid == 1) && (event_id != LTT_EV_START) && (event_id != LTT_EV_BUFFER_START))
 > 		data_size += sizeof(cpu_id);
 > 
 > Frankly this is legacy code for when ltt only supported one trace buffer,
 > and I don't know that we need to keep it. Clearly if you've got many
 > CPUs you don't want to be using one buffer. So this code can go.
 > 
 > Now we do the relayfs part:
 > 	rchan = rchan_get(channel_handle);
 > 	if (rchan == NULL)
 > 		return -ENODEV;
 > 
 > 	relay_lock_channel(rchan, flags); /* nop for lockless */
 > 	reserved = relay_reserve(rchan, data_size, &time_stamp, &time_delta, &reserve_code, &interrupting);
 > 
 > 	if (reserve_code & RELAY_WRITE_DISCARD) {
 > 		events_lost(trace->trace_handle, cpu_id)++;
 > 		bytes_written = 0;
 > 		goto check_buffer_switch;
 > 	}
 > 
 > First, the rchan_get() really ought to go. As Roman suggested, relayfs
 > should be handing out IDs, it should be handing out pointers. Once this
 > is changed in relayfs, this piece of code will go and be replaced by
 > something like:
 > 	atomic_inc(&rchan->refcount);
 > 
 > The rest is ok.
 > 
 > At this point we actually write to the buffer:
 > 	if ((trace->log_cpuid == 1) && (event_id != LTT_EV_START)
 > 	    && (event_id != LTT_EV_BUFFER_START))
 > 		relay_write_direct(reserved,
 > 				   &cpu_id,
 > 				   sizeof(cpu_id));
 > 
 > 	relay_write_direct(reserved,
 > 			   &event_id,
 > 			   sizeof(event_id));
 > 
 > 	relay_write_direct(reserved,
 > 			   &time_delta,
 > 			   sizeof(time_delta));
 > 
 > 	if (ltt_test_bit(event_id, &trace->log_event_details_mask)) {
 > 		relay_write_direct(reserved,
 > 				   event_struct,
 > 				   event_struct_size[event_id]);
 > 		if (var_data_len)
 > 			relay_write_direct(reserved,
 > 					   var_data_beg,
 > 					   var_data_len);
 > 	}
 > 
 > 	relay_write_direct(reserved,
 > 			   &data_size,
 > 			   sizeof(data_size));
 > 
 > 	bytes_written = data_size;
 > 
 > As above, the CPU-Id and the check for log_event_details_mask should
 > go. And the details snippet should look something like this:
 > 
 > relay_write_direct(reserved,
 > 		   event_struct,
 > 		   event_struct_size[event_id]);
 > if (data_len)
 > 	relay_write_direct(reserved,
 > 			   data,
 > 			   data_len);
 > 
 > Finally, we complete the relayfs management:
 > 
 > check_buffer_switch:
 > 	if ((event_id == LTT_EV_SCHEDCHANGE) && (tracer_handle == TRACE_HANDLE) && current_traces[FLIGHT_HANDLE].active)
 > 		(((ltt_schedchange *) event_struct)->in) = (u32)incoming_process;
 > 
 > 	/* We need to commit even if we didn't write anything because
 > 	   that's how the deliver callback is invoked. */
 > 	relay_commit(rchan, reserved, bytes_written, reserve_code, interrupting);
 > 
 > 	relay_unlock_channel(rchan, flags);
 > 	rchan_put(rchan);
 > 
 > For this bit, it's the if() that ought to go now that we would be using
 > data and data_len. Also, the rchan_put() should be replaced with the
 > following once relayfs is changed:
 > 	atomic_dec(&rchan->refcount);
 > 
 > Let me know if have additional suggestions.
 > 
 > > The relay_reserve code can loop in the do { } while() and even go into a
 > > slow path where another do { } while() is found.
 > > So it can not be used in fast paths and for timing related problem
 > > tracking, because it adds variable time overhead.
 > 
 > True. But remember what I said earlier, if timing is an issue you need to
 > be using the locking scheme.
 > 
 > > Due to the fact, that the ltt_log_event path is not preempt safe you can
 > > actually hit the additional go in the do { } while() loop.
 > 
 > Yes, we should have something like this instead:
 > 	u32 cpu;
 > 
 > 	preempt_disable();
 > 	cpu = smp_processor_id();
 > 	for (i = 0; i < NR_TRACES; i++) {
 > 		trace = current_traces[i].active;
 > 		err[i] = _ltt_log_event(trace, event_id, event_struct, cpu);
 > 	}
 > 	preempt_enable();
 > 
 > This better?
 > 
 > > I pointed out before, that it is not possible to selectively select the
 > > events which I'm interested in during compile time. I get either nothing
 > > or everything. If I want to use instrumentation for a particular
 > > problem, why must I process a loop of _ltt_log_event calls for stuff I
 > > do not need instead of just compiling it away ?
 > 
 > Like I said, that's an easy hack in Kconfig.
 > 
 > > If I compile a event in, then adding a couple of checks into the
 > > instrumentation macro itself does not hurt as much as leaving the
 > > straight code path for a disabled event.
 > 
 > Right, like I said above, the instrumentation macros should check for
 > the event's logging as early as possible.
 > 
 > As you can see, I am open to your feedback. The above improvements
 > will go in the ltt code.
 > 
 > Karim
 > -- 
 > Author, Speaker, Developer, Consultant
 > Pushing Embedded and Real-Time Linux Systems Beyond the Limits
 > http://www.opersys.com || karim@opersys.com || 1-866-677-4546
