Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWINWo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWINWo2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 18:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWINWo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 18:44:27 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:42400 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932087AbWINWo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 18:44:26 -0400
Date: Fri, 15 Sep 2006 00:36:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Martin Bligh <mbligh@mbligh.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       fche@redhat.com
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060914223607.GB25004@elte.hu>
References: <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <4509BAD4.8010206@mbligh.org> <20060914203430.GB9252@elte.hu> <4509C1D0.6080208@mbligh.org> <20060914213113.GA16989@elte.hu> <4509D6E6.5030409@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4509D6E6.5030409@mbligh.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Martin Bligh <mbligh@mbligh.org> wrote:

> > i very much agree that they should become as fast as possible. So to 
> > rephrase the question: can we make dynamic tracepoints as fast (or 
> > nearly as fast) as static tracepoints? If yes, should we care about 
> > static tracers at all?
> 
> Depends how many nops you're willing to add, I guess. Anything, even 
> the static tracepoints really needs at least a branch to be useful, 
> IMHO. At least for what I've been doing with it, you need to stop the 
> data flow after a while (when the event you're interested in happens, 
> I'm using it like a flight data recorder, so we can go back and do 
> postmortem on what went wrong). I should imagine branch prediction 
> makes it very cheap on most modern CPUs, but don't have hard data to 
> hand.

only 5 bytes of NOP are needed by default, so that a kprobe can insert a 
call/callq instruction. The easiest way in practice is to insert a 
_single_, unconditional function call that is patched out to NOPs upon 
its first occurance (doing this is not a performance issue at all). That 
way the only cost is the NOP and the function parameter preparation 
side-effects. (which might or might not be significant - with register 
calling conventions and most parameters being readily available it 
should be small.)

note that such a limited, minimally invasive 'data extraction point' 
infrastructure is not actually what the LTT patches are doing. It's not 
even close, and i think you'll be surprised. Let me quote from the 
latest LTT patch (patch-2.6.17-lttng-0.5.108, which is the same version 
submitted to lkml - although no specific tracepoints were submitted):

+/* Event wakeup logging function */
+static inline void trace_process_wakeup(
+		unsigned int lttng_param_pid,
+		int lttng_param_state)
+#if (!defined(CONFIG_LTT) || !defined(CONFIG_LTT_FACILITY_PROCESS))
+{
+}
+#else
+{
+	unsigned int index;
+	struct ltt_channel_struct *channel;
+	struct ltt_trace_struct *trace;
+	void *transport_data;
+	char *buffer = NULL;
+	size_t real_to_base = 0; /* The buffer is allocated on arch_size alignment */
+	size_t *to_base = &real_to_base;
+	size_t real_to = 0;
+	size_t *to = &real_to;
+	size_t real_len = 0;
+	size_t *len = &real_len;
+	size_t reserve_size;
+	size_t slot_size;
+	size_t align;
+	const char *real_from;
+	const char **from = &real_from;
+	u64 tsc;
+	size_t before_hdr_pad, after_hdr_pad, header_size;
+
+	if(ltt_traces.num_active_traces == 0) return;
+
+	/* For each field, calculate the field size. */
+	/* size = *to_base + *to + *len */
+	/* Assume that the padding for alignment starts at a
+	 * sizeof(void *) address. */
+
+	*from = (const char*)&lttng_param_pid;
+	align = sizeof(unsigned int);
+
+	if(*len == 0) {
+		*to += ltt_align(*to, align); /* align output */
+	} else {
+		*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+	}
+
+	*len += sizeof(unsigned int);
+
+	*from = (const char*)&lttng_param_state;
+	align = sizeof(int);
+
+	if(*len == 0) {
+		*to += ltt_align(*to, align); /* align output */
+	} else {
+		*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+	}
+
+	*len += sizeof(int);
+
+	reserve_size = *to_base + *to + *len;
+	preempt_disable();
+	ltt_nesting[smp_processor_id()]++;
+	index = ltt_get_index_from_facility(ltt_facility_process_2905B6EB,
+						event_process_wakeup);
+
+	list_for_each_entry_rcu(trace, &ltt_traces.head, list) {
+		if(!trace->active) continue;
+
+		channel = ltt_get_channel_from_index(trace, index);
+
+		slot_size = 0;
+		buffer = ltt_reserve_slot(trace, channel, &transport_data,
+			reserve_size, &slot_size, &tsc,
+			&before_hdr_pad, &after_hdr_pad, &header_size);
+		if(!buffer) continue; /* buffer full */
+
+		*to_base = *to = *len = 0;
+
+		ltt_write_event_header(trace, channel, buffer,
+			ltt_facility_process_2905B6EB, event_process_wakeup,
+			reserve_size, before_hdr_pad, tsc);
+		*to_base += before_hdr_pad + after_hdr_pad + header_size;
+
+		*from = (const char*)&lttng_param_pid;
+		align = sizeof(unsigned int);
+
+		if(*len == 0) {
+			*to += ltt_align(*to, align); /* align output */
+		} else {
+			*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+		}
+
+		*len += sizeof(unsigned int);
+
+		/* Flush pending memcpy */
+		if(*len != 0) {
+			memcpy(buffer+*to_base+*to, *from, *len);
+			*to += *len;
+			*len = 0;
+		}
+
+		*from = (const char*)&lttng_param_state;
+		align = sizeof(int);
+
+		if(*len == 0) {
+			*to += ltt_align(*to, align); /* align output */
+		} else {
+			*len += ltt_align(*to+*len, align); /* alignment, ok to do a memcpy of it */
+		}
+
+		*len += sizeof(int);
+
+		/* Flush pending memcpy */
+		if(*len != 0) {
+			memcpy(buffer+*to_base+*to, *from, *len);
+			*to += *len;
+			*len = 0;
+		}
+
+		ltt_commit_slot(channel, &transport_data, buffer, slot_size);
+
+	}
+
+	ltt_nesting[smp_processor_id()]--;
+	preempt_enable_no_resched();
+}
+#endif //(!defined(CONFIG_LTT) || !defined(CONFIG_LTT_FACILITY_PROCESS))
+

believe it or not, this is inlined into: kernel/sched.c ...

'enuff said. LTT is so far from being even considerable that it's not 
even funny.

	Ingo
