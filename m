Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161614AbWJDQ6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161614AbWJDQ6K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161613AbWJDQ6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:58:09 -0400
Received: from mga03.intel.com ([143.182.124.21]:10857 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1161612AbWJDQ6F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:58:05 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,256,1157353200"; 
   d="scan'208"; a="126886182:sNHT30637439"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Date: Wed, 4 Oct 2006 20:57:57 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC3F3FAD@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Thread-Index: Acbn0nAQlw6+AksOQcmSf0GDvd3VfAAA6anA
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, <tim.c.chen@linux.intel.com>
Cc: "Jeremy Fitzhardinge" <jeremy@goop.org>, <herbert@gondor.apana.org.au>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Oct 2006 16:58:03.0417 (UTC) FILETIME=[417A0090:01C6E7D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Guys.  Please.  Help us out here.  None of this makes sense, and it's
> possible that we have an underlying problem in there which we need to
know
> about.
 This is explantion:

The static variable __warn_once was "never" read (until there is no bug)
before patch "Let WARN_ON/WARN_ON_ONCE return the condition"
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
t;h=684f978347deb42d180373ac4c427f82ef963171
 in WARN_ON_ONCE's line 
- if (unlikely((condition) && __warn_once)) { \
because 'condition' is false. There was no cache miss as a result.

Cache miss for __warn_once is happened in new lines
+ if (likely(__warn_once)) \
+ if (WARN_ON(__ret_warn_once)) \

Proposed patch is tested by tbench.

>From Leonid Ananiev

Cache miss eliminating in WARN_ON_ONCE  by testing expression value
before static variable value.

Signed-off-by: Leonid Ananiev <leonid.i.ananiev@intel.com>
--- linux-2.6.18-git14/include/asm-generic/bug.h
+++ linux-2.6.18-git14b/include/asm-generic/bug.h
@@ -45,9 +45,12 @@
        static int __warn_once = 1;                     \
        typeof(condition) __ret_warn_once = (condition);\
                                                        \
-       if (likely(__warn_once))                        \
-               if (WARN_ON(__ret_warn_once))           \
+       /* check 'condition' first to avoid cache miss with __warn_once
*/\
+       if (unlikely(__ret_warn_once))                  \
+               if (__warn_once) {                      \
                        __warn_once = 0;                \
+                       WARN_ON(1);                     \
+               }                                       \
        unlikely(__ret_warn_once);                      \
 })
-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 
Sent: Wednesday, October 04, 2006 8:30 PM
To: tim.c.chen@linux.intel.com
Cc: Jeremy Fitzhardinge; herbert@gondor.apana.org.au;
linux-kernel@vger.kernel.org; Ananiev, Leonid I
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression

On Wed, 04 Oct 2006 06:21:35 -0700
Tim Chen <tim.c.chen@linux.intel.com> wrote:

> On Tue, 2006-10-03 at 21:39 -0700, Jeremy Fitzhardinge wrote:
> 
> > 
> > I don't think you've proved your case here.  Do you *know* there are

> > extra cache misses (ie, measuring them), or is it just your theory
to 
> > explain a performance regression?
> > 
> 
> I have measured the cache miss with tool.  So it is not just my
theory.
> 

And what did that tool tell you?

Guys.  Please.  Help us out here.  None of this makes sense, and it's
possible that we have an underlying problem in there which we need to
know
about.

Please don't just ignore my questions.  *why* are we getting a cache
miss
rate on that integer which is causing measurable performance changes?
If
we're reading it that frequently then the variable should be in
cache(!).

Again: do you know which callsite is causing the problem?  I assume one
of
the ones in softirq.c?  Do you know what the cache miss frequency is?
etc.

Because if we don't answer these questions there's an excellent chance
that
the problem (whatever it is) will come back and bite us again.
