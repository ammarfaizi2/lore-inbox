Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752610AbVHGTUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbVHGTUE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 15:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbVHGTUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 15:20:04 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:49165 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1752610AbVHGTUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 15:20:04 -0400
Message-ID: <42F65EE0.4070205@vmware.com>
Date: Sun, 07 Aug 2005 12:20:00 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, pratap@vmware.com
Subject: Re: [PATCH 1/1] i386 Encapsulate copying of pgd entries
References: <200508060026.j760Q6FT025108@zach-dev.vmware.com> <20050807190017.GE1024@openzaurus.ucw.cz>
In-Reply-To: <20050807190017.GE1024@openzaurus.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Aug 2005 19:19:46.0453 (UTC) FILETIME=[F8F21450:01C59B84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>  
>
>>This helps complete the encapsulation of updates to page tables (or pages
>>about to become page tables) into accessor functions rather than using
>>memcpy() to duplicate them.  This is both generally good for consistency
>>and also necessary for running in a hypervisor which requires explicit
>>updates to page table entries.
>>    
>>
>
>Hmm, I'm not sure if this kind of hypervisor can reasonably work with swsusp;
>swsusp is just copying memory, it does not know which part of memory are page tables.
>				Pavel
>  
>

There are good and bad things about this.  Everything with swap suspend 
should be fine for the suspend portion of things; it is when resuming 
back up that one must take care to call the hypervisor functions for 
reloading control registers and updating page tables.

I'm not sure that Xen can cope with that scenario - it would have to go 
into shadowed mode first, then after resume, go back from shadow mode 
into direct page table mode.  Otherwise, as you say, making swap suspend 
aware of what pages are page tables would be quite difficult and 
needlessly complicate the code.

Since most hypervisors will likely provide a suspend/resume mechanism 
that is external to the guest, most of this is a moot point anyways.  
But I wondered if you thought the pgd_clone() accessor would make this 
cleaner or if it is just most confusing:

#ifdef CONFIG_SOFTWARE_SUSPEND
/*
 * Swap suspend & friends need this for resume because things like the 
intel-agp
 * driver might have split up a kernel 4MB mapping.
 */
char __nosavedata swsusp_pg_dir[PAGE_SIZE]
        __attribute__ ((aligned (PAGE_SIZE)));

static inline void save_pg_dir(void)
{
        memcpy(swsusp_pg_dir, swapper_pg_dir, PAGE_SIZE);  <--- could be 
clone_pgd_range()
}

Zach
