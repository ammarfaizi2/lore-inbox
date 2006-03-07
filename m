Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWCGMKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWCGMKN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 07:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbWCGMKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 07:10:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2504 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751155AbWCGMKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 07:10:11 -0500
Date: Tue, 7 Mar 2006 04:08:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andres Salomon <dilinger@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pdflush and high load
Message-Id: <20060307040821.29aa78c1.akpm@osdl.org>
In-Reply-To: <1141682814.30428.60.camel@localhost.localdomain>
References: <1141682814.30428.60.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andres Salomon <dilinger@debian.org> wrote:
>
> Hi,
> 
> (2nd attempt at posting this; the first one appears to have
> disappeared?)

It came through.

> Basically, what ends up happening on my system is, each pdflush process
> is handling background_writeout(), encountering congestion, and calling
> blk_congestion_wait(WRITE, HZ/10) after every loop.

Yes, the do-we-need-another-thread algorithm is rather too naive.  I could
swear it _used_ to work OK.  Maybe something changed to cause individual
threads to block for longer than they used to.  That would be an
independent problem - one pdflush instance is supposed to be able to handle
many queues (I tested one instance on 12 disks and it worked OK.  But that
was 4-5 years ago)

> My solution to the problem is to keep the blk_congestion_wait() sleep as
> uninterruptible, but add a check to the background_writeout() loop to
> check whether the current pdflush thread is actually doing anything
> useful; if it's not, just give up.

It would be better to not start a new thread in the first place.

