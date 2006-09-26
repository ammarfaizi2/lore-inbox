Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWIZSEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWIZSEV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 14:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWIZSEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 14:04:20 -0400
Received: from tomts22-srv.bellnexxia.net ([209.226.175.184]:57075 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932358AbWIZSET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 14:04:19 -0400
Date: Tue, 26 Sep 2006 14:04:14 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
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
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Karim Yaghmour <karim@opersys.com>,
       Pavel Machek <pavel@suse.cz>, Joe Perches <joe@perches.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
Subject: Re: [PATCH] Linux Kernel Markers 0.13 for 2.6.17
Message-ID: <20060926180414.GA10497@Krystal>
References: <20060925233349.GA2352@Krystal> <20060925235617.GA3147@Krystal> <45187146.8040302@goop.org> <20060926002551.GA18276@Krystal> <20060926004535.GA2978@Krystal> <45187C0E.1080601@goop.org> <20060926025924.GA27366@Krystal> <4518B4A0.6070509@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <4518B4A0.6070509@goop.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 13:58:29 up 34 days, 15:07,  4 users,  load average: 1.73, 0.81, 0.44
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ok, so as far as I can see, we can only control the execution flow by modifying
values in the output list of the asm.

Do you think the following would work ?


#define MARK_JUMP(name, format, args...) \
        do { \
                char condition; \
                asm volatile(   ".section .markers, \"a\";\n\t" \
                                        ".long 0f;\n\t" \
                                        ".previous;\n\t" \
                                        "0:\n\t" \
                                        "movb $0,%1;\n\t" \
                                : "+m" (__marker_sequencer), \
                                "=r" (condition) : ); \
                if(unlikely(condition)) { \
                        MARK_CALL(name, format, ## args); \
                } \
        } while(0)

The jump is left to gcc, we only modify an immediate value (a byte) to change
the selection. The is no memory load involved on the fast path :

...
   6:   b0 00                   mov    $0x0,%al
   8:   84 c0                   test   %al,%al
   a:   75 07                   jne    13 <my_open+0x13>
   c:   b8 ff ff ff ff          mov    $0xffffffff,%eax
  11:   c9                      leave  
  12:   c3                      ret    
  13:   b8 01 00 00 00          mov    $0x1,%eax
  18:   e8 fc ff ff ff          call   19 <my_open+0x19>
  1d:   c7 44 24 0c 00 00 00    movl   $0x0,0xc(%esp)
  24:   00 
  25:   c7 44 24 08 06 00 00    movl   $0x6,0x8(%esp)
  2c:   00 
  2d:   c7 44 24 04 02 00 00    movl   $0x2,0x4(%esp)
  34:   00 
  35:   c7 04 24 0c 00 00 00    movl   $0xc,(%esp)
  3c:   ff 15 94 00 00 00       call   *0x94
  42:   b8 01 00 00 00          mov    $0x1,%eax
  47:   e8 fc ff ff ff          call   48 <my_open+0x48>
  4c:   eb be                   jmp    c <my_open+0xc>


Mathieu

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Mathieu Desnoyers wrote:
> >>Mathieu Desnoyers wrote:
> >>    
> >>>To protect code from being preempted, the macros preempt_disable and
> >>>preempt_enable must normally be used. Logically, this macro must make 
> >>>sure gcc
> >>>doesn't interleave preemptible code and non-preemptible code.
> >>> 
> >>>      
> >>No, it only needs to prevent globally visible side-effects from being 
> >>moved into/out of preemptable blocks.  In practice that means memory 
> >>updates (including the implicit ones that calls to external functions 
> >>are assumed to make).
> >>
> >>    
> >>>Which makes me think that if I put barriers around my asm, call, asm 
> >>>trio, no
> >>>other code will be interleaved. Is it right ?
> >>> 
> >>>      
> >>No global side effects, but code with local side effects could be moved 
> >>around without changing the meaning of preempt.
> >>
> >>For example:
> >>
> >>	int foo;
> >>	extern int global;
> >>
> >>	foo = some_function();
> >>
> >>	foo += 42;
> >>
> >>	preempt_disable();
> >>	// stuff
> >>	preempt_enable();
> >>
> >>	global = foo;
> >>	foo += other_thing();
> >>
> >>Assume here that some_function and other_function are extern, and so gcc 
> >>has no insight into their behaviour and therefore conservatively assumes 
> >>they have global side-effects.
> >>
> >>The memory barriers in preempt_disable/enable will prevent gcc from 
> >>moving any of the function calls into the non-preemptable region. But 
> >>because "foo" is local and isn't visible to any other code, there's no 
> >>reason why the "foo += 42" couldn't move into the preempt region.  
> >>    
> >
> >I am not sure about this last statement. The same reference :
> >http://developer.apple.com/documentation/DeveloperTools/gcc-4.0.1/gcc/Extended-Asm.html
> >  
> (This is pretty old, and this is an area which changes quite a lot.  You 
> should refer to something more recent;
> http://www.cims.nyu.edu/cgi-systems/info2html?/usr/local/info(gcc)Top 
> for example, though in this case the quoted text looks the same.)
> 
> >I am just wondering how gcc can assume that I will not modify variables on 
> >the
> >stack from within a function with a memory clobber. If I would like to do 
> >some
> >nasty things in my assembly code, like accessing directly to a local 
> >variable by
> >using an offset from the stack pointer, I would expect gcc not to relocate 
> >this
> >local variable around my asm volatile memory clobbered statement, as it 
> >falls
> >under the category "access memory in an unpredictable fashion".
> >  
> 
> That not really what it means.  gcc is free to put local variables in 
> memory or register, and unless you pass the local to your asm as a 
> parameter, your code has no way of knowing how to find the current 
> location of the local.  You could trash your stack frame from within the 
> asm if you like, but I don't think gcc is under any obligation to behave 
> in a deterministic way if you do.
> 
> "Unpredictable" in this case means that the memory modified isn't easily 
> specified as a normal asm parameter.  For example, if you have an asm 
> which does a memset(), the modified memory's size is a runtime variable 
> rather than a compile-time constant.  Or perhaps your asm follows a 
> linked list and modifies memory as it traverses the list.
> 
> 
>    J
> 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
