Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265810AbUG1GER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265810AbUG1GER (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 02:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUG1GER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 02:04:17 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:12712 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265810AbUG1GEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 02:04:02 -0400
Message-ID: <410739BD.2040203@yahoo.com.au>
Date: Wed, 28 Jul 2004 15:29:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Avi Kivity <avi@exanet.com>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS
 server on local NFS mount
References: <41050300.90800@exanet.com> <20040726210229.GC21889@openzaurus.ucw.cz> <4106B992.8000703@exanet.com> <20040727203438.GB2149@elf.ucw.cz> <4106C2E8.905@exanet.com> <41070183.5000701@yahoo.com.au> <4107357C.9080108@exanet.com>
In-Reply-To: <4107357C.9080108@exanet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> Nick Piggin wrote:
> 
>>
>> There is some need arising for a call to set the PF_MEMALLOC flag for
>> userspace tasks, so you could probably get a patch accepted. Don't
>> call it KSWAPD_HELPER though, maybe MEMFREE or RECLAIM or RECLAIM_HELPER.
> 
> 
> I don't think my patch is general enough, it deals with only one level 
> of dependencies, and doesn't work if the NFS server (or other process 
> that kswapd depends on) depends on kswapd itself. It was intended more 
> as an RFC than a request for inclusion.
> 
> It's probably fine for those with the exact same problem as us.
> 

Well it isn't that you depend on kswapd, but that your task gets called
into via page reclaim (to facilitate page reclaim). In which case having
the task block in memory allocation can cause a deadlock.

The solution is that PF_MEMALLOC tasks are allowed to access the reserve
pool. Dependencies don't matter to this system. It would be your job to
ensure all tasks that might need to allocate memory in order to free
memory have the flag set.


>>
>> But why is your NFS server needed to reclaim memory? Do you have the
>> filesystem mounted locally?
> 
> 
> Yes, for use by protocol adapters like samba.
> 

OK.
