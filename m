Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbUJ0IB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbUJ0IB5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 04:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbUJ0IB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 04:01:57 -0400
Received: from ozlabs.org ([203.10.76.45]:9678 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262319AbUJ0IBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 04:01:09 -0400
Date: Wed, 27 Oct 2004 17:59:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: James Cloos <cloos@jhcloos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MAP_SHARED bizarrely slow
Message-ID: <20041027075944.GK1676@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	James Cloos <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
References: <20041027064527.GJ1676@zax> <m3u0sgiq0b.fsf@lugabout.cloos.reno.nv.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3u0sgiq0b.fsf@lugabout.cloos.reno.nv.us>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 12:23:00AM -0700, James Cloos wrote:
> >>>>> "David" == David Gibson <david@gibson.dropbear.id.au> writes:
> 
> David> http://www.ozlabs.org/people/dgibson/maptest.tar.gz
> 
> David> On a number of machines I've tested - both ppc64 and x86 - the
> David> SHARED version is consistently and significantly (50-100%)
> David> slower than the PRIVATE version.
> 
> Just gave it a test on my laptop and server.  Both are p3.  The
> laptop is under heavier mem pressure; the server has just under
> a gig with most free/cache/buff.  Laptop is still running 2.6.7
> whereas the server is bk as of 2004-10-24.
> 
> Buth took about 11 seconds for the private and around 30 seconds
> for the shared tests.
> 
> So if this is a regression, it predates v2.6.7.

Actually, I think I've figured this one out, now.  And I think it may
have been a very subtle change in my test case.

The difference between MAP_SHARED and MAP_PRIVATE is that when a page
is touched for any reason on MAP_SHARED, a new page will be allocated,
whereas if a MAP_PRIVATE page is touched for read only it will get a
copy of the zero page.  My test wasn't initializing the matrices, just
multiplying whatever was in memory, so it was never write-touching the
input matrices.

With the entire input matrices all copies of the zero page, cache
performance, oddly enough, would have been rather better...

<sticks head in bucket>

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
