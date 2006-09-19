Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751825AbWISQGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbWISQGN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbWISQGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:06:13 -0400
Received: from smtp-out.google.com ([216.239.33.17]:39065 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751825AbWISQGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:06:12 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=cbK93MdXJC0ym5fXXDL/Rv06CRe8I3zsDQFRD1CkdtksCJMx2yDcJmxKa4LY2i2OA
	xNz+ewUVl+upp8eAGcrPA==
Message-ID: <4510151B.5070304@google.com>
Date: Tue, 19 Sep 2006 09:04:43 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Frank Ch. Eigler" <fche@redhat.com>
CC: Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com>
In-Reply-To: <20060919154612.GU3951@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Ch. Eigler wrote:
> Hi -
> 
> On Tue, Sep 19, 2006 at 08:11:40AM -0700, Martin J. Bligh wrote:
> 
> 
>>[...]  Why don't we just copy the whole damned function somewhere
>>else, and make an instrumented copy (as a kernel module)? Then
>>reroute all the function calls through it [...]
> 
> 
> Interesting idea.  Are you imagining this instrumented copy being
> built at kernel compile time (something like building a "-g -O0"
> parallel)?  Or compiled anew from original sources after deployment?
> Or on-the-fly binary-level rewriting a la SPIN?

"compiled anew from original sources after deployment" seems the most
practical to do to me. From second hand info on using systemtap, you
seem to need the same compiler and source tree to work from anyway, so
this doesn't seem much of a burden.

>>OK, it's not completely trivial to do, but simpler than kprobes [...]
> 
> None of the three above are that easy.  Do you have an implementation
> idea?

not in detail, but given the problems that the other probe technologies
solved, it seems easy in comparison. It seems like all we'd need to do
is "list all references to function, freeze kernel, update all
references, continue", but perhaps I'm oversimplifying it ... if it's
all just straight calls, it'd seem easy. The freeze would be very short,
it's just poking a few addresses.

Having multiple hooks inside the same function pieced in at different
times, etc gets tricky, but you can always fall back on one of the other
methods if you get something complicated (or enforce some self-dicipline
in userspace on how to compound them together).

Ingo Molnar wrote:
 > yeah, this would be nice - if it werent it for function pointers,
 > and if all kernel functions were relocatable. But if you can think of
 > a method to do this, it would be nice.

Well, it doesn't have to work for everything. But would be much nicer
for when it does work, it seems to me. Which functions are not
relocatable? Function pointers are indeed a problem, for the functions
they're used on, but they're not common. Some simple markup for these
types of functions would fix it easily enough, I'd think.

A more common problem would seem to me to be instrumenting a inlined
function that was pulled into multiple places, but even that doesn't
seem particularly difficult.

M.
