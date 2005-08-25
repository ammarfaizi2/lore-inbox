Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbVHYTDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVHYTDa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 15:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbVHYTDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 15:03:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52714 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932403AbVHYTD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 15:03:28 -0400
Subject: Re: [PATCH] Ext3 online resizing locking issue
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Glauber de Oliveira Costa <gocosta@br.ibm.com>
Cc: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       ext2resize-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050824210325.GK23782@br.ibm.com>
References: <20050824210325.GK23782@br.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1124996561.1884.212.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 25 Aug 2005 20:02:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-08-24 at 22:03, Glauber de Oliveira Costa wrote:

> This simple patch provides a fix for a locking issue found in the online
> resizing code. The problem actually happened while trying to resize the
> filesystem trough the resize=xxx option in a remount. 

NAK, this is wrong:

> +		lock_super(sb);
>  		err = ext3_group_extend(sb, EXT3_SB(sb)->s_es, n_blocks_count);
> +		unlock_super(sb);

This basically reverses the order of locking between lock_super() and
journal_start() (the latter acts like a lock because it can block on a
resource if the journal is too full for the new transaction.)  That's
the opposite order to normal, and will result in a potential deadlock.

> +	{Opt_resize, "resize=%u"},
>  	{Opt_err, NULL},
> -	{Opt_resize, "resize"},

Right, that's disabled for now.  I guess the easy fix here is just to
remove the code entirely, given that we have locking problems with
trying to fix it!

But the _right_ fix, if you really want to keep that code, is probably
to move all the resize locking to a separate lock that ranks outside the
journal_start.  The easy workaround is to drop the superblock lock and
reaquire it around the journal_start(); it would be pretty easy to make
that work robustly as far as ext3 is concerned, but I suspect there may
be VFS-layer problems if we start dropping the superblock lock in the
middle of the s_ops->remount() call --- Al?

--Stephen

