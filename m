Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbTHXQyQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 12:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbTHXQyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 12:54:16 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:44294 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261674AbTHXQyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 12:54:14 -0400
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing
	tst-mmap-eofsync in glibc on parisc)
From: James Bottomley <James.Bottomley@steeleye.com>
To: "David S. Miller" <davem@redhat.com>
Cc: hugh@veritas.com, willy@debian.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>, drepper@redhat.com
In-Reply-To: <20030823222300.4695a0c4.davem@redhat.com>
References: <20030822110144.5f7b83c5.davem@redhat.com>
	<Pine.LNX.4.44.0308221926060.2200-100000@localhost.localdomain>
	<20030822113106.0503a665.davem@redhat.com>
	<1061578568.2053.313.camel@mulgrave>
	<20030822121955.619a14eb.davem@redhat.com>
	<1061591255.1784.636.camel@mulgrave>
	<20030822154100.06314c8e.davem@redhat.com>
	<1061600974.2090.809.camel@mulgrave>
	<20030823144330.5ddab065.davem@redhat.com>
	<1061677283.1992.471.camel@mulgrave>
	<20030823155312.63f996f6.davem@redhat.com>
	<1061680279.1785.534.camel@mulgrave>
	<20030823172251.4e656f9a.davem@redhat.com>
	<1061702282.1992.1153.camel@mulgrave> 
	<20030823222300.4695a0c4.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Aug 2003 11:54:00 -0500
Message-Id: <1061744042.13315.29.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-24 at 00:23, David S. Miller wrote:
> This is what I'm asking of you, to find cases in real life,
> not some contrived example, where your optimization helps
> appreciably.

Oh, OK, that's easy...it's what the glibc test was designed for.

In glibc, for each file you fopen as a mapped file, you seem to get a
separate mmapping of the file (this actually looks wrong to me...it
seems glibc should have only one mapping per file which all the file
objects share, but anyway).  That means we get one entry in one of the
i_mmaps lists for each of the opens.  Since these are files, the chances
are they'll be read and written which will generate lots of dcache
flushes.  This case would kill us if we had to flush every entry in
i_mmap.

Right at the moment, you have to specifically request that the file be
mmapped by specifying the "m" modifier, but glibc seems to be migrating
to this being the default one day...that's what I want to be ready for.

Besides the optimisation adds no overhead and compromises nothing, so
its worth doing regardless.

James


