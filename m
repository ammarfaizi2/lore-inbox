Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262120AbTDAHkd>; Tue, 1 Apr 2003 02:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262130AbTDAHkd>; Tue, 1 Apr 2003 02:40:33 -0500
Received: from [12.47.58.55] ([12.47.58.55]:61180 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S262120AbTDAHkc>;
	Tue, 1 Apr 2003 02:40:32 -0500
Date: Mon, 31 Mar 2003 23:52:05 -0800
From: Andrew Morton <akpm@digeo.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org, gibbs@scsiguy.com
Subject: Re: aic7(censored) use after free in 2.5.66
Message-Id: <20030331235205.3d4d8f9f.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.50.0304010236270.8773-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0304010141200.8773-100000@montezuma.mastecende.com>
	<Pine.LNX.4.50.0304010155470.8773-100000@montezuma.mastecende.com>
	<20030331232227.3f9c9c5f.akpm@digeo.com>
	<Pine.LNX.4.50.0304010236270.8773-100000@montezuma.mastecende.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Apr 2003 07:51:49.0216 (UTC) FILETIME=[8CF44E00:01C2F823]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
> On Mon, 31 Mar 2003, Andrew Morton wrote:
> 
> > The corruption was at offset 52 decimal into struct ahc_linux_device. 
> > Without knowing your config it is hard for me to work out what you have at
> > that offset.   Rebuild your kernel with -g and do:
> > 
> > (gdb) p/d &(((struct ahc_linux_device *)0)->maxtags)
> > 
> > until you find which member is at offset 52.
> > 
> > Something incremented that field by one after it was freed.
> 
> (gdb) p/d &(((struct ahc_linux_device *)0)->timer.lock)
> $4 = 52
> 
> That would be a lock free it appears.

OK, so that's a spin_unlock(&timer->lock) in the timer code itself.  Your
patch will fix that up.

We just need to be sure that the del_timer_sync() is not called while holding
any locks which would prevent the timer handler from completing.  


