Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137202AbREKSVg>; Fri, 11 May 2001 14:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137201AbREKSV0>; Fri, 11 May 2001 14:21:26 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:5124 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S137199AbREKSVS>; Fri, 11 May 2001 14:21:18 -0400
Date: Fri, 11 May 2001 13:42:57 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] VM fixes against 2.4.4-ac6
In-Reply-To: <Pine.LNX.4.21.0105111222330.23350-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0105111340020.23350-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 May 2001, Marcelo Tosatti wrote:

> Hi, 
> 
> The following patch addresses two issues:
> 
> 
> - Buffer cache pages in the inactive lists are not getting their age
> increased if they get touched by getblk (which will set the referenced bit
> on the page).  page_launder() simply cleans the referenced bit on such
> pages and moves them to the active list. To resume: buffercache pages
> suffer more pressure from VM than pagecache pages. That is horrible for
> performance.
> 
> 
> - When there is no memory available on the system for normal allocations
> (GFP_KERNEL), the tasks may loop in try_to_free_pages() (which is here
> called by __alloc_pages()) without blocking:
> 
> 	- GFP_BUFFER allocations will _never_ block on IO inside
> 	try_to_free_pages(). They will keep looping inside __alloc_pages() 
> 	until they get a free page. 
> 	
> 	- __GFP_IO|__GFP_WAIT allocations may not find any way to block on
> 	IO inside try_to_free_pages() in case we already have other tasks
> 	inside there (kswapd will be there in such condition, for sure).

Ah, one subtle issue here: if they loop, they'll probably bump
memory_pressure a lot.  

That will result in a bigger inactive target, which means aggressive
aging. 

 

