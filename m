Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVEWPqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVEWPqP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 11:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVEWPqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 11:46:15 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:137 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261893AbVEWPqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 11:46:03 -0400
Message-ID: <4291FC90.7791036C@tv-sign.ru>
Date: Mon, 23 May 2005 19:53:52 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
References: <Pine.LNX.4.44.0505230800580.863-100000@dhcp153.mvista.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
>
> On Mon, 23 May 2005, Oleg Nesterov wrote:
>
> > So the very first node will be skipped, iteration will be out of order,
> > and you will have the plist's *head* as a last element (which is not
> > struct rt_mutex_waiter, of course).
>
> True, but the first node is the list head which must be static,
> It's not an actual list member.

No. Look, plist_for_each() is just list_for_each_entry() now.
So, the the first iteration will play with head->sp_node.next,
not with head! And then you are doing ->dp_node.next again in
plist_entry().

I'd suggest you to write simple programm, and test. I bet I'm
right.

> > 	new_sp_head:
> > 		itr_pl2 = container_of(itr_pl->dp_node.prev, struct plist, dp_node);
> > 		list_add(&pl->sp_node, &itr_pl2->sp_node);
> >
> > Why?  Just list_add_tail(&pl->sp_node, itr_pl->sp_node), you don't
> > need itr_pl2 at all.
>
> Wouldn't work . What if itr_pl has 15 elements at it's priority?

15 or 0, I think it would work. Look, it is *new* priority, and
pl->prio < itr_pl->prio, so pl should stay just before itr_pl
in ->sp_node list. That is why list_add_tail(&pl->sp_node, itr_pl->sp_node)
is enough.

Oleg.
