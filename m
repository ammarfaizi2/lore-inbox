Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbUDUNSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbUDUNSh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 09:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUDUNSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 09:18:37 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:35078 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261852AbUDUNSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 09:18:35 -0400
Date: Wed, 21 Apr 2004 14:18:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: raven@themaw.net
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc1-mm1
Message-ID: <20040421141829.A5551@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, raven@themaw.net,
	Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040418230131.285aa8ae.akpm@osdl.org> <20040419202538.A15701@infradead.org> <Pine.LNX.4.58.0404200911090.12229@wombat.indigo.net.au> <20040419182657.7870aee9.akpm@osdl.org> <20040421100835.A3577@infradead.org> <Pine.LNX.4.58.0404212022370.3740@donald.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0404212022370.3740@donald.themaw.net>; from raven@themaw.net on Wed, Apr 21, 2004 at 08:31:38PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 08:31:38PM +0800, raven@themaw.net wrote:
> If it is decided to do this then would something like this be approiate 
> Andrew?
> 
> I have
> - renamed autofs4_may_umount to may_umount_tree and moved
>   it to namespace.c
> - removed the EXPORT_SYMBOL for vfsmount_lock
> - updated autofs4 to suit
> 
> It is not possible to merge the functionality of may_umount into this as, 
> it stands, as autofs v3 requires a slightly different semantic. That is if 
> there are submounts that are not busy then it should return -EBUSY but 
> may_umount_tree would return not busy.

What about adding a paramter 'ignore_busy_submounts' and use most of the
function in common for both autofs3 and autofs4?

> +	struct list_head *next;
> +	struct vfsmount *this_parent = mnt;
> +	int actual_refs;
> +	int minimum_refs;
> +
> +	spin_lock(&vfsmount_lock);
> +	actual_refs = atomic_read(&mnt->mnt_count);
> +	minimum_refs = 2;
> +repeat:
> +	next = this_parent->mnt_mounts.next;
> +resume:
> +	while (next != &this_parent->mnt_mounts) {
> +		struct vfsmount *p = list_entry(next, struct vfsmount, mnt_child);
> +
> +		next = next->next;

Any chance to use list_for_each_entry here?

> +		if ( !list_empty(&p->mnt_mounts) ) {

This wants a white-space fixup.

