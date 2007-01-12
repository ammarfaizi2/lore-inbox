Return-Path: <linux-kernel-owner+w=401wt.eu-S1751608AbXALFAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbXALFAg (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 00:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030480AbXALFAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 00:00:36 -0500
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:42023 "EHLO
	tomts16-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751608AbXALFAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 00:00:35 -0500
Date: Fri, 12 Jan 2007 00:00:32 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 05/05] Linux Kernel Markers, non optimised architectures
Message-ID: <20070112050032.GA14100@Krystal>
References: <11685601382063-git-send-email-mathieu.desnoyers@polymtl.ca> <11685601404005-git-send-email-mathieu.desnoyers@polymtl.ca> <45A710F8.7000405@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <45A710F8.7000405@yahoo.com.au>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 23:50:41 up 142 days,  1:58,  4 users,  load average: 0.38, 0.60, 0.87
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nick Piggin (nickpiggin@yahoo.com.au) wrote:
> Mathieu Desnoyers wrote:
> 
> >+#define MARK(name, format, args...) \
> >+	do { \
> >+		static marker_probe_func *__mark_call_##name = \
> >+					__mark_empty_function; \
> >+		volatile static char __marker_enable_##name = 0; \
> >+		static const struct __mark_marker_c __mark_c_##name \
> >+			__attribute__((section(".markers.c"))) = \
> >+			{ #name, &__mark_call_##name, format } ; \
> >+		static const struct __mark_marker __mark_##name \
> >+			__attribute__((section(".markers"))) = \
> >+			{ &__mark_c_##name, &__marker_enable_##name } ; \
> >+		asm volatile ( "" : : "i" (&__mark_##name)); \
> >+		__mark_check_format(format, ## args); \
> >+		if (unlikely(__marker_enable_##name)) { \
> >+			preempt_disable(); \
> >+			(*__mark_call_##name)(format, ## args); \
> >+			preempt_enable_no_resched(); \
> 
> Why not just preempt_enable() here?
> 

Because the preempt_enable() macro contains preempt_check_resched(), which
may call preempt_schedule() which leads us to a call to schedule(). Therefore,
all those very interesting scheduler functions would cause an infinite
recursive scheduler call if we marked schedule() and used preempt_enable() in
the marker.

The primary goal for the markers (and the probes that attaches to them) is to
have the fewest side-effects possible : any kernel method called from an
instrumentation site adds this precise kernel method to the "cannot be
instrumented" list, which I want to keep as small possible.

Mathieu

-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
