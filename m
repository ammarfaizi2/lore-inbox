Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbUAPXaY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 18:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265894AbUAPXaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 18:30:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:27099 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265879AbUAPXaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 18:30:21 -0500
Date: Fri, 16 Jan 2004 15:31:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: timing code in 2.6.1
Message-Id: <20040116153122.2c4adffe.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0401161150390.28039@chaos>
References: <Pine.LNX.4.53.0401161150390.28039@chaos>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> wrote:
>
> 
> Some drivers are being re-written for 2.6++. The following
> construct seems to work for "waiting for an event" in
> the kernel modules.
> 
>         // No locks are being held
>         tim = jiffies + EVENT_TIMEOUT;
>         while(!event() && time_before(jiffies, tim))
>             schedule_timeout(0);
> 
> Is there anything wrong?

This is not a good thing to be doing.  You should add this task to a
waitqueue and then sleep.  Make the code which causes event() to come true
deliver a wake_up to that waitqueue.  There are many examples of this in
the kernel.

If the hardware only supports polling then gee, you'd be best off spinning
for a few microseconds then fall into a schedule_timeout(1) polling loop. 
Or something like that.  Or make the hardware designer write the damn
driver.

> Do I have to execute "set_current_state(TASK_INTERRUPTIBLE)" before?
> Do I have to execute "set_current_state(TASK_RUNNING)" after?
> 
> I don't want to have to change this again so I really need to
> know. For instance, if I execute "set_current_state(TASK_INTERRUPTIBLE)"
> in version 2.4.24, it didn't hurt anything. In 2.6.1, there are
> conditions where schedule_timeout(0) doesn't return if another
> task is spinning "while(1) ; ". This is NotGood(tm).

As you have it, you may as well be calling schedule() inside that loop. 
You _have_ to be in state TASK_RUNNING, else you'll sleep forever.


