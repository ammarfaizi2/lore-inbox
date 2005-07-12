Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVGLNcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVGLNcG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 09:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVGLNcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 09:32:06 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:27302 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261432AbVGLNaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 09:30:55 -0400
Subject: Re: "scheduling while atomic" ?
From: Steven Rostedt <rostedt@goodmis.org>
To: Mateusz Berezecki <mateuszb@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <42D3C37C.6040401@gmail.com>
References: <42D3C37C.6040401@gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 12 Jul 2005 09:30:49 -0400
Message-Id: <1121175049.6917.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 15:19 +0200, Mateusz Berezecki wrote:
> Hi LKML,
> 
> What does the message saying "scheduling while atomic" mean?

It means that you called schedule with preemption turned off, which
could be by grabbing a spin_lock.

> The kernel prints a stack backtrace after this message appears so I
> suppose this is
> not a good behaviour. I am finishing an open source driver, and I need
> to do all of this
> locking stuff, etc. and this really makes me wonder what I am doing wrong.
> 
> here is some part of a backtrace...
> 
> scheduling while atomic: insmod/0x00000001/12692
>  [<c03e7352>] schedule+0x632/0x640
>  [<c0119bb1>] __wake_up_common+0x41/0x70
>  [<c03e74df>] wait_for_completion+0x8f/0xf0
>  [<c0119b50>] default_wake_function+0x0/0x20
>  [<c0119b50>] default_wake_function+0x0/0x20
>  [<c012e2dd>] queue_work+0x8d/0xa0
>  [<c012e070>] __call_usermodehelper+0x0/0x70
>  [<c012e1a5>] call_usermodehelper_keys+0xc5/0xd0
>  [<c012e070>] __call_usermodehelper+0x0/0x70
>  [<c020c028>] sprintf+0x28/0x30
>  [<c020955d>] kobject_hotplug+0x29d/0x310
>  [<c019fc6e>] sysfs_create_link+0x3e/0x60
>  [<c028b601>] class_device_add+0x161/0x1e0
>  [<c036f38e>] netdev_register_sysfs+0x3e/0x100
>  [<c03650db>] netdev_run_todo+0x1eb/0x220
>  [<c0364dce>] register_netdev+0x5e/0x90
> 
> I enable a lock at the beginning of device attach routine
> and I disable it at the end. Whats wrong with it?

When you say enable a lock, do you mean that you grabbed a lock?  Now if
you grabbed a spinlock, it is really bad to then call schedule, since a
another process that will grab that same spinlock will deadlock the CPU
(on an SMP system). Since you are using locks (I'm also assuming that
you are using spinlocks) I assume that you will be running this on a
CONFIG_PREEMPT or SMP system.

So the fix will be to release the lock before calling something that
will schedule, and regrab it afterwards.

-- Steve


