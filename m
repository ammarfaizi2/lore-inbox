Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272712AbTHKPZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 11:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272729AbTHKPZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 11:25:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:3242 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S272712AbTHKPZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:25:37 -0400
Date: Mon, 11 Aug 2003 17:24:49 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: 4GB+DEBUG_PAGEALLOC oopses with 2.6.0-test3-mm1
In-Reply-To: <3F37B4B7.9010108@colorfullife.com>
Message-ID: <Pine.LNX.4.56.0308111723040.11173@localhost.localdomain>
References: <3F361F5E.10106@colorfullife.com> <Pine.LNX.4.56.0308111024330.19887@localhost.localdomain>
 <3F37B4B7.9010108@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Aug 2003, Manfred Spraul wrote:

> >(in theory it's possible that kernel-internal mounts pass in a pointer
> >where pointer + PAGE_SIZE is not a valid kernel address - if this happens
> >then we'd get a hard crash.)

> Exactly that happens.
> I'm running with CONFIG_PAGE_DEBUG, i.e. unallocated pages are marked as 
> non-present in the linear mapping.

this is not a bug technically, unless the mount options are in the last
linearly mapped page. It is a bug to copy those unallocated bytes, but
they do not get to relied upon. Note that the non-4G code copies them just
as much.

> Regarding the i386 trap handler: show_registers tries to hexdump the 
> current instructions. It did a __get_user, to avoid causing a fault when 
> %eip is invalid.
> Now it contains:
> 
> >      if ((user_mode(regs) && get_user(c, eip)) ||
> >           (!user_mode(regs) && __direct_get_user(c, eip))) {
> >              printk(" Bad EIP value.");
> >              break;
> >      }
> 
> I.e. it's already fixed.

yeah, this was one of the latest patches that went into Andrew's tree.  
(This fix enabled us to get rid of the do_page_fault() hacks.)

	Ingo
