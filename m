Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVEDV6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVEDV6B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 17:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVEDV6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 17:58:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:1184 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261712AbVEDV5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 17:57:51 -0400
Date: Wed, 4 May 2005 14:58:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: dedekind@infradead.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] VFS bugfix: two read_inode() calles without
 clear_inode() call between
Message-Id: <20050504145811.63e9bb10.akpm@osdl.org>
In-Reply-To: <1115242507.12012.394.camel@baythorne.infradead.org>
References: <1114607741.12617.4.camel@sauron.oktetlabs.ru>
	<E1DQoui-0002In-00@dorka.pomaz.szeredi.hu>
	<1114618748.12617.23.camel@sauron.oktetlabs.ru>
	<E1DQqZu-0002Rf-00@dorka.pomaz.szeredi.hu>
	<1114673528.3483.2.camel@sauron.oktetlabs.ru>
	<20050428003450.51687b65.akpm@osdl.org>
	<1115209055.8559.12.camel@sauron.oktetlabs.ru>
	<20050504130450.7c90a422.akpm@osdl.org>
	<1115242507.12012.394.camel@baythorne.infradead.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Wed, 2005-05-04 at 13:04 -0700, Andrew Morton wrote:
> > This sounds more like a bug in the iget() caller to me.
> > 
> > Question is: if the inode has zero refcount and is unhashed then how
> > did the caller get its sticky paws onto the inode* in the first place?
> > 
> > If the caller had saved a copy of the inode* in local storage then the
> > caller should have taken a ref against the inode.
> > 
> > If the caller had just looked up the inode via hastable lookup via
> > iget_whatever() then again the caller will have a ref on the inode.
> > 
> > So.  Please tell us more about how the caller got into this situation.
> 
> I could explain in detail how JFFS2 garbage collection works, moving log
> entries out of the way by calling iget() on the inode to which they
> belong.... or I could just say "NFS".
> 

That doesn't really settle the question of whether the callers are broken,
whether they are doing something which the VFS really should support and
what need to be done to the VFS to support it properly.

Looking at the proposed patch: what happens if an inode is on its way to
dispose_list() and someone tries to do an iget() on it?  I don't think I_LOCK
is set, so __wait_on_freeing_inode() will no longer provide this guarantee:

/*
 * If we try to find an inode in the inode hash while it is being deleted, we
 * have to wait until the filesystem completes its deletion before reporting
 * that it isn't found.  This is because iget will immediately call
 * ->read_inode, and we want to be sure that evidence of the deletion is found
 * by ->read_inode.

Not only will we break the __wait_on_freeing_inode() guarantee, but we'll
break it in extremely rare circumstances.

And that's just from a quick peek.  There may be other problems.  Worried.
