Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbTFQUco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 16:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264938AbTFQUco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 16:32:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39641 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264929AbTFQUcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 16:32:42 -0400
Date: Tue, 17 Jun 2003 13:42:06 -0700 (PDT)
Message-Id: <20030617.134206.133917056.davem@redhat.com>
To: girouard@us.ibm.com
Cc: garzik@pobox.com, shemminger@osdl.org, Valdis.Kletnieks@vt.edu,
       stekloff@us.ibm.com, lkessler@us.ibm.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: patch for common networking error messages
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <OF296D6F92.1C7252A9-ON85256D48.00713BCF@us.ibm.com>
References: <OF296D6F92.1C7252A9-ON85256D48.00713BCF@us.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Janice Girouard <girouard@us.ibm.com>
   Date: Tue, 17 Jun 2003 15:40:48 -0500
   
   From:  David S. Miller" <davem@redhat.com>
         Date: 06/17/2003 03:27 PM
   
         On RX, clever RX buffer management is what we need.
   
   What RX buffer management are you proposing?  I'm having a hard time
   understanding how  you'll get rid of the copy without support from the
   card.
   
Sigh... someone write store email down somewhere for the next time
someone asks about this.

The "one true way (tm)" works like this:

1) Chip has a "flow cache", LRU based, managed like routing caches
    in many production router implementations.  Difference is
    that it merely does flow watching.

    Flow entries are keyed on saddr/daddr/sport/dport.  Flow misses
    kill the oldest entry, and replace it with the new one.

    Entries are only created in response to full sized data
    packets.

2) The receive buffering is segmented into small (256 byte) and
    PAGE sized buffers.  IP/TCP/whatever headers (determined using
    a simply programmable header parser logic, so you can do things
    like RPC etc. headers for NFS) are put into the "small" buffers,
    data portions for matching flows get accumulated into the PAGE
    sized buffers.

    It is implied that the card's flow cache keeps track of the
    pointers into page it is currently trying to fill for that
    flow.

So the first time you see a flow, you add a entry and grab a page
buffer and stick the data part into the page buffer and the
TCP/IP/etc. headers into a "small" buffer.  You defer a configurable
amount of time waiting for more TCP data packets (a packet train)
to accumulate more into the PAGE buffer for that flow.

Such receive buffers are presented to the stack as a linked list
of packets, with some indicator that together their data parts are
filling a page.

Things like "sys_receivefile()" and NFS flip these things into the
filesystem page cache.

I'm surprised this isn't evident to more people...
