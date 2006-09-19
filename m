Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWISUyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWISUyb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 16:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWISUya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 16:54:30 -0400
Received: from opersys.com ([64.40.108.71]:17672 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751121AbWISUy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 16:54:29 -0400
Message-ID: <45105B5E.9080107@opersys.com>
Date: Tue, 19 Sep 2006 17:04:30 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: prasanna@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       "Frank Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <20060919070516.GD23836@in.ibm.com> <451030A6.6040801@google.com>
In-Reply-To: <451030A6.6040801@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin Bligh wrote:
> be that many? Still doesn't fix the problem Matieu just pointed
> out though. Humpf.

There's one possibility if we're willing to insert a placeholder
at function entry that allows to essentially do what Andrew
suggests without much impact. Specifically, if you need a 5-byte
operation to jump to the alternate instrumented function, you
can then do something like:
1- At build time insert 5-byte unconditional jump to instruction
right after placeholder.
2- At runtime for diverting flow:
   - Replace first byte with int3 (atomically)
   - Replace next 4 bytes with instrumented function destination
   - Replace first byte
3- At runtime for returning flow:
   - Do #2 but for the original placeholder jump.

There's not race condition here or fear of interrupt return in
the middle of anything, or any need to stop the kernel from
operating and the likes, or even dependency on kprobes or need
for dprobes, at least in as far as I can see -- so this should
be trivial on m68k ;). The price to pay is an additional
unconditional jump at all times, which should be optimized at
runtime by the CPU. Benchmarks could help show the real impact,
but as Ingo said, these things should be minimal.

In sum, this would work for function pointers and wouldn't
require having to walk the code in search of instances of
"call foo" to replace.

Just a thought.

Karim

