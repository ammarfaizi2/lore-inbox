Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267634AbUBTAWV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267629AbUBTAUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:20:00 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:14027 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S267631AbUBTAQF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:16:05 -0500
Message-ID: <403551BD.2050901@cyberone.com.au>
Date: Fri, 20 Feb 2004 11:15:57 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
       thornber@redhat.com
Subject: Re: IO scheduler, queue depth, nr_requests
References: <20040216133047.GA9330@suse.de> <20040217145716.GE30438@traveler.cistron.net> <20040218235243.GA30621@drinkel.cistron.nl> <20040218172622.52914567.akpm@osdl.org> <20040219021159.GE30621@drinkel.cistron.nl> <20040218182628.7eb63d57.akpm@osdl.org> <20040219101519.GG30621@drinkel.cistron.nl> <20040219101915.GJ27190@suse.de> <20040219205907.GE32263@drinkel.cistron.nl> <40353E30.6000105@cyberone.com.au> <20040219235303.GI32263@drinkel.cistron.nl>
In-Reply-To: <20040219235303.GI32263@drinkel.cistron.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Miquel van Smoorenburg wrote:

>On Thu, 19 Feb 2004 23:52:32, Nick Piggin wrote:
>
>>
>>Miquel van Smoorenburg wrote:
>>
>
...

>>>Note that this is not an issue of '2 processes writing to 1 file', really.
>>>It's one process and pdflush writing the same dirty pages of the same file.
>>>
>>pdflush is a process though, that's all that matters.
>>
>
>I understand that when the two processes are unrelated, the patch as I
>sent it will do the wrong thing.
>
>But the thing is, you get this:
>
>- "dd" process writes requests
>- pdflush triggers to write dirty pages
>- too many pages are dirty so "dd" blocks as well to write synchronously
>- "dd" process triggers "queue full" but gets marked as "batching" so
>  can continue (get_request)
>- pdflush tries to submit one bio and gets blocked (get_request_wait)
>- "dd" continues, but that one bio from pdflush remains stuck for a while
>
>

The batching logic can probably all be ripped out with per
process limits. It's too complex anyway really.

>That's stupid, that one bio from pdflush should really be allowed on
>the queue, since "dd" is adding requests from the same source to it
>anyway.
>
>

But the whole reason it is getting blocked in the first place
is because your controller is sucking up all your requests.
The whole problem is not a problem if you use properly sized
queues.

I'm a bit surprised that it wasn't working well with a controller
queue depth of 64 and 128 nr_requests. I'll give you a per process
request limit patch to try in a minute.

>Perhaps writes from pdflush should be handled differently to prevent
>this specific case ?
>
>Say, if pdflush adds request #128, don't mark it as batching, but
>let it block. The next process will be the one marked as batching
>and can continue. If pdflush tries to add a request > 128, allow it,
>but _then_ block it.
>
>Would something like that work ? Would it be a good idea to never mark
>a pdflush process as batching, or would that have a negative impact
>for some things ?
>
>

It's hard to know. Maybe a better solution would be to allow pdflush
to be exempt from the limits entirely as long as it tries not to write
to congested queues (which is what it does)...

