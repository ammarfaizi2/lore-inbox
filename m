Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266796AbUG1IBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266796AbUG1IBz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 04:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266831AbUG1HsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:48:07 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:60584 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266806AbUG1HQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:16:18 -0400
Message-ID: <410752BE.80808@yahoo.com.au>
Date: Wed, 28 Jul 2004 17:16:14 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Avi Kivity <avi@exanet.com>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS
 server on local NFS mount
References: <41050300.90800@exanet.com> <20040726210229.GC21889@openzaurus.ucw.cz> <4106B992.8000703@exanet.com> <20040727203438.GB2149@elf.ucw.cz> <4106C2E8.905@exanet.com> <41070183.5000701@yahoo.com.au> <4107357C.9080108@exanet.com> <410739BD.2040203@yahoo.com.au> <41075034.7080701@exanet.com>
In-Reply-To: <41075034.7080701@exanet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> Nick Piggin wrote:

>>
>> The solution is that PF_MEMALLOC tasks are allowed to access the reserve
>> pool. Dependencies don't matter to this system. It would be your job to
>> ensure all tasks that might need to allocate memory in order to free
>> memory have the flag set.
> 
> 
> In the general case that's not sufficient. What if the NFS server wrote 
> to ext3 via the VFS? We might have a ton of ext3 pagecache waiting for 
> kswapd to reclaim NFS memory, while kswapd is waiting on the NFS server 
> writing to ext3.
> 

It is sufficient.

You didn't explain your example very well, but I'll assume it is the
following:

dirty NFS data -> NFS server on localhost -> ext3 filesystem.

So kswapd tries to reclaim some memory and writes out the dirty NFS
data. The NFS server then writes this data to ext3 (it can do this
because it is PF_MEMALLOC). The data gets written out, the NFS server
tells the client it is clean, kswapd continues.

Right?
