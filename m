Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268155AbUHFSw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268155AbUHFSw0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 14:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268221AbUHFSw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 14:52:26 -0400
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:14539 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S268155AbUHFSwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 14:52:21 -0400
Message-ID: <4113D480.9050003@am.sony.com>
Date: Fri, 06 Aug 2004 11:57:04 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Henderson <rth@twiddle.net>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is extern inline -> static inline OK?
References: <4112D32B.4060900@am.sony.com> <20040806070027.GA20642@twiddle.net>
In-Reply-To: <20040806070027.GA20642@twiddle.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson wrote:
> On Thu, Aug 05, 2004 at 05:39:07PM -0700, Tim Bird wrote:
>>Under what conditions is it NOT OK to convert "extern inline"
>>to "static inline"?
> 
> When... I arrange for an external version to exist.

Richard - thanks for responding.

As you probably know, many people use extern inline
incorrectly in the kernel.  Your construction appears
correct.

 > ... Grep for EXTERN_INLINE in arch/alpha/kernel to see how it is
 > used. If you can't figure it out, don't try to change anything.

I can see how it is used, but I can only guess the "why".
The only comment I can find about this usage is:
/* Do not touch, this should *NOT* be static inline */

There are a few different reasons someone might use
extern inline rather than static inline. Some affect
code correctness and some don't.  Based on the strength
of the wording in your comment, I would guess that
the related code would suffer code correctness issues if
changed.  However just examining the EXTERN_INLINE usage
itself did not reveal where the code would be incorrect
if static inline were used.

One type of usage which affects code correctness is
when the extern function definition differs from the
inline function definition. This type of usage of
"extern inline" is just plain wrong, since it RELIES
on the compiler to use a particular version of the
function (either the extern one or the inline one),
and the compiler is supposed to be free to make this
choice. This does not appear to be the case with your
code, since your construct uses the same source code
to create the extern functions as the extern inline
definitions. (But maybe I missed something.)

Other reasons for using extern inline are to minimize
code footprint by avoiding extra function copies in
different compilation units, and to increase cache hotness
by reusing the same code, when the compiler decides to not
inline a function.  This last benefit is usually unlikely,
since uninlined code in the same compilation unit as the
currently executing code is much more likely to be
in-cache than uninlined code in some other compilation
unit.

Finally, another reason for using extern inline is to
avoid pointer comparison mismatch for function pointers
to uninlined functions.

In any event, it is difficult to tell what incorrectness
is (presumably) introduced in the alpha code by
using 'static inline' vs. 'extern inline', for the functions
so designated.  Maybe you have specific code that breaks,
or maybe you just saw broken behaviour with the code compiled
differently.

If you could indicate WHY the alpha code must be 'extern inline',
it might be helpful to me, and instructive for others who
need to be educated on this same issue.
  1) have different definitions for functions with same name
  2) avoid wasting space with multiple function copies
  3) increased instruction cache effectiveness
  4) function pointers comparisons
  5) some other reason I still don't understand

If anyone else can tell me if they are aware of cases of either
1) or 5) for other uses of 'extern inline' in the kernel, that
would be helpful.

BTW - I'm trying to figure this out because an instrumentation
system I'm working with uses gcc's -finstrument-functions, which
doesn't deal well with extern inlines that don't really have extern
definitions.  I'm trying to get a grip on which 'extern inlines' it's
OK to change, and which aren't, and how to deal with the ones which
shouldn't be changed.

Thanks,

=============================
Tim Bird
Architecture Group Co-Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
E-mail: tim.bird@am.sony.com
=============================
