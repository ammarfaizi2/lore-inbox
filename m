Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946255AbWBDBPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946255AbWBDBPg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 20:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946254AbWBDBPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 20:15:35 -0500
Received: from sitemail2.everyone.net ([216.200.145.36]:30637 "EHLO
	omta16.mta.everyone.net") by vger.kernel.org with ESMTP
	id S1946255AbWBDBPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 20:15:34 -0500
X-Eon-Dm: dm17
X-Eon-Sig: AQHOS7ND5AAun0D6pwIAAAAE,e80374f60c734c7e6be89939253902b7
Date: Fri, 3 Feb 2006 20:13:05 -0500
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jmorris@namei.org
Subject: Re: Size-128 slab leak
Message-ID: <20060204011305.GA3250@double.lan>
References: <20060131024928.GA11395@double.lan> <20060201231001.0ca96bf0.akpm@osdl.org> <20060203040018.GA3757@double.lan> <1138972872.18268.327.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138972872.18268.327.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 08:21:12AM -0500, Stephen Smalley wrote:
> On Thu, 2006-02-02 at 23:00 -0500, Kevin O'Connor wrote:
> > After running updatedb I got 23530 occurrences of:
> > 
> > kernel: obj ffff81003f04f000/12: ffffffff801ed7b7 <selinux_inode_alloc_security+0x37/0x100>
> > 
> Hmm...that allocation call occurs upon alloc_inode() via
> security_inode_alloc, and the associated free call occurs upon
> destroy_inode() via security_inode_free.  However, when Jeff Mahoney
> introduced the support for "private inodes" (S_PRIVATE flag) to support
> reiserfs xattrs-as-files, he added the IS_PRIVATE guards to both
> security_inode_alloc and security_inode_free.  I think that this ends up
> causing SELinux to allocate a security structure for every reiserfs
> inode including private inodes since they are not marked until later by
> reiserfs, while preventing SELinux from ever freeing the security
> structure for the private inodes.  Note that
> selinux_inode_free_security() should be safe even for the private
> inodes, as it doesn't assume any other initialization beyond the
> allocation-time initialization.  Patch below.  

Hi Stephen,

I've applied your patch.  It seems to be working.  (Multiple runs of
updatedb no longer grow the size-128 slab.)

Thanks,
-Kevin
