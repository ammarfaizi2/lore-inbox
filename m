Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264511AbTKNFJv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 00:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264509AbTKNFJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 00:09:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27316 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262176AbTKNFJf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 00:09:35 -0500
Date: Fri, 14 Nov 2003 05:09:34 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [RFCI] How best to partition MD/raid devices in 2.6
Message-ID: <20031114050934.GI24159@parcelfarce.linux.theplanet.co.uk>
References: <16308.18387.142415.469027@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16308.18387.142415.469027@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 02:11:15PM +1100, Neil Brown wrote:
>  This patch declares a new major number and uses it to address upto 15
>  partitions on each of the first 16 md arrays.
>  Not only does this limit you do only partitioning 16 md arrays, but
>  it means that there are two separate devices (major+minor) that
>  access the same device.  In 2.4 this is just untidy.  In 2.6 it would
>  also subvert the exclusive access provided by bd_claim, and that
>  isn't a good thing. 
 
It breaks all sorts of exclusions common for 2.4 and 2.6.

>  2/ new major number which uses 6 bits for partitioning and provide
>    some sort of interlock so that you cannot access the same raid
>    array from both the old and the new major at the same time.
>    I'm not sure how easy the interlock would be, but it is probably
>    do-able.  The problem is that I would like a well-defined major

Very painful.

>    number and Linus doesn't seem keen on any more of those (though I
>    realise that isn't unanimous).
>    There was once talk of a 'disk' major number and all the things
>    that looked like discs would come under that somehow, but that
>    doesn't seem to have eventuated.  Maybe it should, but there would
>    still be the interlock problem

Yup.  And it won't be easy (if at all feasible).

>  3/ define minor numbers of block-major-9 that are larger than 255 to
>    have 6 bits of partitioning information. i.e.
>      9,0 -> md0
>      9,1 -> md1
>       ...
>      9,255 -> md255
>      9,256 -> md256
>      9,257 -> md256p1
>      9,257 -> md256p2
>       ...
>      9,320 -> md257
>      9,321 -> md257p1
>       ...
>    This has least impact on other system and is in some ways simplest,
>    but it has the problem of lack of uniformity.  You wouldn't be able
>    to partition md0, but that isn't a big problem as long as you can
>    partition some md arrays.

That works and is trivial to implement.
 
>  4/ just use 'dm', or write a new 'md' module that can present a
>     partition of a device.  Then leave the setup to user-space.
>     This is least impact on the kernel, but most impact on
>     user-space.  It would not be too hard to create a userspace tool
>     that made most of this fairly transparent.
>     Particularly if it was a new 'md' personality, userspace could
>     then effectively decide how the minor numbers of block-major-9
>     were used with respect to partitioning.

Maybe...

> 
> There are probably other options and I would be happy to hear them.
> My personal preference is wavering between 4 (using md) and 2.
> Possibly I should learn more about how 'dm' could handle it for me..

(2) is going to be very nasty.  Keep in mind that there is locking
based on having unique struct block_device.  And entire area is not
too nice to start with - we still have lots of cleanup to do in 2.7.
Try it if you really want to, but I'd expect a lot of hard-to-plug
holes.

(3) is absolutely trivial - will take 10--30 lines in md.c.

No comments on (4).
