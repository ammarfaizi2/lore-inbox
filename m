Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWFGSUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWFGSUt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 14:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWFGSUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 14:20:49 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:43394 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751213AbWFGSUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 14:20:47 -0400
Date: Wed, 7 Jun 2006 11:20:40 -0700
From: Don Fry <brazilnut@us.ibm.com>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] pcnet32 driver NAPI support
Message-ID: <20060607182040.GA12748@us.ibm.com>
References: <20060607165225.GB7859@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060607165225.GB7859@csclub.uwaterloo.ca>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 12:52:25PM -0400, Lennart Sorensen wrote:
> I have added NAPI support to the pcnet32 driver.  This has greatly
> improved the responsiveness on my systems (geode GX1 266MHz) when under
> heavy network load.  Without this change the system would become
> unresponsive due to interrupts when flooded with traffic, and eventually
> the watchdog would reboot the system due to the watchdog daemon being
> starved for cpu time.  With the patch the system is still useable on a
> serial console, although very slow.  Network throughput is also higher
> since more time is spend processing packets and getting them sent out,
> instead of only spending time acknowledging interrupts from incoming
> packets.
> 
> Now having never actually done a patch submission to the kernel before,
> I will try and see if I can do it right.
> 
> The patch adds a PCNET32_NAPI config option to drivers/net/Kconfig, and
> the appropriate code to support the option to drivers/net/pcnet32.c and
> has been tested on many of my systems (allthough they are allmost all
> identical, and require some extra patches to pcnet32 due to not having
> an EEPROM installed), and on an AT-2700TX.
> 
> I have made a diff against 2.6.16.20 and 2.6.17-rc6.
> 
> Comments would be very welcome.

I am also working on a NAPI version of the pcnet32 driver for many of
the same reasons, and will compare what you have with my own
implementation.  I probably won't be able to do much until Friday.  

Just a couple of comments.  I am adding netdev@vger.kernel.org to the cc
list, as most network driver discussion is done here rather than lkml.
linux-kernel (and linux-net) should be deleted in future replies.

The 2.6.17-rc6 would be the correct source to patch against.  Since this
is an enhancement it will not come out till 2.6.18.

I would not change the driver name from pcnet32 to pcnet32napi, but I
would changes the version from 1.32 to 1.33NAPI or something like that.

Some areas of concern that you may have addressed already, I have not
scanned your changes yet, are what happens if the ring size is changed
without bringing down the interface (via ethtool), or if the loopback
test is run in a similar fashion, or a tx timeout occurs.

The lp->lock MUST be held whenever accessing the csr or bcr registers as
this is a multi-step process, and has been the source of problems in the
past.  Even on UP systems.

> 
> Signed-off-by: Len Sorensen <lsorense@csclub.uwaterloo.ca>
> 
> Len Sorensen

-- 
Don Fry
brazilnut@us.ibm.com
