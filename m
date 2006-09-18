Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965573AbWIRIYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965573AbWIRIYE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965581AbWIRIYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:24:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21172 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965577AbWIRIYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:24:00 -0400
Subject: Re: [PATCH 05/16] GFS2: File and inode operations
From: Steven Whitehouse <swhiteho@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060916133947.GA1498@infradead.org>
References: <1157031183.3384.793.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0609040824290.9108@yvahk01.tjqt.qr>
	 <20060916133947.GA1498@infradead.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 18 Sep 2006 09:27:22 +0100
Message-Id: <1158568042.11901.267.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2006-09-16 at 14:39 +0100, Christoph Hellwig wrote:
> > 
> > >+struct file gfs2_internal_file_sentinal = {
> > >+	.f_flags = O_NOATIME|O_RDONLY,
> > >+};
> 
> Statically allocation a struct file is not allowed.  Where do you use
> gfs2_internal_read?  It really shouldn't be needed.
> 
The sentinel is used as a flag value only. Its passed through to the
underlying address space operations of readpage(s) to indicate that the
glock for the inode is already held and therefore locking isn't required
at the address space operations level. The glock is used to ensure
consistancy when reading certain "internal" files.

For example, the resource index contains a list of all the resource
groups on disk and is written through the gfs2meta filesystem when the
filesystem is expanded. We need a way to read the resource index in, in
such a way as to ensure its not being updated in the middle of the read.
So we use gfs2_internal_read to do that, holding the glock for the
entire operation.

It has a similar use for some of the other internal files as well.

> > >+static int gfs2_readdir(struct file *file, void *dirent, filldir_t filldir)
> > >+{
> > >+	int error;
> > >+
> > >+	if (strcmp(current->comm, "nfsd") != 0)
> > 
> > Is not there a better way to do this? Note that there is also a "nfsd4" process
> 
> This is in fact not allowed at at all.  Please fix you readdir code not to
> need special cases for nfsd.
> 
Perhaps you can suggest a solution to the problem.... We have a bz
#201015 (in bugzilla.redhat.com) tracking this.

The problem is caused by the way in which nfsd does a stat from
readdir's filldir routine. We have to acquire and drop the directory
glock in filldir otherwise it may deadlock with the glocks which are
taken by stat. As a result of this, we then have to revalidate the
position in the directory on each call to filldir, rather than locking
the whole readdir call as the "normal" version does, so the current nfs
variant of readdir is much slower than the "normal" one even though it
could otherwise potentially be used for both cases.

I will try and have a look at this problem in more detail some time this
week,

Steve.


