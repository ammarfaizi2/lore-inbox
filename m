Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWIIDDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWIIDDd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 23:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWIIDDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 23:03:33 -0400
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:62142 "EHLO
	mtiwmhc13.worldnet.att.net") by vger.kernel.org with ESMTP
	id S932094AbWIIDDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 23:03:32 -0400
Message-ID: <45022EF8.2020005@lwfinger.net>
Date: Fri, 08 Sep 2006 22:03:20 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: HELP - NETDEV WATCHDOG tx timeouts
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the bcm43xx driver, the code snippet shown below has a problem. When the synchronize_net 
statement is included, once every 200-300 passes through the code, the system will report a NETDEV 
WATCHDOG tx timeout for bcm43xx, even when the watchdog timeout is set to 30 sec. When the 
synchronize statement is removed, there are no errors, Except for lo, this is the only active 
network device on the system.

Is there something wrong with this structure? How can synchronize_net take that long?

Thanks, Larry

==============

        mutex_lock(...);
        netif_stop_queue(net_device);
        synchronize_net();               <================ problem ?
        spin_lock_irqsave(.....);
...... do some stuff on the hardware
        disable interrupts on device
        spin_unlock_irqrestore(.......);
        synchronize irq top/bottom halves
...... lengthy processing here
        spin_lock_irqsave(.....);
        tasklet_enable(.....);
        enable interrupts
...... more stuff with the hardware
        netif_wake_queue(net_device);
        spin_unlock_irqrestore(...);
        mutex_unlock(...);
