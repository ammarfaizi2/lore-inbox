Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264459AbTK0I4n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 03:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264460AbTK0I4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 03:56:43 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:60632 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264459AbTK0I4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 03:56:39 -0500
Message-ID: <3FC5BC43.8030209@cyberone.com.au>
Date: Thu, 27 Nov 2003 19:56:35 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Robert White <rwhite@casabyte.com>,
       "'Jesse Pollard'" <jesse@cats-chateau.net>,
       "'Florian Weimer'" <fw@deneb.enyo.de>, Valdis.Kletnieks@vt.edu,
       "'Daniel Gryniewicz'" <dang@fprintf.net>,
       "'linux-kernel mailing list'" <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAilRHd97CfESTROe2OYd1HQEAAAAA@casabyte.com> <3FC5A7F0.8080507@cyberone.com.au> <Pine.LNX.4.58.0311270106430.6400@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.58.0311270106430.6400@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Lang wrote:

>On Thu, 27 Nov 2003, Nick Piggin wrote:
>
>
>>Robert White wrote:
>>
>>
>>>(Among the other N objections, add things like the lack of any sort of
>>>control or option parameters)
>>>...
>>>N += 1: Sparse Copying (e.g. seeking past blocks of zeros)
>>>N += 1: Unlink or overwrite or what?
>>>N += 1: In-Kernel locking and resolution for pages that are mandatory
>>>lock(ed)
>>>N += 1: No fine-grained control for concurrency issues (multiple writers)
>>>
>>>Start with doing a cp --help and move on from there for an unbounded list of
>>>issues that sys_copy(int fd1, int fd2) does not even come close to
>>>addressing.
>>>
>>>
>>>
>>To be fair, sys_copy is never intended to replace cp or try to be
>>very smart. I don't think it is semantically supposed to do much more
>>than replace a read, write loop (of course, the syscall also has an
>>offset and count).
>>
>>sparse copying would be implementation dependant. If cp wanted to do
>>something special it would not use one big copy call. I think unlink
>>/ overwrite is irrelevant if its semantically a read write loop.
>>
>>
>
>actually if this syscall is allowed to do a COW at the filesystem level
>(which I think is one of the better reasons for implementing this) then
>sparse files would produce sparse copies.
>

Sure, I just mean the semantics should be equivalent to a read write
loop. Another example is zero copy copy for a remote fs that supports
it.

>
>if the destination exists it would need to be unlinked (overwrite doesn't
>make sense in the COW context)
>

Well it would be implementation specific. Presumably it should keep
the semantics of an overwrite.

>
>I don't understand the in-kernel page locking issues refered to above
>
>the concurrancy issues are a good question, but I would suggest that the
>syscall fully setup the copy and then create the link to it. this would
>make the final creation an atomic operation (or as close to it as a
>particular filesystem allows) and if you have multiple writers doing a
>copy to the same destination then the last one wins, the earlier copies
>get unlinked and deleted
>

I don't think it should do any linking / unlinking it should just work
with file descriptors. Concurrent writes to a file don't have many
guarantees. sys_copy shouldn't have to be any stronger (read weaker).

>
>I definantly don't see it being worth it to make a syscall to just
>implement the read/write loop, but a copy syscall designed from the outset
>to do a COW copy that falls back to a read/write loop for filesystems that
>don't do COW has some real benifits
>

No I just mean the semantics.



