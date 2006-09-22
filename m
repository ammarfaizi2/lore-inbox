Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWIVD72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWIVD72 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 23:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWIVD71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 23:59:27 -0400
Received: from gw.goop.org ([64.81.55.164]:13290 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932256AbWIVD71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 23:59:27 -0400
Message-ID: <45135FA0.1030403@goop.org>
Date: Thu, 21 Sep 2006 20:59:28 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
CC: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
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
Subject: Re: [PATCH] Linux Kernel Markers 0.7 for 2.6.17 (with type checking!)
References: <20060921232024.GA16155@Krystal> <451331A1.3020601@goop.org> <20060922020119.GA28712@Krystal> <45134539.7070305@goop.org> <20060922021400.GA6330@Krystal>
In-Reply-To: <20060922021400.GA6330@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> * Jeremy Fitzhardinge (jeremy@goop.org) wrote:
>   
>> Mathieu Desnoyers wrote:
>>     
>>> #define MARK_SYM(name) \
>>>        do { \
>>>                __label__ here; \
>>>                volatile static void *__mark_kprobe_##name \
>>>                        asm (MARK_CALL_PREFIX#name) \
>>>                        __attribute__((unused)) = &&here; \
>>> here: \
>>>                do { } while(0); \
>>>        } while(0)
>>>
>>> Which fixes the problem. Some tests showed me that the compiler does not 
>>> unroll
>>> an otherwise unrolled loop when this specific macro is called. (test done 
>>> with
>>> -funroll-all-loops).
>>>       
>> Eh?  I thought you wanted to avoid changing the generated code?  
>> Inhibiting loop unrolling could be a pretty large change...
>>
>>     
>
> Yes, if possible. But letting gcc duplicate those symbols brings many questions,
> such as : how can we name each of them differently ? Is there any way to
> automatically increment an "identifier" counter in assembly ?

Use a section instead:

struct marker {
	const char *name;
	const void *location;
};

#define MARKER_SYM(name)
	do {
		__label__ here;
	here:	asm volatile(".section \".markers\"; .long %0, %1; .previous" : : "m" (#name), "m" (*&&here));\
	} while(0);

Not a linker symbol, but it does let you find all the places containing 
a particular mark.

    J
