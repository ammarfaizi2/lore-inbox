Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287809AbSBHW4X>; Fri, 8 Feb 2002 17:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287816AbSBHW4G>; Fri, 8 Feb 2002 17:56:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30476 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287809AbSBHWzy>; Fri, 8 Feb 2002 17:55:54 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: patch: aio + bio for raw io
Date: Fri, 8 Feb 2002 22:54:51 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a41kvr$836$1@penguin.transmeta.com>
In-Reply-To: <20020208025313.A11893@redhat.com> <200202082107.g18L7wx26206@eng2.beaverton.ibm.com> <20020208171327.B12788@redhat.com>
X-Trace: palladium.transmeta.com 1013208942 10848 127.0.0.1 (8 Feb 2002 22:55:42 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 8 Feb 2002 22:55:42 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020208171327.B12788@redhat.com>,
Benjamin LaHaise  <bcrl@redhat.com> wrote:
>On Fri, Feb 08, 2002 at 01:07:58PM -0800, Badari Pulavarty wrote:
>> I am looking at the 2.5 patch you sent out. I have few questions/comments:
>> 
>> 1) brw_kvec_async() does not seem to split IO at BIO_MAX_SIZE. I thought
>>    each bio can handle only BIO_MAX_SIZE (ll_rw_kio() is creating one bio
>>    for each BIO_MAX_SIZE IO). 
>
>Sounds like a needless restriction in bio, especially as one of the design 
>requirements for the 2.5 block work is that we're able to support large ios 
>(think 4MB page support).

bio can handle arbitrarily large IO's, BUT it can never split them. 

Basically, IO splitting is NOT the job of the IO layer.  So you can make
any size request you want, but you had better know that the hardware you
send it to can take it.  The bio layer basically guarantees only that
you can send a single contiguous request of PAGE_SIZE, nothing more (in
fact, we might at some point get away from even that, and only guarantee
sectors - with things like loopback remapping etc you might have trouble
even for "contiguous" requests). 

Now, before you say "that's stupid, I don't know what the driver limits
are", ask yourself: 
 - what is it that you want to go fast?
 - what is it that you CAN make fast?

The answer to the "want" question is: the common case. And like it or
not, the common case is never going to be 4MB pages.

The answer to the "can" question is: merging can be fast, splitting
fundamentally cannot.

Splitting a request _fundamentally_ involves memory management (at the
very least you have to allocate a new request), while growing a request
can (and does) mean just adding an entry to the end of a list (until you
cannot grow it any more, of course, but that's the point where you have
to end anyway, so..)

Now, think about that for five minutes, and if you don't come back with
the right answer, you get an F.

In short:

 - the right answer to handling 4MB pages is not to push complexity into
   the low-level drivers and make them try to handle requests that are
   bigger than the hardware can do. 

   In fact, we don't even want to handle it in the mid layers, because
   (a) the mid layers have historically been even more flaky than some
   device drivers and (b) it's a performance loss to even test for the
   common case where the splitting is neither needed nor wanted.

 - the _right_ answer to handling big areas is to build up big bio's
   from smaller ones. And no, you don't have to call the elevator in
   between requests that you know are consecutive on the disk.

   Another way of saying it: if you have 4MB worth of IO, it's YOUR
   resposibility to do the work to make it fit the controller. It is off
   the default case, and _you_ do a bit of extra work instead of asking
   everybody else to do your heavy lifting for you.

Does bio have the interfaces to do this yet? No.  But if you think that
bio's should natively handle any kind of request at all, you're really
barking up the wrong tree. 

If you are in the small small _small_ minority care about 4MB requests,
you should build the infrastructure not to make drivers split them, but
to build up a list of bio's and then submit them all consecutively in
one go.

Remember: checking the limits as you build stuff up is easy, and fast. 

So you should make sure that you never EVER cause anybody to want to
split a bio. 

		Linus
