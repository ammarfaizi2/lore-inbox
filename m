Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268697AbUILMMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268697AbUILMMo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 08:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268689AbUILMMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 08:12:44 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:49618 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S268697AbUILMLD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 08:11:03 -0400
Date: Sun, 12 Sep 2004 14:10:20 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Tejun Heo <tj@home-tj.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, alan@redhat.com
Subject: Re: [PATCH] via-velocity fixes
Message-ID: <20040912121020.GB20942@electric-eye.fr.zoreil.com>
References: <20040912093301.GC13359@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912093301.GC13359@home-tj.org>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo <tj@home-tj.org> :
[...]
>  First of all, many thanks for the driver.  I've encountered problems
> with recent updates to the driver and fixed them and some others.  I'm
> also interested in improving this driver, and having the programming
> manual would be very helpful.  Does anybody know how to obtain the
> programming manual for this chip?  Is it available online somewhere?

See www.viaarena.com for a .exe driver which turns out to be a .zip.

[...]
>  Recent receive ring related updates to via-velocity broke the driver.
> My box lost packets, recevied duplicate truncated packets and soon
> locked into infinite error interrupt handling.  This patch fixes
> receive ring handling and some other parts of the driver.  List of
> fixes follow.
> 
> Using cpu_to_le32 on OWNED_BY_NIC is wrong.  It will produce
> 0x10000000 on big endian machines while owner bitfield would still
> evaluate to 0 or 1.

The rx_desc structure is used in the network device, not in the host
computer. I see nowhere in the code where it is said to the network
adapter that it should change the ordering of the bytes in its registers.

Was this change tested on a big endian machine ?

> In velocity_give_rx_desc(), there should be a wmb() between resetting
> the first four bytes of rdesc0 and setting owner.  As resetting the
> first four bytes isn't necessary, I just removed the function and
> directly set owner.

- The function keeps code factored. Feel free to modify the function
  but please keep the function in place. 
- having the lower bytes cleaned can help when something goes wrong.
  I would favor a removal of the bitfield and use dumb accesses to
  registers (as u32) like can be found in others drivers (just mho).

Though simple, the changes to velocity_init_td_ring could be commented
(it takes a few seconds to realize that the settings in velocity_info_tbl()
allowed the former buggy code to work as well).

Can you be convinced to post the whole thing as a serie of incremental
patches on netdev@oss.sgi.com with Cc: to jgarzik@pobox.com and
alan@redhat.com ?

The patch looks quite good and it clearly fixes several points but
I guess that most people prefer to review small incremental changes.

--
Ueimor
