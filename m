Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264260AbUHTII4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbUHTII4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUHTIIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:08:55 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:54454 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264260AbUHTIGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:06:51 -0400
Message-ID: <4125B111.2040308@yahoo.com.au>
Date: Fri, 20 Aug 2004 18:06:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
CC: Hugh Dickins <hugh@veritas.com>, Pete Zaitcev <zaitcev@redhat.com>,
       arjanv@redhat.com, alan@redhat.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, riel@redhat.com, sct@redhat.com
Subject: Re: PF_MEMALLOC in 2.6
References: <Pine.LNX.4.44.0408191320320.17508-100000@localhost.localdomain> <200408192025.53536.oliver@neukum.org> <412563F6.1080202@yahoo.com.au> <200408200956.50972.oliver@neukum.org>
In-Reply-To: <200408200956.50972.oliver@neukum.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> Am Freitag, 20. August 2004 04:37 schrieb Nick Piggin:
> 
>>So if this thing allocates memory on behalf of a read request, then
>>it is basically a bug. In practice you could probably get away with
>>servicing all writes with PF_MEMALLOC, however that could still lead
>>to situations where it consumes all your low memory on behalf of
>>highmem IO (though perhaps this won't deadlock if that memory is
>>going to be released as a matter of course?)
>>
>>Another thing, having it always use PF_MEMALLOC means it can easily
>>wipe out the GFP_ATOMIC reserve.
>>
>>So I'd say try to find a way to only use PF_MEMALLOC on behalf of
>>a PF_MEMALLOC thread or use a mempool or something.
> 
> 
> Then the SCSI layer should pass down the flag.
> 

It would be ideal from the memory allocator's point of view to do it
on a per-request basis like that.

When the rubber hits the road, I think it is probably going to be very
troublesome to do it right that way. For example, what happens when
your usb-thingy-thread blocks on a memory allocation while handling a
read request, then the system gets low on memory and someone tries to
free some by submitting a write request to the USB device?

I don't know anything about how the usb thread works so I'm not sure.

The mempool model seems to work well for requests in the block layer -
making a completely uneducated guess I'd say that could be a good
option to investigate.
