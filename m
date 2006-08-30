Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWH3RZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWH3RZz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWH3RZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:25:55 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:61152 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751188AbWH3RZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:25:54 -0400
Date: Wed, 30 Aug 2006 19:25:07 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Oleg Nesterov <oleg@tv-sign.ru>, Kirill Korotaev <dev@sw.ru>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Alexey Dobriyan <adobriyan@mail.ru>,
       Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH 1/7] introduce atomic_dec_and_lock_irqsave()
In-Reply-To: <20060830165851.GA8481@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0608301918260.6761@scrub.home>
References: <44F45045.70402@sw.ru> <44F4540C.8050205@sw.ru>
 <Pine.LNX.4.64.0608301156010.6762@scrub.home> <20060830145759.GA163@oleg>
 <Pine.LNX.4.64.0608301248420.6761@scrub.home> <20060830165851.GA8481@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 30 Aug 2006, Dipankar Sarma wrote:

> > > uidhash_lock can be taken from irq context. For example, delayed_put_task_struct()
> > > does __put_task_struct()->free_uid().
> > 
> > AFAICT it's called via rcu, does that mean anything released via rcu has 
> > to be protected against interrupts?
> 
> No. You need protection only if you have are using some 
> data that can also be used by the RCU callback. For example,
> if your RCU callback just calls kfree(), you don't have to 
> do a spin_lock_bh().

In this case kfree() does its own interrupt synchronization. I didn't 
realize before that rcu had this (IMO serious) limitation. I think there 
should be two call_rcu() variants, one that queues the callback in a soft 
irq and a second which queues it in a thread context.

bye, Roman
