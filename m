Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWJJNQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWJJNQZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 09:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWJJNQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 09:16:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61600 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750728AbWJJNQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 09:16:24 -0400
Date: Tue, 10 Oct 2006 15:16:03 +0200
From: Jan Kara <jack@suse.cz>
To: Eric Sandeen <sandeen@sandeen.net>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, esandeen@redhat.com,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: 2.6.18 ext3 panic.
Message-ID: <20061010131603.GL23622@atrey.karlin.mff.cuni.cz>
References: <20061002194711.GA1815@redhat.com> <20061003052219.GA15563@redhat.com> <4521F865.6060400@sandeen.net> <20061002231945.f2711f99.akpm@osdl.org> <452AA716.7060701@sandeen.net> <20061009224050.GD30283@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009224050.GD30283@lug-owl.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2006-10-09 14:46:30 -0500, Eric Sandeen <sandeen@sandeen.net> wrote:
> > Andrew Morton wrote:
> > > On Tue, 03 Oct 2006 00:43:01 -0500
> > > Eric Sandeen <sandeen@sandeen.net> wrote:
> > > > Dave Jones wrote:
> > > > > So I managed to reproduce it with an 'fsx foo' and a
> > > > > 'fsstress -d . -r -n 100000 -p 20 -r'. This time I grabbed it from
> > > > > a vanilla 2.6.18 with none of the Fedora patches..
> > > > >
> > > > > I'll give 2.6.18-git a try next.
> > > > >
> > > > > ----------- [cut here ] --------- [please bite here ] ---------
> > > > > Kernel BUG at fs/buffer.c:2791
> > > > I had thought/hoped that this was fixed by Jan's patch at 
> > > > http://lkml.org/lkml/2006/9/7/236 from the thread started at 
> > > > http://lkml.org/lkml/2006/9/1/149, but it seems maybe not.  Dave hit this bug 
> > > > first by going through that new codepath....
> > > 
> > > Yes, Jan's patch is supposed to fix that !buffer_mapped() assertion.  iirc,
> > > Badari was hitting that BUG and was able to confirm that Jan's patch
> > > (3998b9301d3d55be8373add22b6bc5e11c1d9b71 in post-2.6.18 mainline) fixed
> > > it.
> > 
> > Looking at some BH traces*, it appears that what Dave hit is a truncate
> > racing with a sync...
> > 
> > truncate ...
> >   ext3_invalidate_page
> >     journal_invalidatepage
> >       journal_unmap buffer
> > 
> > going off at the same time as
> > 
> > sync ...
> >   journal_dirty_data
> >     sync_dirty_buffer
> >       submit_bh <-- finds unmapped buffer, boom.
> 
> Is this possibly related to the issues that are discussed in another
> thread? We're seeing problems while unlinking large files (usually get
> it within some hours with 200MB files, but couldn't yet reproduce it
> with 20MB.)
  I don't think this is related (BTW: I've run your test for 5 hours
without any luck ;( Maybe I'll try again for some longer time...).

									Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
