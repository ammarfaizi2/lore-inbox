Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbTDVGbc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 02:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbTDVGbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 02:31:32 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:21157 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262219AbTDVGbb
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 22 Apr 2003 02:31:31 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16036.58518.467848.341356@laputa.namesys.com>
Date: Tue, 22 Apr 2003 10:43:34 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Andrew Morton <akpm@digeo.com>
Cc: Linux-Kernel@Vger.Kernel.ORG
Subject: Re: zone->nr_inactive race?
In-Reply-To: <20030421153449.69b494fc.akpm@digeo.com>
References: <16036.12627.477016.967042@laputa.namesys.com>
	<20030421153449.69b494fc.akpm@digeo.com>
X-Mailer: VM 7.07 under 21.5  (beta11) "cabbage" XEmacs Lucid
X-Tom-Swifty: "Ed is the Standard Text Editor," Tom sed.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Nikita Danilov <Nikita@Namesys.COM> wrote:
 > >
 > > This fragment of refill_inactive_zone() looks strange:
 > > 
 > > 		list_move(&page->lru, &zone->inactive_list);
 > > 		if (!pagevec_add(&pvec, page)) {
 > > 			spin_unlock_irq(&zone->lru_lock);
 > > 			if (buffer_heads_over_limit)
 > > 				pagevec_strip(&pvec);
 > > 			__pagevec_release(&pvec);
 > > 			spin_lock_irq(&zone->lru_lock);
 > > 		}
 > > 
 > 
 > Thanks, you're dead right.  That's buggy.
 > 
 > I am fairly surprised that you were able to hit this.  How are you doing
 > it?  On a 1G machine with a teeny ZONE_HIGHMEM??

:)

Modester:

Dual Xeon, 2.20GHz with hyper threading.

512M of ram, but with CONFIG_HIGHMEM4G=y.

I am running

ftp://ftp.namesys.com/pub/namesys-utils/nfs_fh_stale.c

with 

./nfs -p 41 -i 100000000 -B -L 22000000 -F sync=0 -s 0 -f 1000000000 -M 1000000000

on reiser4. Its on-disk working set stabilizes somewhere around 14G, and
it produces large amounts of ->writepage() traffic.

 > 
 > I haven't tested this yet, but it should fix it up.
 > 

OK, I shall try.

Nikita.
