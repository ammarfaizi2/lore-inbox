Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263384AbRFEWTz>; Tue, 5 Jun 2001 18:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263392AbRFEWTp>; Tue, 5 Jun 2001 18:19:45 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:63248 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S263384AbRFEWTd>; Tue, 5 Jun 2001 18:19:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Mike Galbraith <mikeg@wen-online.de>,
        "Benjamin C.R. LaHaise" <blah@kvack.org>
Subject: Re: Comment on patch to remove nr_async_pages limitA
Date: Wed, 6 Jun 2001 00:21:33 +0200
X-Mailer: KMail [version 1.2]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Zlatko Calusic <zlatko.calusic@iskon.hr>,
        lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.33.0106052211490.2310-100000@mikeg.weiden.de>
In-Reply-To: <Pine.LNX.4.33.0106052211490.2310-100000@mikeg.weiden.de>
MIME-Version: 1.0
Message-Id: <01060600213307.00553@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 June 2001 23:00, Mike Galbraith wrote:
> On Tue, 5 Jun 2001, Benjamin C.R. LaHaise wrote:
> > Swapping early causes many more problems than swapping late as
> > extraneous seeks to the swap partiton severely degrade performance.
>
> That is not the case here at the spot in the performance curve I'm
> looking at (transition to throughput).
>
> Does this mean the block layer and/or elevator is having problems? 
> Why would using avaliable disk bandwidth vs letting it lie dormant be
> a generically bad thing?.. this I just can't understand.  The
> elevator deals with seeks, the vm is flat not equipped to do so.. it
> contains such concept.

Clearly, if the spindle a dirty file page belongs to is idle, we have 
goofed.

With process data the situation is a little different because the 
natural home of the data is not the swap device but main memory.  The 
following gets pretty close to the truth: when there is memory 
pressure, if the spindle a dirty process page belongs to is idle, we 
have goofed.

Well, as soon as I wrote those obvious truths I started thinking of 
exceptions, but they are silly exceptions such as:

  - read disk block 0
  - dirty last block of disk
  - dirty 1,000 blocks starting at block 0.

For good measure, delete the file the last block of the disk belongs 
to.  We have just sent the head off on a wild goose chase, but we had 
to work at it.  To handle such a set of events without requiring 
prescience we need to be able to cancel disk writes, but just ignoring 
such oddball situations is the next best thing.

That's all by way of saying I agree with you.

--
Daniel
