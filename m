Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbULCUHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbULCUHF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 15:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbULCUG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 15:06:29 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:16294 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262491AbULCUBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 15:01:10 -0500
Subject: Re: Suspend 2 merge: 50/51: Device mapper support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Alasdair G Kergon <agk@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dm-devel@redhat.com
In-Reply-To: <20041203174749.GF24233@agk.surrey.redhat.com>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101300802.5805.398.camel@desktop.cunninghams>
	 <20041125235829.GJ2909@elf.ucw.cz>
	 <1101427667.27250.175.camel@desktop.cunninghams>
	 <20041202204042.GD24233@agk.surrey.redhat.com>
	 <1102021461.13302.40.camel@desktop.cunninghams>
	 <20041202214932.GE24233@agk.surrey.redhat.com>
	 <1102025297.13302.51.camel@desktop.cunninghams>
	 <20041203174749.GF24233@agk.surrey.redhat.com>
Content-Type: text/plain
Message-Id: <1102103827.22511.10.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 04 Dec 2004 06:57:07 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2004-12-04 at 04:47, Alasdair G Kergon wrote:
> On Fri, Dec 03, 2004 at 09:08:18AM +1100, Nigel Cunningham wrote:
> > My mistake. The code has been improved and I haven't reverted some of
> > the changes in drivers/md to match. I'll do that and make the two
> > exports that are needed (dm_io_get and dm_io_put) into an
> > include/linux/dm.h.
>  
> It would be device-mapper.h - or the whole of dm-io.h.
> The vmalloc comment also looks wrong BTW - it's extra kmalloc 
> GFP_KERNEL memory you're asking for here.
> 
> I'd like to understand why you need to call those functions
> and how it integrates with the rest of what you're doing:
> do you have calls to other dm functions in other patches?
> 
> Or is this particular change optional, but you have test results 
> showing it to be desirable or necessary in certain cases, maybe 
> indicating a shortcoming within the dm-io code which should be 
> addressed instead?
> 
> Alasdair

Okay. 

Pavel's method of storing the image has an inherent limit: you have to
get a consistent image, so you have to make an atomic copy of memory.
This implies a maximum image size of half of memory. If you want to save
all of your memory when suspending to disk, you simply can't. In order
to get around this limitation, I'm saving the image in two parts: LRU
pages and 'the rest'. The saving is done using highlevel routines (bio
calls, rather than our own polling or whatever drivers), but LRU pages
are guaranteed not to change while we're writing the image. We can then
use the space occupied by our (saved) LRU pages for the atomic copy. 

Prior to saving any of the pages, we generate all of the image meta
data, including (of course) the list of pages in both parts of the
image. But saving the LRU pages may also result in extra slab pages
being allocated, which could make our image inconsistent (they wouldn't
get saved, since we've already calculated which pages to save). To get
around this problem, we use a memory pool, to and from which all page
allocs are satisfied/returned while suspending. The pages in this pool
are unconditionally saved, thereby removing the potentiality of having
an inconsistent image.

Now the question arises, "How big should the memory pool be?". The
answer depends on how much I/O we intend to have on the fly at once
(among other things). If, therefore, we we're using DM crypt to do our
I/O, it will help if we can either get it to allocate the memory it will
need prior to us preparing the metadata, or get from it an amount of
memory to include in the pool, given the maximum amount of I/O we intend
to have on the fly at once.
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

