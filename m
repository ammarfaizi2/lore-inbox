Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTFGJaP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 05:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTFGJaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 05:30:15 -0400
Received: from dp.samba.org ([66.70.73.150]:56542 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262878AbTFGJaM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 05:30:12 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16097.45833.384548.319399@argo.ozlabs.ibm.com>
Date: Sat, 7 Jun 2003 19:40:25 +1000
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.5.70-bk11 zlib merge #4 pure magic
In-Reply-To: <20030606201306.GJ10487@wohnheim.fh-wedel.de>
References: <20030606183126.GA10487@wohnheim.fh-wedel.de>
	<20030606183247.GB10487@wohnheim.fh-wedel.de>
	<20030606183920.GC10487@wohnheim.fh-wedel.de>
	<20030606185210.GE10487@wohnheim.fh-wedel.de>
	<20030606192325.GG10487@wohnheim.fh-wedel.de>
	<20030606192814.GH10487@wohnheim.fh-wedel.de>
	<20030606200051.GI10487@wohnheim.fh-wedel.de>
	<20030606201306.GJ10487@wohnheim.fh-wedel.de>
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel writes:

> The only code that could be bitten by this change is ppp, so I changed
> that as well.  Paulus, could you have a quick look at it?

As Bart pointed out, there is a bug in zlib for window_size == 256.
Here is James Carlson's description of the problem:

        The problem is that s->strstart gets set to a very large
        positive integer when wsize (local copy of s->w_size) is
        subtracted in deflate.c:fill_window().  This happens because
        MAX_DIST(s) resolves as a negative number when the window size
        is 8 -- MAX_DIST(s) is defined as s->w_size-MIN_LOOKAHEAD in
        deflate.h.  MIN_LOOKAHEAD is MAX_MATCH+MIN_MATCH+1, and that
        is 258+3+1 or 262.  Since a window size of 8 gives s->w_size
        256, MAX_DIST(s) is 256-262 or -6.

        This results in read_buf() writing over memory outside of
        s->window, and a crash.

Your change won't affect PPP, since pppd already refuses to use
windowBits == 8 (as a workaround for this bug).

Regards,
Paul.

