Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268959AbUIMUes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268959AbUIMUes (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 16:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268961AbUIMUes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 16:34:48 -0400
Received: from cantor.suse.de ([195.135.220.2]:52924 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268959AbUIMUen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 16:34:43 -0400
Subject: Re: BUG in writeback_inodes()?
From: Chris Mason <mason@suse.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <4145C45E.2020705@sw.ru>
References: <4145C45E.2020705@sw.ru>
Content-Type: text/plain
Message-Id: <1095107711.15547.102.camel@coffee.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 13 Sep 2004 16:35:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-13 at 12:01, Kirill Korotaev wrote:

> The problem with it is that writeback_inodes() supposes that if 
> __put_super() returns 0 then no super block was deleted from the list 
> and we can safely traverse sb list further.
> 
> But as it is obvious from the deactivate_super() it's not actually true. 
> because at point Y we delete super block from the list and drop the 
> lock. We do __put_super() very much later... So we can find sb with 
> poisoned sb->s_list at point X and we won't be the last sb reference 
> holders. The last reference will be dropped in point Z.
> 
> So in case of the following sequence of execution Y -> X -> Z we'll get 
> an oops after point X in writeback_inodes().
> 
> Am I correct with it?

Hmmm, sure looks that way.  Seems like it should be enough to switch to
list_del_init in deactivate_super, and then check for
list_empty(sb->s_list) in writeback_inodes.

-chris


