Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbTLUUvz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 15:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbTLUUvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 15:51:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:64911 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263980AbTLUUvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 15:51:53 -0500
Date: Sun, 21 Dec 2003 12:51:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
In-Reply-To: <3FE5F116.9020608@colorfullife.com>
Message-ID: <Pine.LNX.4.58.0312211250370.13039@home.osdl.org>
References: <3FE492EF.2090202@colorfullife.com> <8765ga6moe.fsf@devron.myhome.or.jp>
 <3FE5F116.9020608@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Dec 2003, Manfred Spraul wrote:
>
> Initially I tried to keep the patch as tiny as possible, thus I avoided 
> adding an inline function. But Stephen Hemminger convinced me to update 
> the network code, and thus it didn't matter and I've switched to an 
> inline function.
> What do you think about the attached patch?

Please, NO!

Stuff like this

	-       write_lock_irq(&fasync_lock);
	+       if (s)
	+               lock_sock(s);
	+       else
	+               spin_lock(&fasync_lock);
	+

should not be allowed. That's especially true since the choice really is a 
static one depending on the caller.

Just make the caller do the locking.

		Linus
