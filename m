Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWCQTiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWCQTiN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 14:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWCQTiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 14:38:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7362 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751164AbWCQTiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 14:38:13 -0500
Date: Fri, 17 Mar 2006 11:35:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: efault@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: oops in ext3_discard_reservation()
Message-Id: <20060317113521.7861167d.akpm@osdl.org>
In-Reply-To: <1142615381.4545.10.camel@localhost.localdomain>
References: <1142577177.7973.6.camel@homer>
	<20060317035127.4c70eed3.akpm@osdl.org>
	<1142615381.4545.10.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> > It died in rsv_is_empty(), accessing rsv->_rsv_end, because `block_i' has a
> > value of 0x00010000.
> > 
> > Looks like a bitflip.    How good is that hardware?
>
> I am not sure what is happening.

Sorry, I cc'ed you, then worked out what happened then forgot to un-cc you.
It looks like Mike's machine suffered a single-bit hardware error.

> Smells like another race between two
> reservation window freeing. I thought we have thought this through quite
> well last year but maybe not.:(
> 
> In general, the reservation window allocating and freeing should be
> protected by a semaphore, so that we will not run into the case where we
> are trying to free a window, while another thread is in the middle of
> window-freed-and-then-re-allocating. But in the path of
> ext3_delete_inode()->clear_inode()->ext3_clear_inode()-
> >ext3_discard_reservation(), since it's only called at the last input(),
> so this race seems not exists. 

Yes, it looks OK.

> But with the path of invalidate_inodes->dispose_list->clear_inode-
> >ext3_discard_inode, I guess it is still possible that another thread is
> in the middle of block allocation, who just freed the current window and
> is about to allocating a new window?

The inode shootdown logic is quite gruesome, but we'd have heard about it
if it was possible for block allocation to be happening while an inode has
I_FREEING set.  Various things in fs/inode.c would explode.
