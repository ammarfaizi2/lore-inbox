Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbTFPFe6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 01:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTFPFe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 01:34:58 -0400
Received: from sj-core-5.cisco.com ([171.71.177.238]:51660 "EHLO
	sj-core-5.cisco.com") by vger.kernel.org with ESMTP id S263365AbTFPFe4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 01:34:56 -0400
Message-Id: <5.1.0.14.2.20030616154156.0253dc98@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 16 Jun 2003 15:47:13 +1000
To: Zwane Mwaikambo <zwane@linuxpower.ca>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: 64-bit fields in struct net_device_stats
Cc: Jeff <jeffpc@optonline.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.50.0306152309220.32020-100000@montezuma.mastece
 nde.com>
References: <200306152253.36768.jeffpc@optonline.net>
 <200306152131.09983.jeffpc@optonline.net>
 <200306152253.36768.jeffpc@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:12 PM 15/06/2003 -0400, Zwane Mwaikambo wrote:
> > suggested to use per cpu stats and overflow into a global counter. (Thanks
> > Zwane) This might be a better idea - the problem is, the counter won't be
> > 100% accurate at all times. The degree of inaccuracy will vary with the
> > threshold value. On the other hand, if the threshold is relatively low, no
> > one will notice the difference these days.
>
>This would be one method of doing updates and for stats it would be fine,
>however feel free to look into other ways...

why not a set of counters which are toggled between.

e.g.
         struct netdevice... {
           uint64        tx_pkts_counter[2];
           uint64 tx_octets_counter[2];
           uint64        rx_pkts_counter[2];
           uint64 rx_octets_counter[2];
           int counter_bounce;
         ...
         }


where readers simply do something like:
         tx_bytes += 
netdevice[foo]->tx_octets_counter[(netdevice[foo]->counter_bounce)];

and writer(s) alternate between updating one uint64 and an alternate one?

in this manner, you don't need to do any special synchronization or atomic 
updates or have any dependency on any particular architecture being able to 
do atomic 64-bit ops.


cheers,

lincoln.

