Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbUB1GSm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 01:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbUB1GSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 01:18:42 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8876
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261814AbUB1GSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 01:18:39 -0500
Date: Sat, 28 Feb 2004 07:18:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Wim Coekaerts <wim.coekaerts@oracle.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040228061838.GO8834@dualathlon.random>
References: <20040227173250.GC8834@dualathlon.random> <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com> <20040227122936.4c1be1fd.akpm@osdl.org> <20040227211548.GI8834@dualathlon.random> <162060000.1077919387@flay> <20040228023236.GL8834@dualathlon.random> <20040228045713.GA388@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040228045713.GA388@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 08:57:14PM -0800, Wim Coekaerts wrote:
> On Sat, Feb 28, 2004 at 03:32:36AM +0100, Andrea Arcangeli wrote:
> > On Fri, Feb 27, 2004 at 02:03:07PM -0800, Martin J. Bligh wrote:
> > > 
> > > Eh? You have a 2GB difference of user address space, and a 1GB difference
> > > of shm size. You lost a GB somewhere ;-) Depending on whether you move
> > > TASK_UNMAPPPED_BASE or not, it you might mean 2.7 vs 0.7 or at a pinch
> > > 3.5 vs 1.5, I'm not sure.
> > 
> > the numbers I wrote are right. No shm size is lost. The shm size is >20G,
> > it doesn't fit in 4g of address space of 4:4 like it doesn't fit in 3G
> > of address space of 3:1 like it doesn't fit in 2:2.
> 
> Andrea, one thing I don't think we have discussed before is that aside
> from mapping into shmfs or hugetlbfs, there is also the regular shmem
> segment (shmget) we always use. the way we currently allocate memory is
> like this :
> 
> just a big shmem segment w/ shmget() up to like 1.7 or 2.5 gb,
> containing the entire in memory part
> 
> or 
> 
> shm (reasoanble sized segment, between 400mb and today on 32bit up to
> like 1.7 - 2 gb) which is used for non buffercache (sqlcache, parse
> trees etc)
> a default of about 16000 mmaps into the shmfs file (or
> remap_file_pages) and the total size ranging from a few gb to many gb
> 	which contains the data buffer cache
> 
> we cannot put the sqlcache(shared pool) into shmfs and do the windowing
> and this is a big deal for performance as well. eg the larger the
> better. it would have to be able to get to a reasonable size, and you
> have about 512mb on top of that for the window into shmfs. average sizes
> range between 1gb and 1.7gb so a 2/2 split would not be useful here. 
> sql/plsql/java cache is quite important for certain things. 

I see, so losing 1g sounds too much.

> 
> I think Van is running a test on a32gb box to compare the 2 but I think
> that would be too limiting in general to have only 2gb.

thanks for giving it a spin (btw I assume it's 2.4, that's fine for
a quick test, and I seem not to find the 2:2 and 1:3 options in the 2.6
kernel anymore ;).

What I probably didn't specify yet is that 2.5:1.5 is feasible too, I've
a fairly small and strightforward patch here from ibm that implements
3.5:0.5 for PAE mode (for a completely different matter, but I mean,
it's not really a problem to do 2.5:1.5 either if needed, it's the same
as the current PAE mode 3.5:0.5).

starting with the assumtion that 32G machines works with 3:1 (like they
do in 2.4), and assuming the size of a page is 48 bytes (like in 2.4, in
2.6 it's a bit bigger but we can most certainly shrink it, for example
removing rmap for anon pages will immediatly release 128M of kernel
memory), moving from 32G to 64G means losing 384M of those additional
512M in pages, you can use the remaining additional 512M-384M=128M for
vmas, task structs, files etc...  So 2.5:1.5 should be enough as far as
the kernel is concerned to run on 64G machines (provided the page_t is
not bigger than 2.4 which sounds feasible too).

we can add a config option to enable together with 2.5:1.5 to drop the
gap page in vmalloc, and to reduce the vmalloc space, so that we can
sneak another few "free" dozen megs back for the 64G kernel just to get
more margin even if we don't strictly need it. (btw, the vmalloc space
is also tunable at boot, so this config option would just change the
default value)

So as far as 32G works with 3:1, 2.5:1.5 is going to be more than enough
to handle 64G.

the question remains is if you can live with only 2.5G of address space,
so if losing 512m is a blocker or not. I see losing 1G was way too much,
but kernel doesn't need 1G more, an additional 512m is enough to make
the kernel happy. If losing 512m is a big problem too, I don't think we
can drop from userspace less than 512m of address space, so 4:4 would
remain the only way to handle 64G and we can forget about this my
suggestion. Certainly I believe 2.5:1.5 has a very good chance to
significantly outperform 4:4 if you can make the ipc shm 1.7G and the
window on the shm 512m (that leaves you 300m for holes, stack, binary,
anonymous memory and similar minor allocations).

thanks.
