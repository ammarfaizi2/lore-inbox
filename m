Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281932AbRLQSms>; Mon, 17 Dec 2001 13:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282082AbRLQSmj>; Mon, 17 Dec 2001 13:42:39 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:5846 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281932AbRLQSm1>;
	Mon, 17 Dec 2001 13:42:27 -0500
Date: Mon, 17 Dec 2001 13:42:25 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        dzafman@kahuna.cag.cpqcorp.net, linux-kernel@vger.kernel.org
Subject: Re: NFS client llseek
In-Reply-To: <20011217181748.GA15970@cs.cmu.edu>
Message-ID: <Pine.GSO.4.21.0112171339180.3992-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Dec 2001, Jan Harkes wrote:

> On Fri, Dec 14, 2001 at 01:51:36PM +0100, Trond Myklebust wrote:
> > Just one comment: Isn't it easier to do this in generic_file_llseek()
> > itself using inode->i_op->revalidate()? That would make it work for
> > coda and smbfs too...
> 
> Actually, as far as Coda is concerned this only adds overhead. Coda uses
> AFS2 session semantics instead of UNIX semantics, so updates are only
> propagated when a file is closed.
> 
> Adding this to the generic_file_llseek will force an useless but
> expensive upcall (and RPC call to the server) to every seek to check for
> an updated i_size while we already know that the i_size of the file
> won't have to change until it is closed and reopened.
> 
> I guess we're just (mis-)using the revalidate call as a replacement of a
> missing call to i_ops->getattr from sys_stat. So perhaps adding the
> revalidate to the generic_llseek is fine, but I'll just have to get that
> missing getattr call into the tree.

As far as I'm concerned it's not fine.

->getattr() is needed and will be added (patch exists), but the thing
about ->revalidate()...  It's a bloody mess that will need serious
cleanups.  And I'd rather have fewer code paths involved into that
cleanup.

	So please, do it in nfs_lseek() explicitly.  If you want to use
generic_file_lseek() - wonderful, call it from nfs_lseek() after you've
done revalidation.

