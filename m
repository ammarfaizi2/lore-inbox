Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUHMQAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUHMQAG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 12:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266114AbUHMQAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 12:00:06 -0400
Received: from omx3-ext.SGI.COM ([192.48.171.20]:17306 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266069AbUHMQAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 12:00:00 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] allocate page caches pages in round robin fasion
Date: Fri, 13 Aug 2004 08:59:24 -0700
User-Agent: KMail/1.6.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, steiner@sgi.com
References: <200408121646.50740.jbarnes@engr.sgi.com> <84960000.1092408633@[10.10.2.4]>
In-Reply-To: <84960000.1092408633@[10.10.2.4]>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408130859.24637.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 13, 2004 7:50 am, Martin J. Bligh wrote:
> I really don't think this is a good idea - you're assuming there's really
> no locality of reference, which I don't think is at all true in most cases.

No, not at all, just that locality of reference matters more for stack and 
anonymous pages than it does for page cache pages.  I.e. we don't want a node 
to be filled up with page cache pages causing all other memory references 
from the process to be off node.

> If we round-robin it ... surely 7/8 of your data (on your 8 node machine)
> will ALWAYS be off-node ? I thought we discussed this at KS/OLS - what is
> needed is to punt old pages back off onto another node, rather than
> swapping them out. That way all your pages are going to be local.

That gets complicated pretty quickly I think.  We don't want to constantly 
shuffle pages between nodes with kswapd, and there's also the problem of 
deciding when to do it.

> OK, so it obviously does something ... but is the dd actually faster?
> I'd think it's slower ...

Sure, it's probably a tiny bit slower, but assume that dd actually had some 
compute work to do after it read in a file (like an encoder or fp app), w/o 
the patch, most of it's time critical references would be off node.  The 
important thing is to get the file data in memory, since that'll be way 
faster than reading from disk, but it doesn't really matter *where* it is in 
memory.  Especially since we want an app's code and data to be node local.

Jesse
