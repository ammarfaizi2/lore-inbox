Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946510AbWJTVBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946510AbWJTVBl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946504AbWJTVBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:01:41 -0400
Received: from ns2.suse.de ([195.135.220.15]:59564 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1946488AbWJTVBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:01:40 -0400
From: Andi Kleen <ak@suse.de>
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH 2/3] netpoll: rework skb transmit queue
Date: Fri, 20 Oct 2006 23:01:29 +0200
User-Agent: KMail/1.9.3
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20061019171814.281988608@osdl.org> <20061020.134209.85688168.davem@davemloft.net> <20061020134826.75dd1cba@freekitty>
In-Reply-To: <20061020134826.75dd1cba@freekitty>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610202301.29859.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But, it also violates the assumptions of the network devices.
> It calls NAPI poll back with IRQ's disabled and potentially doesn't
> obey the semantics about only running on the same CPU as the
> received packet.

netpoll always played a little fast'n'lose with various locking rules.
Also often inside the drivers are a little sloppy in the poll path.

That's fine for getting an oops out, but risky for normal kernel
messages when the driver must be still working afterwards.

The standard console code makes this conditional on oops_in_progress -
it breaks locks when true and otherwise it follows the safe
approach.

Perhaps it would be better to use different paths in netconsole too 
depending  on whether oops_in_progress is true or not.  

e.g. if !oops_in_progress (use the standard output path)
else use current path.

That would avoid breaking the driver during normal operation
and also have the advantage that the normal netconsole messages
would go through the queueing disciplines etc.

-Andi
