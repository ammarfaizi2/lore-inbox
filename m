Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264110AbTLUVIn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 16:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbTLUVIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 16:08:42 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:20707 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264110AbTLUVIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 16:08:41 -0500
Message-ID: <3FE60BCC.5090305@colorfullife.com>
Date: Sun, 21 Dec 2003 22:08:28 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
References: <3FE492EF.2090202@colorfullife.com> <8765ga6moe.fsf@devron.myhome.or.jp> <3FE5F116.9020608@colorfullife.com> <Pine.LNX.4.58.0312211250370.13039@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312211250370.13039@home.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Sun, 21 Dec 2003, Manfred Spraul wrote:
>  
>
>>Initially I tried to keep the patch as tiny as possible, thus I avoided 
>>adding an inline function. But Stephen Hemminger convinced me to update 
>>the network code, and thus it didn't matter and I've switched to an 
>>inline function.
>>What do you think about the attached patch?
>>    
>>
>
>Please, NO!
>
>Stuff like this
>
>	-       write_lock_irq(&fasync_lock);
>	+       if (s)
>	+               lock_sock(s);
>	+       else
>	+               spin_lock(&fasync_lock);
>	+
>
>should not be allowed. That's especially true since the choice really is a 
>static one depending on the caller.
>
>Just make the caller do the locking.
>  
>
It's not that simple: the function does
    kmalloc();
    spin_lock();
    use_allocation.
If the caller does the locking, then the kmalloc would have to use 
GFP_ATOMIC, or the caller would have to do the alloc.
But: as far as I can see, these lines usually run under lock_kernel(). 
If this is true, then the spin_lock(&fasync_lock) won't cause any 
scalability regression, and I'll use that lock instead of lock_sock, 
even for network sockets.

--
    Manfred

