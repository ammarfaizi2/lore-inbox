Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUDCLas (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 06:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbUDCLas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 06:30:48 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:25740 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261711AbUDCLaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 06:30:46 -0500
Message-ID: <406EA054.2020401@colorfullife.com>
Date: Sat, 03 Apr 2004 13:30:28 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Adam Nielsen <a.nielsen@optushome.com.au>
Subject: Re: [PATCH] Fix kernel lockup in RTL-8169 gigabit ethernet driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:

>The logic is faulty, or at least very odd.
>
>	tx_left = tp->cur_tx - dirty_tx;
>
>	while (tx_left > 0) {
>		int entry = dirty_tx % NUM_TX_DESC;
>
>		if (!(le32_to_cpu(tp->TxDescArray[entry].status) & OWNbit)) {
>			...
>		}
>	}
>
>Why is that `if' test there at all?  If it ever returns false, the box
>locks up.  A BUG_ON(le32_to_cpu(tp->TxDescArray[entry].status) & OWNbit)
>might make more sense.
>  
>
tx_left counts packets submitted by hard_xmit_start to the hardware. 
Initially OWNbit is set, the packet is owned by the nic. The OWNbit is 
cleared by the hardware after the packet was sent. A packet with OWNbit 
set means that the nic didn't send it yet to the wire. I think the "else 
break;" patch is correct, but someone with docs should confirm that.

Adam: did you see deadlocks that disappeared after applying your patch? 
It shouldn't deadlock - it should loop until the nic sends the packet to 
the wire. It might take a few msecs, but then it should continue. 
Perhaps gcc optimized away the reload from memory and loops on a 
register. Or there is another bug that is hidden by your patch.

--
    Manfred

