Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWIUHRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWIUHRX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 03:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWIUHRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 03:17:23 -0400
Received: from gw.goop.org ([64.81.55.164]:62163 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750865AbWIUHRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 03:17:22 -0400
Message-ID: <45123C7D.3080309@goop.org>
Date: Thu, 21 Sep 2006 00:17:17 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
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
Subject: Re: [PATCH] Linux Markers 0.4 (+dynamic probe loader) for 2.6.17
References: <20060920234517.GA29171@Krystal> <4511D92A.3090204@goop.org> <20060921015840.GB13504@Krystal>
In-Reply-To: <20060921015840.GB13504@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> Yup, good catch. I have not seen gcc removing this asm in my objdump however, by
> I guess we cannot be sure. This MARK_SYM() is only useful for kprobe
> insertion : I don't use it myself for the jump markup stuff. I don't know how
> relevant it is for kprobes users for the symbol to be at a specific location,
> as they don't know themself what data they are interested in and they simply
> don't want to modify the instruction stream. I fact, if the asm volatile
> modifies the instruction stream, it would be an unwanted side-effect :(
>   

"asm volatile" isn't documented to do anything other than prevent the 
asm from being removed altogether.  It doesn't prevent it from being 
moved elsewhere, and it doesn't imply any ordering dependency with the 
code around it.  So I don't think it will change the generated code, but 
I also don't think it will be all that useful unless there's something 
to actually make sure it's in a particular place - and that may change 
codegen because it may force the compiler to not eliminate/reorder/move 
the point at which you want the label.

Something like this might do it:

    #define MARK_SYM(label)						\
    	do {							\
    		__label__ here;					\
    	  here: asm volatile(#label " = %0" : : "m" (*&&here));	\
    	} while(0)
      

This at least gives the compiler a C-level label to hang the asm from.

> It doesn't matter :) You are absolutely right, they can get reordered, and the
> fact is : we don't care. The function above sets the *target_mark_call before
> the *target_mark_jump_over, so that the function pointer is set up before the
> jump can call it. But imagine the inverse : the will be able to the function
> call before the function call handler is set up. It really doesn't matter
> because the function pointer is always pointing to a valid function : either the
> "empty" default function or the inserted one.
>   

Does the local indirect jump really help?  Wouldn't you do just as well 
with the call?  It's a jump out of line, but if it points to the null 
function, it's likely to be in cache, and reducing the number of 
indirect targets within a few instructions will help the CPU keep its 
branch target prediction in order (modern Intel chips don't like having 
too many indirect jumps within a cache line, for example).

It's a pity you can't make these all direct jumps; I guess patching the 
instruction stream on an SMP system on the fly is too tricky...

(Though on x86 you could do something like make the default case 5 bytes 
of nops.  Then to patch it, you could patch in an int3 on the first 
byte, put the relative address in the other 4 bytes, then patch the int3 
back to the call/jump.  The int3 handler would look to see if the fault 
address is a kernel hook point, and if so, spin waiting for the *eip to 
go to a call/jump, then resume the instruction.)

    J
