Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWCBKgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWCBKgP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 05:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWCBKgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 05:36:15 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:46233 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751437AbWCBKgP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 05:36:15 -0500
Date: Thu, 2 Mar 2006 10:36:03 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Steven Whitehouse <steve@chygwyn.com>
Cc: Phillip Susi <psusi@cfl.rr.com>, Christoph Hellwig <hch@infradead.org>,
       Steven Whitehouse <swhiteho@redhat.com>, Andrew Morton <akpm@osdl.org>,
       David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: GFS2 Filesystem [0/16]
Message-ID: <20060302103603.GX27946@ftp.linux.org.uk>
References: <1140792511.6400.707.camel@quoit.chygwyn.com> <20060224213553.GA8817@infradead.org> <440485E7.4090702@cfl.rr.com> <20060302101219.GA22243@souterrain.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060302101219.GA22243@souterrain.chygwyn.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 10:12:19AM +0000, Steven Whitehouse wrote:
> Hi,
> 
> On Tue, Feb 28, 2006 at 12:18:31PM -0500, Phillip Susi wrote:
> > I'm a bit confused.  Why exactly is this unacceptable, and what exactly 
> > do you propose instead?  Having an entirely separate mount point that is 
> > sort of parallel to the main one, but with extra metadata exposed?  So 
> > instead of /path/to/foo/.gfs2_admin/metafile you'd prefer having a 
> > separate mount point like /proc/fs/gfs/path/to/foo/metafile?
> >
> I believe that is what Christoph is proposing. It does simplify certain
> things, not least preventing someone from moving the .gfs2_admin directory
> to somewhere other than the root directory of the filesystem or even
> removing it completely which would otherwise need to be added as special
> cases.
> 
> On the otherhand, its not clear to me at the moment, exactly how to
> implement this bearing in mind that both the "normal" filesystem and
> the metadata filesystem are really one and the same as far as journaling
> and locking are concerned. Perhaps what's needed is one fs with two
> different roots. I'm still looking into the best way to do this,

Two superblocks, one keeping a reference to another.  Filesystem driver is,
of course, the single piece of code, with common locking.  There's no need
to have the common struct super_block for that and no benefit in doing so -
only extra complications.  You can easily register two filesystem types
in the same driver and have ->get_sb() for your metadata fs parse its
arguments in any way it likes.  E.g. by doing pathname lookup on what would
normally be a device name and seeing if its on a filesystem of the primary
type; if it is - grab a reference to struct super_block of that fs
and work with it.
