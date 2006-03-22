Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751945AbWCVBk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbWCVBk6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 20:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbWCVBk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 20:40:57 -0500
Received: from test-iport-1.cisco.com ([171.71.176.117]:31337 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751945AbWCVBk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 20:40:56 -0500
To: "Sean Hefty" <sean.hefty@intel.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <openib-general@openib.org>
Subject: Re: [PATCH 6/6 v2] IB: userspace support for RDMA connection manager
X-Message-Flag: Warning: May contain useful information
References: <ORSMSX4011XvpFVjCRG0000000f@orsmsx401.amr.corp.intel.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 21 Mar 2006 17:40:54 -0800
In-Reply-To: <ORSMSX4011XvpFVjCRG0000000f@orsmsx401.amr.corp.intel.com> (Sean Hefty's message of "Mon, 6 Mar 2006 15:41:14 -0800")
Message-ID: <adawten6yu1.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 22 Mar 2006 01:40:56.0052 (UTC) FILETIME=[A9A57340:01C64D51]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I added this patch to the rdma_cm branch in my git tree.  When I was
doing that, I noticed that it builds rdma_ucm.ko unconditionally.  It
seems that we want this to depend on CONFIG_INFINIBAND_USER_ACCESS,
since that controls ib_uverbs.ko and ib_ucm.ko.

To do this I rejiggered the Kconfig and Makefile changes I made
before.  I made CONFIG_INFINIBAND_ADDR_TRANS into a bool (instead of a
tristate), so that it's 'y' if INFINIBAND and INET are on, and made
the top of the Makefile look like:

infiniband-$(CONFIG_INFINIBAND_ADDR_TRANS)	:= ib_addr.o rdma_cm.o
user_access-$(CONFIG_INFINIBAND_ADDR_TRANS)	:= rdma_ucm.o

obj-$(CONFIG_INFINIBAND) +=		ib_core.o ib_mad.o ib_sa.o \
					ib_cm.o $(infiniband-y)
obj-$(CONFIG_INFINIBAND_USER_MAD) +=	ib_umad.o
obj-$(CONFIG_INFINIBAND_USER_ACCESS) +=	ib_uverbs.o ib_ucm.o $(user_access-y)

I'm pretty sure this does exactly what we want.

 - R.
