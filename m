Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263884AbTHVSlo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 14:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264136AbTHVSlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 14:41:44 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:39686 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264015AbTHVSlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 14:41:39 -0400
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing
	tst-mmap-eofsync in glibc on parisc)
From: James Bottomley <James.Bottomley@steeleye.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: "David S. Miller" <davem@redhat.com>, willy@debian.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>, drepper@redhat.com
In-Reply-To: <Pine.LNX.4.44.0308221926060.2200-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0308221926060.2200-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 22 Aug 2003 13:41:26 -0500
Message-Id: <1061577688.2090.285.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-22 at 13:34, Hugh Dickins wrote:
> Might the problem be in parisc's __flush_dcache_page,
> which only examines i_mmap_shared?

This is the issue: we do treat them differently.

Semantics differ between privately mapped data (where there's no
coherency guarantee) and shared data (where there is).  Flushing the
virtual cache is expensive on pa, so we only do it for the i_mmap_shared
list.

The difficulty is that a mmap of a read only file with MAP_SHARED is
expecting the shared cache semantics, but gets added to the non shared
list.

Since flushing the caches is a performance hog, we'd like do be able to
distinguish the cases where we have to do the flush MAP_SHARED mappings
from those we don't (MAP_PRIVATE).

James



