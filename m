Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbTGAQ6I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 12:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTGAQ6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 12:58:08 -0400
Received: from adsl-66-120-156-55.dsl.lsan03.pacbell.net ([66.120.156.55]:64765
	"EHLO river.fishnet") by vger.kernel.org with ESMTP id S262861AbTGAQ6B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 12:58:01 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       kuznet@ms2.inr.ac.ru, jmorris@redhat.com
Subject: Re: negative tcp_tw_count and other TIME_WAIT weirdness?
References: <200307010025.h610PGmX007656@river.fishnet>
	<20030701.012107.42800729.davem@redhat.com>
From: John Salmon <jsalmon@thesalmons.org>
Date: Tue, 01 Jul 2003 10:12:18 -0700
In-Reply-To: <20030701.012107.42800729.davem@redhat.com> (David S. Miller's
 message of "Tue, 01 Jul 2003 01:21:07 -0700 (PDT)")
Message-ID: <m3brwedvd9.fsf@river.fishnet>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the tip.  I'll try the patch.

Another question - is there any chance that this bug could be
responsible for a slowdown in network processing.  Some of my machines
get themselves into a state in which their ability to serve
network traffic (they're running squid) is significantly reduced -
perhaps by a factor of two.  I wish I had more specific data, but at
this point it's a mystery.  What I'm really wondering is whether
there's any chance at all that this kernel bug could be behind my
performance problem, or should I look elsewhere.

TIA,
John Salmon


>>>>> "David" == David S Miller <davem@redhat.com> writes:

David>    From: John Salmon <jsalmon@thesalmons.org>
David>    Date: Mon, 30 Jun 2003 17:25:16 -0700

David>    I have several fairly busy servers reporting a negative value
David>    for tcp_tw_count.

David>  I have a sneaking suspicion that this patch (already in 2.4.22-preX)
David>  will fix your problem.

David> # This is a BitKeeper generated patch for the following project:
David> # Project Name: Linux kernel tree
David> # This patch format is intended for GNU patch command version 2.5 or higher.
David> # This patch includes the following deltas:
David> #	           ChangeSet	1.930.114.22 -> 1.930.114.23
David> #	net/ipv4/tcp_minisocks.c	1.13    -> 1.14   
David> #
David> # The following is the BitKeeper ChangeSet Log
David> # --------------------------------------------
David> # 03/05/07	olof@austin.ibm.com	1.930.114.23
David> # [TCP]: tcp_twkill leaves death row list in inconsistent state over tcp_timewait_kill.
David> # --------------------------------------------
David> #
David> diff -Nru a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
David> --- a/net/ipv4/tcp_minisocks.c	Tue Jul  1 01:25:26 2003
David> +++ b/net/ipv4/tcp_minisocks.c	Tue Jul  1 01:25:26 2003
David> @@ -447,6 +447,8 @@
 
David>  	while((tw = tcp_tw_death_row[tcp_tw_death_row_slot]) != NULL) {
David>  		tcp_tw_death_row[tcp_tw_death_row_slot] = tw->next_death;
David> +		if (tw->next_death)
David> +			tw->next_death->pprev_death = tw->pprev_death;
tw-> pprev_death = NULL;
David>  		spin_unlock(&tw_death_lock);
 

