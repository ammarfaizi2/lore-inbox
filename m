Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbTEWHJL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 03:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263855AbTEWHJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 03:09:11 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:57791 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263850AbTEWHJJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 03:09:09 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16077.52259.718519.389903@laputa.namesys.com>
Date: Fri, 23 May 2003 11:22:11 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: "Robert White" <rwhite@casabyte.com>
Cc: "Nick Piggin" <piggin@cyberone.com.au>, <elladan@eskimo.com>,
       "Rik van Riel" <riel@imladris.surriel.com>,
       "David Woodhouse" <dwmw2@infradead.org>, <ptb@it.uc3m.es>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>,
       <root@chaos.analogic.com>
Subject: Re: recursive spinlocks. Shoot.
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGEEKJCMAA.rwhite@casabyte.com>
References: <3ECC4C3A.9000903@cyberone.com.au>
	<PEEPIDHAKMCGHDBJLHKGEEKJCMAA.rwhite@casabyte.com>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta11) "cabbage" XEmacs Lucid
X-Tom-Swifty: "The ASCII standard sucks," Tom said characteristically.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert White writes:
 > This will, hopefully, be my out-comment on this thread.
 > 

[...]

 > 
 > 4) All locks (spin or otherwise) should obviously be held for the shortest
 > amount of time reasonably possible which still produces the correct result.
 > 
 > If this needs explaining...  8-)

It surely does.

Consider two loops:

(1)

spin_lock(&lock);
list_for_each_entry(item, ...) {
  do something with item;
}
spin_unlock(&lock);

versus

(2)

list_for_each_entry(item, ...) {
  spin_lock(&lock);
  do something with item;
  spin_unlock(&lock);
}

and suppose they both are equally correct. Now, in (2) total amount of
time &lock is held is smaller than in (1), but (2) will usually perform
worse on SMP, because:

. spin_lock() is an optimization barrier

. taking even un-contended spin lock is an expensive operation, because
of the cache coherency issues.

 > 

[...]

 > 
 > Rob.
 > 

Nikita.
