Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267891AbUHTJKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267891AbUHTJKL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 05:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268098AbUHTJHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 05:07:44 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:1645 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267891AbUHTJGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 05:06:32 -0400
Message-ID: <4125BF0F.6080803@yahoo.com.au>
Date: Fri, 20 Aug 2004 19:06:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
CC: Hugh Dickins <hugh@veritas.com>, Pete Zaitcev <zaitcev@redhat.com>,
       arjanv@redhat.com, alan@redhat.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, riel@redhat.com, sct@redhat.com
Subject: Re: PF_MEMALLOC in 2.6
References: <Pine.LNX.4.44.0408191320320.17508-100000@localhost.localdomain> <200408200956.50972.oliver@neukum.org> <4125B111.2040308@yahoo.com.au> <200408201052.51178.oliver@neukum.org>
In-Reply-To: <200408201052.51178.oliver@neukum.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> Am Freitag, 20. August 2004 10:06 schrieb Nick Piggin:
> 
>>>>So I'd say try to find a way to only use PF_MEMALLOC on behalf of
>>>>a PF_MEMALLOC thread or use a mempool or something.
>>>
>>>
>>>Then the SCSI layer should pass down the flag.
>>>
>>
>>It would be ideal from the memory allocator's point of view to do it
>>on a per-request basis like that.
>>
>>When the rubber hits the road, I think it is probably going to be very
>>troublesome to do it right that way. For example, what happens when
>>your usb-thingy-thread blocks on a memory allocation while handling a
>>read request, then the system gets low on memory and someone tries to
>>free some by submitting a write request to the USB device?
> 
> 
> The write request will have to wait. Storage cannot do concurrent IO.
> But all memory allocated in the read request will be GFP_NOIO or
> GFP_ATOMIC so the conclusion of the memory allocation should not
> wait for IO. Either it fails and we report that to the SCSI layer or it
> is completed and the write serviced in turn.
> At least that's the intent.
> 

In that case, having the SCSI layer pass down the flag may be a viable
option.

Just FYI, non atomic allocations need to be __GFP_NORETRY otherwise they
won't fail (unless order >= 3). I suspect this detail is fairly important.
