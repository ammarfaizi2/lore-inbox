Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWBPTj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWBPTj4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWBPTj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:39:56 -0500
Received: from mail-a02.ithnet.com ([217.64.83.97]:65182 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S964882AbWBPTjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:39:55 -0500
X-Sender-Authentication: net64
Date: Thu, 16 Feb 2006 20:39:48 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Severe problem with e1000 driver in 2.4.31/32 (at least)
Message-Id: <20060216203948.5953a1e9.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

today we had to experience a bug in e1000 network driver on this type of
network card (a current PCI e1000 sold everywhere):

02:07.0 Ethernet controller: Intel Corp.: Unknown device 107c (rev 05)
        Subsystem: Intel Corp.: Unknown device 1376
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 18
        Memory at f9000000 (32-bit, non-prefetchable) [size=128K]
        Memory at f9020000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at a800 [size=64]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.

We can simply crash the box (2.4.32 stock kernel, 2.4.31 is the same) by
performing this:

1) Boot box with network physically disconnected
2) start pinging some host somewhere, you get "unreachable", let it run
3) connect the network and await some ping replies.
4) disconnect the network again
5) box is dead

The box runs into a BUG in e1000_hw.c line 5052. The BUG shows up because the
code is obviously executed inside an interrupt, which seems not intended.
As this BUG is always reproducable and pretty annoying we made this pretty bad
workaround:

In e1000_osdep.h replace:

#define msec_delay(x)   do { if(in_interrupt()) { \
                                /* Don't mdelay in interrupt context! */ \
                                BUG(); \
                        } else { \
                                set_current_state(TASK_UNINTERRUPTIBLE); \
                                schedule_timeout((x * HZ)/1000 + 2); \
                        } } while(0)

with

#define msec_delay(x)   do { if(in_interrupt()) { \
                                /* Don't mdelay in interrupt context! */ \
                                mdelay(x); \
                        } else { \
                                set_current_state(TASK_UNINTERRUPTIBLE); \
                                schedule_timeout((x * HZ)/1000 + 2); \
                        } } while(0)


Obviously this is not a solution, but it saves the world at least. This is why
I offer no applyable patch.

Someone with inside knowledge of this driver should take a look why
e1000_config_dsp_after_link_change in e1000_hw.c is executed in interrupt
context. Btw I don't know if this shows up in 2.6 either.

-- 
Regards,
Stephan
