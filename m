Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285907AbSAGTm3>; Mon, 7 Jan 2002 14:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285940AbSAGTmV>; Mon, 7 Jan 2002 14:42:21 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:57099 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S285907AbSAGTmJ>; Mon, 7 Jan 2002 14:42:09 -0500
Date: Mon, 7 Jan 2002 16:28:12 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] in 2.4.17 after 10 days uptime
In-Reply-To: <20020101145605.B3283@redhat.com>
Message-ID: <Pine.LNX.4.21.0201071623380.18722-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Jan 2002, Benjamin LaHaise wrote:

> On Tue, Jan 01, 2002 at 02:18:01AM -0500, Ed Tomlinson wrote:
> > I started getting these bugs after about 10 days uptime.  There is a patch 
> > set for reiserfs applied along with a few minor patches (ide-tape, disk 
> > stats for up to hdg).  The kernel is tainted by:
> 
> Expected BUG.  Here's the fix.  Marcelo, this is what we discussed previously: 
> parts of the kernel that grab a temporary reference to a page will frequently 
> not use page_cache_release as the page may never have been part of the page 
> cache.  This shows up with the network stack in sendpage() as well as many 
> other paths.  Please apply.

Ben, 

I suppose you're talking about the following case: 

pagecache code has LRU page

			    nonpagecache code does page_cache_get()

pagecache code does page_cache_release()

			   nonpagecache code does __free_pages_ok()
			   on LRU page: BOOM.	

Is my thinking correct ?

If so, I don't see why Ed's trace BUGs at rmqueue first: It should bug at
__free_pages_ok() PageLRU check.


