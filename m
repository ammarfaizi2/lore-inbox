Return-Path: <linux-kernel-owner+w=401wt.eu-S933217AbWLaUkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933217AbWLaUkU (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 15:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933215AbWLaUkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 15:40:20 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:53820
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S933212AbWLaUkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 15:40:18 -0500
Date: Sun, 31 Dec 2006 12:40:17 -0800 (PST)
Message-Id: <20061231.124017.85689231.davem@davemloft.net>
To: miklos@szeredi.hu
Cc: rmk+lkml@arm.linux.org.uk, arjan@infradead.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@osdl.org
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
 that again
From: David Miller <davem@davemloft.net>
In-Reply-To: <E1H0zkD-0003uw-00@dorka.pomaz.szeredi.hu>
References: <20061231.014756.112264804.davem@davemloft.net>
	<20061231100007.GC1702@flint.arm.linux.org.uk>
	<E1H0zkD-0003uw-00@dorka.pomaz.szeredi.hu>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 31 Dec 2006 13:24:53 +0100

> > I'm willing to do that - and I guess this means we can probably do this
> > instead of walking the list of VMAs for the shared mapping, thereby
> > hitting both anonymous and shared mappings with the same code?
> 
> But for the get_user_pages() case there's no point, is there?  The VMA
> and the virtual address is already available, so trying to find it
> again through RMAP doesn't much make sense.
> 
> Users of get_user_pages() don't care about any other mappings (maybe
> ptrace does, I don't know) only about one single user mapping and one
> kernel mapping.
> 
> So using flush_dcache_page() there is an overkill, trying to teach it
> about anonymous pages is not the real solution, flush_dcache_page()
> was never meant to be used on anything but file mapped pages.

Even in the ptrace() case, you do want to flush all the other VMA's
that might be out there with an aliased cached copy in the cpu cache.

