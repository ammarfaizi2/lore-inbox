Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270501AbTGXGZx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 02:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271101AbTGXGZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 02:25:53 -0400
Received: from fmr06.intel.com ([134.134.136.7]:18160 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S270501AbTGXGZj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 02:25:39 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [IPSEC] proposal for PMTU handling in IPSec for IPv4
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Date: Thu, 24 Jul 2003 14:40:43 +0800
Message-ID: <3AA03342E913FA4BA6D8BD0732BFC74B020F44BB@pdsmsx402.pd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [IPSEC] proposal for PMTU handling in IPSec for IPv4
Thread-Index: AcNQV8psKtgUJeh8TGql03EiJzCAjgBUIEsQ
From: "Zhao, Forrest" <forrest.zhao@intel.com>
To: <kuznet@ms2.inr.ac.ru>
Cc: "David S. Miller" <davem@redhat.com>,
       "linux-net" <linux-net@vger.kernel.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Jul 2003 06:40:43.0554 (UTC) FILETIME=[81837020:01C351AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alexey

Thanks for your reply!

> 3 Every time the source output the data packet, it should check each
SA
> associated with the specific secure policy. If it find any one
> xfrm_state has the meaningful pmtu value, then it should calculate the
> resulting PMTU and send  <<ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED>>
message
> to the real source in the secure policy selector. This checking point
> should be in function: dst_output();.

I am not so sure about this.

First (and a bit different) thing: pmtus of SAs should be taken into
account when we calculate dst->pmtu. So, each pmtu event should cause
recalculation of dst->pmtu on the bundle. It is necessary, when
tunnel is used for locally generated packets, we should prepare
good frames which will not fail while being transformed.

I think I must have overlooked something, but I can't figure out why it
is necessary to recalculate dst->pmtu on the bundle when each pmtu event
occurs. What's the special aspects related with dealing with locally
tunneled packets? Thank you very much for your detailed explanation.

The second thing is painful. We have to send icmp for original packet
as it entered our host. So, pmtu checks at each trnasformations is
not so easy. There are two variants: one was suggested by Dave,
namely, we store required 8 octets of original skb somewhere in skb head
and proceed like you proposed, checking that transformed skb still fits
to pmtu. The second variant is just to check against precaluclated
dst->pmtu on the entry to dst_output() before doing transformations.
Logically it is cleaner, it is simpler and faster, but it will result
in underestimation of mtu for esp due to alignment paddings and for
IPCOMP it will be totally unfair.

Actually, it was the point where Dave, James and me stopped.
Dave's variant looks more promising.

I agree with you and vote for Dave's variant! I omitted the alignment
padding issues previously.

Then since Dave's variant is a good solution for handling PMTU in IPsec
for IPv4, do you think it's appropriate if I write some patches for it
now? Is there any other tricky issue to be resolved for handling PMTU in
IPsec for IPv4 until now?




Thanks,
Forrest
