Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUHTChv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUHTChv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 22:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266114AbUHTChv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 22:37:51 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:6515 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266069AbUHTCht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 22:37:49 -0400
Message-ID: <412563F6.1080202@yahoo.com.au>
Date: Fri, 20 Aug 2004 12:37:42 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
CC: Hugh Dickins <hugh@veritas.com>, Pete Zaitcev <zaitcev@redhat.com>,
       arjanv@redhat.com, alan@redhat.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, riel@redhat.com, sct@redhat.com
Subject: Re: PF_MEMALLOC in 2.6
References: <Pine.LNX.4.44.0408191320320.17508-100000@localhost.localdomain> <200408192025.53536.oliver@neukum.org>
In-Reply-To: <200408192025.53536.oliver@neukum.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> Am Donnerstag, 19. August 2004 14:41 schrieb Hugh Dickins:
> 
>>Fine for it to dip into those reserves when acting on behalf of something
>>already PF_MEMALLOC (i.e. try_to_free_pages itself), but not fine for it
>>to do so as a matter of course e.g. worst case, doing readahead could
>>easily exhaust reserves.  Or, is this thread only used for writing?
>>that wouldn't be so bad if so.
> 
> 
> All IO going to the actual disk uses the thread. However we usually
> don't want to fail IO request due to low memory.
> 

I'm with Hugh on this one. You only want to be PF_MEMALLOC when
you are in the process of cleaning some memory so it can be freed.
(Perhaps it would be more logical if it were called PF_MEMFREE, and
set in mm/vmscan.c, however the end result is the same)

So if this thing allocates memory on behalf of a read request, then
it is basically a bug. In practice you could probably get away with
servicing all writes with PF_MEMALLOC, however that could still lead
to situations where it consumes all your low memory on behalf of
highmem IO (though perhaps this won't deadlock if that memory is
going to be released as a matter of course?)

Another thing, having it always use PF_MEMALLOC means it can easily
wipe out the GFP_ATOMIC reserve.

So I'd say try to find a way to only use PF_MEMALLOC on behalf of
a PF_MEMALLOC thread or use a mempool or something.
