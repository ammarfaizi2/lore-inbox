Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbVAUC6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbVAUC6p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 21:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVAUC6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 21:58:45 -0500
Received: from opersys.com ([64.40.108.71]:20751 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262247AbVAUC6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 21:58:40 -0500
Message-ID: <41F0725B.6070202@opersys.com>
Date: Thu, 20 Jan 2005 22:09:15 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Zach Brown <zach.brown@oracle.com>
CC: linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: [RFC] tracepipe -- event streams, debugfs, and pipe_buffers
References: <41F0344C.1030404@oracle.com> <41F03CEC.4060207@opersys.com> <41F03D59.3030403@oracle.com>
In-Reply-To: <41F03D59.3030403@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Zach Brown wrote:
> Only briefly.  They've always seemed more involved than the sort of
> thing I was after.  I'll try and sit down and investigate in more detail.

There's definitely an opportunity for interfacing here. If nothing else,
this clearly shows the interest for the kind of things both relayfs and
ltt attempt to achieve.

So here are a few comments regading the implementation and how this
relates to the stuff I'm working on.

> While it's running the kernel subsystem can send binary blobs, less than
> the length of a page, down this channel.  The blobs are copied into
> per-cpu lists of pages.  Cutesy little headers with get_cycles() and the
> cpu id are prepended to each blob.  The traces are only recorded if user
> space has open references to the file.

In the case of LTT, we just open one relay channel per cpu. This avoids
having to write the CPUID to the trace, that's 2 bytes less per event,
and also avoids any need for synchronization.

As for get_cycles(), some architectures don't have anything useful to
give. Here's for ARM (include/asm-arm/timex.h):
static inline cycles_t get_cycles (void)
{
	return 0;
}

In the case of LTT, we just use the, albeit expensive, do_gettimeofday
when hardware counters aren't there (currently all non-x86 tracing does
this, but this should be fixed.) Also, in the case of the x86 at least,
we just write the lower 32-bits of the TSC, so that's 4 bytes less per
event. Instead, we use the buffer_start and buffer_end callbacks provided
by relayfs to write a header and footer containing full do_gettimeofday
value and TSC value.

> As the pages fill they're kicked off to a work_struct worker who puts
> them in the bufs[] array in the debugfs pipe file.  Userspace can then
> do whatever it wants with the data via the pipe.  One can imagine it
> wanting to splice() these pages to disk in huge batches, or perhaps some
> zero-copy network card, etc.  I've only tested this so far as verifying
> that 'cat' is able to push data into a regular file.

It seems to me that while this is a nice use of pipes, it isn't as fast
as ram-locked pages. Basically relayfs does the bttv driver magic (or
what used to be done in there, I haven't checked what they do lately.)
Basically, we allocate pages, lock them into ram and remap them for use
as a single memory area. No caching necessary. It goes from the buffer
to whatever media you want (disk, network, etc.) IOW, user-space does
a open(), mmap(), write(). Also, the channels exist whether user-space
has done an open or not. That's good for flight-recording.

Looking at the code:

- tracepipe_event() does a get_cpu()/put_cpu() for protecting the
writing to the buffer. What about tracing within an interrupt?
local_irq_save()?

- I hadn't thought of doing something like this to write the header:
+		hdr = tcpu->next_region;
+		hdr->cycles = get_cycles();
+		hdr->cpu = cpu;
I will replace some of the memcpy() code in LTT with something like this.

- From what I assume is a "whishlist":
+ * 	- actually communicate missed to userspace

Already done in LTT.

+ * 	- how to specify wrapping or dropping

relayfs provides RELAY_MODE_CONTINUOUS and RELAY_MODE_NO_OVERWRITE.

+ * 	- non-temporal stores into bufs

The latest relayfs code doesn't care about timestamps. It's its
clients job to do that (ex. ltt).

+ * 	- let caller reserve space and get a pointer into buf

This is the relevant relayfs function:
char* relay_reserve(struct rchan *rchan, u32 len, int *err, int *interrupting)

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
