Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbVCXBuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbVCXBuP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 20:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVCXBuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 20:50:14 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:14615
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S262977AbVCXBt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 20:49:56 -0500
Date: Thu, 24 Mar 2005 02:49:48 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, aebr@win.tue.nl, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: OOM problems on 2.6.12-rc1 with many fsx tests
Message-ID: <20050324014948.GE14202@opteron.random>
References: <20050316003134.GY7699@opteron.random> <20050316040435.39533675.akpm@osdl.org> <20050316183701.GB21597@opteron.random> <1111607584.5786.55.camel@localhost.localdomain> <20050323144953.288a5baf.akpm@osdl.org> <17250000.1111619602@flay> <20050323152055.6fc8c198.akpm@osdl.org> <20050323232656.GA5704@pclin040.win.tue.nl> <25760000.1111620606@flay> <20050323154232.376f977f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323154232.376f977f.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 03:42:32PM -0800, Andrew Morton wrote:
> I'm suspecting here that we simply leaked a refcount on every darn
> pagecache page in the machine.  Note how mapped memory has shrunk down to
> less than a megabyte and everything which can be swapped out has been
> swapped out.
> 
> If so, then oom-killing everything in the world is pretty inevitable.

Agreed, it looks like a memleak of a page_count (while mapcount is fine).

I would suggest looking after pages part of pagecache (i.e.
page->mapcount not null) that have a mapcount of 0 and a page_count > 1,
almost all of them should be like that during the memleak, and almost
none should be like that before the memleak.

This seems unrelated to the bug that started the thread that was clearly
a slab shrinking issue and not a pagecache memleak.

Thanks.
