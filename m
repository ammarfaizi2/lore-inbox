Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUDEHH0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 03:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUDEHH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 03:07:26 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:20968 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263159AbUDEHHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 03:07:13 -0400
Date: Mon, 5 Apr 2004 00:05:28 -0700
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com, colpatch@us.ibm.com
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-Id: <20040405000528.513a4af8.pj@sgi.com>
In-Reply-To: <1081128401.18831.6.camel@bach>
References: <20040329041253.5cd281a5.pj@sgi.com>
	<1081128401.18831.6.camel@bach>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, let me say I am honored to have the pleasure of your
consideration of this work.   I enjoy your work and your irreverant
style.

I have a suspicion that what you saw is not what I wrote ;).

> 1) It doesn't add new code to the kernel,

This work reduces the number of kernel source files by about 30, reduces
the number of kernel source lines (after filtering out block comments ;)
by over 200 lines, and for most of the kernel configurations that I've
tried, reduces the kernel text size by a few 100 bytes (numa text sizes
are larger - I'll be working with Matthew on that ...).

Essentially what I am doing here is taking Mathew's nodemask_t proposed
patch, which duplicated much of the cpumask_t mechanisms, each providing
several implementations (arith, array, const or not const), and throwing
away all the duplication with cpumasks and variations of implementation,
to have a single underlying type.

Where before, someone coding an operation on cpumasks had to look in
several nested, configuration ifdef'd files to figure out what
operations were available, and how they worked, now there would be one
file cpumask.h, one file nodemask.h, and one common mask.h file they
share.

I'm removing kernel code, net, not adding, whether you count by source
lines, source files or binary text size.

The resulting API's that a kernel hacker might encounter are
  (1) the bitmap/bitops of before,
  (2) the cpumask_t ops of before, but more accessible, and
  (3) the nodemask_t ops Matthew proposed, just like cpumask_t ops.

> 2) Operations on "cpumap.bits" are easy to read, write and understand,

This sounds like an objection to the cpumask_t type, which was added by
others before me.  I'm sure that Bill Irwin would know the origins of
that type, and may well have played an essential role in its creation.

> 3) Different mask types are not type compatible,

I'm confused which way you mean this.  I'm not sure what you mean
by 'type compatible', and I am not sure whether you think it is a
good idea I'm missing out on, or a bad idea that I'd be better off
without.

So I will have to await the honor of a future reply before I can
comment on this entirely.

Note however that my declarations for cpumask_t and nodemask_t types
are essentially:

  typedef struct { DECLARE_BITMAP(_m,NR_CPUS); } cpumask_t
  typedef struct { DECLARE_BITMAP(_m,MAX_NUMNODES); } nodemask_t

which look suspicously like what you recommend.  Would you rather
I used "bits" for "_m", and removed the typedef?  I inherited the
cpumask_t typedef from those who came before me, but would be quite
open to a recommendation to change the style of declarations from:

	cpumask_t foo;
to:
	struct cpumask foo;

> 4) Any new operations you need to write can be used by anyone who needs
>    a bitmap, whether in a struct or not.

This is still entirely true - new operations (such as the intersects,
subset, xor and andnot that I'm proposing here) _are_ added to bitmaps
or bitops, and directly usable there, as before.  That layer is entirely
unchanged, except:

  1) I added four bitmap ops (though I might abandon xor, andnot)
  2) I added a 'theory' comment, resulting from my confusions
     in properly understanding what Bill Irwin had done.
  3) I added a couple of missing 'const' attributes
  4) I changed bitmap_complement to zero out the unused high bits.

I'm concerned that you thought otherwise, and suspect a serious failure
to communicate on my part.

Again - thank-you for reviewing this.  I await your further feedback.

 P.S. - Perhaps you real concern here is that I'm not going far enough.

	Instead of just putting the cpumask_t internals on a diet
	and allowing for a nodemask_t that shares implementation,
	rather I should change both outright, to the more explicit
	style that is perhaps what you have in mind:

	    struct cpumap { DECLARE_BITMAP(bits, NR_CPUS); };
	    struct cpumask s, d1, d2;
	    bitmap_or(s.bits, d1.bits, d2.bits);

	Nuke cpumask_t, nodemask_t and the existing cpus_or,
	nodes_or, ... and similar such 60 odd various macros
	specific to these two types.

	I rather like that approach.  It would build nicely on
	what I've done so far.  It would be a more intrusive patch,
	changing all declarations and operations on cpumasks.

	If I thought it would sell, I would be most interested.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
