Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVETOrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVETOrQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 10:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVETOrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 10:47:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57483 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261382AbVETOrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 10:47:11 -0400
Date: Fri, 20 May 2005 15:47:37 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, dhowells@redhat.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] namespace.c: cleanup in mark_mounts_for_expiry()
Message-ID: <20050520144737.GR29811@parcelfarce.linux.theplanet.co.uk>
References: <E1DZ7xj-0003ol-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DZ7xj-0003ol-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 03:54:51PM +0200, Miklos Szeredi wrote:
> [ fell in love with that function, now can't let go... ]
> 
> This patch simplifies mark_mounts_for_expiry() by using detach_mnt()
> instead of duplicating everything it does.
> 
> It should be an equivalent transformation except for righting the
> dput/mntput order.

Looks sane.  However, we still have a problem here - just what would
happen if vfsmount is detached while we were grabbing namespace
semaphore?  Refcount alone is not useful here - we might be held by
whoever had detached the vfsmount.  IOW, we should check that it's
still attached (i.e. that mnt->mnt_parent != mnt).  If it's not -
just leave it alone, do mntput() and let whoever holds it deal with
the sucker.  No need to put it back on lists.
