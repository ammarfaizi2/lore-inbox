Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271771AbTGRQla (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 12:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270255AbTGRQjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 12:39:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:45264 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267517AbTGRQiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 12:38:15 -0400
Date: Fri, 18 Jul 2003 09:45:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Osterlund <petero2@telia.com>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: Software suspend testing in 2.6.0-test1
Message-Id: <20030718094542.07b2685a.akpm@osdl.org>
In-Reply-To: <m2el0nvnhm.fsf@telia.com>
References: <m2wueh2axz.fsf@telia.com>
	<20030717200039.GA227@elf.ucw.cz>
	<20030717130906.0717b30d.akpm@osdl.org>
	<m2d6g8cg06.fsf@telia.com>
	<20030718032433.4b6b9281.akpm@osdl.org>
	<20030718152205.GA407@elf.ucw.cz>
	<m2el0nvnhm.fsf@telia.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
>
> I tried the patch below, but it didn't work. Nothing (or very little)
> was swapped out to disk. I also tried using GFP_KERNEL, but that
> seemed to cause a deadlock. (Maybe it would have gone OOM if I had
> waited long enough). I think the problem is that pdflush and friends
> are already frozen when this code runs.

Oh, we shouldn't be doing this sort of thing when the kernel threads are
refrigerated.  We do need kswapd services for the trick you tried.

And all flavours of ext3_writepage() can block on kjournald activity, so if
kjournald is refrigerated during the memory shrink the machine can deadlock.

It would be much better to freeze kernel threads _after_ doing the big
memory shrink.

