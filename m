Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751740AbWIYFjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbWIYFjp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 01:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbWIYFjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 01:39:45 -0400
Received: from tomts43-srv.bellnexxia.net ([209.226.175.110]:12478 "EHLO
	tomts43-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751740AbWIYFjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 01:39:44 -0400
Date: Mon, 25 Sep 2006 01:39:40 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Karim Yaghmour <karim@opersys.com>
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
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Linux Kernel Markers 0.8 for 2.6.17 (with near jump for  i386)
Message-ID: <20060925053940.GA7014@Krystal>
References: <20060922214239.GA28625@Krystal> <451591AC.9030703@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <451591AC.9030703@opersys.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 01:34:19 up 33 days,  2:42,  3 users,  load average: 0.02, 0.08, 0.05
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Karim Yaghmour (karim@opersys.com) wrote:
> diffing against an LTT tree ...
> 

Ok, I will do the diff against a vanilla kernel, good point.

> > --- /dev/null
> > +++ b/include/asm-alpha/marker.h
> ...
> > --- /dev/null
> > +++ b/include/asm-arm/marker.h
> ...
> > --- /dev/null
> > +++ b/include/asm-arm26/marker.h
> ...
> ...
> 
> Not sure about the need for asm-foo/marker.h if the file contains no
> code at all. If there's going to be one marker.h per arch, it might
> as well have a purpose. So instead of:
> 
> > --- /dev/null
> > +++ b/include/asm-i386/marker.h
> ...
> > +#define ARCH_HAS_MARK_NEAR_JUMP
> 
> and
> 
> > --- /dev/null
> > +++ b/include/linux/marker.h
> ...
> > +#ifndef ARCH_HAS_MARK_NEAR_JUMP
> ...
> 
> Why not just have asm-foo/marker.h either implement the optimization
> or point to an asm-generic/marker.h which contains the non-optimized
> code. No #ifndefs needed.
> 
Ok, good idea.

> > --- /dev/null
> > +++ b/kernel/Kconfig.marker
> ...
> > +config MARK_SYMBOL
> ...
> > +config MARK_JUMP_CALL
> ...
> > +config MARK_JUMP
> ...
> 
> My understanding of Ingo's input is that he'd rather not have this
> multiple options. Either the markers are active or they aren't.
> So ...
> MARK_ACTIVE ... speaks for itself, enables both the markers and
> the set/disable infrastructure. Markers are enabled in their
> optimized per-architecture implementation.
> 
> MARK_FORCE_DIRECT_CALL ... forces all markers to be non-optimized
> (good for embedded systems where the image is in rom/flash and
> can therefore not have runtime binary modifications.) Maybe this
> should depend on CONFIG_EMBEDDED.
> 
> 

Ok, now only :

CONFIG_MARKERS
and
CONFIG_MARKERS_FORCE_DIRECT_CALL (only appears is EMBEDDED is enabled)

I have rewritted almost everything else, I will post a patch soon (currently
cleaning up). It now supports inline function, unrolled loops and multiple
definitions of the same marker.

Supporting inline functions has proven more important than I first thought
because of gcc 4.0+ optimisations where it takes a static-only function and
inline it automatically in the body of the caller. It removes the symbols of the
inlined function when it does that.

My new approach is a separate .markers section, everything is there.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
