Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWHPXsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWHPXsb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 19:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWHPXsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 19:48:31 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:33439 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932123AbWHPXsa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 19:48:30 -0400
Date: Wed, 16 Aug 2006 18:47:28 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, akpm@osdl.org, jeff@garzik.org,
       netdev@vger.kernel.org, jklewis@us.ibm.com,
       linux-kernel@vger.kernel.org, Jens.Osterkamp@de.ibm.com,
       David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
Message-ID: <20060816234728.GP20551@austin.ibm.com>
References: <44E34825.2020105@garzik.org> <200608162324.47235.arnd@arndb.de> <20060816225558.GM20551@austin.ibm.com> <200608170103.21097.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608170103.21097.arnd@arndb.de>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 01:03:20AM +0200, Arnd Bergmann wrote:
> 
> Could well be related to latencies when going to the remote
> node for descriptor DMAs. Have you tried if the hch's NUMA
> patch or using numactl makes a difference here?

No. I guess I should try.

> > > sounds like the right approach to simplify the code.
> >
> > Its not a big a driver. 'wc' says its 2.3 loc, which
> > is 1/3 or 1/5 the size of tg3.c or the e1000*c files.
> 
> Right, I was thinking of removing a lock or another, not
> throwing out half of the driver ;-)

There's only four lock points grand total. 
-- One on the receive side,
-- one to protect the transmit head pointer, 
-- one to protect the transmit tail pointer, 
-- one to protect the location of the transmit low watermark.

The last three share the same lock. I tried using distinct
locks, but this worsened things, probably due to cache-line 
trashing. I tried removing the head pointer lock, but this
failed. I don't know why, and was surprised by this. I thought
hard_start_xmit() was serialized.

--linas
