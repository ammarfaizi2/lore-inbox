Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVAOENO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVAOENO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 23:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVAOEMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 23:12:46 -0500
Received: from opersys.com ([64.40.108.71]:46345 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262091AbVAOELj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 23:11:39 -0500
Message-ID: <41E899AC.3070705@opersys.com>
Date: Fri, 14 Jan 2005 23:18:52 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Andi Kleen <ak@muc.de>, Nikita Danilov <nikita@clusterfs.com>,
       linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de> <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de> <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home> <41E8358A.4030908@opersys.com> <Pine.LNX.4.61.0501150101010.30794@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0501150101010.30794@scrub.home>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Roman,

Roman Zippel wrote:
> This doesn't mean everything has to be put into a single call. Several 
> parameters can still be set after creation.

I don't have a problem with that. If that's preferable, then we can do
it this way too.

> Why should a subsystem care about the details of the buffer management?

Because it wants to enforce a data format on buffer boundaries.

Let me explain how this applies in the case of LTT, but this easily
generalizes itself to any sort of subsystem that needs to transfer
large amounts of information between the kernel and user-space. And
to avoid any confusion, let me repeat that relayfs is not intended
just for conveying debug/performance/trace info.

Basically, in the case of LTT at least, the kernel tracing infrastructure
must provide a stream of data to the user-space tools that they will in
turn process and display to the user. At this point it must be said that
what you write and you how write it in the trace depends largely on a
few key issues. Namely:
- How much data you expect to be generating.
- What you intend to do with it.

Given ltt's target audience (mainstream developers, sysadmins, and power-
users), one of the goals was to have a trace format that provided
easy browsing forward and backwards, and random access. Initially,
this was implemented using two 1MB buffers, one that was being written to
while the other one was being written to disk. So, in essence, we had
random access at 1MB boundaries. For reading backwards, the size of the
event is written at the end of the event and we just need to read
2 bytes prior to the current event to know where the previous event
started.

Eventually we found that this format was rather bulky, and that it
recorded superfluous data. Amongst other things we relied on a single
buffer, so with each event we logged the CPU-ID of the processor on
which the event occured. So, in order to reduce the amount of data
recorded and in trying to obtain better performance at runtime by
avoiding a call to do_gettimeofday for every event, we did the
following:
- Eliminate the CPU-ID => use per-cpu buffers instead.
- Stop calling do_gettimeofday when possible => instead write a
  complete time-stamp at sub-buffer boundaries (begining and end;
  because of clock drift) and only read the lower-half of the TSC
  for each event. Determining an event's actual time is done in
  post-mortem in user-space.

So how does this translate in practice? Here's the trace header. This
is written only once at the start of the trace:
/* Information logged when a trace is started */
typedef struct _ltt_trace_start {
	u32 magic_number;
	u32 arch_type;
	u32 arch_variant;
	u32 system_type;
	u8 major_version;
	u8 minor_version;

	u32 buffer_size;
	ltt_event_mask event_mask;
	ltt_event_mask details_mask;
	u8 log_cpuid;
	u8 use_tsc;
	u8 flight_recorder;
} LTT_PACKED_STRUCT ltt_trace_start;

This is written in the begining of every new sub-buffer:
/* Start of trace buffer information */
typedef struct _ltt_buffer_start {
	struct timeval time;	/* Time stamp of this buffer */
	u32 tsc;   		/* TSC of this buffer, if applicable */
	u32 id;			/* Unique buffer ID */
} LTT_PACKED_STRUCT ltt_buffer_start;

This is written at the end of every sub-buffer:
typedef struct _ltt_buffer_end {
	struct timeval time;	/* Time stamp of this buffer */
	u32 tsc;   		/* TSC of this buffer, if applicable */
} LTT_PACKED_STRUCT ltt_buffer_end;

As you can see, we can't just dump this information in an event channel.
This is really intrinsic to how the trace data is going to be read
later on. Removing this data would require more data for each event to
be logged, and require parsing through the trace before reading it in
order to obtain markers allowing random access. This wouldn't be so
bad if we were expecting users to use LTT sporadically for very short
periods of time. However, given ltt's target audience (i.e. need to
run traces for hours, maybe days, weeks), traces would rapidely become
useless because while plowing through a few hundred KBs of data and
allocating RAM for building internal structures as you go is fine,
plowing through tens of GBs of data, possibly hundreds, requires that
you come up with a format that won't require unreasonable resources
from your system, while incuring negligeable runtime costs for generating
it. We believe the format we currently have achieves the right balance
here.

So what happens now is that ltt tells relayfs when creating a channel
how much space it needs for these basic structures, and provides it
with callbacks which are invoked at boundaries for filling the actual
reserved space. In all other circumstances, here's what we are writing
into the relayfs buffer for each event:
- Event ID (1 byte)
- Time delta (4 bytes) => this the low 32-bits from the TSC or a
  diff between the current do_gettimeofday and the one at buffer start.
- Event details (variable length, see include/linux/ltt-events.h)
- Event size (2 bytes)

Of course there are possible improvements. For one thing, we've
discussed dropping the "event size" altogether and rely on smaller
buffers and dynamically create sub-buffer indexing tables for reading
backwards. This is still part of a work in progress which aims at
creating an even better and more flexible format. Of course in an
ideal world this new format and the corresponding user tools would
be available as we speak, but there's only so much that can be done
without having an existing solid base to work off on. As usual,
we're open to any other outside suggestions.

> You could move all this into the relay layer by making a relay channel 
> an event channel. I know you want to save space, but having a magic 
> event_struct_size array is not a good idea. If you have that much events, 
> that a little more overhead causes problems, the tracing results won't be 
> reliable anymore anyway.

I hope what I said above explains why this isn't possible.

> Simplicity and maintainability are far more important than saving a few 
> bytes, the general case should be fast and simple, leave the complexity to 
> the special cases.

I agree. I also realize that not all relayfs clients will have the
same requirements as ltt. Already, ltt uses a few things from relayfs
that others are unlikely to need. For example, it directly invokes
relay_lock_channel() to directly lock a channel and relay_write_direct()
to directly write to the buffers without relying on the usual
relay_write() which takes care of both. This allows LTT to do
zero-copy (i.e. no need to pack a buffer before comiting it.) Other
subsystems may actually not use any relayfs function to write, but
instead write directly to a channel as if it was an allocated buffer
(which in fact it is). In all cases, though, the open(), mmap(),
write() semantic makes it very simple for user-space applications
to process channeled data.

So here's a suggested change. Instead of the current relay_open()
API, here are three replacement functions (inspired by Tim's input
and your comments above):
relay_open(channel_path, mode, bufsize, nbufs);
relay_set_property(property, value);
relay_get_property(property, &value);

Is this more palatable?

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
