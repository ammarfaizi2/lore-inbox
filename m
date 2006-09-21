Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWIUOqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWIUOqg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 10:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWIUOqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 10:46:36 -0400
Received: from tomts40-srv.bellnexxia.net ([209.226.175.97]:43700 "EHLO
	tomts40-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750762AbWIUOqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 10:46:35 -0400
Date: Thu, 21 Sep 2006 10:46:26 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
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
Message-ID: <20060921144626.GA1438@Krystal>
References: <20060920234517.GA29171@Krystal> <4511D92A.3090204@goop.org> <20060921015840.GB13504@Krystal> <45123C7D.3080309@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <45123C7D.3080309@goop.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 10:26:12 up 29 days, 11:34,  5 users,  load average: 1.59, 2.05, 1.55
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Mathieu Desnoyers wrote:
> >Yup, good catch. I have not seen gcc removing this asm in my objdump 
> >however, by
> >I guess we cannot be sure. This MARK_SYM() is only useful for kprobe
> >insertion : I don't use it myself for the jump markup stuff. I don't know 
> >how
> >relevant it is for kprobes users for the symbol to be at a specific 
> >location,
> >as they don't know themself what data they are interested in and they 
> >simply
> >don't want to modify the instruction stream. I fact, if the asm volatile
> >modifies the instruction stream, it would be an unwanted side-effect :(
> >  
> 
> "asm volatile" isn't documented to do anything other than prevent the 
> asm from being removed altogether.  It doesn't prevent it from being 
> moved elsewhere, and it doesn't imply any ordering dependency with the 
> code around it.  So I don't think it will change the generated code, but 
> I also don't think it will be all that useful unless there's something 
> to actually make sure it's in a particular place - and that may change 
> codegen because it may force the compiler to not eliminate/reorder/move 
> the point at which you want the label.
> 
> Something like this might do it:
> 
>    #define MARK_SYM(label)						\
>    	do {							\
>    		__label__ here;					\
>    	  here: asm volatile(#label " = %0" : : "m" (*&&here));	\
>    	} while(0)
>      
> 
> This at least gives the compiler a C-level label to hang the asm from.
> 
Ok, let's do that then. Thanks for the hint.


> >It doesn't matter :) You are absolutely right, they can get reordered, and 
> >the
> >fact is : we don't care. The function above sets the *target_mark_call 
> >before
> >the *target_mark_jump_over, so that the function pointer is set up before 
> >the
> >jump can call it. But imagine the inverse : the will be able to the 
> >function
> >call before the function call handler is set up. It really doesn't matter
> >because the function pointer is always pointing to a valid function : 
> >either the
> >"empty" default function or the inserted one.
> >  
> 
> Does the local indirect jump really help?  Wouldn't you do just as well 
> with the call?

Taking a function call, even if it is an empty function, will also imply the
cost of setting up the stack. I think it will be more costly than a load+jump.

> It's a jump out of line, but if it points to the null 
> function, it's likely to be in cache, and reducing the number of 
> indirect targets within a few instructions will help the CPU keep its 
> branch target prediction in order (modern Intel chips don't like having 
> too many indirect jumps within a cache line, for example).
> 

Good point. However, as my tests pointed out, it seems less costly to loop
doing out of line jumps than to loop doing predicted branches. Weird, but it
seems to be the case. We should however compare the speed of the jump vs stack
setup and call to empty function.


> It's a pity you can't make these all direct jumps; I guess patching the 
> instruction stream on an SMP system on the fly is too tricky...
> 

This is my basic concern : teams have been working on this full-time for a few
years without success, why would I succeed at doing faset portable
code-modifying branching code in less than that ? I think that the first thing
to achieve is to provide a fast+portable way of dealing with markers and then
the architecture specific improvements will come. As my marking mechanism is
generic enough to do any symbol marking of assembly, it will be easily
customizable per architecture.


> (Though on x86 you could do something like make the default case 5 bytes 
> of nops.  Then to patch it, you could patch in an int3 on the first 
> byte, put the relative address in the other 4 bytes, then patch the int3 
> back to the call/jump.  The int3 handler would look to see if the fault 
> address is a kernel hook point, and if so, spin waiting for the *eip to 
> go to a call/jump, then resume the instruction.)
> 

Yes, many optimisations can be thought of, for many architectures. What I miss
in your idea is where the function call will be ? Probably jumped-over by a
goto after the nops (so that the compiler will put the function call rarely-used
part of the function) ?

The problem with your approach is that : as we are in preemptible code, there
can be an arbitrary thread running in the NOPs, scheduled out and stopped. It
must not come back and iret in the middle of your addresses. The same problem
exists for interrupt handlers.

Regards,

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
