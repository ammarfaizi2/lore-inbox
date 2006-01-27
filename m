Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWA0Pgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWA0Pgn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 10:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWA0Pgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 10:36:43 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:43449 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751113AbWA0Pgm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 10:36:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EOwDFUiyGHWLrj06rJ41B+lgImJsM4QD/p8wqiVXAkEf3xis95xwpIDkao5b+vtae3G1Li6q5YURcqmvA7IE0PzhFb0mXlRlEtOOSU6Q977FvQ3bev1crtj2BmjMMylMjDbBEDMX4p4KPfB9a4a7IxYVO0z97QVmKRX7tGOk7W0=
Message-ID: <58d0dbf10601270736o3381d4fbt@mail.gmail.com>
Date: Fri, 27 Jan 2006 16:36:39 +0100
From: Jan Kiszka <jan.kiszka@googlemail.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Subject: Re: [patch 0/9] Critical Mempools
Cc: Benjamin LaHaise <bcrl@kvack.org>,
       Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org,
       sri@us.ibm.com, andrea@suse.de, pavel@suse.cz, linux-mm@kvack.org
In-Reply-To: <43D968E4.5020300@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1138217992.2092.0.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0601260954540.15128@schroedinger.engr.sgi.com>
	 <43D954D8.2050305@us.ibm.com>
	 <Pine.LNX.4.62.0601261516160.18716@schroedinger.engr.sgi.com>
	 <43D95BFE.4010705@us.ibm.com> <20060127000304.GG10409@kvack.org>
	 <43D968E4.5020300@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/1/27, Matthew Dobson <colpatch@us.ibm.com>:

> The impetus for this work was getting this functionality into the
> networking stack, to keep the network alive under periods of extreme VM
> pressure.  Keeping track of 'criticalness' on a per-socket basis is good,
> but the problem is the receive side.  Networking packets are received and
> put into skbuffs before there is any concept of what socket they belong to.
>  So to really handle incoming traffic under extreme memory pressure would
> require something beyond just a per-socket flag.

Maybe as an interesting lecture you want study how we handle this in
the deterministic network stack RTnet (www.rtnet.org): exchange full
with empty (rt-)skbs between per-user packet pools. Every packet
producer or consumer (socket, NIC, in-kernel networking service) has
its own pool of pre-allocated, fixed-sized packets. Incoming packets
are first stored at the expense of the NIC. But as soon as the real
receiver is known, that one has to pass over an empty buffer in order
to get the full one. Otherwise, the packet is dropped. Kind of hard
policy, but it prevents any local user from starving the system with
respect to skbs. Additionally for full determinism, remote users have
to be controlled via bandwidth management (to avoid exhausting the
NIC's pool), in our case a TDMA mechanism.

I'm not suggesting that this is something easy to adopt into a general
purpose networking stack (this is /one/ reason why we maintain a
separate project for it). But maybe the concept can inspire something
in this direction. Would be funny to have "native" RTnet in the kernel
one day :). Separate memory pools for critical allocations is an
interesting step that may help us as well.

Jan
