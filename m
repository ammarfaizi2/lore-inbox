Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWH3X3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWH3X3o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWH3X3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:29:44 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:1863 "EHLO
	asav00.insightbb.com") by vger.kernel.org with ESMTP
	id S932236AbWH3X3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:29:43 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAP+69USBT4lXLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: LOCKDEP: input layer warning.
Date: Wed, 30 Aug 2006 19:29:35 -0400
User-Agent: KMail/1.9.3
Cc: arjan@linux.intel.com, linux-kernel@vger.kernel.org
References: <20060830171120.32466551@doriath.conectiva>
In-Reply-To: <20060830171120.32466551@doriath.conectiva>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608301929.35456.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luiz, 

On Wednesday 30 August 2006 16:11, Luiz Fernando N. Capitulino wrote:
> 
>  Hi Dmitry,
> 
>  A Mandriva user is getting the lockdep warning bellow when running an
> unpatched 2.6.18-rc5 kernel.
> 
>  But according to this thread:
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0607.0/1598.html
> 
>  this was reported already, but not fixed.

I am still convinced that this is a false lockdep positive. The lock in
question is actuallt 2 separate mutextes, one on parent PS/2 device and
another on the child connected via synaptics' pass-through port.
 
> 
> =============================================
> [ INFO: possible recursive locking detected ]
> ---------------------------------------------
> kseriod/187 is trying to acquire lock:
>  (&ps2dev->cmd_mutex/1){--..}, at: [<c024b1da>] ps2_command+0x7b/0x2d6
> 
> but task is already holding lock:
>  (&ps2dev->cmd_mutex/1){--..}, at: [<c024b1da>] ps2_command+0x7b/0x2d6
> 
> other info that might help us debug this:
> 4 locks held by kseriod/187:
>  #0:  (serio_mutex){--..}, at: [<c02bfd62>] mutex_lock+0x1c/0x1f
>  #1:  (&serio->drv_mutex){--..}, at: [<c02bfd62>] mutex_lock+0x1c/0x1f
>  #2:  (psmouse_mutex){--..}, at: [<c02bfd62>] mutex_lock+0x1c/0x1f
>  #3:  (&ps2dev->cmd_mutex/1){--..}, at: [<c024b1da>] ps2_command+0x7b/0x2d6
> 
> stack backtrace:
>  [<c010454c>] show_trace_log_lvl+0x58/0x152
>  [<c0104b2c>] show_trace+0xd/0x10
>  [<c0104c42>] dump_stack+0x19/0x1b
>  [<c0135d2a>] __lock_acquire+0x755/0x973
>  [<c013648b>] lock_acquire+0x4b/0x6c
>  [<c02bfe28>] mutex_lock_nested+0xc3/0x209
>  [<c024b1da>] ps2_command+0x7b/0x2d6
>  [<c024fa91>] psmouse_sliced_command+0x1c/0x5a
>  [<c0252f9a>] synaptics_pt_write+0x1e/0x44
>  [<c024b0c7>] ps2_sendbyte+0x3e/0xd6
>  [<c024b25b>] ps2_command+0xfc/0x2d6
>  [<c024f6c4>] psmouse_probe+0x1d/0x68
>  [<c025061a>] psmouse_connect+0xe8/0x20f
>  [<c0248f76>] serio_connect_driver+0x1e/0x2e
>  [<c0248f9c>] serio_driver_probe+0x16/0x18
>  [<c022b08a>] driver_probe_device+0x45/0x92
>  [<c022b0df>] __device_attach+0x8/0xa
>  [<c022aa29>] bus_for_each_drv+0x3c/0x67
>  [<c022b135>] device_attach+0x54/0x69
>  [<c022a765>] bus_attach_device+0x16/0x2b
>  [<c0229bcf>] device_add+0x1f8/0x2e3
>  [<c0249a09>] serio_thread+0xd0/0x28f
>  [<c0130a1d>] kthread+0xc3/0xf2
>  [<c0101005>] kernel_thread_helper+0x5/0xb
> DWARF2 unwinder stuck at kernel_thread_helper+0x5/0xb
> Leftover inexact backtrace:
>  [<c0104b2c>] show_trace+0xd/0x10
>  [<c0104c42>] dump_stack+0x19/0x1b
>  [<c0135d2a>] __lock_acquire+0x755/0x973
>  [<c013648b>] lock_acquire+0x4b/0x6c
>  [<c02bfe28>] mutex_lock_nested+0xc3/0x209
>  [<c024b1da>] ps2_command+0x7b/0x2d6
>  [<c024fa91>] psmouse_sliced_command+0x1c/0x5a
>  [<c0252f9a>] synaptics_pt_write+0x1e/0x44
>  [<c024b0c7>] ps2_sendbyte+0x3e/0xd6
>  [<c024b25b>] ps2_command+0xfc/0x2d6
>  [<c024f6c4>] psmouse_probe+0x1d/0x68
>  [<c025061a>] psmouse_connect+0xe8/0x20f
>  [<c0248f76>] serio_connect_driver+0x1e/0x2e
>  [<c0248f9c>] serio_driver_probe+0x16/0x18
>  [<c022b08a>] driver_probe_device+0x45/0x92
>  [<c022b0df>] __device_attach+0x8/0xa
>  [<c022aa29>] bus_for_each_drv+0x3c/0x67
>  [<c022b135>] device_attach+0x54/0x69
>  [<c022a765>] bus_attach_device+0x16/0x2b
>  [<c0229bcf>] device_add+0x1f8/0x2e3
>  [<c0249a09>] serio_thread+0xd0/0x28f
>  [<c0130a1d>] kthread+0xc3/0xf2
>  [<c0101005>] kernel_thread_helper+0x5/0xb
> 

-- 
Dmitry
