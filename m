Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbVAUCpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVAUCpX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 21:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbVAUCpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 21:45:23 -0500
Received: from ozlabs.org ([203.10.76.45]:31688 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262237AbVAUCpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 21:45:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16880.28170.976516.285336@cargo.ozlabs.ibm.com>
Date: Fri, 21 Jan 2005 13:50:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: anton@samba.org, akpm@osdl.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64: EEH Recovery
In-Reply-To: <20050120223916.GJ9140@austin.ibm.com>
References: <20050106192413.GK22274@austin.ibm.com>
	<20050117201415.GA11505@austin.ibm.com>
	<16877.63693.915740.385920@cargo.ozlabs.ibm.com>
	<20050120223916.GJ9140@austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas writes:

> > 2. I don't see why the device nodes for the PCI subtree being reset
> >    would go away, and thus I don't see the need for your eeh_cfg_tree
> >    struct.
> 
> Its not the reset, its the hot-plug remove.  The hot plug code assumes
> that you are going to physically remove the device from the slot, so
> it removes the device_node as part of the "unconfig".  

OK, I missed that.  It seems a bit bogus to me.  Could you point me at
where in the code this happens?

> > 3. Is there a good reason why we can't use the assigned-addresses
> >    property on the relevant device tree nodes to tell us what to set
> >    the BARs to?
> 
> Yes, the reason is that after a reset, that property doesn't hold any 
> decent data.   I discussed this with the firmware developers, and thier 
> response was that it is the kernel's responsibility to compute 
> (or save/restore) such values.  (Except for bridges, which they will do for us).

The not holding any decent data is a consequence of the device nodes
getting thrown away, isn't it?  I fail to see how resetting the device
can of itself affect our copy of the device tree.

> > In particular I think it should be a
> >    userland write to a sysfs file that kicks off the restart process
> >    rather than it just happening after 5 seconds.  Anyway, what
> >    process or thread is executing that 5 second sleep?  Is it keventd
> >    or something?
> 
> Its a workqueue.

Which get run in keventd's context.  In other words no other
workqueues will get run during the 5 second sleep, or at least not on
that cpu.

Paul.
