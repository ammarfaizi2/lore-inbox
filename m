Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759980AbWLCX4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759980AbWLCX4k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 18:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760022AbWLCX4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 18:56:40 -0500
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:49129 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S1759980AbWLCX4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 18:56:39 -0500
Message-Id: <200612032356.kB3NuPc0010673@ms-smtp-04.texas.rr.com>
Reply-To: <Aucoin@Houston.RR.com>
From: "Aucoin" <Aucoin@Houston.RR.com>
To: "'Tim Schmielau'" <tim@physik3.uni-rostock.de>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>, <clameter@sgi.com>
Subject: RE: la la la la ... swappiness
Date: Sun, 3 Dec 2006 17:56:30 -0600
Organization: home
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-reply-to: <Pine.LNX.4.63.0612032137380.17489@gockel.physik3.uni-rostock.de>
Thread-Index: AccXHCFif5GC8F1LTyK9O/h/c7XcKwAFpk5A
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We want it to swap less for this particular operation because it is low
priority compared to the rest of what's going on inside the box.

We've considered both artificially manipulating swap on the fly similar to
your suggestion as well a parallel thread that pumps a 3 into drop_caches
every few seconds while the update is running, but these seem too much like
hacks for our liking. Mind you, if we don't have a choice we'll do what we
need to get the job done but there's a nagging voice in our conscience that
says keep looking for a more elegant solution and work *with* the kernel
rather than working against it or trying to trick it into doing what we
want. 

We've already disabled OOM so we can at least keep our testing alive while
searching for a more elegant solution. Although we want to avoid swap in
this particular instance for this particular reason, in our hearts we agree
with Andrew that swap can be your friend and get you out of a jam once in a
while. Even more, we'd like to leave OOM active if we can because we want to
be told when somebody's not being a good memory citizen.

Some background, what we've done is carve up a huge chunk of memory that is
shared between three resident processes as write cache for a proprietary
block system layout that is part of a scalable storage architecture
currently capable of RAID 0, 1, 5 (soon 6) virtualized across multiple
chassis's, essentially treating each machine as a "disk" and providing
multipath I/O to multiple iSCSI targets as part of a grid/array storage
solution. Whew! We also have a version that leverages a battery backed write
cache for higher performance at an additional cost. This software is
installable on any commodity platform with 4-N disks supported by Linux,
I've even put it on an Optiplex with 4 simulated disks. Yawn ... yet another
iSCSI storage solution, but this one scales linearly in capacity as well as
performance. As such, we have no user level apps on the boxes and precious
little disk to spare for additional swap so our version of the swap
manipulation solution is to turn swap completely off for the duration of the
update.

I hope I haven't muddied things up even more but basically what we want to
do is find a way to limit the number of cached pages for disk I/O on the OS
filesystem, even if it drastically slows down the untar and verify process
because the disk I/O we really care about is not on any of the OS
partitions.

Louis Aucoin

-----Original Message-----
From: Tim Schmielau [mailto:tim@physik3.uni-rostock.de] 
Sent: Sunday, December 03, 2006 2:47 PM
To: Aucoin
Cc: 'Andrew Morton'; torvalds@osdl.org; linux-kernel@vger.kernel.org;
clameter@sgi.com
Subject: RE: la la la la ... swappiness

On Sun, 3 Dec 2006, Aucoin wrote:

> during tar extraction ... inactive pages reaches levels as high as ~375000

So why do you want the system to swap _less_? You need to find some free 
memory for the additional processes to run in, and you have lots of 
inactive pages, so I think you want to swap out _more_ pages.

I'd suggest to temporarily add a swapfile before you update your system. 
This can even help in bringing your memory use to the state before if you 
do it like this
  - swapon additional swapfile
  - update your database software
  - swapoff swap partition
  - swapon swap partition
  - swapoff additional swapfile

Tim


