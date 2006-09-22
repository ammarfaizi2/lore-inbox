Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbWIVPIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbWIVPIO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 11:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbWIVPIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 11:08:14 -0400
Received: from tomts25-srv.bellnexxia.net ([209.226.175.188]:41700 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932580AbWIVPIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 11:08:13 -0400
Date: Fri, 22 Sep 2006 11:08:11 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers 0.5 for Linux 2.6.17 (with probe management)
Message-ID: <20060922150810.GB20839@Krystal>
References: <20060921160009.GA30115@Krystal> <20060921160656.GA24774@elte.hu> <20060921214248.GA10097@Krystal> <20060922070714.GB4167@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060922070714.GB4167@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 10:36:23 up 30 days, 11:45,  4 users,  load average: 0.52, 0.45, 0.52
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Ingo,

* Ingo Molnar (mingo@elte.hu) wrote:
> 
> * Mathieu Desnoyers <compudj@krystal.dyndns.org> wrote:
> 
> > I clearly expressed my position in the previous emails, so did you. 
> > You argued about a use of tracing that is not relevant to my vision of 
> > reality, which is :
> > 
> > - Embedded systems developers won't want a breakpoint-based probe
> 
> are you arguing that i'm trying to force breakpoint-based probing on 
> you? I dont. In fact i explicitly mentioned that i'd accept and support 
> a 5-byte NOP in the body of the marker, in the following mails:
> 
>     "just go for [...] the 5-NOP variant"
>       http://marc.theaimsgroup.com/?l=linux-kernel&m=115859771924187&w=2
>         (my reply to your second proposal)
> 
>     "or at most one NOP"
>       http://marc.theaimsgroup.com/?l=linux-kernel&m=115865412332230&w=2
>         (my reply to your third proposal)
> 
>     "at most a NOP inserted"
>       http://marc.theaimsgroup.com/?l=linux-kernel&m=115886524224874&w=2
>         (my reply to your fifth proposal)
> 
> That enables the probe to be turned into a function call - not an INT3 
> breakpoint. Does it take some effort to implement that on your part? 
> Yes, of course, but getting code upstream is never easy, /especially/ in 
> cases where most of the users wont use a particular feature.
> 

Some details are worth to be mentioned :

- The 5-NOP variant will imply a replacement of 5 1 bytes instructions with 1 5
  bytes one, which is trickier. Masami Hiramatsu's proposal of 2 bytes near jump
  + 3 NOPS is nicer.
- Patching such a 5-bytes instruction memory region doesn't turn markers into a
  complete function call, which includes argument passing.
- The argument "most of the users wont use a particular feature" contradicts
  what you said earlier about every distribution wanting to enable a tracing
  mechanism for their users.

> > - High performance computing users won't want a breakpoint-based probe
> 
> I am not forcing breakpoint-based probing, at all. I dont want _static, 
> build-time function call based_ probing, and there is a big difference. 
> And one reason why i want to avoid "static, build-time function call 
> based probing" is because high-performance computing users dont want any 
> overhead at all in the kernel fastpath.
> 

I think that the performance benefits gained by using tracing information for
studying a system makes the overhead of a jump in the kernel fast path
insignificant. Having a stack setup + function call already put there by the
compiler has the following advantages :

- It is very robust (I could think of using it on a live server, which is not
  true of the djprobe approach).
- It is predictable on every architecture.
- The information extracted is _always_ coherent with the marked variables,
  because the compiler itself created the full function call (stack setup
  included).


> > - djprobe is far away from being in an acceptable state on 
> >   architectures with very inconvenient erratas (x86).
> 
> djprobes over a NOP marker are perfectly usable and safe: just add a 
> simple constraint to them to only allow a djprobes insertion if it 
> replaces a 5-byte NOP.
> 

2 bytes jump + 3 bytes nops.. Yes, it should modify it without causing an
illegal instruction, but how ? Are you aware that their approach has to :
- put an int3
- wait for _all_ the CPUs to execute this int3
- then change the 5 bytes instruction

I can think of a lot of cases where the CPUs will never execute this int3.
Probably that sending an IPI or launching a kernel thread on each CPU to make
sure that this int3 is executed could give more guarantees there. But my point
is not even there : I have seen very skillful teams work hard on those
hardware-caused problems for years and the result is still not usable. It looks
to me like a race between software developers and hardware manufacturers, where
the software guy is always one step behind. This kind of scenario happens when
you want to use an architecture in a way it was not designed and tested for.

As long as CPU manufacturers won't design for live instruction patching (and why
should they do that ? the in3 breakpoint is all what is needed from their
perspective), this will be a race where software developers will lose.


> > - kprobe and djprobe cannot access local variables in every cases
> 
> it is possible with the marker mechanism i outlined before:
> 
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=115886524224874&w=2
> 
> have i missed to address any concern of yours?
> 

Interesting idea. That would make it possible to probe local variables at the
marker site. That's very good for use of kprobes on low rate debug-type markers,
but that doesn't solve my concern about the cat-and-mouse race expressed earlier
about live kernel polymorphic code.

I would be all in for this kind of combo :

If you can find a way to make a kprobe-based probe extract the variables from
such a variable-dependency marked site, that would be great for dynamic of low
event rate code paths. For the high event rate, and while we wait for such a
probe to exist, I think that the load+jump over a complete call is the lowest
cost, most robust, coherent, predictable and portable mechanism I have seen
so far.


Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
