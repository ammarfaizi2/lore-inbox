Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263227AbTCYSTX>; Tue, 25 Mar 2003 13:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263226AbTCYSSj>; Tue, 25 Mar 2003 13:18:39 -0500
Received: from AMarseille-201-1-1-200.abo.wanadoo.fr ([193.252.38.200]:18727
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263225AbTCYSSf>; Tue, 25 Mar 2003 13:18:35 -0500
Subject: Re: [BK FBDEV] A few more updates.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0303251031180.4272-100000@maxwell.earthlink.net>
References: <Pine.LNX.4.33.0303251031180.4272-100000@maxwell.earthlink.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048616901.10476.3.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 25 Mar 2003 19:28:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-25 at 19:32, James Simmons wrote:
> Linus, please do a
> 
> 	bk pull http://fbdev.bkbits.net/fbdev-2.5
> 
> This will update the following files:
> 
>  drivers/video/aty/aty128fb.c  |   16 +++++++---------
>  drivers/video/console/fbcon.c |    4 ++--
>  drivers/video/controlfb.c     |   18 +++---------------
>  drivers/video/platinumfb.c    |   28 ++++++++--------------------
>  drivers/video/radeonfb.c      |   10 ++++++++++
>  drivers/video/softcursor.c    |    2 +-
>  6 files changed, 31 insertions(+), 47 deletions(-)
> 
> through these ChangeSets:
> 
> <jsimmons@maxwell.earthlink.net> (03/03/25 1.981)
>    [FBCON] Could be called outside of a process context. This fixes that.

You "fixed" it by using GFP_ATOMIC but didn't test the result of
kmalloc. That is very bad. GFP_ATOMIC can fail (return NULL), thus
you will crash the kernel under high memory pressure.

I think the proper fix is, as you asked me, using a workqueue,
that way, you can both use GFP_KERNEL allocations, and avoid
the spinlock you added to fbmem.c, thus letting the fb_sync()
ops on fbdev's be able to block.

Ben.

