Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131819AbRARJIV>; Thu, 18 Jan 2001 04:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132035AbRARJIL>; Thu, 18 Jan 2001 04:08:11 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:24082 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S131819AbRARJIC>;
	Thu, 18 Jan 2001 04:08:02 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Urban Widmark <urban@teststation.com>
Date: Thu, 18 Jan 2001 10:06:36 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: oops in 2.4.1-pre8
CC: <linux-kernel@vger.kernel.org>, kernel@hollins.edu
X-mailer: Pegasus Mail v3.40
Message-ID: <12E9172B5107@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Ethernet is compiled into the kernel as is smbfs (not as modules).  I've
> > compiled this kernel with 4GB bigmem support (otherwise I only get 8xxMB
> > total).
> 
> The smbfs cache code in 2.4.0 doesn't work with bigmem. For now disable
> bigmem or don't use smbfs, it's oopsing all the time.
> 
> Rainer Mager reported the same thing yesterday ("Oops with 4GB memory
> setting in 2.4.0 stable" if you want to read the thread).

I think that I found source of problem. I have no simple solution :-(

You are using 'page_cache_entry()' function three times. But you
are using it on kmap()ped memory (cachep, in this oops example). So
it returns almost random value, which caused 'mapping' to be set
to NULL when doing grab_page_cache(), which caused oops later in
add_to_page_cache_unique...

But I'm not 100% sure, as this would mean that you do not 
kunmap/UnlockPage/page_cache_release any >1GB page at all in 
smb_free_cache_blocks(), as page pointer obtained by page_cache_entry()
points to some random page (to couple just below 1GB boundary) instead 
of to correct one, so smbfs should die as soon as it finds first highmem
page... Is it possible?

Same problem is in smb_free_dircache. 

You can try using __find_get_page() with index to get 'struct *page' 
(it should always suceed, as you have all pages locked...), instead 
of page_cache_entry(), but better solution is using couple { page, 
page_address } instead of page_address alone.

So your system has couple of chances to deadlock - either on out of
kmaps, or on locked directory cache root (cachep), or on some of locked 
directory cache pages (blocks)...

And one nonfatal ;-) In smb_add_to_cache you have:

page_off = PAGE_SIZE + (cachep->idx << PAGE_SHIFT);
page = grab_cache_page(mapping, page_off >> PAGE_CACHE_SHIFT);

This does not look correct to me. You should use PAGE_CACHE_SHIFT and
PAGE_CACHE_SIZE, as otherwise you'll receive same page for idx=1 and 2
when cache will use 8KB pages, but CPU 4KB ones. Using only first 4KB 
of each cache page is better solution, than using same page for two
different indexes, I think... But as currently PAGE_CACHE_SIZE == PAGE_SIZE...
                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
