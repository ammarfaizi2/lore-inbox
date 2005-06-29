Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbVF2Npr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbVF2Npr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 09:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbVF2Npr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 09:45:47 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:61180 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262572AbVF2Npl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 09:45:41 -0400
Date: Wed, 29 Jun 2005 09:44:52 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Arjan van de Ven <arjan@infradead.org>
cc: Denis Vlasenko <vda@ilport.com.ua>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: kmalloc without GFP_xxx?
In-Reply-To: <1120045024.3196.34.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0506290927370.22775@localhost.localdomain>
References: <200506291402.18064.vda@ilport.com.ua> 
 <1120043739.3196.32.camel@laptopd505.fenrus.org>  <200506291420.09956.vda@ilport.com.ua>
 <1120045024.3196.34.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Jun 2005, Arjan van de Ven wrote:
> >
> > but it sets irqs_disabled() IIRC.
>
> only spin_lock_irq() and co do.
> not the simple spin_lock()
>

It may be dangerous to use spin_lock with interrupts enabled, since you
have to make sure that no interrupt ever grabs that lock.  Although I do
recall seeing a few locks like this.  But even so, you can transfer the
latency of the interrupts going off while holding that lock to another CPU
which IMHO is a bad thing.  Also a simple spin_lock would disable
preemption with CONFIG_PREEMPT set and that would make in_atomic fail.
But to implement a kmalloc_auto you would always need to have a preempt
count.

I'm not for a kmalloc_auto, but something like it would be useful for a
function that can work for either context, and just fail nicely if the
ATOMIC is set and the malloc can't get memory.  A function like this would
currently have to always use ATOMIC even if it could have used KERNEL for
some scenarios, since it would suffer the same pitfalls as a kmalloc_auto
in determining its context.

-- Steve

