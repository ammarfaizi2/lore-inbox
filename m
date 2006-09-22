Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWIVSG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWIVSG6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWIVSG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:06:58 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:58872 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S964824AbWIVSG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:06:57 -0400
Date: Fri, 22 Sep 2006 14:06:54 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Martin Bligh <mbligh@google.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
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
Subject: Re: [PATCH] Linux Kernel Markers 0.5 for Linux 2.6.17 (with probe  management)
Message-ID: <20060922180654.GA12645@Krystal>
References: <20060921160009.GA30115@Krystal> <20060921160656.GA24774@elte.hu> <20060921214248.GA10097@Krystal> <20060922070714.GB4167@elte.hu> <20060922150810.GB20839@Krystal> <45140E33.9030509@opersys.com> <20060922161353.GA1569@Krystal> <45141759.8060600@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <45141759.8060600@opersys.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 14:03:06 up 30 days, 15:11,  4 users,  load average: 0.30, 0.20, 0.19
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Karim Yaghmour (karim@opersys.com) wrote:
> 
> > Hrm, your comment makes me think of an interesting idea :
> > 
> > .align
> > jump_address:
> >   near jump to end
> > setup_stack_address:
> >   setup stack
> >   call empty function
> > end:
> > 
> > So, instead of putting nops in the target area, we fill it with a useful
> > function call. Near jump being 2 bytes, it might be much easier to modify.
> > If necessary, making sure the instruction is aligned would help to change it
> > atomically. If we mark the jump address, the setup stack address and the end
> > tag address with symbols, we can easily calculate (portably) the offset of the
> > near jump to activate either the setup_stack_address or end tags.
> 
> That's another possibility. It seems more C friendly than the simple
> short-jump+3bytes.
> 
Here is the implementation :-)

Comments are welcome.


/*****************************************************************************
 * marker.h
 *
 * Code markup for dynamic and static tracing. i386 architecture optimisations.
 *
 * (C) Copyright 2006 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
 *
 * This file is released under the GPLv2.
 * See the file COPYING for more details.
 */

#define MARK_NEAR_JUMP_PREFIX "__mark_near_jump_"
#define MARK_NEAR_JUMP_SELECT_PREFIX "__mark_near_jump_select_"

/* Note : max 256 bytes between over_label and near_jump */
#define MARK_DO_JUMP(name)      \
        do { \
                __label__ near_jump; \
                volatile static void *__mark_near_jump_##name \
                        asm (MARK_NEAR_JUMP_PREFIX#name) \
                        __attribute__((unused)) = &&near_jump; \
                volatile static void *__mark_near_jump_select_##name \
                        asm (MARK_NEAR_JUMP_SELECT_PREFIX#name) \
                        __attribute__((unused)) = &&near_jump_select; \
                asm volatile (  ".align 16;\n\t" : : ); \
                asm volatile (  ".byte 0xeb;\n\t" : : ); \
near_jump_select: \
                asm volatile (  ".byte %0-%1;\n\t" : : \
                                "m" (*&&over_label),  "m" (*&&near_jump)); \
near_jump: \
                asm volatile (  "" : : ); \
        } while(0)


To change it, we can dynamically overwrite the __mark_near_jump_select_##name
value (a byte) to (__mark_jump_call_##name - __mark_near_jump_##name).

So we have one architecture specific optimisation within the architecture
agnostic marking mechanism.

Comments are welcome.

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
