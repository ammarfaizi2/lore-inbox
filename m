Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263972AbUG2Dgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbUG2Dgp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 23:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbUG2Dgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 23:36:45 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:9905 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263972AbUG2Dgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 23:36:44 -0400
Message-ID: <410870C9.7090103@yahoo.com.au>
Date: Thu, 29 Jul 2004 13:36:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>
CC: Avi Kivity <avi@exanet.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS
References: <200407282236.AAA00859@faui1m.informatik.uni-erlangen.de>
In-Reply-To: <200407282236.AAA00859@faui1m.informatik.uni-erlangen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Weigand wrote:

>Nick Piggin wrote:
>
>
>>Avi Kivity wrote:
>>
>>>The kernel NFS client (which kswapd depends on) has the same issue. Has 
>>>anyone ever observed kswapd deadlock due to imcoming or outgoing NFS 
>>>packets being discarded due to oom?
>>>
>>>
>>Yes this has been observed.
>>
>>alloc_skb on the client needs to somehow know that traffic coming
>>from the server is "MEMALLOC" and allowed to use memory reserves.
>>
>
>What would be an appropriate way to solve this problem? A special
>socket option?
>
>

What I think was happening is dirty NFS pages being written out in response
to low memory. The acks coming back from the server weren't being received
because memory couldn't be allocated for them.

Ideally you would allow the NFS path to allocate enough memory that it can
guarantee forward progress - like how the block layer uses mempools for
struct requests, for example.

