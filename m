Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWJMGpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWJMGpy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 02:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWJMGpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 02:45:54 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:28507 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751200AbWJMGpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 02:45:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=aNy2Ltxa6uhcUJanQyAYmWmGPsAfNDUYqf6vTyJJeRfmXRNbLfSiBOrGH4dBmYMQ2QLoiDQ8qyra0zCNPyZHl3vcYeDkMWe9nHMV2fkXLIpJFVe7WV0Fs7AqcfjDq08x08VU6u3Q/JEkKeWhut8YSP7llsAZPLHC4FqPPa6o79I=  ;
Message-ID: <452F361D.1010306@yahoo.com.au>
Date: Fri, 13 Oct 2006 16:45:49 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Nick Piggin <npiggin@suse.de>, Kirill Korotaev <dev@sw.ru>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 5/5] oom: invoke OOM killer from pagefault handler
References: <20061012120102.29671.31163.sendpatchset@linux.site>	<20061012120150.29671.48586.sendpatchset@linux.site>	<452E5B4D.7000402@sw.ru>	<20061012151907.GB18463@wotan.suse.de> <20061012150942.42e05898.akpm@osdl.org>
In-Reply-To: <20061012150942.42e05898.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Thu, 12 Oct 2006 17:19:07 +0200
>Nick Piggin <npiggin@suse.de> wrote:
>
>
>>On Thu, Oct 12, 2006 at 07:12:13PM +0400, Kirill Korotaev wrote:
>>
>>>Nick,
>>>
>>>AFAICS, 1 page allocation which is done in page fault handler
>>>can fail in the only case - OOM kills current, so if we failed
>>>we should have TIF_MEMDIE and just kill current.
>>>Selecting another process for killing if page fault fails means
>>>taking another victim with the one being already killed.
>>>
>>>
>>Hi Kirill,
>>
>>I don't quite understand you.
>>
>
>Kirill is claiming that the only occasion on which a pagefault handler would
>get an oom is when it killed itself in the oom handler.
>

Well I don't think that should happen much. When the process gets OOM 
killed,
it is given full access to all memory reserves, so it will be _less_ likely
to go OOM maybe.

Actually if you work it through, maybe that isn't the case -- our 
infinite retry
logic in the allocator means that non OOM killed tasks will never return 
NULL,
while the OOM task might just use up every single free page in the 
system and
will eventually return NULL. In this case the system is probably on 
death's door
though, so I don't know if it is worth worrying about.

>>If the page allocation fails in the
>>fault handler, we don't want to kill current if it is marked as
>>OOM_DISABLE or sysctl_panic_on_oom is set... imagine a critical
>>service in a failover system.
>>
>>It should be quite likely for another process to be kiled and
>>provide enough memory to keep the system running. Presuming you
>>have faith in the concept of the OOM killer ;)
>>
>
>I'm a bit wobbly about this one.  Some before-and-after testing results
>would help things along..
>

I can force VM_FAULT_OOMs to happen, but it is difficult to make it 
happen in
the real world because most fault handling paths don't allocate higher order
allocations.

What I especially have in mind here is the OOM_DISABLE and panic_on_oom 
sysctl
rather than expecting particularly much better general oom killing 
behaviour.
Suppose you have a critical failover node or heartbeat process or something
where you'd rather the system to panic and reboot instead of doing something
silly...

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
