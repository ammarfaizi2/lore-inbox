Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVAGJx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVAGJx7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 04:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVAGJx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 04:53:58 -0500
Received: from smail4.alcatel.fr ([62.23.212.167]:62373 "EHLO
	smail4.alcatel.fr") by vger.kernel.org with ESMTP id S261336AbVAGJxw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 04:53:52 -0500
Message-ID: <41DE5B99.1040602@linux-fr.org>
Date: Fri, 07 Jan 2005 10:51:21 +0100
From: Jean Delvare <khali@linux-fr.org>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.8a5) Gecko/20041222
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Subject: Re: i2c: lost sensors with 2.6.10(-mm1)
References: <1105058791l.5580l.0l@werewolf.able.es>
In-Reply-To: <1105058791l.5580l.0l@werewolf.able.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Alcanet-MTA-scanned-and-authorized: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:

> I have lost my sensors info with 2.6.10, in particular -mm1.
> They work fine with 2.6.9-mm1 (current state of the box, booted on
> 2.6.9 or 10, no other difference).
 > (...)
> I have noticed different contents in /sys:
> under 2.6.9:
> /sys/devices/platform/i2c-1:
> /sys/devices/platform/i2c-1/1-0290:
> /sys/devices/platform/i2c-1/1-0290/power:
> /sys/devices/platform/i2c-1/power:
> 
> under 2.6.10:
> /sys/devices/platform/i2c-1:
> /sys/devices/platform/i2c-1/power:
> 
> So some /sys nodes are missing !!!
> (the isa bus)

This basically means that the i2c client was not registered.

> Debug output from 2.6.10-mm1:
> (...)
> Jan  7 01:33:11 werewolf kernel: i2c-core: driver w83627hf registered.
> Jan  7 01:33:11 werewolf kernel: i2c_adapter i2c-1: found normal isa entry for adapter 9191, addr 0290

However, this suggests that the driver loaded properly and the base 
address was correctly read from Super-I/O space. This would mean that 
the problem happened later, in w83627hf_detect(). The most likely reason 
for this would be if the region request failed (unfortunately we have no 
message, not even debug, if this happens).

> Some ideas ?

Three things to try, in order:

1* Compare /proc/ioports in 2.6.9-mm1 and 2.6.10-mm1. I suspect that the 
0x290-0x297 range is held by some device in 2.6.10-mm1.

2* Try reverting this patch in 2.6.10-mm1:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10/2.6.10-mm1/broken-out/bk-i2c.patch
It does indeed include a change in the way the I/O region is requested. 
It should not make any difference, but maybe we are missing something 
and it actually does.

3* Try a vanilla 2.6.10 kernel and report how it is going.

Thanks,
-- 
Jean Delvare
