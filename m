Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263344AbSIPXZW>; Mon, 16 Sep 2002 19:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263346AbSIPXZW>; Mon, 16 Sep 2002 19:25:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24040 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263344AbSIPXZW>;
	Mon, 16 Sep 2002 19:25:22 -0400
Date: Mon, 16 Sep 2002 16:21:23 -0700 (PDT)
Message-Id: <20020916.162123.116935622.davem@redhat.com>
To: bart.de.schuymer@pandora.be
Cc: buytenh@math.leidenuniv.nl, linux-kernel@vger.kernel.org
Subject: Re: bridge-netfilter patch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200209162341.17032.bart.de.schuymer@pandora.be>
References: <200209140905.40816.bart.de.schuymer@pandora.be>
	<20020915.203528.08097520.davem@redhat.com>
	<200209162341.17032.bart.de.schuymer@pandora.be>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Bart De Schuymer <bart.de.schuymer@pandora.be>
   Date: Mon, 16 Sep 2002 23:41:17 +0200

   net/ipv4/ip_output.c:ip_fragment()
   In this function the copy of the Ethernet frame is added for each fragment (by 
   the br-nf patch).

'output' callback arg to ip_fragment() must generate correct hardware
headers when necessary.  This hack usage of it via netfilter, in this
weird bridging case, is violating this requirement.

Normally ip_finish_output2() is going to make this.

If it can't do the job properly, pass instead a routine that can do
what netfilter needs.

Lennert says:

   So if we postpone FORWARD and POST_ROUTING until after br_dev_xmit,
   we effectively reverse refragmentation and neighbor resolution.
   But refragmentation messes up the hardware header.

   The 16byte hardware header copy fixes this by copying to each
   fragment the hardware header that was tacked onto or was already
   present on the bigger packet.  It's ugly, I admit.  There's
   currently no better way though.

I don't understand why you can't add on the hardware header some other
way.

If ip_finish_output doesn't put the right hardware header on there,
you have to use as 'okfn' (what netfilter sends down as 'output' to
ip_fragment) some routine which will do it correctly.
