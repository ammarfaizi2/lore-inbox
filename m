Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbTLLBnR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 20:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbTLLBnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 20:43:17 -0500
Received: from pizda.ninka.net ([216.101.162.242]:14767 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264449AbTLLBnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 20:43:15 -0500
Date: Thu, 11 Dec 2003 17:41:36 -0800
From: "David S. Miller" <davem@redhat.com>
To: Harald Welte <laforge@netfilter.org>
Cc: mukansai@emailplus.org, scott.feldman@intel.com,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: TSO and netfilter (Re: Extremely slow network with e1000 &
 ip_conntrack)
Message-Id: <20031211174136.1ed23e2e.davem@redhat.com>
In-Reply-To: <20031211110315.GJ22826@sunbeam.de.gnumonks.org>
References: <20031204213030.2B75.MUKANSAI@emailplus.org>
	<20031205122819.25ac14ab.davem@redhat.com>
	<20031211110315.GJ22826@sunbeam.de.gnumonks.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003 12:03:15 +0100
Harald Welte <laforge@netfilter.org> wrote:

> The only interesting case is in ip_output.c:ip_queue_xmit(), where
> tso_size and tso_segs are calculated, before NF_IP_LOCAL_OUT is run.
> 
> But changing the content or the size of the tcp payload should not
> affect those calculations. 

It changes at least tso_segs, since if you decrease of increase the
size of the payload the number of real TCP/IP packets the TSO engine
will end up spitting out could be different.

The one netfilter module I'm most concerned about is the one that
handles non-passive FTP, I remember that one did strange things with
the data stream, removed TCP options, and stuff like that.

> A real problem would be resizing the TCP header (where th.doff is
> affected).  But I cannot think of any case where any of the current
> netfilter/iptables/conntrack/nat code does that.

As mentioned above, I thought the netfilter module handling non-passive
FTP stripped TCP options.

> Even in the past, when
> we used to remove SACKPERM from the tcp header, we just NOP'ed it out
> instead of resizing the header.

This may be what I was thinking about.

> > Another area for inspection are the cases where TCP header bits are
> > changed and thus the checksum needs to be adjusted.
> 
> Why is this a problem?  The netfilter code has to adjust the checksum
> anyway... or is the checksum calculation for TSO-enabled skb's
> different?

Currently all the TSO supporting drivers set the ip and tcp header
checksum values themselves as appropriate, so there are no worries in
this area.
