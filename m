Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbTEANN3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 09:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbTEANN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 09:13:29 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:21263 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id S261250AbTEANN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 09:13:28 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200305011327.OAA16943@gw.chygwyn.com>
Subject: Remains of seq_file conversion for DECnet, plus fixes
To: davem@redhat.com (David S. Miller)
Date: Thu, 1 May 2003 14:27:08 +0100 (BST)
Cc: linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20030421.234303.59654654.davem@redhat.com> from "David S. Miller" at Apr 21, 2003 11:43:03 PM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My latest DECnet patch for 2.5 has the following features:

  o Introduce kfree_release() in seq_file.c for use of DECnet and eventually
    IP as well (and other things...?)
  o Added proc_net_fops_create() like proc_net_create() but with file_operations
    argument to use with seq_file code (cleans up some #ifdefs). If there are
    no objections, I'll send a patch for IPv4/6 shortly.
  o Removed blksize from decnet device parameters - use the device mtu like we
    ought to.
  o Removed /proc/net/decnet_route file - I don't think anybody ever used it
    and it was lacking a full enough description of the routes to be useful.
    ip -D route list is much better :-)
  o Added rt_local_src entry to decnet routes so that we get the local source
    address right when forwarding.
  o Added netfilter subdir for decnet and add the routing grabulator
  o Added correct proto argument to struct flowi for routing
  o MSG_MORE in sendmsg (ignored, but accepted whereas before we'd error)
  o /proc/net/decnet converted to seq_file
  o /proc/net/decnet_dev converted to seq_file
  o /proc/net/decnet_cache converted to seq_file
  o Use pskb_may_pull() and add code to linearize skbs on the input path
    except for those containing data.
  o Fixed returned packet code (mostly - some left to do)
  o update_pmtu() method for decnet dst entries (ip_gre device assumes this
    method exists)
  o Fixed bug in forwarding to get IE bit set correctly
  o Fixed compile bugs with CONFIG_DECNET_ROUTE_FWMARK pointed out by Adrian
    Bunk
  o Fixed zero dest code to grab an address from loopback
  o Fixed local routes in dn_route_output_slow()
  o Fixed error case in dn_route_input/output_slow() pointed out by Rusty

Its got big again, so I've put it here, if you'd like it in bits rather than
all one lump, just shout:

http://www.chygwyn.com/~steve/kpatch/decnet/decnet-2.5.68-bk10-seqfile.diff

If you've been wondering when the routing in DECnet would reach the
stage where its actually likely to be useful, now is that time :-) We
don't yet have full automatic routing, but all the kernel infrastructure
is now in place and the rest can be done in userspace. In the mean time,
iproute2 can set up manual routes.

I'm going to write some docs and post them somewhere in the next few weeks
to give more detailed info on how to use the various features.

Steve.

