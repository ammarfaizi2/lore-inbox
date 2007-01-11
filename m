Return-Path: <linux-kernel-owner+w=401wt.eu-S932674AbXAKWfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbXAKWfJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 17:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbXAKWfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 17:35:09 -0500
Received: from twinlark.arctic.org ([207.29.250.54]:57226 "EHLO
	twinlark.arctic.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932674AbXAKWfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 17:35:08 -0500
Date: Thu, 11 Jan 2007 14:35:06 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: Andrew Morton <akpm@osdl.org>
cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH - RFC] allow setting vm_dirty below 1% for large memory
 machines
In-Reply-To: <20070111122127.5bcc0b0f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0701111431470.4980@twinlark.arctic.org>
References: <17827.22798.625018.673326@notabene.brown>
 <Pine.LNX.4.64.0701110245300.22043@twinlark.arctic.org>
 <20070111122127.5bcc0b0f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007, Andrew Morton wrote:

> On Thu, 11 Jan 2007 03:04:00 -0800 (PST)
> dean gaudet <dean@arctic.org> wrote:
> 
> > On Tue, 9 Jan 2007, Neil Brown wrote:
> > 
> > > Imagine a machine with lots of memory - say 100Gig.
> > 
> > i've had these problems on machines as "small" as 8GiB.  the real problem 
> > is that the kernel will let millions of potential (write) IO ops stack up 
> > for a device which can handle only mere 100s of IOs per second.  (and i'm 
> > not convinced it does the IOs in a sane order when it has millions to 
> > choose from)
> > 
> > replacing the percentage based dirty_ratio / dirty_background_ratio with 
> > sane kibibyte units is a good fix... but i'm not sure it's sufficient.
> > 
> > it seems like the "flow control" mechanism (i.e. dirty_ratio) should be on 
> > a device basis...
> > 
> > try running doug ledford'd memtest.sh on an 8GiB box with a single disk, 
> > let it go a few minutes then ^C and type "sync".  i've had to wait 10 
> > minutes (2.6.18 with default vm settings).
> > 
> > it makes it hard to guarantee a box can shutdown quickly -- nasty for 
> > setting up UPS on-battery timeouts for example.
> > 
> 
> Increasing the request queue size should help there
> (/sys/block/sda/queue/nr_requests).  Maybe 25% or more benefit with that
> test, at a guess.

hmm i've never had much luck with increasing nr_requests... if i get a 
chance i'll reproduce the problem and try that.


> Probably initscripts should do that rather than leaving the kernel defaults
> in place.  It's a bit tricky for the kernel to do because the decision
> depends upon the number of disks in the system, as well as the amount of
> memory.
> 
> Or perhaps the kernel should implement a system-wide limit on the number of
> requests in flight.  While avoiding per-device starvation.  Tricky.

actually a global dirty_ratio causes interference between devices which 
should otherwise not block each other...

if you set up a "dd if=/dev/zero of=/dev/sdb bs=1M" it shouldn't affect 
write performance on sda -- but it does... because the dd basically 
dirties all of the "dirty_background_ratio" pages and then any task 
writing to sda has to block in the foreground...  (i've had this happen in 
practice -- my hack fix is oflag=direct on the dd... but the problem still 
exists.)

i'm not saying fixing any of this is easy, i'm just being a user griping 
about it :)

-dean
