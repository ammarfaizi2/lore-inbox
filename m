Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbUKQEO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbUKQEO6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 23:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbUKQEO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 23:14:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:55525 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262205AbUKQEO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 23:14:56 -0500
Date: Tue, 16 Nov 2004 20:14:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hans Reiser <reiser@namesys.com>
Cc: 7atbggg02@sneakemail.com, linux-kernel@vger.kernel.org
Subject: Re: vm-pageout-throttling.patch: hanging in
 throttle_vm_writeout/blk_congestion_wait
Message-Id: <20041116201435.28554599.akpm@osdl.org>
In-Reply-To: <419A2698.4080900@namesys.com>
References: <20041115012620.GA5750@m.safari.iki.fi>
	<Pine.LNX.4.44.0411152140030.4171-100000@localhost.localdomain>
	<20041115223709.GD6654@m.safari.iki.fi>
	<419A2698.4080900@namesys.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
>
> >>>loop-AES-2.2d)...  I think (!) it caused this deadlock.
>  >>>      
>  >>>
>  >>That's not at all surprising.  See the swap_extent work Andrew did
>  >>for 2.5 (in mm/swapfile.c), by which swap to a swapfile now avoids
>  >>the filesystem altogether (except while swapon prepares the map of
>  >>disk blocks).  By swapping to a loop device over a file, you're
>  >>sneaking past his work, and putting the filesystem back under swap.
>  >>    
>  >>
> 
>  Does Andrew's approach prevent putting swap on a compressed file (useful 
>  for reiser4 once the compression plugin is stable, not reiserfs)? (And 
>  no, I don't have any idea what the performance effect of that would be 
>  before it is tried and benchmarked....)

swapfiles bypass the filesystem completely, so if you're implementing
compression at the writepage() level, swap will cheerfully ignore all that
and will launch submit_bio() direct against your blockdev anyway.

encrypted swap should be done via dm-crypt.  compressed swap would I guess
require dm-compress.
