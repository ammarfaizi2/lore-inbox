Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbUJ1RlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbUJ1RlY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 13:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbUJ1RlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 13:41:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39338 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261609AbUJ1RlO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 13:41:14 -0400
Date: Thu, 28 Oct 2004 12:59:31 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       andrea@novell.com
Subject: Re: Linux 2.6.9-ac2
Message-ID: <20041028145931.GE5741@logos.cnet>
References: <1098379853.17095.160.camel@localhost.localdomain> <20041021123404.1d947ee0.davem@davemloft.net> <1098389527.17096.166.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098389527.17096.166.camel@localhost.localdomain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 09:12:08PM +0100, Alan Cox wrote:
> On Iau, 2004-10-21 at 20:34, David S. Miller wrote:
> > 2.4.x will need this one as well, at least the AF_PACKET
> > case.  Would you mind if I pushed that to Marcelo?
> 
> Not at all. Andrea has proposed fixing it a little differently. 
> For 2.6 making remap_page_range DTRT itself is ok but for 2.4 the
> vma isn't passed.

get_user_pages() is screwed, I'm just not sure
about failing get_user_pages() if PageReserved page
is encountered. 

I'm more worried about make_pages_present(), which is 
called by find_extend_vma/do_mmap_pgoff. Is it valid
to have PageReserved pages on the zones handled 
by these functions anyway?

This is equivalent of Andrea's fix for mainline.

Andrea, this in SuSE's tree for a while correct?


--- memory.c    2004-10-22 15:58:28.000000000 -0200
+++ memory.c  2004-10-28 14:32:26.585813200 -0200
@@ -499,7 +499,7 @@
                                /* FIXME: call the correct function,
                                 * depending on the type of the found page
                                 */
-                               if (!pages[i])
+                               if (!pages[i] || PageReserved(pages[i]))
                                        goto bad_page;
                                page_cache_get(pages[i]);
                        }

