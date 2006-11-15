Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030676AbWKOQm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030676AbWKOQm7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030685AbWKOQm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:42:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16555 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030676AbWKOQm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:42:57 -0500
Message-ID: <455B4314.3010503@redhat.com>
Date: Wed, 15 Nov 2006 11:40:52 -0500
From: William Cohen <wcohen@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Eric Dumazet <dada1@cosmosbay.com>, Andrew Morton <akpm@osdl.org>,
       Komuro <komurojun-mbn@nifty.com>, Ernst Herzberg <earny@net4u.de>,
       Andre Noll <maan@systemlinux.org>, oprofile-list@lists.sourceforge.net,
       Jens Axboe <jens.axboe@oracle.com>,
       linux-usb-devel@lists.sourceforge.net, phil.el@wanadoo.fr,
       Adrian Bunk <bunk@stusta.de>, Ingo Molnar <mingo@redhat.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Stephen Hemminger <shemminger@osdl.org>,
       Prakash Punnoor <prakash@punnoor.de>, Len Brown <len.brown@intel.com>,
       Alex Romosan <romosan@sycorax.lbl.gov>,
       Linus Torvalds <torvalds@osdl.org>, discuss@x86-64.org, gregkh@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: 2.6.19-rc5: known regressions (v3)
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>	<20061115102122.GQ22565@stusta.de>	<200611151135.48306.dada1@cosmosbay.com> <200611151150.11275.ak@suse.de>
In-Reply-To: <200611151150.11275.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>On a working kernel on an Opteron, we have normally 4 directories 
>>in /dev/oprofile :
>>
>># ls -ld /dev/oprofile/?
>>drwxr-xr-x 1 root root 0 15. Nov 12:38 /dev/oprofile/0
>>drwxr-xr-x 1 root root 0 15. Nov 12:38 /dev/oprofile/1
>>drwxr-xr-x 1 root root 0 15. Nov 12:38 /dev/oprofile/2
>>drwxr-xr-x 1 root root 0 15. Nov 12:38 /dev/oprofile/3
>>
>>With linux-2.6.19-rc5, the first one (0) is missing and we get 1,2,3
> 
> 
> That's because 0 was never available. It is used by the NMI watchdog.
> The new kernel doesn't give it to oprofile anymore.
> 
> 
>>Maybe the 'bug' is in oprofile tools, that currently expect to find '0'
> 
> 
> Yes, it's likely a user space issue.
> 
> -Andi

OProfile has a simplistic view of the performance monitoring hardware. The 
routines in libop/op_alloc_counter.c determine what set of performance registers 
is available from the processor in use. There is no check to see what registers 
are actually available in the /dev/oprofile directory.

opcontrol executes ophelp to determine which specific counters to count which 
events. The function map_event_to_counter() in libop/op_alloc_counter.c does the 
actual selection. It seems what is needed is for map_event_to_counter() to check 
to see which counters are available and mark the others as unavailable.

-Will
