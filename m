Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264943AbTFQUo1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 16:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264951AbTFQUo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 16:44:27 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:15829 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264943AbTFQUoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 16:44:22 -0400
Subject: Re: patch for common networking error messages
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFDF06338E.06BC4D08-ON85256D48.00729284@us.ibm.com>
From: Janice Girouard <girouard@us.ibm.com>
Date: Tue, 17 Jun 2003 15:57:59 -0500
X-MIMETrack: Serialize by Router on D01ML063/01/M/IBM(Release 6.0.1 w/SPRs JHEG5JQ5CD, THTO5KLVS6, JHEG5HMLFK, JCHN5K5PG9|March
 27, 2003) at 06/17/2003 16:58:03
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Did I understand:

> 1) Chip has a "flow cache", LRU based, managed like routing caches

You need the chip to support your technique.  Are the vendors picking up on
this?  I still don't see how this gets rid of the copy_to_user space once
you've gathered the buffers.  How do you feed the user buffer addresses to
the card?  You must have something equivalent to the queue pair management
supported in RDMA.  What technique are you using?  Is it proprietary?



                                                                                                                
                      "David S. Miller"                                                                         
                      <davem@redhat.com        To:       Janice Girouard/Austin/IBM@IBMUS                       
                      >                        cc:       garzik@pobox.com, shemminger@osdl.org,                 
                                                Valdis.Kletnieks@vt.edu, Daniel Stekloff/Beaverton/IBM@IBMUS,   
                      06/17/2003 03:42          Larry Kessler/Beaverton/IBM@IBMUS,                              
                      PM                        linux-kernel@vger.kernel.org, netdev@oss.sgi.com,               
                                                niv@us.ltcfwd.linux.ibm.com                                     
                                               Subject:  Re: patch for common networking error messages         
                                                                                                                
                                                                                                                




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




