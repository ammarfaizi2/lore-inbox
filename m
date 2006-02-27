Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWB0URG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWB0URG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWB0URG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:17:06 -0500
Received: from d36-15-41.home1.cgocable.net ([24.36.15.41]:10931 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932337AbWB0URE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:17:04 -0500
Subject: Re: udevd is killing file write performance.
From: John McCutchan <john@johnmccutchan.com>
Reply-To: john@johnmccutchan.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, holt@sgi.com, linux-kernel@vger.kernel.org,
       rml@novell.com, arnd@arndb.de, hch@lst.de,
       Dipankar Sarma <dipankar@in.ibm.com>
In-Reply-To: <4402D039.1050307@yahoo.com.au>
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com>
	 <1140626903.13461.5.camel@localhost.localdomain>
	 <20060222175030.GB30556@lnx-holt.americas.sgi.com>
	 <1140648776.1729.5.camel@localhost.localdomain>
	 <20060222151223.5c9061fd.akpm@osdl.org>
	 <1140651662.2985.2.camel@localhost.localdomain>
	 <20060223161425.4388540e.akpm@osdl.org>
	 <20060224054724.GA8593@johnmccutchan.com>
	 <20060223220053.2f7a977e.akpm@osdl.org>  <43FEB0BF.6080403@yahoo.com.au>
	 <1140972918.15634.1.camel@localhost.localdomain>
	 <4402D039.1050307@yahoo.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Feb 2006 15:17:00 -0500
Message-Id: <1141071420.3735.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-27-02 at 21:11 +1100, Nick Piggin wrote:
> John McCutchan wrote:
> > On Fri, 2006-24-02 at 18:07 +1100, Nick Piggin wrote:
> 
> >>I saw this problem when testing my lockless pagecache a while back.
> >>
> >>Attached is a first implementation of what was my idea then of how
> >>to solve it... note it is pretty rough and I never got around to doing
> >>much testing of it.
> >>
> >>Basically: moves work out of inotify event time and to inotify attach
> >>/detach time while staying out of the core VFS.
> > 
> > 
> > 
> > This looks really good. There might be some corner cases but it looks
> > like it will solve this problem nicely.
> > 
> 
> Thanks. You should see I sent a new version which fixes several bugs
> and cleans up the code a bit.
> 

Yeah, it looks good. I haven't had time to test it myself but nothing
jumps out at as being wrong. I can only say that about the code that
touches inotify -- the rest of the VFS someone else will need to comment
on.

> There might be some areas of potential problems:
> - creating and deleting watches on directories with many entries will
>    take a long time. Is anyone likely to be creating and destroying
>    these things at a very high frequency? Probably nobody cares except
>    it might twist some real-time knickers.
> 

That's not a typical inotify usage pattern. Typically a watch is created
and left until the directory is deleted, or the application closes.

> - concurrent operations in the same watched directory will incur the
>    same scalability penalty. I think this is basically a non-issue since
>    the sheer number of events coming out will likely be a bigger problem.
>    Doctor, it hurts when I do this.
> 

Again, Yeah, I don't think we need to worry.

-- 
John McCutchan <john@johnmccutchan.com>
