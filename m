Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263799AbUESFRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263799AbUESFRe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 01:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbUESFRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 01:17:01 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:55470
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263800AbUESFQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 01:16:53 -0400
Date: Wed, 19 May 2004 07:16:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: invalidate_inode_pages2
Message-ID: <20040519051651.GU3044@dualathlon.random>
References: <20040519001520.GO3044@dualathlon.random> <20040518172718.773d32c1.akpm@osdl.org> <20040519005106.GP3044@dualathlon.random> <20040519050801.GA9605@mentor.odyssey.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040519050801.GA9605@mentor.odyssey.cs.cmu.edu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 01:08:01AM -0400, Jan Harkes wrote:
> On Wed, May 19, 2004 at 02:51:06AM +0200, Andrea Arcangeli wrote:
> > On Tue, May 18, 2004 at 05:27:18PM -0700, Andrew Morton wrote:
> > > Andrea Arcangeli <andrea@suse.de> wrote:
> > > >
> > > > Something broke in invalidate_inode_pages2 between 2.4 and 2.6, this
> > > > causes malfunctions with mapped pages in 2.6.
> > > 
> > > What is the malfunction?
> > 
> > From Olaf Kirch
> > 
> >  -      single application on NFS client opens file and maps it.
> >         No-one else has this file open. File contains "zappa\n",
> >         and the test app stats it once a second and reports size and
> >         contents.
> >         len=6, data=7a 61 70 70 61 0a
> >  -      on the NFS server, I do "echo frobnorz > file"
> >  -      after a while, the test app on the client reports
> >         len=10, data=7a 61 70 70 61 0a
> 
> I'm mostly just curious, what exactly happens when a second process
> opens and mmaps the file at this point? Will it also see the new length
> with the old data, or will that invalidate the mapping and pull the new
> data off of the server?

depends if the new process will generate page faults or not. if it
generates page faults it will re-read the pages from the server while
the other task runs.

> Also what happens if the process had a shared mapping and dirtied the
> page (f.i. it wrote a byte to to offset 0) but the update hasn't yet
> been written back, will it end up committing the (stale) data from the
> local copy of the page but with the updated length=10 back to the server?

it will not commit the stale data because the invalidate clears the
dirty bit, again the new data will arrive from the server. Note that if
there's some VM paging in the client NFS side, the very same task can
pull the data again from the nfs server during pagein (the writeback
during pageout will not happen because the cache has been invalidated
and the dirty bit has been lost).
