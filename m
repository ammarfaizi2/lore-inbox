Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVD3XzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVD3XzR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 19:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVD3XzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 19:55:16 -0400
Received: from mail.shareable.org ([81.29.64.88]:3244 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261462AbVD3XzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 19:55:07 -0400
Date: Sun, 1 May 2005 00:54:54 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050430235453.GA11494@mail.shareable.org>
References: <20050425071047.GA13975@vagabond> <E1DQ0Mc-0007B5-00@dorka.pomaz.szeredi.hu> <20050430083516.GC23253@infradead.org> <E1DRoDm-0002G9-00@dorka.pomaz.szeredi.hu> <20050430094218.GA32679@mail.shareable.org> <E1DRoz9-0002JL-00@dorka.pomaz.szeredi.hu> <20050430143609.GA4362@mail.shareable.org> <E1DRuNU-0002el-00@dorka.pomaz.szeredi.hu> <20050430164258.GA6498@mail.shareable.org> <E1DRvRc-0002lq-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DRvRc-0002lq-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> > But you don't need a new system call to bind an fd.
> > 
> > "mount --bind /proc/self/fd/N mount_point" works, try it.
> 
> Ahh, yes :)
> 
> Still proc_check_root() has to be relaxed, to allow dereferencing link
> under a different namespace.

Not necessary.

Why not have the FUSE daemon keep open a file descriptor for the
directory it's mounted on, and have it sent that to new would-be
mounters of the same directory using a unix domain socket (rather as
Pavel suggested)?

> Maybe the check should be skipped for
> capable(CAP_SYS_ADMIN) or similar.

No.  The check is to prevent processes in chroot jails from accessing
directories outside their jail.  Even CAP_SYS_ADMIN processes must be
forbidden from doing that.

But proc_check_root is unnecessarily strict, in that it prevents a
process from traversing into a "child" namespace.

IMHO, a better security restriction anyway would be for processes in
chroot jails to not be able to see processes outside the jail in /proc
- only processes inside the jail should be visible.  I think everyone
agrees that would be best.

If that were implemented, then proc_check_root would be redundant and
could be removed entirely.

-- Jamie
