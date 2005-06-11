Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVFKKZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVFKKZS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 06:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVFKKZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 06:25:18 -0400
Received: from one.firstfloor.org ([213.235.205.2]:29856 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261676AbVFKKZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 06:25:09 -0400
To: Skywind <gnuwind@gmail.com>
Cc: davem@davemloft.net, casavan@sgi.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Is kernel 2.6.11 adjust tcp_max_syn_backlog incorrectly?
References: <75052be7050606070691c302d@mail.gmail.com>
	<75052be705060607106a6c0882@mail.gmail.com>
From: Andi Kleen <ak@muc.de>
Date: Sat, 11 Jun 2005 12:25:08 +0200
In-Reply-To: <75052be705060607106a6c0882@mail.gmail.com> (gnuwind@gmail.com's
 message of "Mon, 6 Jun 2005 22:10:17 +0800")
Message-ID: <m11x79dwcb.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Skywind <gnuwind@gmail.com> writes:
>
> It seems that kernel don't adjust these value automatic, is this a bug?
>
> I guess the mechanism of tcp.c in 2.6.11 have some changes(between
> 2.6.10), and it conduce to this result,
> Is this guess correctly?

Yes, there were some changes here when it was converted to a common
function for all hash tables (alloc_large_system_hash - the function
with the argument list from hell).  Anyways, here's a quick fix.

DaveM for your consideration.

Adjust TCP mem order check to new alloc_large_system_hash

Signed-off-by: Andi Kleen <ak@suse.de>

--- linux-2.6.11-work/net/ipv4/tcp.c~	2005-03-02 08:37:51.000000000 +0100
+++ linux-2.6.11-work/net/ipv4/tcp.c	2005-06-11 12:16:22.000000000 +0200
@@ -2337,7 +2337,7 @@
 			(tcp_bhash_size * sizeof(struct tcp_bind_hashbucket));
 			order++)
 		;
-	if (order > 4) {
+	if (order >= 4) {
 		sysctl_local_port_range[0] = 32768;
 		sysctl_local_port_range[1] = 61000;
 		sysctl_tcp_max_tw_buckets = 180000;



