Return-Path: <linux-kernel-owner+w=401wt.eu-S1754818AbWL1Lmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818AbWL1Lmp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 06:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754820AbWL1Lmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 06:42:45 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:48711 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754818AbWL1Lmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 06:42:44 -0500
Date: Thu, 28 Dec 2006 14:41:27 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Christoph Hellwig <hch@infradead.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>, linux-aio@kvack.org,
       akpm@osdl.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu
Subject: Re: [RFC] Heads up on a series of AIO patchsets
Message-ID: <20061228114127.GB26314@2ka.mipt.ru>
References: <20061227153855.GA25898@in.ibm.com> <20061227162530.GA23000@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061227162530.GA23000@infradead.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 28 Dec 2006 14:41:36 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ I'm only subscribed to linux-fsdevel@ from above Cc list, please keep this
list in Cc: for AIO related stuff. ]

On Wed, Dec 27, 2006 at 04:25:30PM +0000, Christoph Hellwig (hch@infradead.org) wrote:
> (1) note that there is another problem with the current kevent interface,
> 	and that is that it duplicates the event infrastructure for it's
> 	underlying subsystems instead of reusing existing code (e.g.
> 	inotify, epoll, dio-aio).  If we want kevent to be _the_ unified
> 	event system for Linux we need people to help out with straightening
> 	out these even provides as Evgeny seems to be unwilling/unable to
> 	do the work himself and the duplication is simply not acceptable.

I would rewrite inotify/epoll to use kevent, but I would strongly prefer
that it would be done by peopl who created original interfaces - it is
politic decision, not techinical - I do not want to be blamed on each
corner that I killed other people work :)

FS and network AIO kevent based stuff was dropped from kevent tree in
favour of upcoming project (description below).

According do AIO - my personal opinion is that AIO should be designed
asynchronously in all aspects. Here is brief note on how I plan to
iplement it (I plan to start in about a week after New Year vacations).

===

All existing AIO - both mainline and kevent based lack major feature -
they are not fully asyncronous, i.e. they require synchronous set of
steps, some of which can be asynchronous. For example aio_sendfile() [1]
requires open of the file descriptor and only then aio_sendfile() call.
The same applies to mainline AIO and read/write calls.

My idea is to create real asyncronous IO - i.e. some entity which will
describe set of tasks which should be performed asynchronously (from
user point of view, although read and write obviously must be done after
open and before close), for example syscall which gets as parameter
destination socket and local filename (with optional offset and length
fields), which will asynchronously from user point of view open a file
and transfer requested part to the destination socket and then return
opened file descriptor (or it can be closed if requested). Similar
mechanism can be done for read/write calls.

This approach as long as asynchronous IO at all requires access to user
memory from kernels thread or even interrupt handler (that is where
kevent based AIO completes its requests) - it can be done in the way
similar to how existing kevent ring buffer implementation and also can
use dedicated kernel thread or workqueue to copy data into process
memory.

It is very interesting task and should greatly speed up workloads of
busy web/ftp and other servers, which can work with a huge number of
files and huge number of clients.
I've put it into TODO list.

Someone, please stop the time for several days, so I could create some
really good things for the universe.

1. Network AIO
http://tservice.net.ru/~s0mbre/old/?section=projects&item=naio

-- 
	Evgeniy Polyakov
