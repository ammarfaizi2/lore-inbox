Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbTI3PIw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 11:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbTI3PIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 11:08:52 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:58108 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261553AbTI3PIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 11:08:48 -0400
Date: Tue, 30 Sep 2003 16:08:25 +0100
From: Dave Jones <davej@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       richard.brunner@amd.com
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20030930150825.GD5507@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jamie Lokier <jamie@shareable.org>, akpm@osdl.org,
	torvalds@osdl.org, linux-kernel@vger.kernel.org,
	richard.brunner@amd.com
References: <20030930073814.GA26649@mail.jlokier.co.uk> <20030930132211.GA23333@redhat.com> <20030930133936.GA28876@mail.shareable.org> <20030930135324.GC5507@redhat.com> <20030930144526.GC28876@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930144526.GC28876@mail.shareable.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 03:45:26PM +0100, Jamie Lokier wrote:

 > > And those people are wrong. If they want to save bloat, instead of
 > > 'fixing' things by removing <1 page of .text, how about working on
 > > some of the real problems like shrinking some of the growth of various
 > > data structures that actually *matter*.
 > How about both?

Sounds like wasted effort, in the same sense that rewriting a crap
algorithm in assembly won't be better than using a more efficient
algorithm in C.

 > I'm talking about people with embedded 486s or old 486s donated.  P4s
 > are abundant in RAM

Mine has 256MB. Sure its a huge amount in comparison to how we kitted
out 486s a few years back, but still hardly an abundance in todays bloatware..

 > but 2MB is still not unheard of in the small
 > boxes, and in 2MB, 512 bytes of code (which is about the size of the
 > prefetch workaround) is more significant.

I'l be *amazed* if you manage to get a 2.6 kernel to boot and function
efficiently in 2MB without config'ing away a lot of the 'growth' like
sysfs. (Sidenote: Before some loon actually tries this, by function
efficiently, I mean is actually usable for some purpose, not "it booted
to a bash prompt")
 
 > > F00F workaround was enabled on every kernel that is possible
 > > to boot on affected hardware last time I looked.
 > > This is what you seem to be missing, it's not optional.
 > > If its possible to boot that kernel on affected hardware, 
 > > it needs errata workarounds.
 > 
 > We have a few confusing issues here.
 > 
 > 1. First, your point about affected hardware.
 > 
 >    - I don't see anything that prevents a PPro-compiled kernel from booting
 >      on a P5MMX with the F00F erratum.

Compiled with -m686 - Uses CMOV, won't boot.

 >    - Nor do I see anything that prevents a PII-compiled kernel from booting
 >      on a PPro with the store ordering erratum (X86_PPRO_FENCE).

Correct. As noted in another mail, it arguably should contain the
workaround.

 >    Perhaps it's this apparent hypocrisy which needs healing.

Agreed.

 > 2. I'm not sure if you're criticising the other chap who wants
 >    rid of the AMD errata workaround, or my X86_PREFETCH_FIXUP code.

My criticism was twofold.

1. The splitting of X86_FEATURE_XMM into X86_FEATURE_XMM_PREFETCH and
   X86_FEATURE_3DNOW_PREFETCH doesn't seem to really buy us anything
   other than complication.
2. THis chunk...

+       /* Prefetch works ok? */
+#ifndef CONFIG_X86_PREFETCH_FIXUP
+       if (c->x86_vendor != X86_VENDOR_AMD || c->x86 < 6)
+#endif
+       {
+               if (cpu_has(c, X86_FEATURE_XMM))
+                       set_bit(X86_FEATURE_XMM_PREFETCH, c->x86_capability);
+               if (cpu_has(c, X86_FEATURE_3DNOW))
+                       set_bit(X86_FEATURE_3DNOW_PREFETCH, c->x86_capability);
+       }

- If we haven't set CONFIG_X86_PREFETCH_FIXUP (say a P4 kernel), this
  code path isn't taken, and we end up not doing prefetches on P4's too
  as you're not setting X86_FEATURE_XMM_PREFETCH anywhere else, and apply_alternatives
  leaves them as NOPs.
- Newer C3s are 686's with prefetch, this nobbles them too.


 >    In case you hadn't fully grokked it, my code doesn't disable the
 >    workaround!  It simply substitutes it for a smaller, slightly
 >    slower one, on kernels which are not optimised for AMD.

See above. Or have I missed something ?

 >    Given that, I'm not sure what the thrust of your argument is.

It's possible I'm missing something silly..

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
