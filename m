Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968298AbWLEPXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968298AbWLEPXa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 10:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968297AbWLEPXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 10:23:30 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:54228 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968290AbWLEPX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 10:23:29 -0500
Date: Tue, 5 Dec 2006 18:19:06 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Steve Wise <swise@opengridcomputing.com>
Cc: Roland Dreier <rdreier@cisco.com>, netdev@vger.kernel.org,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH  v2 04/13] Connection Manager
Message-ID: <20061205151905.GA18275@2ka.mipt.ru>
References: <20061202224917.27014.15424.stgit@dell3.ogc.int> <20061202224958.27014.65970.stgit@dell3.ogc.int> <20061204110825.GA26251@2ka.mipt.ru> <ada8xhnk6kv.fsf@cisco.com> <20061205050725.GA26033@2ka.mipt.ru> <1165330925.16087.13.camel@stevo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1165330925.16087.13.camel@stevo-desktop>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 05 Dec 2006 18:19:08 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 09:02:05AM -0600, Steve Wise (swise@opengridcomputing.com) wrote:
> > >  > This and a lot of other changes in this driver definitely says you
> > >  > implement your own stack of protocols on top of infiniband hardware.
> > > 
> > > ...but I do know this driver is for 10-gig ethernet HW.
> > 
> > It is for iwarp/rdma from description.
> > If it is 10ge, then why does it parse incomping packet headers and
> > implements initial tcp state machine?
> > 
> 
> Its not implementing the TCP state machine at all. Its implementing the
> MPA state machine (see the iWARP internet drafts).  These packets are
> TCP payload.  MPA is used to negotiate RDMA mode on a TCP connection.
> This entails an exchange of 2 messages on the TCP connection.  Once this
> is exchanged and both side agree, the connection is bound to an RDMA QP
> and the connection moved into RDMA mode.  From that point on, all IO is
> done via the post_send() and post_recv().

And why does rdma require window scaling, keep alive, nagle and other
interesting options from TCP spec?

This really looks like initial implementation of TCP in hardware - you
setup flags like doing the same using setsockopt() and then hardware
manages the flow like network stack manages TCP state machine changes.

According to draft-culley-iwarp-mpa-03.txt this layer can do a lot of
things with valid TCP flow like

   5.  The TCP sender puts the FPDUs into the TCP stream.  If the TCP
       Sender is MPA-aware, it segments the TCP stream in such a way
       that a TCP Segment boundary is also the boundary of an FPDU.  
       TCP then passes each segment to the IP layer for transmission.

Phrases like "MPA-aware TCP" rises a lot of questions - briefly saying
that hardware (even if it is called ethernet driver) can create and work
with own TCP flows potentially modified in the way it likes which is seen 
in driver. Likely such flows will not be seen by upper layers like OS 
network stack according to hardware descriptions.

Is it correct?

> Steve. 

-- 
	Evgeniy Polyakov
