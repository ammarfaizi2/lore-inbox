Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbTLUVzO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 16:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbTLUVzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 16:55:14 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:31459 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264132AbTLUVzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 16:55:10 -0500
Message-ID: <3FE616AE.5030103@colorfullife.com>
Date: Sun, 21 Dec 2003 22:54:54 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
References: <3FE492EF.2090202@colorfullife.com> <8765ga6moe.fsf@devron.myhome.or.jp> <3FE5F116.9020608@colorfullife.com> <Pine.LNX.4.58.0312211250370.13039@home.osdl.org> <3FE60BCC.5090305@colorfullife.com> <Pine.LNX.4.58.0312211313070.13039@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312211313070.13039@home.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>Here's a big clue: if you make code worse than it is today, it won't be 
>accepted. I don't even see why you'd bother in the first place.
>  
>
fasync_helper != kill_fasync
fasync_helper is rare, and usually running under lock_kernel().
kill_fasync is far more common (every pipe_read and _write), I want to 
remove the unconditional read_lock(&global_lock).

>So go back to the drawing board, and just do it _right_. Or don't do it at 
>all. There's no point to making the code look and behave worse than it 
>does today.
>
Today's solution is two copies of fasync_helper: one with lock_sock in 
net/socket.c, one with write_lock_irq(&fasync_lock) in fs/fcntl.c.

Perhaps just a "if (*fp == NULL) return;" before grabbing the read_lock 
in kill_fasync, without touching fasync_helper - that would be 
sufficient to fix pipe_read and _write.

--
    Manfred

