Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264883AbUD2QxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264883AbUD2QxP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 12:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUD2QxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 12:53:15 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:31971 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264883AbUD2QxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 12:53:13 -0400
Date: Thu, 29 Apr 2004 09:50:50 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, paulus@samba.org,
       brettspamacct@fastclick.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <51560000.1083257450@flay>
In-Reply-To: <20040428194039.4b1f5d40.akpm@osdl.org>
References: <409021D3.4060305@fastclick.com><20040428170106.122fd94e.akpm@osdl.org><409047E6.5000505@pobox.com><40905127.3000001@fastclick.com><20040428180038.73a38683.akpm@osdl.org><16528.23219.17557.608276@cargo.ozlabs.ibm.com><20040428185342.0f61ed48.akpm@osdl.org> <20040428194039.4b1f5d40.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  I suspect rsync is taking two passes across the source files for its
>>  checksumming thing.  If so, this will defeat the pagecache use-once logic. 
>>  The kernel sees the second touch of the pages and assumes that there will
>>  be a third touch.
> 
> OK, a bit of fiddling does indicate that if a file is present on both
> client and server, and is modified on the client, the rsync client will
> indeed touch the pagecache pages twice.  Does this describe the files which
> you're copying at all?
> 
> One thing you could do is to run `watch -n1 cat /proc/meminfo'.  Cause lots
> of memory to be freed up then do the copy.  Monitor the size of the active
> and inactive lists.  If the active list is growing then we know that rsync
> is touching pages twice.
> 
> That would be an unfortunate special-case.

Personally, I think that the use-twice logic is a bit of a hack that mostly
works. If we moved to a method where we kept an eye on which pages are 
associated with which address_space (for mapped pages) or which process
(for anonymous pages) we'd have a much better shot at stopping any one
process / file from monopolizing the whole of system memory. 

We'd also be able to favour memory for files that are still open over ones 
that have been closed, and recognize linear access scan patterns per file,
and reclaim more agressively from the overscanned areas, and favour higher
prio tasks over lower prio ones (including, but not limited to interactive).

Global LRU (even with the tweaks it has in Linux) doesn't seem optimal.

M.

