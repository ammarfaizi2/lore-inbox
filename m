Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263789AbTEYWSr (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 18:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbTEYWSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 18:18:47 -0400
Received: from pat.uio.no ([129.240.130.16]:48059 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263789AbTEYWSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 18:18:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16081.17490.889937.791357@charged.uio.no>
Date: Mon, 26 May 2003 00:31:46 +0200
To: Peter Braam <braam@clusterfs.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
   Linux FSdevel <linux-fsdevel@vger.kernel.org>,
   Linux Kernel <linux-kernel@vger.kernel.org>,
   NFS maillist <nfs@lists.sourceforge.net>,
   lustre-devel@lists.sourceforge.net
Subject: intent patches
In-Reply-To: <20030525074243.GF18405@localhost.localdomain>
References: <20030525074243.GF18405@localhost.localdomain>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Peter Braam <braam@clusterfs.com> writes:

     > We _do_ have resources to sort it all out very agressively in
     > the next few weeks.

Good. Let's do that...

     > We currently use intents for two methods:
     > - getattr
     > - open
     > For other methods, we would like the intents also, but they did
     > not solve all our woes.  We may have overlooked one or two,
     > like permission.

Permission provides a pretty major source of optimization as far as
NFS is concerned: we can ignore it for all operations *except* open(),
and cached lookup().

     > We introduced lookup2 and d_revalidate2 to avoid changing all
     > file systems and in 2.5 we give them a namei data parameter.

Is this really desirable? It makes maintenance easy when you are
making add-on patches for the kernel, but IMHO it otherwise just makes
for a confusing interface.

     > We would like to pass a pointer to nameidata to:

     > - open (file method)
     > - create directory (inode method)
     > - lookup (inode method)
     > - revalidate (dentry method)

All those are good as far as I'm concerned.

     > - revalidate (inode method)

That's no longer in 2.5.x. Do you perhaps mean the new getattr()?

     > and perhaps also to mkdir, rmdir, unlink, rename, mknod,
     > setattr.

setattr() may help for NFSv4 where we can do open(O_TRUNC) atomically
on the server, and could optimize away the truncation.

The other ops aren't really prime candidates for optimization,
although we could possibly plonk the lookup+op into a single RPC call
by means of the COMPOUND call (again NFSv4 only).

     >   We have not done so yet, and can work aroud this by adding a
     >   field
     >      struct lookup_intent *d_it
     > in a dentry. This is not elegant, and the protection of this
     > field is delicate, but avoids large scale api changes.

Hmmm...

     > Trond changes all callers instead of adding lookup2 (better
     > long term, very invasive for pre-2.6)

We could mitigate the effects by making the nameidata field an
optional one. Of course, that would make it harder to add support for
credentials.

     > he has vfsintent point to nameidata and inside "opendata" and
     > we have the exact opposite...

Swapping will fail to offend any deeply held religious beliefs of
mine. No problems there...

     > We do all methods.

Yep. As you can see I've looked only at those methods that are known
to have the largest impact w.r.t. the NFS client.

Cheers,
  Trond
