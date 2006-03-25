Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWCYALi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWCYALi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 19:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWCYALi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 19:11:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39636 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751042AbWCYALh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 19:11:37 -0500
Date: Fri, 24 Mar 2006 16:13:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] synclink_gt add gpio feature
Message-Id: <20060324161350.0a18c29b.akpm@osdl.org>
In-Reply-To: <1143244969.2594.24.camel@localhost.localdomain>
References: <1143216251.8513.3.camel@amdx2.microgate.com>
	<20060324141929.1fff0c15.akpm@osdl.org>
	<44247812.1040301@microgate.com>
	<20060324151245.299ff2c1.akpm@osdl.org>
	<1143244969.2594.24.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> wrote:
>
> On Fri, 2006-03-24 at 15:12 -0800, Andrew Morton wrote:
> > Paul Fulghum <paulkf@microgate.com> wrote:
> > > The wrapper seems to be the minimal and most efficient
> > > way of implementing this. Maybe I missed some existing
> > > infrastructure that implements the same features?
> > 
> > wait_on_bit()/wake_up_bit() might be usable?
> 
> Interesting, I had not noticed this previously.
> There are similarities to what I am doing.
> 
> The difference is that a conditional wait allows a caller
> to wait for one or more 'bits' (in my specific case one
> or more signal transitions) with a single wait call.
> The caller wakes when at least one of the conditions is met.
> 
> wake_up_bit does not directly allow communicating state back
> to the waiter, because the only state the waiter is interested
> in is defined in the wait_on_bit call.
> 
> A concise description of the conditional wait is that each
> wait queue implements an event type where additional wake
> discrimination is provided by an arbitrary input data field.
> The same data field allows arbitrary per waiter state to be passed back
> to the waiter. Interpretation of the input and output data
> is specific to an event type and the associated waiter/waker code.
> 
> In my case I use this facility to allow a waiter to say:
> wait for one or more specific GPIO transitions
> and tell me the state of all GPIO when at least
> one of the specified transitions occur.
> 

It should be possible to communicate between waker and waiter via
__wait_queue.private and __wait_queue.func.  Make ->private point at some
on-stack thing, let the waker read and write that.

That'd involve some rather low-level poking at waitqueues, but I don't
expect those facilities are going away.
