Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290743AbSA3XfY>; Wed, 30 Jan 2002 18:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290745AbSA3XfM>; Wed, 30 Jan 2002 18:35:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25099 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290743AbSA3XfF>;
	Wed, 30 Jan 2002 18:35:05 -0500
Message-ID: <3C58817F.63166F13@zip.com.au>
Date: Wed, 30 Jan 2002 15:27:59 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeffrey W. Baker" <jwbaker@acm.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17: pwrite destroys block I/O throughput
In-Reply-To: <1012431302.17074.10.camel@heat>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeffrey W. Baker" wrote:
> 
> Hi there,
> 
> I've never heard of pwrite and pread before, but htdig apparently makes
> very heavy use of it.

pwrite() is nice.  There's nothing special about it from a kernel
point of view.  It's equivalent to lseek+write to lower layers.

> Is linux's pwrite() just horribly broken?  Is htdig the only program
> that uses it?

Anything which does lots of discontiguous writes can do this.
Probably the recent shortening of the request queue made
it a little worse, but without the ability to perform
write merging at the buffercache LRU list level, we don't
really have a fix.

The reason why it makes your *read* throughput so bad is
that the writes are asynchronous.  So htdig can cheerfully
fill the request queue with 128 writes (and 128 seeks!) but
processes which are doing reads cannot do this asynchronously
(apart from readhead, which doesn't help much here).

So the readers get stuck on a queue behind 127 write seeks.
Eventually their read hits the head of the queue and gets
serviced.  Then they request another read.  And they go
to the back of the queue (or maybe the middle, if they get
lucky  - depends what block they're trying to read).

> Here's a little snapshot of htdig's syscalls, strace -s 0:
> 
> pwrite(6, ""..., 8192, 20717568)        = 8192
> pread(6, ""..., 8192, 138395648)        = 8192
> pwrite(6, ""..., 8192, 127918080)       = 8192
> ...
>

ug.  So we do have a real-world case.
 
> It's seeking all over the place.  Maybe pwrite/pread bypass the elevator
> and proper I/O scheduling.

Nope.  It's just a pathological case.

You'll get much, much better behaviour with

	http://www.zip.com.au/~akpm/linux/2.4/2.4.18-pre7/read-latency2.patch

Because it

a) boosts the priority of readers and
b) Increases the request queue size a lot, so write merges will
   be more common.

Long-term, the only fix for this is to perform the write-merging
at a much higher level - to give it visibility of all the writable
data in the machine.

-
