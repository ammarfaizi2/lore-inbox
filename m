Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWINUgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWINUgT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWINUgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:36:19 -0400
Received: from opersys.com ([64.40.108.71]:34577 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751146AbWINUgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:36:18 -0400
Message-ID: <4509BF9D.5080806@opersys.com>
Date: Thu, 14 Sep 2006 16:46:21 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Tim Bird <tim.bird@am.sony.com>, Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home> <20060914181557.GA22469@elte.hu> <4509B03A.3070504@am.sony.com> <20060914200040.GB5812@elte.hu>
In-Reply-To: <20060914200040.GB5812@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> There's a third option, and that's the one i'm advocating: adding the 
> tracepoint rules to the kernel, but in a _detached_ form from the actual 
> source code.
> 
> yes, someone has to maintain it, but that will be a detached effort, on 
> a low-frequency as-needed basis. It doesnt slow down or hinder 
> high-frequency fast prototyping work, it does not impact the source code 
> visually, and it does not make reading the code harder. Furthermore, 
> while a single broken LTT tracepoint prevents the kernel from building 
> at all, a single broken dynamic rule just wont be inserted into the 
> kernel. All the other rules are still very much intact.

Actually the way ltt used to add its trace-statements is again an
implementation issue. Broken tracepoints need not lead to kernel
build failure.

That's where the markers idea can be useful. What a marker should
do is but provide location. It doesn't need to specify the variables
being observed or anything local, though it doesn't mean the
infrastructure shouldn't allow for this if the maintainer of the
code wanted to.

Ideally, though, markers should be self-contained. IOW, the person
implementing such a marker should not need to edit any other file
that the one being worked on to add an instrumentation point --
at least that's the way I think is easiest. What this means is that
you would be able to add an instrumentation point in the kernel,
build it, run the tracing and view the trace with your new event
without any further intervention on any tool, header, or anything
else.

The only way that I believe this can be done is with a flexible
marker infrastructure that a has a few basic properties:
- Markers should be inlined (clearly this is the bone of contention
  at this point of the thread.)
- By default, all markers should generate not a single instruction
  or modify any instruction path that would be generated should the
  the instrumentation not be there.
- Allow the person instrumenting to specify which variables they
  are interested in without any possibility of build failure should
  the code change making the variable obsolete.
- Build options should be added allowing users to:
  - Keep instrumentation disabled.
  - Create inlined trace points.
  - Create dynamic instrumentation markers.
  - Automatically generate appropriate information required for
    tools to be able to deal with the new instrumentation and/or
    display new information properly -- possibly in a new section
    of the binary.
  - etc.

Again, the goal is to have the loop from instrumentation to
visualization as simple as possible. Any instrumentation required
more that single-file modification is bound to fall in bitrot,
and fast.

Hope this helps.

Thanks,

Karim
