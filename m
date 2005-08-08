Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVHHHcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVHHHcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 03:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVHHHcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 03:32:16 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:56495 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750748AbVHHHcP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 03:32:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bY6TCtBH0n9zy4SqQfloK12fo+r9Qhrp8FVOX29AAMHhpv1Xwoi1t4OfXRAJex4TqZZGGJX8K8fusRM3faO6sLHYnsHzh2jgvapWLxC5aMGOeaL/Za3dbKUUw0IWJ/fr/h4N7xFHGCU40Ylbfta4606o0WhGwkbzHup5awc3GNQ=
Message-ID: <1e62d13705080800329114fdd@mail.gmail.com>
Date: Mon, 8 Aug 2005 12:32:12 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: Highmemory Problem with RHEL3 .... 2.4.21-5.ELsmp
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42F6EB73.3030104@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1e62d137050807205047daf9e0@mail.gmail.com>
	 <42F6EB73.3030104@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/05, Zachary Amsden <zach@vmware.com> wrote:
> 
> IIRC 2.4.21 has some highmem bugs that have since been fixed.  But, it
> sounds like you might be doing something quite unusual.  Code would
> definitely give people a better idea of what might be wrong.  

I think you overlooked what i mentioned in P.S. ; which is 

My memory reservation and later using that memory through kmap_atomic
works well on the kernels other than RHEL3 2.4.21-e.ELsmp
.............. the page reservation was done in the
arch/i386/mm/init.c file in function one_highpage_init ...... I have
Machine with 16GB RAM and 2 - Xeon 2.4GHz Processors .....

The code which I added for memory reservation in kernel is : 

void __init one_highpage_init(struct page *page, int pfn, int bad_ppro)
{
	if (!page_is_ram(pfn)) {
		SetPageReserved(page);
		return;
	}
	
	if (bad_ppro && page_kills_ppro(pfn)) {
		SetPageReserved(page);
		return;
	}

// Here's the code which i added for memory reservation ..... i m
setting 0xC4 in page->count just because i will know later that these
pages have been reserved by me ... not by kernel .....

	if ((unsigned long)(page - mem_map) > 0x80000) {
		SetPageReserved(page);
		set_bit(PG_highmem, &page->flags);
		atomic_set(&page->count, 0xC4);
		totalhigh_pages++;
		return;
	}

// My code Ends here 
	
	ClearPageReserved(page);
	set_bit(PG_highmem, &page->flags);
	atomic_set(&page->count, 1);
	__free_page(page);
	totalhigh_pages++;
}


After this in my module, i simply use kmap_atomic to map the page
reserved by me and tried to use that ........ its working perfect in
both 2.4.x series and also working in 2.6.x .....

> You should definitely consider moving to 2.6 to get a better response.
> 

i already moved to 2.6.x already !!! but the current requiment is to
use RHEL3 Kernel which is 2.4.21-27.ELsmp

I think its now more clear !!!! waiting for your resposes !!!


-- 
Fawad Lateef
