Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269274AbRIBVOH>; Sun, 2 Sep 2001 17:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269326AbRIBVN5>; Sun, 2 Sep 2001 17:13:57 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:4773 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S269274AbRIBVNt>;
	Sun, 2 Sep 2001 17:13:49 -0400
Date: Sun, 02 Sep 2001 22:14:03 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Message-ID: <1040242705.999468843@[169.254.198.40]>
In-Reply-To: <20010902202648Z16301-32383+3039@humbolt.nl.linux.org>
In-Reply-To: <20010902202648Z16301-32383+3039@humbolt.nl.linux.org>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

>> > What do you do when a new module gets inserted, increasing the high
>> > order load and requiring that the slab be expanded? I.e, the need for
>> > dependable  handling of high order physical allocations doesn't go away
>> > entirely.  The slab would help even out the situation with atomic
>> > allocs because it can be expanded to a target size by a normal task,
>> > which can wait.
>>
>> Yes, chew away to disk as this allocation is non atomic.
>
> What I meant was, the new module implements a network driver which
> proceeds  to do atomic allocs.

I think I was agreeing with you, but I think what you meant was
that when you load the module, it expands the slab, but with
a /non-atomic/ alloc. And what I meant was that as the
page reclaim stuff is dumb in terms of recovering buddies
of existing pages, it will chew away for a good while until
it happens to find a large enough hole. But this isn't really
a problem if it happens on module load only.

> One thing I am hearing from some developers is that we don't need to
> solve  the high-order allocation problems because they are really driver
> issues -  all drivers should be changed to use scatter-gather or some
> such.  I don't  know if that's correct, this would require knowledge of
> all driver types and  archs which I can't begin to claim.

We have lots of interesting current restrictions, like we assume
IP packets are contiguous in memory, and we assume we can allocate
their buffers atomically. I suspect there will not be many fans
of non-contiguous IP packet models. [Historics: the buddy system
was originally introduced to cope with fragments which reassembled
to >4k in length, though devices like HSSI with 4470 byte MTU's
are going to have the same problem without fragmentation]

No argument that scatter/gather is better if possible & practical
(SCSI comes to mind).

--
Alex Bligh
