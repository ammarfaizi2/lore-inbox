Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267620AbUH0Tm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267620AbUH0Tm4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 15:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267566AbUH0Tdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 15:33:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27786 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267540AbUH0T2i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 15:28:38 -0400
Message-ID: <412F8B58.4040905@pobox.com>
Date: Fri, 27 Aug 2004 15:28:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Santiago Leon <santil@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] POWER5 Virtual Ethernet Checkum offload
References: <412F85B7.1060804@us.ibm.com>
In-Reply-To: <412F85B7.1060804@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Santiago Leon wrote:
> Andrew,
> 
> The following patch adds checksum offloading for the POWER5 Virtual 
> Ethernet driver.  In the case where the OS in the partitions 
> communicating support this feature (i.e. both partition have this patch 
> applied), no checksum will be created because the link is reliable. 
> However, in the case where one of the OS in a partition does support 
> this feature and the other doesn't (i.e. linux with patch applied 
> talking to AIX), then the hypervisor will generate the checksum.
> 
> Some levels of firmware will not support this feature but the code will 
> figure it out and not enable it.
> 
> Applies against the latest mainline and -mm trees. Please apply.

First, please always CC net driver patches to me and netdev@oss.sgi.com.

Second, this patch is incorrect.  Read the top of include/linux/skbuff.h 
for the various levels of checksum offloading, and how to use them.

Specifically,

a) you should not be using CHECKSUM_HW unless your hardware provides a 
valid csum (ipv4 or ipv6) that you store in skb->csum.

b) you should not be using NETIF_F_HW_CSUM for reasons similar to (a): 
your hardware must be able to csum the packet whether its ipv4 or ipv6 
or whatever, given the information in the skb.

c) use of NETIF_F_xxx_CSUM is pointless without NETIF_F_SG and code in 
the transmit path to handle page-based fragments (a scatter-gather list).

	Jeff





