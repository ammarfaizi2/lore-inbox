Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbTJCUgl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 16:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbTJCUgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 16:36:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:59318 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261224AbTJCUgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 16:36:39 -0400
Date: Fri, 3 Oct 2003 13:36:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <willy@debian.org>
Cc: umka@namesys.com, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: down_timeout
Message-Id: <20031003133632.4b8cd1bc.akpm@osdl.org>
In-Reply-To: <20031003142518.GN24824@parcelfarce.linux.theplanet.co.uk>
References: <3F7D6DA1.9070801@namesys.com>
	<20031003142518.GN24824@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> wrote:
>
> /* Returns -EINTR if the timeout expires */
> int down_timeout(struct semaphore *sem, long timeout)
> {
> 	struct timer_list timer;
> 	int result;
> 
> 	init_timer(&timer);
> 	timer.expires = timeout + jiffies;
> 	timer.data = (unsigned long) current;
> 	timer.function = process_timeout;
> 
> 	add_timer(&timer);
> 	result = down_interruptible(sem);
> 	del_timer_sync(&timer);
> 
> 	return result;
> }

down_interruptible() will only break out if signal_pending(current), so the
wakeup-on-expiry here will not work as desired.

New per-arch primitives would be needed to implement this, I think.

