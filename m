Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVEDUEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVEDUEi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 16:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVEDUEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 16:04:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:24040 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261273AbVEDUEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 16:04:25 -0400
Date: Wed, 4 May 2005 13:04:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: dedekind@infradead.org
Cc: miklos@szeredi.hu, linux-kernel@vger.kernel.org, dwmw2@infradead.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] VFS bugfix: two read_inode() calles without
 clear_inode() call between
Message-Id: <20050504130450.7c90a422.akpm@osdl.org>
In-Reply-To: <1115209055.8559.12.camel@sauron.oktetlabs.ru>
References: <1114607741.12617.4.camel@sauron.oktetlabs.ru>
	<E1DQoui-0002In-00@dorka.pomaz.szeredi.hu>
	<1114618748.12617.23.camel@sauron.oktetlabs.ru>
	<E1DQqZu-0002Rf-00@dorka.pomaz.szeredi.hu>
	<1114673528.3483.2.camel@sauron.oktetlabs.ru>
	<20050428003450.51687b65.akpm@osdl.org>
	<1115209055.8559.12.camel@sauron.oktetlabs.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Artem B. Bityuckiy" <dedekind@infradead.org> wrote:
>
> Bug symptoms
> ~~~~~~~~~~~~
> For the same inode VFS calls read_inode() twice and doesn't call
> clear_inode() between the two read_inode() invocations.
> 
> Bug description
> ~~~~~~~~~~~~~~~
> Suppose we have an inode which has zero reference count but is still in
> the inode cache. Suppose kswapd invokes shrink_icache_memory() to free
> some RAM. In prune_icache() inodes are removed from i_hash. prune_icache
> () is then going to call clear_inode(), but drops the inode_lock
> spinlock before this. If in this moment another task calls iget() for an
> inode which was just removed from i_hash by prune_icache(), then iget()
> invokes read_inode() for this inode, because it is *already removed*
> from i_hash.

This sounds more like a bug in the iget() caller to me.

Question is: if the inode has zero refcount and is unhashed then how did
the caller get its sticky paws onto the inode* in the first place?

If the caller had saved a copy of the inode* in local storage then the
caller should have taken a ref against the inode.

If the caller had just looked up the inode via hastable lookup via
iget_whatever() then again the caller will have a ref on the inode.

So.  Please tell us more about how the caller got into this situation.
