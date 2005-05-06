Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVEFXMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVEFXMB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 19:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVEFXKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 19:10:33 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:50862 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261332AbVEFXIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 19:08:53 -0400
Message-ID: <427BF8E1.2080006@ammasso.com>
Date: Fri, 06 May 2005 18:08:17 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Timur Tabi <timur.tabi@ammasso.com>
CC: Libor Michalek <libor@topspin.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs
 implementation
References: <200544159.Ahk9l0puXy39U6u6@topspin.com> <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com> <20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com> <20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com> <20050411171347.7e05859f.akpm@osdl.org> <20050412180447.E6958@topspin.com> <20050425203110.A9729@topspin.com> <4279142A.8050501@ammasso.com> <427A6A7E.8000604@ammasso.com>
In-Reply-To: <427A6A7E.8000604@ammasso.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi wrote:

> I haven't gotten a reply to this question, but I've done my own 
> research, and I think I found the answer.  Using my own test of 
> get_user_pages(), it appears that the fix was placed in 2.6.7.  However, 
> I would like to know specifically what the fix is. Unfortunately, 
> tracking this stuff down is beyond my understanding of the Linux VM.

I'm also still waiting for a reply to this question. Anyone????

Upon doing some more research, I think the fix might be those code instead:

	/*
	 * Don't pull an anonymous page out from under get_user_pages.
	 * GUP carefully breaks COW and raises page count (while holding
	 * page_table_lock, as we have here) to make sure that the page
	 * cannot be freed.  If we unmap that page here, a user write
	 * access to the virtual address will bring back the page, but
	 * its raised count will (ironically) be taken to mean it's not
	 * an exclusive swap page, do_wp_page will replace it by a copy
	 * page, and the user never get to see the data GUP was holding
	 * the original page for.
	 */
	if (PageSwapCache(page) &&
	    page_count(page) != page->mapcount + 2) {
		ret = SWAP_FAIL;
		goto out_unmap;
	}

Both this change and the other one I mentioned are new to 2.6.7.  I suppose I could try 
applying these patches to the 2.6.6 kernel and see if anything improves, but that won't 
help me understand what's really going on.  The above comment makes sounds almost like 
it's a fix, but it talks about copy-on-write, which is has nothing to do with the real 
problem.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
