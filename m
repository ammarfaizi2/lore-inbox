Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268376AbTCFUeB>; Thu, 6 Mar 2003 15:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268377AbTCFUeB>; Thu, 6 Mar 2003 15:34:01 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:53398 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S268376AbTCFUd6>; Thu, 6 Mar 2003 15:33:58 -0500
Message-Id: <200303062044.h26Ki7Gi013598@locutus.cmf.nrl.navy.mil>
To: Werner Almesberger <wa@almesberger.net>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] make atm (and clip) modular + try_module_get() 
In-reply-to: Your message of "Wed, 05 Mar 2003 12:52:31 -0300."
             <20030305125230.B525@almesberger.net> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Thu, 06 Mar 2003 15:44:07 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030305125230.B525@almesberger.net>,Werner Almesberger writes:
>native ATM VCs, owned by atmarpd. When atmarpd clears them for IP
>traffic, all the data that has been queued so far (i.e. any ATMARP
>messages, and any IP - typically I'd expect to find a SYN there)
>is removed from the native ATM VC's queue, and fed into the non-ATM
>part of the stack, for de-encapsulation, etc.

while you could make skb_migrate() generic, in this case it doesnt
really need to be.  since the dest list is on the stack you wouldn't
need to lock it -- only the source list.  however, this whole migrate
thing makes me a bit nervous.  you copy the pending data and then
requeue the data.  what keeps data from arriving on the vcc while
you are reprocessing -- this could lead to out of order packet
arrival.

perhaps the recvq could be locked (to prevent new arrivals) and then
go through and feed the ip traffic to clip_vcc() leaving the atmarp
traffic in the queue.  then, unlock and wakeup the vcc to force atmarp
to get the data pending for it (if any).  this would prevent get 
around the need to 'migrate' the data back and forth.

