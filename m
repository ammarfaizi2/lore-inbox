Return-Path: <linux-kernel-owner+w=401wt.eu-S1030367AbWL3WqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbWL3WqQ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 17:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbWL3WqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 17:46:16 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2179 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030366AbWL3WqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 17:46:13 -0500
Date: Sat, 30 Dec 2006 22:46:04 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
Message-ID: <20061230224604.GA3350@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20061221152621.GB3958@flint.arm.linux.org.uk> <E1GxQF2-0000i6-00@dorka.pomaz.szeredi.hu> <20061221171739.GE3958@flint.arm.linux.org.uk> <20061230163955.GA12622@flint.arm.linux.org.uk> <20061230165012.GB12622@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612301022200.4473@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612301022200.4473@woody.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2006 at 10:26:20AM -0800, Linus Torvalds wrote:
> 
> 
> On Sat, 30 Dec 2006, Russell King wrote:
> > 
> > And here's the flush_anon_page() part.
> > 
> > Add flush_anon_page() for ARM, to avoid data corruption issues when using
> > fuse or other subsystems using get_user_pages().
> 
> Btw, since this doesn't actually change any code for anybody but ARM, just 
> adds a parameter that is obviously unused by everybody else, and if it 
> actually fixes a real bug for ARM, I'll obviously happily take it even 
> before 2.6.20. So go ahead put it in your ARM tree, and we'll get some 
> testing through that. And just ask me to pull at some point.
> 
> I wonder why nobody else seems to have a "flush_anon_page()"? This would 
> seem to be a potential issue for architectures like sparc too.. Although 
> maybe sparc can do a flush by physical index with "flush_dcache_page()".

Well...

iirc, flush_anon_page() was introduced to fix non-working fuse on parisc,
which occurs because fuse wants to use get_user_pages() to read data from
the current processes memory space.

get_user_pages() contains a call to flush_dcache_page(), whose behaviour
is defined for shared mappings.  Anonymous pages are unspecified.  It
appears that flush_anon_page() was introduced to correct this oversight.

Looking at some of the other users of get_user_pages() which want to
access the current processes memory space, one finds the following:

some use flush_cache_page():
- binfmt_elf coredump
- ptrace (in arch code)

others don't:
- aio
- bio
- block (block_dev::blk_get_page seems to be for direct-io, there's problems
   reported with this on ARM)
- direct-io
- fuse
- vmsplice

So, anything except coredumps and ptrace are currently unsafe on ARM
without something being added to get_user_pages() to ensure coherency
of anonymous pages.

Given that we have reported corruption with direct-io, and debian bug
#402876 for nonworking fuse, it seems the correct thing to do is to
implement this function.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
