Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWIUTyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWIUTyK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 15:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWIUTyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 15:54:10 -0400
Received: from gw.goop.org ([64.81.55.164]:24464 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751494AbWIUTyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 15:54:09 -0400
Message-ID: <4512EDDC.2010000@goop.org>
Date: Thu, 21 Sep 2006 12:54:04 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Frank Ch. Eigler" <fche@redhat.com>,
       Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       Martin Bligh <mbligh@google.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>,
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
Subject: Re: [PATCH] Linux Kernel Markers 0.5 for Linux 2.6.17 (with probe
 management)
References: <20060921160009.GA30115@Krystal> <20060921175648.GB22226@redhat.com> <20060921185029.GB12048@elte.hu>
In-Reply-To: <20060921185029.GB12048@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> let me qualify that: parameters must be prepared there too - but no 
> actual function call inserted. (at most a NOP inserted). The register 
> filling doesnt even have to be function-calling-convention compliant - 
> that makes the symbolic probe almost zero-impact to register 
> allocation/scheduling, the only thing it should ensure is that the 
> parameters that are annotated to be available in register, stack or 
> memory _somewhere_. (i.e. not hidden or destroyed at that point by gcc) 
> Does a simple asm() that takes read-only parameters but only adds a NOP 
> achieve this result?

Do you mean using the asm to make sure gcc puts a reference to a 
variable into the DWARF info, or some other way of encoding the value 
locations?

Hm, another problem.  If the mark is in a loop, and gcc decides to 
unroll the loop, then you'll probably only get a mark in one iteration 
of the loop (or 1/Nth of the iterations).  Or worse, assembler errors.  
The only way I can see to deal with this is to not use symbols, but put 
records in a special section.  That way, if the asm() inserting them 
gets duplicated, you'll get duplicate records in the marker section.

I guess you'd get a similar problem with markers inserted in inlined 
functions.

(How does gdb deal with breakpoints in unrolled loops?)

    J
