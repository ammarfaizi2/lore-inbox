Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWACU0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWACU0f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWACU0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:26:13 -0500
Received: from hqemgate03.nvidia.com ([216.228.112.143]:47948 "EHLO
	HQEMGATE03.nvidia.com") by vger.kernel.org with ESMTP
	id S964784AbWACUZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:25:56 -0500
Message-ID: <3E346722.7070304@nvidia.com>
Date: Sun, 26 Jan 2003 17:54:26 -0500
From: Ayaz Abdulla <aabdulla@nvidia.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: manfred@dbl.q-ag.de, jgarzik@pobox.com, afu@fugmann.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] forcedeth: TSO fix for large buffers
References: <200512251451.jBPEpgNe018712@dbl.q-ag.de> <20051225.125742.65007619.davem@davemloft.net>
In-Reply-To: <20051225.125742.65007619.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jan 2006 20:25:39.0624 (UTC) FILETIME=[DCC4DA80:01C610A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you look at the code, I do not set the NV_TX2_VALID bit (stored in 
np->tx_flags) in the first tx descriptor until all other descriptors for 
this transmit are setup. This ensures hardware will not look at it. Once 
all fragments/descriptors are setup, I setup the control bits for the 
first tx descriptor. This includes any TSO (or checksum) info and the 
Valid bit. Hardware now knows that it is valid and can proceed.


David S. Miller wrote:
> From: Manfred Spraul <manfred@dbl.q-ag.de>
> Date: Sun, 25 Dec 2005 15:51:42 +0100
> 
>  > This patch contains a bug fix for large buffers. Originally, if a tx
>  > buffer to be sent was larger then the maximum size of the tx descriptor,
>  >
>  > it would overwrite other control bits. In this patch, the buffer is
>  > split over multiple descriptors. Also, the fragments are now setup in
>  > forward order.
>  >
>  > Signed-off-by: Ayaz Abdulla <aabdulla@nvidia.com>
>  >
>  > Rediffed against forcedeth 0.48
>  > Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>
> 
> Are you sure it's ok to setup the tx descriptors in that order?
> 
> Usually, you need to set them up last to first so that the chip
> doesn't see a half-filled-in set of TX descriptors.  Ie. the
> core question is if the chip can scan the TX descriptors looking
> for valid ones all on it's own after processing existing TX
> descriptors, or do you have to explicitly allow the chip look
> at the newly added TX descriptor with a register write or similar?
> 
