Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWCIJHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWCIJHq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 04:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWCIJHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 04:07:46 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:40299 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751420AbWCIJHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 04:07:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Flhxo6gSJ/n6aZLxnvagEnK7Jp9fcY7FIbqEKJLVxPQelljvqc7569y9A7sA8ZO8/Itx6AolWY0ivxRjjA+zLHag0TGiBnTbqMt1cbOG4zD/WKRNjX65Or1UifjN4xUXiC2VSL6GlemCIrRbOvIdSJeBElTA5S0nVEBPuyeVUu8=  ;
Message-ID: <440FEFD5.6040104@yahoo.com.au>
Date: Thu, 09 Mar 2006 20:05:25 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rt20, "bad page state", jackd
References: <1141846564.5262.20.camel@cmn3.stanford.edu> <20060309084746.GB9408@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060309084746.GB9408@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens wrote:

> Actually I have a bug report that looks quite the same. Happens on s390x
> with lots of I/O stress. But that is against vanilla 2.6.16-rc4 + additional
> patches. I need to ask to reproduce that with a plain vanilla kernel, so
> that a git bisect search might help to figure out what is wrong.
> Unfortunately it seems to take hours before we hit the bug.
> 

It is different because yours is coming from __alloc_pages, so if there
are no previous warnings then it means it wasn't corrupted before last
being freed, so it is a use-after-free bug. I'm surprised at how many
fields have been modified though (mapping, count, mapcount).

PG_error is set, which might mean it is a bug in an error handling path
that doesn't trigger very often.

> <0>Bad page state in process 'blast'
> <0>page:0000000000507d00 flags:0x000000060000002a mapping:00000000007570b0 mapcount:1 count:8
> <0>Trying to fix it up, but a reboot is needed
> <0>Backtrace:
> <4>0000000006e93750 0000000000000000 0000000000773780 0700000000007c7a 
> <4>       0000000000000001 000000000025f878 000000000025f878 0000000000104840 
> <4>       0000000000000000 000000060000002a 0000000000000000 0000000000518d50 
> <4>       000000000000000c 0000000000000008 0000000006e936f8 0000000006e93770 
> <4>       000000000044e1f0 0000000000104840 0000000006e936f8 0000000006e93738 
> <4>Call Trace:
> <4>([<0000000000104870>] dump_stack+0x2b8/0x374)
> <4> [<00000000001a97de>] get_page_from_freelist+0x72e/0x8e8
> <4> [<00000000001a9aa8>] __alloc_pages+0x110/0x324
> <4> [<00000000001b37a0>] page_cache_readahead+0xf6c/0x11e4
> <4> [<000000000019f870>] do_generic_mapping_read+0x150/0x828
> <4> [<00000000001a07f4>] generic_file_aio_read+0x1f8/0x258
> <4> [<00000000001fa844>] do_sync_read+0x130/0x1bc
> <4> [<00000000001fc230>] sys_read+0x170/0x3b8
> <4> [<000000000010fb20>] sysc_tracego+0xe/0x14
> <4> [<0000020000043a84>] 0x20000043a84
> 
> Heiko

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
