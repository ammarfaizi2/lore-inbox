Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbTIGBqM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 21:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbTIGBqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 21:46:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:22400 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262148AbTIGBqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 21:46:11 -0400
Date: Sat, 6 Sep 2003 18:47:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anton Blanchard <anton@samba.org>
Cc: jeremy@goop.org, linux-kernel@vger.kernel.org, bos@serpentine.com,
       netdev@oss.sgi.com
Subject: Re: 2.6.0-test4-mm6: locking imbalance with rtnl_lock/unlock?
Message-Id: <20030906184715.38bf70d9.akpm@osdl.org>
In-Reply-To: <20030906222436.GB15327@krispykreme>
References: <1062885603.24475.7.camel@ixodes.goop.org>
	<20030906222436.GB15327@krispykreme>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
> 
> > which is SIOCGIFADDR.  It seems to me the down() is actually the
> > rtnl_lock() called at net/ipv4/devinet.c:536 in devinet_ioctl.  This
> > happens even when netplugd is no longer running.  It looks like someone
> > isn't releasing the lock.
> > 
> > I'm going over all the uses of rtnl_lock() to see if I can find a
> > problem, but no sign yet.  I wonder if someone might have broken this
> > recently: I'm running 2.6.0-test4-mm6, but I think Bryan is running an
> > older kernel (2.6.0-test4?), and hasn't seen any problems.
> 
> Yep I saw this too when updating from test2 to BK from a few days ago.
> >From memory the cpu that had the rtnl_lock was stuck in dev_close,
> probably netif_poll_disable. I got side tracked and wasnt able to look
> into it.

If the caller of netif_poll_disable() has a signal pending,
netif_poll_disable() becomes a busy loop, which might be causing a
lockup.  Probably not, but it needs to use TASK_UNINTERRUPTIBLE.

I doubt if that explains Jeremy's deadlock though...
