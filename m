Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWJDVzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWJDVzc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWJDVzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:55:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:6563 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1751182AbWJDVzb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:55:31 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,256,1157353200"; 
   d="scan'208"; a="140526888:sNHT25599224"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Date: Thu, 5 Oct 2006 01:55:23 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC3F3FBA@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Thread-Index: Acbn2oAJ1amHluL4S0eECc78JPLvpQAIyDLg
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <tim.c.chen@linux.intel.com>, "Jeremy Fitzhardinge" <jeremy@goop.org>,
       <herbert@gondor.apana.org.au>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Oct 2006 21:55:29.0391 (UTC) FILETIME=[CE8187F0:01C6E7FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's one cache miss.  One.  For the remainder of the benchmark,
> __warn_once is in cache and there are no more misses.  That's how
caches
> work ;)

Before patch for WARN_ON_ONCE we never had risk to get a cache miss for
__warn_once.
After patch we have.
> __warn_once is in cache and there are no more misses.
There is no insuerence that it is in the cache.

Next:
CPU 1Mb cache cache_alignment : 128  => -16% degradation of tbench
CPU 2Mb cache cache_alignment : 128  => -1%  degradation
CPU 4Mb cache cache_alignment : 64  => -70% degradation

An evictees depends from cache size and line size. last is more
essential in considered case.

Leonid
-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 
Sent: Wednesday, October 04, 2006 9:28 PM
To: Ananiev, Leonid I
Cc: tim.c.chen@linux.intel.com; Jeremy Fitzhardinge;
herbert@gondor.apana.org.au; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression

On Wed, 4 Oct 2006 20:57:57 +0400
"Ananiev, Leonid I" <leonid.i.ananiev@intel.com> wrote:

> >Guys.  Please.  Help us out here.  None of this makes sense, and it's
> > possible that we have an underlying problem in there which we need
to
> know
> > about.
>  This is explantion:
> 
> The static variable __warn_once was "never" read (until there is no
bug)
> before patch "Let WARN_ON/WARN_ON_ONCE return the condition"
>
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
> t;h=684f978347deb42d180373ac4c427f82ef963171
>  in WARN_ON_ONCE's line 
> - if (unlikely((condition) && __warn_once)) { \
> because 'condition' is false. There was no cache miss as a result.
> 
> Cache miss for __warn_once is happened in new lines
> + if (likely(__warn_once)) \
> + if (WARN_ON(__ret_warn_once)) \
> 

That's one cache miss.  One.  For the remainder of the benchmark,
__warn_once is in cache and there are no more misses.  That's how caches
work ;)

But it appears this isn't happening.  Why?
