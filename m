Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVBIPes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVBIPes (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 10:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVBIPes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 10:34:48 -0500
Received: from nevyn.them.org ([66.93.172.17]:4225 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261833AbVBIPeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 10:34:46 -0500
Date: Wed, 9 Feb 2005 10:34:41 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.11-rc3: Kylix application no longer works?
Message-ID: <20050209153441.GA8809@nevyn.them.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Stephen Hemminger <shemminger@osdl.org>,
	linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <20050207221107.GA1369@elf.ucw.cz> <20050207145100.6208b8b9.akpm@osdl.org> <20050208175106.GA1091@elf.ucw.cz> <20050208111625.0bb1896d@dxpl.pdx.osdl.net> <20050208181018.5592beab.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208181018.5592beab.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 06:10:18PM -0800, Andrew Morton wrote:
> We could just remove the printk and stick a comment over it.  If the
> application later tries to access the not-there pages then it'll just
> fault.
> 
> However I worry if there is some way in which we can leave unzeroed memory
> accessible to the application, although it's hard to see how that could
> happen.
> 
> Daniel, Pavel cruelly chopped you off the Cc when replying.  What's your
> diagnosis on the below?

It's asking for a lot of unwritable zeroed space.  See this:

>   LOAD           0x000000 0x08048000 0x08048000 0xb7354 0x1b7354 R E 0x1000
>   LOAD           0x0b7354 0x08200354 0x08200354 0x1e3e4 0x1f648 RW  0x1000

The 0xb7354 is size to map from the file, the 0x1b7354 is size to map
in memory.  We're supposed to zero-fill the rest.  Now that I think
about it I can see why this is a problem - the kernel probably assumes
that any segment with MemSiz > FileSiz will be writable.  Certainly
it's a bit weird for the app to request unwritable zeroed pages.

clear_user's probably not the right way to provide the extra zeroing.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
