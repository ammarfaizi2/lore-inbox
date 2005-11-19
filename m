Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbVKSE2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbVKSE2o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 23:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbVKSE2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 23:28:44 -0500
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:14498 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751369AbVKSE2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 23:28:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=BB63/NVGgqEA7euOMaWq1SgNlNF84o9RNkF7Rr72HydOCAZBS5fYdXmwiJtxw/Jbj1RiiiWbIU/tMmzuZcvCJ+alUwJPmiyqHMWnIHd2JLs66b32oVIK939bgRiRqXkXhHRQ3BvhDFz5t3L+W3Rr+/AADI60bxXrZzJkQdKMYIc=  ;
Message-ID: <437EAA83.6010808@yahoo.com.au>
Date: Sat, 19 Nov 2005 15:30:59 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Hugh Dickins <hugh@veritas.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm2 0x414 Bad page states
References: <Pine.LNX.4.61.0511181906240.2853@goblin.wat.veritas.com> <20051118201203.GA31209@isilmar.linta.de> <200511182142.17432.rjw@sisk.pl>
In-Reply-To: <200511182142.17432.rjw@sisk.pl>
Content-Type: multipart/mixed;
 boundary="------------020800070008050003030803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020800070008050003030803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Rafael J. Wysocki wrote:
> Hi,
> 
> On Friday, 18 of November 2005 21:12, Dominik Brodowski wrote:
> 
>>[4294995.698000] Bad page state at free_hot_cold_page (in process 'gaim', page c15eb020)
>>[4294995.698000] flags:0x80000414 mapping:00000000 mapcount:0 count:0
>>[4294995.698000] vm_flags:0x800fb snd_pcm_mmap_data_open+0x0/0x11 snd_pcm_mmap_data_nopage+0x0/0xa7
> 
> 
> I've got pretty much the same:
> 
> Nov 18 21:23:22 albercik kernel: Bad page state at free_hot_cold_page (in process 'artsd', page ffff8100019613b8)
> Nov 18 21:23:22 albercik kernel: flags:0x4000000000000414 mapping:0000000000000000 mapcount:0 count:0
> Nov 18 21:23:22 albercik kernel: vm_flags:0x800fb snd_pcm_mmap_data_open+0x0/0x20 [snd_pcm] snd_pcm_mmap_data_nopage+0x0/0x150 [snd_pcm]
> Nov 18 21:23:22 albercik kernel: Backtrace:

These look like they want the following patch. Does it help?

-- 
SUSE Labs, Novell Inc.


--------------020800070008050003030803
Content-Type: text/plain;
 name="snd-pcm-refcount.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="snd-pcm-refcount.patch"

Index: linux-2.6/sound/core/pcm_native.c
===================================================================
--- linux-2.6.orig/sound/core/pcm_native.c	2005-10-09 18:28:51.000000000 +1000
+++ linux-2.6/sound/core/pcm_native.c	2005-11-19 15:29:59.000000000 +1100
@@ -2949,8 +2949,7 @@ static struct page * snd_pcm_mmap_status
 		return NOPAGE_OOM;
 	runtime = substream->runtime;
 	page = virt_to_page(runtime->status);
-	if (!PageReserved(page))
-		get_page(page);
+	get_page(page);
 	if (type)
 		*type = VM_FAULT_MINOR;
 	return page;
@@ -2992,8 +2991,7 @@ static struct page * snd_pcm_mmap_contro
 		return NOPAGE_OOM;
 	runtime = substream->runtime;
 	page = virt_to_page(runtime->control);
-	if (!PageReserved(page))
-		get_page(page);
+	get_page(page);
 	if (type)
 		*type = VM_FAULT_MINOR;
 	return page;
@@ -3066,8 +3064,7 @@ static struct page *snd_pcm_mmap_data_no
 		vaddr = runtime->dma_area + offset;
 		page = virt_to_page(vaddr);
 	}
-	if (!PageReserved(page))
-		get_page(page);
+	get_page(page);
 	if (type)
 		*type = VM_FAULT_MINOR;
 	return page;

--------------020800070008050003030803--
Send instant messages to your online friends http://au.messenger.yahoo.com 
