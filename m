Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267199AbUHOWpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267199AbUHOWpY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 18:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267209AbUHOWpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 18:45:24 -0400
Received: from gate.crashing.org ([63.228.1.57]:54676 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267199AbUHOWpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 18:45:21 -0400
Subject: Re: page fault fastpath: Increasing SMP scalability by introducing
	pte locks?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-ia64@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1092609485.9538.27.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 08:38:06 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-15 at 23:50, Christoph Lameter wrote:
> Well this is more an idea than a real patch yet. The page_table_lock
> becomes a bottleneck if more than 4 CPUs are rapidly allocating and using
> memory. "pft" is a program that measures the performance of page faults on
> SMP system. It allocates memory simultaneously in multiple threads thereby
> causing lots of page faults for anonymous pages.

Just a note: on ppc64, we already have a PTE lock bit, we use it to
guard against concurrent hash table insertion, it could be extended
to the whole page fault path provided we can guarantee we will never
fault in the hash table on that PTE while it is held. This shouldn't
be a problem as long as only user pages are locked that way (which
should be the case with do_page_fault) provided update_mmu_cache()
is updated to not take this lock, but assume it already held.

Ben.


