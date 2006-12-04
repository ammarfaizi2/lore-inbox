Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759815AbWLDJJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759815AbWLDJJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 04:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759822AbWLDJJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 04:09:58 -0500
Received: from fogou.chygwyn.com ([195.171.2.24]:24706 "EHLO fogou.chygwyn.com")
	by vger.kernel.org with ESMTP id S1759814AbWLDJJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 04:09:57 -0500
Subject: Re: [Cluster-devel] Re: [GFS2] Fix incorrect fs sync behaviour
	[2/5]
From: Steven Whitehouse <steve@chygwyn.com>
To: Russell Cattelan <cattelan@redhat.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1164995853.1194.42.camel@xenon.msp.redhat.com>
References: <1162811279.18219.32.camel@quoit.chygwyn.com>
	 <1164995853.1194.42.camel@xenon.msp.redhat.com>
Content-Type: text/plain
Organization: ChyGwyn Limited
Date: Mon, 04 Dec 2006 09:12:12 +0000
Message-Id: <1165223532.3752.561.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "fogou.chygwyn.com", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Fri, 2006-12-01 at 11:57 -0600, Russell Cattelan
	wrote: > On Mon, 2006-11-06 at 11:07 +0000, Steven Whitehouse wrote: > >
	>From 4a221953ed121692aa25998451a57c7f4be8b4f6 Mon Sep 17 00:00:00 2001
	> > From: Steven Whitehouse <swhiteho@redhat.com> > > Date: Wed, 1 Nov
	2006 09:57:57 -0500 > > Subject: [PATCH] [GFS2] Fix incorrect fs sync
	behaviour. > > > > This adds a sync_fs superblock operation for GFS2 and
	removes > > the journal flush from write_super in favour of sync_fs
	where it > > ought to be. This is more or less identical to the way in
	which ext3 > > does this. > > > > This bug was pointed out by Russell
	Cattelan <cattelan@redhat.com> > > > > Cc: Russell Cattelan
	<cattelan@redhat.com> > > Signed-off-by: Steven Whitehouse
	<swhiteho@redhat.com> > > --- > > fs/gfs2/ops_super.c | 44
	++++++++++++++++++++++++++++ > > 1 files changed, 28 insertions(+), 16
	deletions(-) > > > > diff --git a/fs/gfs2/ops_super.c
	b/fs/gfs2/ops_super.c > > index 06f06f7..b47d959 100644 > > ---
	a/fs/gfs2/ops_super.c > > +++ b/fs/gfs2/ops_super.c > > @@ -138,16
	+138,27 @@ static void gfs2_put_super(struct super_ > > } > > > > /** >
	> - * gfs2_write_super - disk commit all incore transactions > > - *
	@sb: the filesystem > > + * gfs2_write_super > > + * @sb: the superblock
	> > * > > - * This function is called every time sync(2) is called. > >
	- * After this exits, all dirty buffers are synced. > > */ > > > >
	static void gfs2_write_super(struct super_block *sb) > > { > > +
	sb->s_dirt = 0; > This is a bit different than my original patch? This
	was largely taken from the ext3 code as an example, rather than your
	patch. [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-12-01 at 11:57 -0600, Russell Cattelan wrote:
> On Mon, 2006-11-06 at 11:07 +0000, Steven Whitehouse wrote:
> > >From 4a221953ed121692aa25998451a57c7f4be8b4f6 Mon Sep 17 00:00:00 2001
> > From: Steven Whitehouse <swhiteho@redhat.com>
> > Date: Wed, 1 Nov 2006 09:57:57 -0500
> > Subject: [PATCH] [GFS2] Fix incorrect fs sync behaviour.
> > 
> > This adds a sync_fs superblock operation for GFS2 and removes
> > the journal flush from write_super in favour of sync_fs where it
> > ought to be. This is more or less identical to the way in which ext3
> > does this.
> > 
> > This bug was pointed out by Russell Cattelan <cattelan@redhat.com>
> > 
> > Cc: Russell Cattelan <cattelan@redhat.com>
> > Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
> > ---
> >  fs/gfs2/ops_super.c |   44 ++++++++++++++++++++++++++++----------------
> >  1 files changed, 28 insertions(+), 16 deletions(-)
> > 
> > diff --git a/fs/gfs2/ops_super.c b/fs/gfs2/ops_super.c
> > index 06f06f7..b47d959 100644
> > --- a/fs/gfs2/ops_super.c
> > +++ b/fs/gfs2/ops_super.c
> > @@ -138,16 +138,27 @@ static void gfs2_put_super(struct super_
> >  }
> >  
> >  /**
> > - * gfs2_write_super - disk commit all incore transactions
> > - * @sb: the filesystem
> > + * gfs2_write_super
> > + * @sb: the superblock
> >   *
> > - * This function is called every time sync(2) is called.
> > - * After this exits, all dirty buffers are synced.
> >   */
> >  
> >  static void gfs2_write_super(struct super_block *sb)
> >  {
> > +	sb->s_dirt = 0;
> This is a bit different than my original patch?
This was largely taken from the ext3 code as an example, rather than
your patch.

>  
> Are you sure we don't need the s_lock here?
> 
Yes. See linux-2.6/Documentation/filesystems/Locking:


locking rules:
        All may block.
                        BKL     s_lock  s_umount
[snip]
write_super:            no      yes     read

it is already held on entry to write_super,

Steve.


