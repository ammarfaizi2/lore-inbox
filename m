Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbWIVPcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbWIVPcw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 11:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbWIVPcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 11:32:52 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:39584 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932592AbWIVPcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 11:32:51 -0400
Date: Fri, 22 Sep 2006 11:27:37 -0400
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
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers 0.7 for 2.6.17 (with type checking!)
Message-ID: <20060922152737.GA30668@Krystal>
References: <20060921232024.GA16155@Krystal> <451331A1.3020601@goop.org> <20060922020119.GA28712@Krystal> <45134539.7070305@goop.org> <20060922021400.GA6330@Krystal> <45135FA0.1030403@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <45135FA0.1030403@goop.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 11:22:15 up 30 days, 12:30,  5 users,  load average: 0.19, 0.15, 0.15
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Mathieu Desnoyers wrote:
> >* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> >  
> >>Mathieu Desnoyers wrote:
> >>    
> >>>#define MARK_SYM(name) \
> >>>       do { \
> >>>               __label__ here; \
> >>>               volatile static void *__mark_kprobe_##name \
> >>>                       asm (MARK_CALL_PREFIX#name) \
> >>>                       __attribute__((unused)) = &&here; \
> >>>here: \
> >>>               do { } while(0); \
> >>>       } while(0)
> >>>
> >>>Which fixes the problem. Some tests showed me that the compiler does not 
> >>>unroll
> >>>an otherwise unrolled loop when this specific macro is called. (test 
> >>>done with
> >>>-funroll-all-loops).
> >>>      
> >>Eh?  I thought you wanted to avoid changing the generated code?  
> >>Inhibiting loop unrolling could be a pretty large change...
> >>
> >>    
> >
> >Yes, if possible. But letting gcc duplicate those symbols brings many 
> >questions,
> >such as : how can we name each of them differently ? Is there any way to
> >automatically increment an "identifier" counter in assembly ?
> 
> Use a section instead:
> 
> struct marker {
> 	const char *name;
> 	const void *location;
> };
> 
> #define MARKER_SYM(name)
> 	do {
> 		__label__ here;
> 	here:	asm volatile(".section \".markers\"; .long %0, %1; 
> 	.previous" : : "m" (#name), "m" (*&&here));\
> 	} while(0);
> 
> Not a linker symbol, but it does let you find all the places containing 
> a particular mark.
> 

Very clever idea, as it lessens the impact on the compiler optimisations. Any
ideas about how we could fit in a list of "read" memory constraints based on a
vargs list in the macro ?

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
