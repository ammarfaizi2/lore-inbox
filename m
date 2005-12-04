Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbVLDMLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbVLDMLQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 07:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVLDMLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 07:11:16 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:7908 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932205AbVLDMLQ (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 4 Dec 2005 07:11:16 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17298.56560.78408.693927@gargle.gargle.HOWL>
Date: Sun, 4 Dec 2005 15:11:28 +0300
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH 01/16] mm: delayed page activation
Newsgroups: gmane.linux.kernel
In-Reply-To: <20051203071609.755741000@localhost.localdomain>
References: <20051203071444.260068000@localhost.localdomain>
	<20051203071609.755741000@localhost.localdomain>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang writes:
 > When a page is referenced the second time in inactive_list, mark it with
 > PG_activate instead of moving it into active_list immediately. The actual
 > moving work is delayed to vmscan time.
 > 
 > This implies two essential changes:
 > - keeps the adjecency of pages in lru;

But this change destroys LRU ordering: at the time when shrink_list()
inspects PG_activate bit, information about order in which
mark_page_accessed() was called against pages is lost. E.g., suppose
inactive list initially contained pages

     /* head */ (P1, P2, P3) /* tail */

all of them referenced. Then mark_page_accessed(), is called against P1,
P2, and P3 (in that order). With the old code active list would end up 

     /* head */ (P3, P2, P1) /* tail */

which corresponds to LRU. With delayed page activation, pages are moved
to head of the active list in the order they are analyzed by
shrink_list(), which gives

     /* head */ (P1, P2, P3) /* tail */

on the active list, that is _inverse_ LRU order.

Nikita.
