Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968268AbWLEPHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968268AbWLEPHe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 10:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968272AbWLEPHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 10:07:34 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:53597 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S968268AbWLEPHd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 10:07:33 -0500
Subject: Re: [PATCH  v2 04/13] Connection Manager
From: Steve Wise <swise@opengridcomputing.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Roland Dreier <rdreier@cisco.com>, netdev@vger.kernel.org,
       openib-general@openib.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061205051356.GA26845@2ka.mipt.ru>
References: <20061202224917.27014.15424.stgit@dell3.ogc.int>
	 <20061202224958.27014.65970.stgit@dell3.ogc.int>
	 <20061204110825.GA26251@2ka.mipt.ru> <ada8xhnk6kv.fsf@cisco.com>
	 <1165249251.32724.26.camel@stevo-desktop>
	 <20061205051356.GA26845@2ka.mipt.ru>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 09:07:33 -0600
Message-Id: <1165331253.16087.21.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-05 at 08:13 +0300, Evgeniy Polyakov wrote:
> On Mon, Dec 04, 2006 at 10:20:51AM -0600, Steve Wise (swise@opengridcomputing.com) wrote:
> > >  > This and a lot of other changes in this driver definitely says you
> > >  > implement your own stack of protocols on top of infiniband hardware.
> > > 
> > > ...but I do know this driver is for 10-gig ethernet HW.
> > > 
> > 
> > There is no SW TCP stack in this driver.  The HW supports RDMA over
> > TCP/IP/10GbE in HW and this is required for zero-copy RDMA over Ethernet
> > (aka iWARP).  The device is a 10 GbE device, not Infiniband.  The
> > Ethernet driver, upon which the rdma driver depends, acts both like a
> > traditional Ethernet NIC for the Linux stack as well as a TCP offload
> > device for the RDMA driver allowing establishment of RDMA connections.
> > The Connection Manager (patch 04/13) sends/receives messages from the
> > Ethernet driver that sets up HW TCP connections for doing RDMA.  While
> > this is indeed implementing TCP offload, it is _not_ integrating it with
> > the sockets layer nor the linux stack and offloading sockets
> > connections.  Its only supporting offload connections for the RDMA
> > driver to do iWARP.   The Ammasso device is another example of this
> > (drivers/infiniband/hw/amso1100).  Deep iSCSI adapters are another
> > example of this.
> 
> So what will happen when application will create a socket, bind it to
> that NIC, and then try to establish a TCP connection? How NIC will
> decide that received packets are from socket but not for internal TCP
> state machine handled by that device?

The HW knows which TCP connections are offloaded by virtue of the fact
that they were setup via the RDMA subsystem.  Any other TCP traffic (and
all other non TCP traffic) gets passed to the host stack.

> 
> As a side note, does all iwarp devices _require_ to have very
> limited TCP engine implemented it in its hardware, or it is possible
> to work with external SW stack?

It is possible, but not very interesting.

One could implement an all-software iWARP stack.  The iWARP protocols
are just TCP payload and _could_ be implemented in user mode on top of a
socket.  However, this isn't very interesting:  the goal of iWARP (and
RDMA for that matter) is to allow direct placement of data into user
memory with 0 copies done by the host CPU.  low latency.

Steve.


