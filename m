Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVASGBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVASGBW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 01:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVASGBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 01:01:22 -0500
Received: from ozlabs.org ([203.10.76.45]:1965 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261595AbVASGBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 01:01:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16877.63693.915740.385920@cargo.ozlabs.ibm.com>
Date: Wed, 19 Jan 2005 17:06:05 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: anton@samba.org, akpm@osdl.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64: EEH Recovery
In-Reply-To: <20050117201415.GA11505@austin.ibm.com>
References: <20050106192413.GK22274@austin.ibm.com>
	<20050117201415.GA11505@austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas writes:

> p.s.  It was not clear to me if the EEH patch previously sent 
> (6 January 2005, same subject line) will be wending its way into 
> the main Torvalds kernel tree, or not.  I hadn't really gotten
> confirmation one way or another.

I'm not really totally happy with it yet, on a number of fronts:

1. You're adding more PCI-specific stuff to the device_node struct,
   which I don't like.  I would prefer that the device_node tree
   contains basically just what we get from OF, and that we have a
   separate struct for storing ppc64-specific information for each PCI
   device.  Fixing that is outside the scope of your patch, though.

2. I don't see why the device nodes for the PCI subtree being reset
   would go away, and thus I don't see the need for your eeh_cfg_tree
   struct.

3. Is there a good reason why we can't use the assigned-addresses
   property on the relevant device tree nodes to tell us what to set
   the BARs to?

4. I think the 5 second sleep is quite bogus, and shows that we have
   the flow of control wrong.  In particular I think it should be a
   userland write to a sysfs file that kicks off the restart process
   rather than it just happening after 5 seconds.  Anyway, what
   process or thread is executing that 5 second sleep?  Is it keventd
   or something?

5. AFAICS userland will get an unplug notification for the device, but
   nothing to indicate that is due to an EEH slot isolation event.  I
   think userland should be told about EEH events.

Regards,
Paul.

