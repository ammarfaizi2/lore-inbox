Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVCWRA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVCWRA1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 12:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVCWRA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 12:00:27 -0500
Received: from port-212-202-144-146.static.qsc.de ([212.202.144.146]:57263
	"EHLO mail.hennerich.de") by vger.kernel.org with ESMTP
	id S261659AbVCWRAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 12:00:09 -0500
Date: Wed, 23 Mar 2005 17:57:45 +0100
From: Tobias Hennerich <Tobias@Hennerich.de>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: Timo Hennerich <Timo@Hennerich.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Vladimir Saveliev <vs@namesys.com>
Subject: Re: Strange memory leak in 2.6.x
Message-ID: <20050323175745.A25998@bart.hennerich.de>
References: <20050311183207.A22397@bart.hennerich.de> <1110565420.2501.12.camel@boxen> <20050312133241.A11469@bart.hennerich.de> <1110640085.2376.22.camel@boxen> <20050312214216.A24046@bart.hennerich.de> <1110661479.3360.11.camel@boxen> <026101c52891$2a618410$0404010a@hennerich.de> <1110812292.2492.21.camel@localhost.localdomain> <20050317133026.A4515@bart.hennerich.de> <1111585276.2441.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <1111585276.2441.1.camel@localhost.localdomain>; from alexn@dsv.su.se on Wed, Mar 23, 2005 at 02:41:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexander,

On Wed, Mar 23, 2005 at 02:41:15PM +0100, Alexander Nyberg wrote:
> > > >     881397 times:
> > > >     Page allocated via order 0
> > > >     [0xc013962b] find_or_create_page+91
> > > >     [0xf8aa9955] reiserfs_prepare_file_region_for_write+613
> > > >     [0xf8aaa606] reiserfs_file_write+1366
> > > > 
> > > > So I guess that we have a problem with the reiser filesystem??
> > > > We are using reiserfs 3.6...
> > > 
> > > The only thing that stands out is big page cache. However, looking at
> > > the previous OOM output it shows that it is zone normal that is
> > > completely out of memory and that highmem zone has lots of free memory.
> > > 
> > > Let's see if the big sharks know what is going on...
> > 
> > Because we suspect the problem in reiserfs and we still have to reboot
> > the machine every other day, we will switch to ext3 now.
> 
> Just to follow up, did the problems go away when switching to ext3?

The switch has been delayed. Up to now we just reboot the machine every
48h - the administrator responsible for the machine is on holiday... 

Meanwhile, I noticed, that the latest release candidate has several
changes which could be quite interesting for us:

<andrea@suse.de>
    [PATCH] orphaned pagecache memleak fix

    Chris found that with data journaling a reiserfs pagecache may
    be truncate while still pinned.  The truncation removes the
    page->mapping, but the page is still listed in the VM queues
    because it still has buffers.  Then during the journaling process,
    a buffer is marked dirty and that sets the PG_dirty bitflag as well
    (in mark_buffer_dirty).  After that the page is leaked because it's
    both dirty and without a mapping.

<mason@suse.com>
    [PATCH] reiserfs: make sure data=journal buffers are cleaned on free

    In data=journal mode, when blocks are freed and their buffers
    are dirty, reiserfs can remove them from the transaction without
    cleaning them. These buffers never get cleaned, resulting in an
    unfreeable page.

On the other side we don't want to install a rc1-kernel on a important
system. Up to now we still plan to do the switch to ext3...

If someone would recommend to install a special reiserfs-patch (*not*
the 12mb of patch-2.6.12-rc1) we would consider that, too! So some
feedback from "the big sharks" is still very welcome.

Best regards	Tobias

-- 
T+T Hennerich GmbH --- Zettachring 12a --- 70567 Stuttgart
Fon:+49(711)720714-0  Fax:+49(711)720714-44  Vanity:+49(700)HENNERICH
UNIX - Linux - Java - C  Entwicklung/Beratung/Betreuung/Schulung
http://www.hennerich.de/
