Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266585AbUG0VCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266585AbUG0VCh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 17:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266592AbUG0VCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 17:02:37 -0400
Received: from services.exanet.com ([212.143.73.102]:18682 "EHLO
	services.exanet.com") by vger.kernel.org with ESMTP id S266585AbUG0VCf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 17:02:35 -0400
Message-ID: <4106C2E8.905@exanet.com>
Date: Wed, 28 Jul 2004 00:02:32 +0300
From: Avi Kivity <avi@exanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS
 server on local NFS mount
References: <41050300.90800@exanet.com> <20040726210229.GC21889@openzaurus.ucw.cz> <4106B992.8000703@exanet.com> <20040727203438.GB2149@elf.ucw.cz>
In-Reply-To: <20040727203438.GB2149@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jul 2004 21:02:34.0410 (UTC) FILETIME=[0A03A0A0:01C4741D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>I'd hope that kswapd was carefully to make sure that it always has
>enough pages...
>
>...it is harder to do the same auditing with userland program.
>
>  
>
Very true. But is a kernel thread like kswapd depends on a userspace 
program, then that program better be well behaved.

>>A more complete solution would be to assign memory reserve levels below 
>>which a process starts allocating synchronously. For example, normal 
>>processes must have >20MB to make forward progress, kswapd wants >15MB 
>>and the NFS server needs >10MB. Some way would be needed to express the 
>>dependencies.
>>    
>>
>
>Yes, something like that would be neccessary. I believe it would be
>slightly more complicated, like
>
>"NFS server needs > 10MB *and working kswapd*", so you'd need 25MB in
>fact... and this info should be stored in some readable form so that
>it can be checked.
>
>  
>
If the NFS server needed kswapd, we'd deadlock pretty soon, as kswapd 
*really* needs the NFS server. In our case, all block I/O is done using 
unbuffered I/O, and all memory is preallocated, so we don't need kswapd 
at all, just that small bit of memory that syscalls consume.

If the NFS server really needs kswapd, then there'd better be two of 
them. Regular processes would depend on one kswapd, which depends on the 
NFS server, which depends on the second kswapd, which depends on the 
hardware alone. It should be fun trying to describe that topology to the 
kernel through some API.

Our filesystem actually does something like that internally, except the 
dependency chain length is seven, not two.

Avi
