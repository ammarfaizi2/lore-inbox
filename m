Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVALWh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVALWh2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVALWhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:37:25 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:17282 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id S261486AbVALWep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:34:45 -0500
Message-ID: <41E5A5DA.1010301@qualcomm.com>
Date: Wed, 12 Jan 2005 14:34:02 -0800
From: Max Krasnyansky <maxk@qualcomm.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davem@davemloft.net, akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [BK] TUN/TAP driver update and fixes for 2.6.BK
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave, Andrew,

Could one of you please pull TUN/TAP driver updates from my tree
         bk://maxk.bkbits.net/tun-2.6

This will update the following files:

  drivers/net/Kconfig    |    1
  drivers/net/tun.c      |  145 ++++++++++++++++++++++++++++++++++++++++++-------
  include/linux/if_tun.h |    2
  3 files changed, 128 insertions(+), 20 deletions(-)

through these ChangeSets:

<maxk@qualcomm.com> (05/01/12 1.2379)
    [TUN] Add a missing dependency on enabling the crc32 libraries

    Patch by Steve French <smfltc@us.ibm.com>

    Signed-off-by: Max Krasnyansky <maxk@qualcomm.com>

<maxk@qualcomm.com> (04/12/23 1.1938.458.6)
    Use random_ether_addr() to generate TAP MAC address.

    Signed-off-by: Mark Smith <markzzzsmith@yahoo.com.au>
    Signed-off-by: Max Krasnyansky <maxk@qualcomm.com>

<maxk@qualcomm.com> (04/12/23 1.1938.458.5)
    TUN/TAP driver packet queuing fixes and improvements

    Patch from Harald Roelle <harald.roelle@nm.ifi.lmu.de>

    Fixes for the following issues
    - "Kicking" packet behavior in case of kernel packet scheduler (! TUN_ONE_QUEUE):
      When the netif queue is stopped because of an overrun of the driver's queue,
      no new packets are delivered to the driver until a new packet arrives, not even
      when in the meantime there's again space in the driver's queue (gained by a
      reading user process). In short, whenever netif queue was stopped, one needs an
      additional packet to "kick" packet delivery to the driver.
      The reason for this is, that the netif queue is started but not woken up, i.e.
      the rest of the kernel is not signaled to resume packet delivery.

    - Adjustment of tx queue length by ifconfig has only effect when TUN_ONE_QUEUE
      is set.  Otherwise always constant TUN_READQ_SIZE queue length is used.

    - TX queue default length setting is not consistent:
      o TAP dev + TUN_ONE_QUEUE: 1000 (by ether_setup())
      o all other cases: 10

    - Default tx queue length is too short in many cases.
      IMHO it should be at least twice as long as the number of fragments needed
      for a maximum sized IP packet at a "typical" MTU size.
      This would ensure that at least one complete IP packet can be delivered
      to the attached user space process, even if the packet's fragments
      are "misaligned" in the buffer and the user process is not scheduled
      in time to read the queue.

    Additional modifications:

    - To signal that stopping of the queue has occurred, the tx fifo overrun
      counter is increased.

    - Implemented ethtool api. Primarily added to have a standard method requesting
      the driver version.

    Signed-off-by: Max Krasnyansky <maxk@qualcomm.com>


Thanks
Max
