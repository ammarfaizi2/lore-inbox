Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbUB1E5r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 23:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263198AbUB1E5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 23:57:47 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:55744 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S263187AbUB1E5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 23:57:45 -0500
Date: Fri, 27 Feb 2004 20:57:14 -0800
From: Wim Coekaerts <wim.coekaerts@oracle.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040228045713.GA388@ca-server1.us.oracle.com>
References: <20040227173250.GC8834@dualathlon.random> <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com> <20040227122936.4c1be1fd.akpm@osdl.org> <20040227211548.GI8834@dualathlon.random> <162060000.1077919387@flay> <20040228023236.GL8834@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040228023236.GL8834@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 28, 2004 at 03:32:36AM +0100, Andrea Arcangeli wrote:
> On Fri, Feb 27, 2004 at 02:03:07PM -0800, Martin J. Bligh wrote:
> > 
> > Eh? You have a 2GB difference of user address space, and a 1GB difference
> > of shm size. You lost a GB somewhere ;-) Depending on whether you move
> > TASK_UNMAPPPED_BASE or not, it you might mean 2.7 vs 0.7 or at a pinch
> > 3.5 vs 1.5, I'm not sure.
> 
> the numbers I wrote are right. No shm size is lost. The shm size is >20G,
> it doesn't fit in 4g of address space of 4:4 like it doesn't fit in 3G
> of address space of 3:1 like it doesn't fit in 2:2.

Andrea, one thing I don't think we have discussed before is that aside
from mapping into shmfs or hugetlbfs, there is also the regular shmem
segment (shmget) we always use. the way we currently allocate memory is
like this :

just a big shmem segment w/ shmget() up to like 1.7 or 2.5 gb,
containing the entire in memory part

or 

shm (reasoanble sized segment, between 400mb and today on 32bit up to
like 1.7 - 2 gb) which is used for non buffercache (sqlcache, parse
trees etc)
a default of about 16000 mmaps into the shmfs file (or
remap_file_pages) and the total size ranging from a few gb to many gb
	which contains the data buffer cache

we cannot put the sqlcache(shared pool) into shmfs and do the windowing
and this is a big deal for performance as well. eg the larger the
better. it would have to be able to get to a reasonable size, and you
have about 512mb on top of that for the window into shmfs. average sizes
range between 1gb and 1.7gb so a 2/2 split would not be useful here. 
sql/plsql/java cache is quite important for certain things. 

I think Van is running a test on a32gb box to compare the 2 but I think
that would be too limiting in general to have only 2gb.

wim





