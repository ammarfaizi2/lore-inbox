Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270657AbRIFNVT>; Thu, 6 Sep 2001 09:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270721AbRIFNVK>; Thu, 6 Sep 2001 09:21:10 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:42928 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S270661AbRIFNU4>;
	Thu, 6 Sep 2001 09:20:56 -0400
Date: Thu, 06 Sep 2001 14:21:14 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Rik van Riel <riel@conectiva.com.br>,
        Stephan von Krawczynski <skraw@ithnet.com>
Cc: _deepfire@mail.ru, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: page pre-swapping + moving it on cache-list
Message-ID: <591984348.999786074@[10.132.112.53]>
In-Reply-To: <Pine.LNX.4.33L.0109061003320.31200-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0109061003320.31200-100000@imladris.rielhome.con
 ectiva>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan / Rik,

--On Thursday, September 06, 2001 10:05 AM -0300 Rik van Riel 
<riel@conectiva.com.br> wrote:

> Pages on the inactive_clean list contain data. Throwing
> away data when you can keep it in memory isn't the smartest
> thing.
>
>> Besides the fact, that the splitting in two lists prevents proper
>> defragmentation
>
> Patches to fix this thing while still allowing us to keep
> the data in memory for most pages are appreciated.

It's not keeping it two lists that prevents proper
defragmentation. It's having it allocated all around
memory, and never freeing the pages which prevent
coalescence of areas, and thus either
throwing away the data, or garbage collecting, that
prevents defragmentation. We never free these pages
either because they sit in an idle system (with
no memory pressure) in places like
inactive_dirty, or in caches, or, in an active
system, because they are direct_reclaim'd out
of inactive_clean etc., so never get freed [1].

As this kind of garbage collection requires memcpy()
etc., it might be harmless when the system is
idle, but isn't going to be an attractive option when
the system is busy thrashing away (though it might be
possible to hueristically evict awkward pages
preferentially, by aging them more harshly).

But before we go introducing tentacles of the buddy
system into every part of the memory manager, I'd
like to be satisfied we can't attempt to allocate
and free stuff more intelligently in the first place.

I have some more ideas on this I shall code up
tonight.

[1] though as disabling direct_reclaim entirely
    has NO measurable effect on fragmentation, fixing
    it is at best a necessary but not sufficient component
    of a fix). I haven't measured the effect of Roger L's
    patch in total.


--
Alex Bligh
