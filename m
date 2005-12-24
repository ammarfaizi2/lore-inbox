Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVLXQIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVLXQIw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 11:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbVLXQIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 11:08:52 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:19637 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S932099AbVLXQIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 11:08:52 -0500
Message-ID: <43AD726A.5010703@colorfullife.com>
Date: Sat, 24 Dec 2005 17:08:10 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linus Torvalds <torvalds@osdl.org>, Ayaz Abdulla <AAbdulla@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] forcedeth: fix random memory scribbling bug
References: <43AD4ADC.8050004@colorfullife.com> <43AD64AB.2070306@pobox.com>
In-Reply-To: <43AD64AB.2070306@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Manfred Spraul wrote:
>
>> Two critical bugs were found in forcedeth 0.47:
>> - TSO doesn't work.
>> - pci_map_single() for the rx buffers is called with size==0. This 
>> bug is critical, it causes random memory corruptions on systems with 
>> an iommu.
>>
>> Below is a minimal fix for both bugs, for inclusion into 2.6.15.
>> TSO will be fixed properly in the next version.
>> Tested on x86-64.
>>
>> Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>
>
>
> 1) Why does forcedeth require a non-standard calculation for each 
> pci_map_single() call?
>
- skb->len is the wrong thing (tm), since it's 0 until skb_put().
- I have not found a field that contains the actual size of the data 
area of an skb.
- the results must be identical for map and unmap.
- I could recalculate the size of the allocation from np->rx_buf_sz, but 
I don't like that. Right now it would work, but it's too subtile that 
changing rx_buf_sz while there are outstanding rx buffers results in a 
iommu memory leak.
Therefore I decided to calculate the mapping size with "skb->end - 
skb->data": The size of the mapping for an skb is calculated by looking 
at fields in the skb, no knowledge about driver fields.

> 2) I have requested multiple times that you avoid MIME...
>
It's the first time that you complain about Content-Transfer-Encoding: 
7bit attachments.

> 3) Why disable TSO completely?  It sounds like it should default to 
> off, then permit enabling via ethtool.
>
The bugfix is in 0.49 - it's just a bit larger, I would consider it for 
2.5.16.

--
    Manfred
