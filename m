Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758988AbWLDKoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758988AbWLDKoU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 05:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758994AbWLDKoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 05:44:20 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:60553 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1758983AbWLDKoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 05:44:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=jV5TcbTsHeGmle3fKzkWbFnQlSPSvLxMnSJk5fZpFa7Oco53Wv+oJ+7IjmE76hFKRd9QUyjnZlRvLiJlzxtby2UxYNwT5RcYLit3UU/aQ+YuDNupiMwIkPPWd58eKwIqyU6tanFLAWJkGdXxWLpBZmp51wPhwETfES2qmolvyUE=  ;
X-YMail-OSG: USNPJdMVM1mDMpTJiJfnCDyPpD8hhpURCiljCUOh1tJEtfKdiM5Jo8sjLOS_KREpYx.Kekcze5TrYKYH5zQ9T_sLu2iPAJCea_i4V8LcNdfJuYdJn8dhDKG5mjmNTnsDliOO_.e746N4MgM-
Message-ID: <4573FBD1.8050802@yahoo.com.au>
Date: Mon, 04 Dec 2006 21:43:29 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Aucoin@Houston.RR.com
CC: "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       "'Andrew Morton'" <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: la la la la ... swappiness
References: <200612032356.kB3NuPc0010673@ms-smtp-04.texas.rr.com>
In-Reply-To: <200612032356.kB3NuPc0010673@ms-smtp-04.texas.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aucoin wrote:
> We want it to swap less for this particular operation because it is low
> priority compared to the rest of what's going on inside the box.
> 
> We've considered both artificially manipulating swap on the fly similar to
> your suggestion as well a parallel thread that pumps a 3 into drop_caches
> every few seconds while the update is running, but these seem too much like
> hacks for our liking. Mind you, if we don't have a choice we'll do what we
> need to get the job done but there's a nagging voice in our conscience that
> says keep looking for a more elegant solution and work *with* the kernel
> rather than working against it or trying to trick it into doing what we
> want. 
> 
> We've already disabled OOM so we can at least keep our testing alive while
> searching for a more elegant solution. Although we want to avoid swap in
> this particular instance for this particular reason, in our hearts we agree
> with Andrew that swap can be your friend and get you out of a jam once in a
> while. Even more, we'd like to leave OOM active if we can because we want to
> be told when somebody's not being a good memory citizen.
> 
> Some background, what we've done is carve up a huge chunk of memory that is
> shared between three resident processes as write cache for a proprietary
> block system layout that is part of a scalable storage architecture
> currently capable of RAID 0, 1, 5 (soon 6) virtualized across multiple
> chassis's, essentially treating each machine as a "disk" and providing
> multipath I/O to multiple iSCSI targets as part of a grid/array storage
> solution. Whew! We also have a version that leverages a battery backed write
> cache for higher performance at an additional cost. This software is
> installable on any commodity platform with 4-N disks supported by Linux,
> I've even put it on an Optiplex with 4 simulated disks. Yawn ... yet another
> iSCSI storage solution, but this one scales linearly in capacity as well as
> performance. As such, we have no user level apps on the boxes and precious
> little disk to spare for additional swap so our version of the swap
> manipulation solution is to turn swap completely off for the duration of the
> update.
> 
> I hope I haven't muddied things up even more but basically what we want to
> do is find a way to limit the number of cached pages for disk I/O on the OS
> filesystem, even if it drastically slows down the untar and verify process
> because the disk I/O we really care about is not on any of the OS
> partitions.

Hi Louis,

We had customers see similar incorrect OOM problems, so I sent in some
patches merged after 2.6.16. Can you upgrade to latest kernel? (otherwise
I guess backporting could be an option for you).

Basically the fixes are more conservative about going OOM if the kernel
thinks it can still reclaim some pages, and also allow the kernel to swap
as a last resort, even if swappiness is set to 0.

Once your OOM problems are solved, I think that page reclaim should do a
reasonable job at evicting the right pages with your simple untar
workload.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
