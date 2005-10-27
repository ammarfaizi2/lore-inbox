Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751599AbVJ0WbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbVJ0WbK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbVJ0WbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:31:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26297 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751599AbVJ0WbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:31:08 -0400
Date: Thu, 27 Oct 2005 15:31:04 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Nicholas Jefferson <xanthophile@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: <REAL> iBurst (TM) compatible driver
Message-ID: <20051027153104.1a6531db@dxpl.pdx.osdl.net>
In-Reply-To: <4cd031a50510270924r38ad4d5oa88ae92a514df3cf@mail.gmail.com>
References: <4cd031a50510270924r38ad4d5oa88ae92a514df3cf@mail.gmail.com>
X-Mailer: Sylpheed-Claws 1.9.15 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is good to see more hardware supported, but like many drivers
you are adding a lot of racy ugliness just for debug crap.
Did you actually read any of the other network device drivers first
or try to write code from scratch off some book?

In order of severity.

1. Your network device registration code is wrong.
   Read Documentation/netdevices.txt
   You need to use alloc_netdev() and make the device specific data
   be allocated there, not bury netdevice in a kmalloc'd structure.

2. Transmit routine is wrong. Drop packets if out of memory.
   You can only return NETDEV_TX_OKAY or NETDEV_TX_BUSY
   You probably don't need to allocate memory anyway if you use
   hard header space properly.

3. You need to flow control the transmit queue. When it gets full
   use netdev_stop_queue() and call netdev_wake_queue when you
   have more space.

4. WTF is the whole ib_net_tap file stuff, and why do you need it?
   You can eliminate a lot of module races etc, by just pulling it.

5. Why bother with a /proc interface?
6. If you must then use seq_file.
7. If you must then do one device per file.
8. Then you can get rid of having a global array of device structures
   which is hard to maintain properly.
9. If you don't support ioctl's just leave dev->ioctl as NULL
10. Error code's from call's like register_netdev() should propogate back
    out.
11. ib_net_open, ib_net_close only called from user context don't need irqsave
    use spin_lock_irq()
12. Coding style: don't use u_long it's a BSDism
13. Please have source code laid out as patch to kernel, not out of tree driver

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
