Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbTLAB4H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 20:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbTLAB4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 20:56:07 -0500
Received: from dp.samba.org ([66.70.73.150]:65164 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263053AbTLAB4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 20:56:04 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: James Bourne <jbourne@hardrock.org>
Cc: linux-kernel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [netfilter-core] 2.4.23/others and ip_conntrack causing hangs 
In-reply-to: Your message of "Sun, 30 Nov 2003 12:21:33 PDT."
             <Pine.LNX.4.44.0311301204520.2148-100000@cafe.hardrock.org> 
Date: Mon, 01 Dec 2003 11:22:59 +1100
Message-Id: <20031201015604.816D52C06F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0311301204520.2148-100000@cafe.hardrock.org> you writ
e:
> Hi all,
> I wanted to bring up an issue with ip_conntrack in 2.4.23, 2.4.22, and at
> least 2.4.21 (sorry, didn't try 2.4.20).
> 
> The issue is that as long as there are connections being tracked, the
> ip_conntrack module will not unload.  I can understand why this might be,
> but the problem is that ip_conntrack will hang rmmod and modprobe -r until
> such time as all the connections have been closed.
> 
> I think we need something like an ip_conntrack_flush or else completely drop
> the connections when the module is unloaded (as previously done) as this
> becomes an issue for people who need to drop their ip_tables and reload the
> modules (perhaps to correct other issues) especially ip_conntrack...  

Um, this is exactly what the code does on unload: an explicit flush.

Unfortunately, some packets are still referencing connections, so the
module *cannot* go away.  Figuring out exactly where the packets are
referenced from is the fun part.  We explicitly drop the reference in
ip_local_deliver_finish() for exactly this reason.  Perhaps there is
somewhere else we should be doing the same thing.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
