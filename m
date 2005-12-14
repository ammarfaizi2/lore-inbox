Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVLNJMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVLNJMZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 04:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVLNJMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 04:12:25 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:46289 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932228AbVLNJMY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 04:12:24 -0500
Date: Wed, 14 Dec 2005 01:12:23 -0800 (PST)
From: Sridhar Samudrala <sri@us.ibm.com>
X-X-Sender: sridhar@w-sridhar.beaverton.ibm.com
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
Message-ID: <Pine.LNX.4.58.0512140042280.31720@w-sridhar.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These set of patches provide a TCP/IP emergency communication mechanism that
could be used to guarantee high priority communications over a critical socket
to succeed even under very low memory conditions that last for a couple of
minutes. It uses the critical page pool facility provided by Matt's patches
that he posted recently on lkml.
	http://lkml.org/lkml/2005/12/14/34/index.html

This mechanism provides a new socket option SO_CRITICAL that can be used to
mark a socket as critical. A critical connection used for emergency
communications has to be established and marked as critical before we enter
the emergency condition.

It uses the __GFP_CRITICAL flag introduced in the critical page pool patches
to indicate an allocation request as critical and should be satisfied from the
critical page pool if required. In the send path, this flag is passed with all
allocation requests that are made for a critical socket. But in the receive
path we do not know if a packet is critical or not until we receive it and
find the socket that it is destined to. So we treat all the allocation
requests in the receive path as critical.

The critical page pool patches also introduces a global flag
'system_in_emergency' that is used to indicate an emergency situation(could be
a low memory condition). When this flag is set any incoming packets that belong
to non-critical sockets are dropped as soon as possible in the receive path.
This is necessary to prevent incoming non-critical packets to consume memory
from critical page pool.

I would appreciate any feedback or comments on this approach.

Thanks
Sridhar
