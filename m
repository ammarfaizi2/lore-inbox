Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbTHXQc1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 12:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbTHXQc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 12:32:27 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:62095 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261277AbTHXQb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 12:31:58 -0400
Message-ID: <3F48E870.2070205@colorfullife.com>
Date: Sun, 24 Aug 2003 18:31:44 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vinay K Nallamothu <vinay-rc@naturesoft.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.0-test4][NET] ni5010.c: remove cli/sti
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vinay wrote:

>drivers/net/ni5010.c:
>This patch replaces cli/sti with spinlocks. Compiles fine though
>untested.
>  
>
I don't have the hardware either, but the patch seems to be wrong:
The cli() call was in hardware_send_packet(). I assume that this 
function should be synchronized against concurrent interrupts - both 
functions access the hardware. Due to the dev_xmit_lock, the networking 
core already guarantees that hardware_send_packet is never reentered. 
cli() provided protection against concurrent interrupts on other cpus, 
spin_lock_irqsave() doesn't.

Could you add a spin_lock()/spin_unlock() into ni5010_interrupt?

--
    Manfred

