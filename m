Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965256AbWADVrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965256AbWADVrt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbWADVrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:47:48 -0500
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:49837 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1751806AbWADVrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:47:48 -0500
Date: Wed, 4 Jan 2006 23:48:52 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Ryan Richter <ryan@tau.solarneutrino.net>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <20060104172727.GA320@tau.solarneutrino.net>
Message-ID: <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local>
References: <Pine.LNX.4.61.0512071803300.2975@goblin.wat.veritas.com>
 <20051212165443.GD17295@tau.solarneutrino.net> <Pine.LNX.4.64.0512120928110.15597@g5.osdl.org>
 <1134409531.9994.13.camel@mulgrave> <Pine.LNX.4.64.0512121007220.15597@g5.osdl.org>
 <1134411882.9994.18.camel@mulgrave> <20051215190930.GA20156@tau.solarneutrino.net>
 <1134705703.3906.1.camel@mulgrave> <20051226234238.GA28037@tau.solarneutrino.net>
 <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
 <20060104172727.GA320@tau.solarneutrino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006, Ryan Richter wrote:

> On Tue, Dec 27, 2005 at 06:21:39PM +0200, Kai Makisara wrote:
...
> > I don't have any new ideas but I will tell you what I have tried. In order 
> > to get more information about what is happening, I inserted the patch at 
> > the end of this message to my kernel. The purpose of the patch was to 
> > print something about the page mappings (prt_pages) and to catch possible 
> > double freeing from st earlier (clear page pointers).
> > 
> > Running dump gave me the following output:
> 
> Here's what I got:
> 
> 
>  st: page attributes before page_release 8
>  0: flags:0x060000000000006c mapping:ffff810102bba238 mapcount:2 count:4 pfn:1392956
>  1: flags:0x060000000000006c mapping:ffff810102bba238 mapcount:2 count:4 pfn:1397945
>  2: flags:0x060000000000006c mapping:ffff810102bba238 mapcount:2 count:4 pfn:1537473
>  3: flags:0x060000000000006c mapping:ffff810102bba238 mapcount:2 count:4 pfn:1398161
>  4: flags:0x060000000000006c mapping:ffff810102bba238 mapcount:2 count:4 pfn:1398261
>  5: flags:0x060000000000006c mapping:ffff810102bba238 mapcount:2 count:4 pfn:1392778
>  6: flags:0x060000000000006c mapping:ffff810102bba238 mapcount:2 count:4 pfn:1402858
>  7: flags:0x060000000000006c mapping:ffff810102bba238 mapcount:2 count:4 pfn:1396799

This looks similar to my output except that the page flags are 
0x060000000000006c in your case whereas I have 0x010000000000006c.

I have run amanda with a patch modified so that it prints results for 32 
consecutive writes each 10000 writes (if ((ctr++ % 10000) < 32)). This 
showed that taper (at least in my case) is actually using a buffer of 20 x 
32 kB = 640 kB. In all writes the mapping, counts, and flags were the 
same. Instead of remapping a single 32 kB buffer, st is cyclically mapping 
20 32 kB buffers.

> Bad page state at free_hot_cold_page (in process 'taper', page ffff81000427ff60)
> flags:0x010000000000000c mapping:ffff810102bbaaf0 mapcount:2 count:0

The mapping and flags have changed. The flags have lost one bit at the 
high end and the PG_lru and PG_active flags.

The patch sets the page pointer to NULL after page_cache_release() is 
called in st. This means that st is not calling page_cache_release() more 
than once for each page returned by get_user_pages(). The page state 
seems to get corrupted somewhere.

I have to continue thinking.

-- 
Kai
