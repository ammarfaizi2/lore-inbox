Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264207AbTEaIBq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 04:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264210AbTEaIBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 04:01:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:5558 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264207AbTEaIBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 04:01:39 -0400
Date: Sat, 31 May 2003 01:12:10 -0700 (PDT)
Message-Id: <20030531.011210.34750891.davem@redhat.com>
To: willy@w.ods.org
Cc: scrosby@cs.rice.edu, alexander.riesen@synopsys.COM,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030531080205.GA776@pcw.home.local>
References: <oydd6i04gq8.fsf@bert.cs.rice.edu>
	<20030530.231813.59666274.davem@redhat.com>
	<20030531080205.GA776@pcw.home.local>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Willy TARREAU <willy@w.ods.org>
   Date: Sat, 31 May 2003 10:02:05 +0200

   With this simple change, jhash_mix is *exactly* three times faster
   for me on athlon-xp, whatever gcc I use (2.95.3 or 3.2.3), on the
   following do_hash() function, and about 40% faster when used on
   local variables.

Interesting :-)

   This function is 189 bytes long, and takes about 72 cycles to
   complete with the original macro, and is now 130 bytes long for
   about 24 cycles, which means about 1.5 operation/cycle... not bad :-)
   
__jhash_mix takes ~23 cycles on sparc64 in the original version for
me.  I get the same measurement for your version.  Maybe your gcc
version just stinks :-(

Oh wait, yes, it's the memory operations it can't eliminate.
It can't do that because it has no idea whether certain pointers
alias or not.  (ie. it doesn't know whether 'a' and 'b' point
to the same value)

Since all the networking versions work on local variables, in
2.4.x it shouldn't matter performance wise.

You'll note that my updated dcache jenkins patch for 2.5.x
brought the hash->words[] variables into locals before running
__jhash_mix() on it.  So it shouldn't matter there either.
