Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbUC2IAw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 03:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbUC2IAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 03:00:52 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:61200 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262736AbUC2IAt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 03:00:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jamie Lokier <jamie@shareable.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] cowlinks v2
Date: Mon, 29 Mar 2004 09:45:28 +0200
X-Mailer: KMail [version 1.4]
Cc: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <m1ekrgyf5y.fsf@ebiederm.dsl.xmission.com> <m14qs8vipz.fsf@ebiederm.dsl.xmission.com> <20040328235528.GA2693@mail.shareable.org>
In-Reply-To: <20040328235528.GA2693@mail.shareable.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200403290945.29003.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 March 2004 01:55, Jamie Lokier wrote:
> Eric W. Biederman wrote:
> > A COW on a directory implies a COW on everything in it.  So the
> > implication is an atomic snapshot of that directory and everything below
> > it.
> >
> > Assuming no files are open and in use.  The implementation would
> > create the cow link on the directory just like it would on a file.
> > Then when you open/modify a directory or file the cow copies would be
> > taken up to the point of the original cow directory so you have a
> > separate directory structure.
> >
> > All of which works great until you have a file that has one hard link
> > in your cow directory structure and another hard link outside of
> > any cow.  An application can come in and modify the file through that
> > second cow link causing problems.
>
> I don't see that problem (although I see another, see below).  The
> application will modify only one instance of the file, and it's the
> correct instance.  If the application writes through the link outside
> both trees, or the link inside the original tree, it will only affect
> the tree that was cowlinked _from_, which is correct.  If the
> application writes to the name inside the snapshot tree, it will only
> affect that tree, which is also correct.
>
> You cowlinked a directory.  That converts the original directory inode
> to a cowlink, creates another cowlink, and creates a shared inode
> which now contains the directory.
>
> Then you modify the directory or anything below it.  That duplicates
> the directory, breaking the directory cowlinks and duplicating the
> shared directory inode -- so that the two directory cowlink inodes
> become normal directory inodes.  The directory duplication results in
> two directory which are full of cowlinks -- every object in the
> original directory is cowlinked by this operation.
>
> A file which was originally hard-linked inside the tree and also
> outside both trees retains the correct hard-link identity: the hard
> link is simply two directory entries referring to the same inode,
> which at all times is the inode visible inside the original tree and
> not visible inside the snapshot, cowlinked tree.  That inode changes
> its underlying representation from file-inode to cowlink-inode
> (pointing to a shared file-inode) and back again during these
> operations.  However, the hard link identity remains correct at all
> times.  Writing to a file won't ever modify the wrong file.
>
> There is a different problem, though: cowlinking whole trees like that
> doesn't preserve hard-linkage _within_ the tree being copied.  Each
> time a directory is lazily duplicated, every entry in it is cowlinked,
> and if two or more entries are hard linked to the same inode, the
> cowlinked copies won't share an inode.  It's as if you did "cp -p"
> instead of "cp -pd".  This can be solved easily within a single
> directory, but when there are hard linked within the tree from
> different directories, it's too hard to solve with lazy directory
> duplication, without keeping a lot of extra metadata.  (That's the
> same metadata that "cp --preserve=links" or "rsync -H" has to keep
> track of when copying a whole tree: on my home system, there's so much
> of it due to hard links that rsync can't copy my home directory).

Personally I'll dump hardlinks functionality entirely if I'll get
working cowlinks instead. Most of the time, hardlinks used to save space
and/or provide alternate names to programs/whatever,
but then you have to be damn careful to remember what is linked where.

Softlinks can be used insteal, and actually they are better for
alternate naming purpose, with them I easily see that it is
a link and where it points.

But cowlinks are *ultimate* space saving stuff because they never
make you fail and update wrong file, as it happens with hardlinks.
It just all works the Right Way.
--
vda
