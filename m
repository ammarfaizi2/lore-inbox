Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbVDYIrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbVDYIrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 04:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVDYIrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 04:47:14 -0400
Received: from post.arx.com ([212.25.66.95]:33800 "EHLO post.arx.com")
	by vger.kernel.org with ESMTP id S262536AbVDYIrC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 04:47:02 -0400
Content-class: urn:content-classes:message
Subject: Re-routing packets via netfilter (ip_rt_bug)
Date: Mon, 25 Apr 2005 11:49:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <4151C0F9B9C25C47B3328922A6297A3286CF98@post.arx.com>
X-MS-Has-Attach: 
X-Mimeole: Produced By Microsoft Exchange V6.5.7226.0
X-MS-TNEF-Correlator: 
Thread-Topic: Re-routing packets via netfilter (ip_rt_bug)
Thread-Index: AcVJfBZewIqcR758TSSGAn/RnX9zJQ==
From: "Yair Itzhaki" <Yair@arx.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Summary:
While traversing packets through Netfilter, changing dest address from a foreign to a local address causes the packet to drop (and show up at ip_rt_bug(), along a syslog entry).

* Description:
I'm using libipq/ip_tables and ip_queue to trap packets to a userspace VPN product, using nothing but standard kernel modules (and my own VPN proxy app).

The packets flowing into or out of the machine get diverted to a userspace application, src/dest addresses are modified, and injected back into the IP stack. 

For example, an outgoing packet (that has a foreign dest addr) is overridden with a local dest address, hoping it would end up at the local VPN listener. 

Under kernel 2.4 this works fine.
In 2.6 it breaks. 

* Details:
An outgoing packet (has a non-local dest addr) is queued and recognized at the ip_queue userspace app. Its dest addr+port are set to that of the local machine (to get to my userspace VPN app).
The modified packet is marked NF_ACCEPT and sent back into the kernel, but ends up at the ip_rt_bug function (with a syslog entry).

* Assumed bug analysis:
Due to the destination address change, the packet needed to go through routing once again, since it's no longer an outgoing packet.
This does happen in the ip_route_me_harder function, which sets the dst->output to point at ip_rt_bug.
Since this was an outgoing packet (in the NF_IP_LOCAL_OUT chain), the final operation done on the packet is calling the *okfn function, which points to dst->output which is ip_rt_bug.

I would have expected the routing function to realize it needs to re-evaluate the route, and set the *okfn to dst->input instead.

* Kernel version:
2.6.9-prep, (Red Hat 3.4.2-6.fc3) compiled locally with no modifications.

Please advise (and please CC "YAIR at ARX.COM")

A similar problem has been reported a while back but never replied (http://groups-beta.google.com/group/linux.kernel/msg/455c04e17e354d04?dmode=source&hl=en)


Yair
