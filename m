Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318757AbSHGL7o>; Wed, 7 Aug 2002 07:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318758AbSHGL7o>; Wed, 7 Aug 2002 07:59:44 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:41465 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318757AbSHGL7n>; Wed, 7 Aug 2002 07:59:43 -0400
Subject: Re: kernel thread exit race
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
In-Reply-To: <15697.1225.84051.277799@laputa.namesys.com>
References: <15696.59115.395706.489896@laputa.namesys.com>
	<1028719111.18156.227.camel@irongate.swansea.linux.org.uk>
	<15696.61666.452460.264138@laputa.namesys.com>
	<1028722283.18156.274.camel@irongate.swansea.linux.org.uk> 
	<15697.1225.84051.277799@laputa.namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 14:22:46 +0100
Message-Id: <1028726566.18478.291.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-07 at 12:30, Nikita Danilov wrote:
> Let me clarify this. Suppose there is some obscure architecture that
> maintains in spinlocks some additional data for debugging. Then,
> 
> complete_and_exit()->complete()->spin_unlock_irqrestore() 
> 
> "wakes up" thread on another CPU and proceeds to access spin-lock data
> (to check/update debugging information, for example), but by this time
> woken up thread manages to unload module and to un-map page containing
> spin-lock data.

At the point complete() sets x->done to indicate completion occurred it
holds the lock, when it drops the lock then the wait_for_completion can
return, and while it may touch the data again, the complete() call will
not.

So in your unload you have got

	complete_and_exit()

On return from this we know the thread won't touch the lock data again
and we know the thread if executing is not executing in module space


And
	wait_for_completion

in the actual module unload path means the complete has finished (but
not neccessarily the exit) so the thread isnt running module code any
more and won't touch the lock again


This does assume that spin_unlock in the arch code doesn't scribble on
things after it unlocks. So if its doing debugging or pre-emption magic
it must do that before it finally drops the lock proper. Thats what I'd
expect anyway since it has to protect its own internal data too

