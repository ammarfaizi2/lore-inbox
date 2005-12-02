Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbVLCC7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVLCC7g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 21:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVLCC7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 21:59:36 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:1716 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751174AbVLCC7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 21:59:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=lQ14DstkineXOQhUy5X5657t3XWLgmQzcvyXChSO1U+ZB7WrCqjlbPxarc+FbSYIHnKGAwf4wLpVzyGsnN6q1g4CO5K3EaeSoDaUjntrm5YGbzGfatCgyLX1JtjwjAoKN7o19ayb6vQc0QUIUHoNdN5LyG2LSw5CmVyBSSIH2Co=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>
Subject: [2.6.15-rc1+ regression] do_file_page bug introduced in recent rework
Date: Fri, 2 Dec 2005 01:11:56 +0100
User-Agent: KMail/1.8.3
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512020111.56671.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently found a bug introduced in your commit 
65500d234e74fc4e8f18e1a429bc24e51e75de4a, i.e. between 2.6.14 and 2.6.15-rc1, 
about do_file_page changes wrt remap_file_pages and MAP_POPULATE.

Quoting from the changelog (which is wrong):

    do_file_page's fallback to do_no_page dates from a time when we were 
testing
    pte_file by using it wherever possible: currently it's peculiar to 
nonlinear
    vmas, so just check that.  BUG_ON if not?  Better not, it's probably page
    table corruption, so just show the pte: hmm, there's a pte_ERROR macro, 
let's
    use that for do_wp_page's invalid pfn too.

This is false:

do_mmap_pgoff:
        if (flags & MAP_POPULATE) {
                up_write(&mm->mmap_sem);
                sys_remap_file_pages(addr, len, 0,
                                        pgoff, flags & MAP_NONBLOCK);
                down_write(&mm->mmap_sem);
        }

So, with MAP_POPULATE|MAP_NONBLOCK passed, you can get a linear PAGE_FILE pte 
in a !VM_NONLINEAR vma.

That PTE is very useless since it doesn't add any information, I know that, so 
avoiding that possible installation is a possible fix, but for now it's 
simpler to change the test in do_file_page(). Btw, in fact I discovered this 
bug while I was implementing this optimization (working again on 
remap_file_pages() patches of this summer).

Indeed, the condition to test (and to possibly BUG_ON/pte_ERROR) is that 
->populate must exist for the sys_remap_file_pages call to work.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
