Return-Path: <linux-kernel-owner+w=401wt.eu-S933104AbWLaJXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933104AbWLaJXb (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 04:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933103AbWLaJXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 04:23:30 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4472 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933101AbWLaJX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 04:23:28 -0500
Date: Sun, 31 Dec 2006 09:23:18 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Miller <davem@davemloft.net>
Cc: torvalds@osdl.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, akpm@osdl.org
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
Message-ID: <20061231092318.GA1702@flint.arm.linux.org.uk>
Mail-Followup-To: David Miller <davem@davemloft.net>, torvalds@osdl.org,
	miklos@szeredi.hu, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, akpm@osdl.org
References: <20061230165012.GB12622@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612301022200.4473@woody.osdl.org> <20061230224604.GA3350@flint.arm.linux.org.uk> <20061230.212338.92583434.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061230.212338.92583434.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2006 at 09:23:38PM -0800, David Miller wrote:
> From: Russell King <rmk+lkml@arm.linux.org.uk>
> Date: Sat, 30 Dec 2006 22:46:04 +0000
> 
> > iirc, flush_anon_page() was introduced to fix non-working fuse on parisc,
> > which occurs because fuse wants to use get_user_pages() to read data from
> > the current processes memory space.
> > 
> > get_user_pages() contains a call to flush_dcache_page(), whose behaviour
> > is defined for shared mappings.  Anonymous pages are unspecified.  It
> > appears that flush_anon_page() was introduced to correct this oversight.
> 
> Sparc64 flushes anonymous pages too when flush_dcache_page() is
> called on such pages.  It only tries to "defer" flushes for
> pages which have a non-NULL page_mapping().  For NULL page_mapping()
> we just flush immediately.

We do this on ARM - if page_mapping() is NULL, we flush the kernel
alias unconditionally.  However, we have no view where the user
mapping of that page is, which is where the problem is.  Cache lines
remain allocated for the user mapping and data contained within is
not visible via the kernel mapping.

> For the ptrace() cases we created the copy_{to,from}_user_page()
> interfaces.  So that when you access data inside of pages obtained via
> a get_user_pages() call, you are supposed to use those two interfaces
> so that everything works out right.
> 
> Therefore, FUSE probably could have been fixed by judicious use
> of copy_{to,from}_user_page() calls instead of adding this new
> ad-hoc flush_anon_page() thing.

It would've been nice to have had your view when the whole thing blew
up.

However, it's not only FUSE which is suffering - direct-IO also doesn't
work.  If my analysis is correct, only _two_ users of get_user_pages()
with the current process actually does the right thing and that's ptrace
and ELF core dumping.  All other users are buggy.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
