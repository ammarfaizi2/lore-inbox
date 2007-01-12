Return-Path: <linux-kernel-owner+w=401wt.eu-S1751612AbXALFKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbXALFKa (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 00:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbXALFKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 00:10:30 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:26817 "HELO
	smtp105.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751609AbXALFK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 00:10:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=wOT2tJB75dcz1QPxYFSl/0QiogvhAhaiscRNXRyaTR3d+CHOHD+XLYKV1fu1aaqJ5PoWybR4/E3CnD8dQeQ4l0ZKjNC07xvq5izAEHbXtqv08IF7MoC971kNt5DuPmNpSf46ooewL+IlHYHSQQO9v38xrojT/fYMWMbQTDQ40Bk=  ;
X-YMail-OSG: TwDpp8YVM1lYvbG48BIyLBdjKUslwJWBgyk0AdHdgdgQnVffVjNiQYtSHw2QRoVQHibCKHZl1eVCzN1f6RiTRTKZx_BNTqwLB542ESZZhOvwNnD2hTYl.eQQEmGZrCAw1hhi6zyjV50L5BSgFu3sznuQQGeD_glzDQ--
Message-ID: <45A71827.6020300@yahoo.com.au>
Date: Fri, 12 Jan 2007 16:09:59 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 05/05] Linux Kernel Markers, non optimised architectures
References: <11685601382063-git-send-email-mathieu.desnoyers@polymtl.ca> <11685601404005-git-send-email-mathieu.desnoyers@polymtl.ca> <45A710F8.7000405@yahoo.com.au> <20070112050032.GA14100@Krystal>
In-Reply-To: <20070112050032.GA14100@Krystal>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> * Nick Piggin (nickpiggin@yahoo.com.au) wrote:
> 
>>Mathieu Desnoyers wrote:
>>
>>
>>>+#define MARK(name, format, args...) \
>>>+	do { \
>>>+		static marker_probe_func *__mark_call_##name = \
>>>+					__mark_empty_function; \
>>>+		volatile static char __marker_enable_##name = 0; \
>>>+		static const struct __mark_marker_c __mark_c_##name \
>>>+			__attribute__((section(".markers.c"))) = \
>>>+			{ #name, &__mark_call_##name, format } ; \
>>>+		static const struct __mark_marker __mark_##name \
>>>+			__attribute__((section(".markers"))) = \
>>>+			{ &__mark_c_##name, &__marker_enable_##name } ; \
>>>+		asm volatile ( "" : : "i" (&__mark_##name)); \
>>>+		__mark_check_format(format, ## args); \
>>>+		if (unlikely(__marker_enable_##name)) { \
>>>+			preempt_disable(); \
>>>+			(*__mark_call_##name)(format, ## args); \
>>>+			preempt_enable_no_resched(); \
>>
>>Why not just preempt_enable() here?
>>
> 
> 
> Because the preempt_enable() macro contains preempt_check_resched(), which
> may call preempt_schedule() which leads us to a call to schedule(). Therefore,
> all those very interesting scheduler functions would cause an infinite
> recursive scheduler call if we marked schedule() and used preempt_enable() in
> the marker.

The vast majority of schedule() has preempt turned off, so that shouldn't
be a problem, if you provide a comment.

> The primary goal for the markers (and the probes that attaches to them) is to
> have the fewest side-effects possible : any kernel method called from an
> instrumentation site adds this precise kernel method to the "cannot be
> instrumented" list, which I want to keep as small possible.

OK, well one problem is that it can cause a resched event to be lost, so
you might say it has more side-effects without checking resched.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
