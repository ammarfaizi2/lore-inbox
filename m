Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266688AbSKOVDw>; Fri, 15 Nov 2002 16:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266701AbSKOVDw>; Fri, 15 Nov 2002 16:03:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16913 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266688AbSKOVDw>; Fri, 15 Nov 2002 16:03:52 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: NFS mountned  directory  and apache2 (2.5.47)
Date: Fri, 15 Nov 2002 21:10:19 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <ar3nrr$f1a$1@penguin.transmeta.com>
References: <79A23782BB8@vcnet.vc.cvut.cz> <15829.22032.166977.73195@helicity.uio.no> <20021115202649.A18706@infradead.org>
X-Trace: palladium.transmeta.com 1037394638 32540 127.0.0.1 (15 Nov 2002 21:10:38 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 15 Nov 2002 21:10:38 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021115202649.A18706@infradead.org>,
Christoph Hellwig  <hch@infradead.org> wrote:
>On Fri, Nov 15, 2002 at 09:16:16PM +0100, Trond Myklebust wrote:
>> >>>>> " " == Petr Vandrovec <VANDROVE@vc.cvut.cz> writes:
>> 
>>      > It does not change anything on the brokeness of apache2 (or
>>      > maybe glibc). It must be able to revert to read/write loop if
>>      > sendfile fails with EINVAL. There is no guarantee that existing
>>      > sendfile() API means that you can use it with all filesystems.
>> 
>> I disagree. Sendfile can *always* be emulated using the standard file
>> 'read' method.
>
>Linus removed that in early 2.5 because it led to kmap() deadlocks.
>sendfile can fail with EINVAL and userspace must not rely on it
>working on any object.

Now that I think we've fixed the deadlocks a different way, we _might_
be able to re-introduce a more generic sendfile(). 

We should also change the name of the dang thing at least internally,
since it has very little to do with sending a file any more.  And
furthermore we should probably introduce an internal file operation that
is the reverse of our misnamed "sendfile", ie a "receive actor" (we
already have the notion of actors, but we don't use them for receiving
directly into a "struct file *"). 

Then we could actually do a real "copyfile()", by just matching up the
source file "sendfile()" function with the destination file "receive
actor" function and letting it rip.  That should allow true "move the
page cache page from one file to another" copies of files, for example. 

		Linus
