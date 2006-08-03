Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWHCMQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWHCMQo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 08:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWHCMQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 08:16:43 -0400
Received: from e-nvb.com ([69.27.17.200]:26554 "EHLO e-nvb.com")
	by vger.kernel.org with ESMTP id S932382AbWHCMQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 08:16:42 -0400
Subject: Re: orinoco driver causes *lots* of lockdep spew
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
In-Reply-To: <20060802215932.GE3639@redhat.com>
References: <20060802215932.GE3639@redhat.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 03 Aug 2006 14:15:59 +0200
Message-Id: <1154607380.2965.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-02 at 17:59 -0400, Dave Jones wrote:
> Wow. Nearly 400 lines of debug spew, from a simple 'ifup eth1'.
> 
> 		Dave
> 
> 
> ADDRCONF(NETDEV_UP): eth1: link is not ready
> eth1: New link status: Disconnected (0002)
> 
> ======================================================
> [ INFO: hard-safe -> hard-unsafe lock order detected ]
> ------------------------------------------------------
> events/0/5 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>  (af_callback_keys + sk->sk_family){-.--}, at: [<ffffffff802136b1>] sock_def_readable+0x19/0x6f
> 
> and this task is already holding:
>  (&priv->lock){++..}, at: [<ffffffff8824f70e>] orinoco_send_wevents+0x28/0x8b [orinoco]
> which would create a new lock dependency:
>  (&priv->lock){++..} -> (af_callback_keys + sk->sk_family){-.--}

>  [<ffffffff80267948>] _read_lock+0x28/0x34
>  [<ffffffff802136b1>] sock_def_readable+0x19/0x6f
>  [<ffffffff80259ad7>] netlink_broadcast+0x222/0x2e2
>  [<ffffffff804287eb>] wireless_send_event+0x300/0x317
>  [<ffffffff8824f732>] :orinoco:orinoco_send_wevents+0x4c/0x8b
>  [<ffffffff8024f99c>] run_workqueue+0xa8/0xfb
>  [<ffffffff8024c180>] worker_thread+0xef/0x122
>  [<ffffffff80235437>] kthread+0x100/0x136
>  [<ffffffff802613de>] child_rip+0x8/0x12



this is another one of those nasty buggers;

Lock A = the sk->sk_callback_lock
Lock B = priv->lock in the driver

Lock A is only BH safe 
Lock B is hardirq safe and used in the hardirq


Cpu 0			cpu 1
                        user closes the netlink socket
takes lock B in orinoco_send_events 
                        takes lock A  in user context in netlink_release() (for write)
                        interrupt happens
                        takes lock B in hardirq handler (spins)

calls netlink_broadcast
which takes lock A for read (spins)

and you have a nice classical AB-BA deadlock

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

