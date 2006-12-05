Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968501AbWLERc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968501AbWLERc4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 12:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968502AbWLERc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 12:32:56 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:52271 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968501AbWLERcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 12:32:55 -0500
Date: Tue, 5 Dec 2006 20:32:22 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Steve Wise <swise@opengridcomputing.com>
Cc: Roland Dreier <rdreier@cisco.com>, netdev@vger.kernel.org,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH  v2 04/13] Connection Manager
Message-ID: <20061205173221.GB24149@2ka.mipt.ru>
References: <ada8xhnk6kv.fsf@cisco.com> <20061205050725.GA26033@2ka.mipt.ru> <1165330925.16087.13.camel@stevo-desktop> <20061205151905.GA18275@2ka.mipt.ru> <1165333198.16087.53.camel@stevo-desktop> <20061205155932.GA32380@2ka.mipt.ru> <1165335162.16087.79.camel@stevo-desktop> <20061205163008.GA30211@2ka.mipt.ru> <1165337245.16087.95.camel@stevo-desktop> <20061205172649.GA20229@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061205172649.GA20229@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 05 Dec 2006 20:32:23 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 08:26:49PM +0300, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> On Tue, Dec 05, 2006 at 10:47:25AM -0600, Steve Wise (swise@opengridcomputing.com) wrote:
> > > And if there were a dataflow between addr/port a.b to addr/port c.d
> > > already, it will either terminated?
> > > 
> > > Considering the following sequence:
> > > handlers->t3c_handlers->sched()->work_queue->work_handlers()->for
> > > example CPL_PASS_ACCEPT_REQ->pass_accept_req() - it just parses incoming
> > > skb and sets port/addr/route and other fields to be used as a base for rdma
> > > connection. What if it just a usual network packet from kernelspace or 
> > > userspace with the same payload as should be sent by remote rdma system?
> > > 
> > 
> > That skb isn't a network packet.  Its a CPL_PASS_ACCEPT_REQ message (see
> > struct cpl_pass_accept_req in the Ethernet driver t3_cpl.h).  If the
> > RDMA driver hadn't registered to listen on that addr/port, it would
> > never get this skb.  Once a connection is established, the MPA messages
> > (and any TCP payload data) is delivered to the RDMA driver in the form
> > of skb's containing struct cpl_rx_data.  So these skbs aren't just TCP
> > packets at all.  They either control messages or TCP payload. Either way
> > they are encapsulated in CPL message structures.
> > 
> > Does this make sense?
>  
> Almost - except the case about where those skbs are coming from?
> It looks like they are obtained from network, since it is ethernet
> driver, and if they match some set of rules, they are considered as valid 
> MPA negotiation protocol.
> 
> If it is correct, it means that any packet in the network can be
> potentially 'stolen' by rdma hardware, although it was part of the usual
> dataflow. 
> If that packets are not from ethernet network, but from different
> low-level, then there is a question (besides why this driver is called
> ethernet if it manages different hardware) about how connection over
> that different media is being setup and since packets contain perfectly
> valid IP addresses and ports.

It looks like I've answered myself - it is _not_ ethernet driver, but
rdma one, and although it gets all data through skbs from ethernet
driver, the latter gets them not from ethernet network.
And thus addresses and ports and all other information can not be mixed
between the two.

-- 
	Evgeniy Polyakov
