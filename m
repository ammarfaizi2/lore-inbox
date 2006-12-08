Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425334AbWLHK0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425334AbWLHK0A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 05:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425333AbWLHK0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 05:26:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35635 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425334AbWLHKZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 05:25:59 -0500
Subject: Re: [Cluster-devel] Re: [GFS2] Don't flush everything on fdatasync
	[70/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Wendy Cheng <wcheng@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, cluster-devel@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <457865DC.3020608@redhat.com>
References: <1164889448.3752.449.camel@quoit.chygwyn.com>
	 <20061130230158.174e995c.akpm@osdl.org>
	 <1164970738.3752.508.camel@quoit.chygwyn.com>
	 <20061201110927.ec6ee073.akpm@osdl.org>
	 <1165482686.3752.816.camel@quoit.chygwyn.com> <457865DC.3020608@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 08 Dec 2006 10:29:27 +0000
Message-Id: <1165573767.3752.927.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2006-12-07 at 14:05 -0500, Wendy Cheng wrote:
> Steven Whitehouse wrote:
> > Hi,
> >
> > On Fri, 2006-12-01 at 11:09 -0800, Andrew Morton wrote:
> >   
> >>> I was taking my cue here from ext3 which does something similar. The
> >>> filemap_fdatawrite() is done by the VFS before this is called with a
> >>> filemap_fdatawait() afterwards. This was intended to flush the metadata
> >>> via (eventually) ->write_inode() although I guess I should be calling
> >>> write_inode_now() instead?
> >>>       
> >> oh I see, you're jsut trying to write the inode itself, not the pages.
> >>
> >> write_inode_now() will write the pages, which you seem to not want to do.
> >> Whatever.  The APIs here are a bit awkward.
> >>     
> >
> > I've added a comment to explain whats going on here, and also the
> > following patch. I know it could be better, but its still an improvement
> > on what was there before,
> >
> >
> >   
> Steve,
> 
> I'm in the middle of something else and don't have upstream kernel 
> source handy at this moment. But I read akpm's comment as 
> "write_inode_now" would do writepage and that is *not* what you want (?) 
> (since vfs has done that before this call is invoked). I vaguely 
> recalled I did try write_inode_now() on GFS1 once but had to replace it 
> with "sync_inode" on RHEL4 (for the reason that I can't remember at this 
> moment). I suggest you keep "sync_inode" (at least for a while until we 
> can prove other call can do better). This "sync_inode" has been well 
> tested out (with GFS1's fsync call).
> 
Ok. Its gone upstream now, but I'm happy to revert that change if it
turns out to be a problem. My tests show identical performance between
the two calls, but maybe there is a corner case I missed?

Both calls do writepage() but since the VFS has already done it for us,
the chances of there being any more dirty pages to write is fairly
small, so its unlikely to be much of a problem I think, but I'm willing
to be proved wrong if there is a good reason.

> There is another issue. It is a gray area. Note that you don't grab any 
> glock here ... so if someone *has* written something in other nodes, 
> this sync could miss it (?). This depends on how people expects a 
> fsync/fdatasync should behave in a cluster filesystem. GFS1 asks for a 
> shared lock here so it will force other node to flush the data (I 
> personally think this is a more correct behavior). Your call though.
> 
> -- Wendy
> 
Its a tricky one to deal with. I would expect that the chances of an
application relying on an fsync on one node to cause a cross-cluster
flush is relatively unlikely. It would mean that there would have to be
another communication channel between the processes on the different
nodes through which the node that was writing data could request a flush
and then receive notification that it has finished, otherwise it would
not seem to make any sense. It would seem an odd way to write an
application, but maybe one does exist which does this somewhere.

Delving back into the history it looks like this is a change (with
respect to gfs1) made by Ken rather than myself. I don't mind adding
this feature though, but even so what we have now is still a marked
improvement on what was there previously I think,

Steve.


