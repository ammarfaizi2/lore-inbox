Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965124AbVINJoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbVINJoO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbVINJoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:44:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10205 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965124AbVINJoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:44:11 -0400
Date: Wed, 14 Sep 2005 02:43:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: ak@suse.de, dgc@sgi.com, bharata@in.ibm.com, tytso@mit.edu,
       dipankar@in.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk
 enough
Message-Id: <20050914024313.1e70f2a3.akpm@osdl.org>
In-Reply-To: <4327EA6B.6090102@colorfullife.com>
References: <20050911105709.GA16369@thunk.org>
	<20050913084752.GC4474@in.ibm.com>
	<20050913215932.GA1654338@melbourne.sgi.com>
	<200509141101.16781.ak@suse.de>
	<4327EA6B.6090102@colorfullife.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
> One tricky point are directory dentries: As far as I see, they are 
>  pinned and unfreeable if a (freeable) directory entry is in the cache.
>

Well.  That's the whole problem.

I don't think it's been demonstrated that Ted's problem was caused by
internal fragementation, btw.  Ted, could you run slabtop, see what the
dcache occupancy is?  Monitor it as you start to manually apply pressure? 
If the occupancy falls to 10% and not many slab pages are freed up yet then
yup, it's internal fragmentation.

I've found that internal fragmentation due to pinned directory dentries can
be very high if you're running silly benchmarks which create some
regular-shaped directory tree which can easily create pathological
patterns.  For real-world things with irregular creation and access
patterns and irregular directory sizes the fragmentation isn't as easy to
demonstrate.

Another approach would be to do an aging round on a directory's children
when an unfreeable dentry is encountered on the LRU.  Something like that. 
If internal fragmentation is indeed the problem.
