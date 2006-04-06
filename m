Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWDFBFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWDFBFP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 21:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWDFBFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 21:05:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:64397 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750777AbWDFBFO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 21:05:14 -0400
Date: Thu, 6 Apr 2006 02:05:09 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: Jon Smirl <jonsmirl@gmail.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [patch 03/26] sysfs: zero terminate sysfs write buffers (CVE-2006-1055)
Message-ID: <20060406010509.GO27946@ftp.linux.org.uk>
References: <20060404235634.696852000@quad.kroah.org> <20060404235947.GD27049@kroah.com> <20060405190928.17b9ba6a.vsu@altlinux.ru> <20060405152123.GH27946@ftp.linux.org.uk> <9e4733910604050838g339d48cao4e0f8582f6d90187@mail.gmail.com> <20060405153957.GI27946@ftp.linux.org.uk> <200604051958.k35JwF0M019652@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604051958.k35JwF0M019652@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 03:58:15PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 05 Apr 2006 16:39:57 BST, Al Viro said:
> 
> > How about _NOT_ using sysfs and just having ->read()/->write() on a file in fs
> > of your own?  ~20 lines for all of it, not counting #include...
> 
> Great.  Instead of everybody using the same piece-of-manure sysfs interface,
> each driver carries around its 20 lines to implement read() and write() in
> subtly buggy and incompatible ways.

No, that would be 20 lines to tell what and where you want in that fs and
how long should the things live.  Plus whatever you've got for your ->read()
and ->write() - using existing libfs helpers if needed.  Instead of pushing
into sysfs the things that do not fit sysfs interfaces.

BTW, in my experience "subtly buggy and incompatible ways" describes sysfs
uses, except that there's rarely anything subtle about that.  Care to name
four kernel data structures that got kobjects embedded into them (directly
or via struct device and it ilk) and had _NOT_ required at one point or
another (post-merge) fixing of blatant user-exploitable holes due to botched
lifetime rules?

Not that you had to embed them to achieve the same wonderful effect -
witness fbsysfs.c user-exploitable holes on unregister_framebuffer();
sure, fb_info->class_device will stay allocated if you have one of the
attributes opened.  Now try to call read(); what will it access?

Not to mention that the same file has a pile of ->store() assuming we
have NUL-termination, or the lovely use of sscanf() on non-NUL-terminated
array right in store_cmap() itself.  Equivalent of
	p = malloc(5);
	if (p) {
		memcpy(p, q, 5);
		sscanf(p, "%4hx", &v);
	}
You do realize that it's broken, don't you?  sscanf field width for %x
applies _after_ skipping the whitespace, not to the total amount of
characters being eaten.  And in reality this buffer comes from the end
of get_zeroed_page() result, so there's really nothing past its end.
