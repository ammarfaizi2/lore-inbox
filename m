Return-Path: <linux-kernel-owner+w=401wt.eu-S1750849AbWL2K3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWL2K3Y (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 05:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWL2K3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 05:29:24 -0500
Received: from pat.uio.no ([129.240.10.15]:39827 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbWL2K3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 05:29:23 -0500
Subject: Re: [nfsv4] RE: Finding hardlinks
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Halevy, Benny" <bhalevy@panasas.com>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, nfsv4@ietf.org,
       linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@poochiereds.net>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <E472128B1EB43941B4E7FB268020C89B149CEC@riverside.int.panasas.com>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
	 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>
	 <20061221185850.GA16807@delft.aura.cs.cmu.edu>
	 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
	 <1166869106.3281.587.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
	 <4593890C.8030207@panasas.com> <4593C524.8070209@poochiereds.net>
	 <4593DEF8.5020609@panasas.com>
	 <Pine.LNX.4.64.0612281916230.2960@artax.karlin.mff.cuni.cz>
	 <E472128B1EB43941B4E7FB268020C89B149CEC@riverside.int.panasas.com>
Content-Type: text/plain
Date: Fri, 29 Dec 2006 11:28:49 +0100
Message-Id: <1167388129.6106.45.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=failed, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: BDB21F42809B1EB74B04066B4164AA29E4350D1B
X-UiO-SPAM-Test: 83.109.147.16 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-28 at 15:07 -0500, Halevy, Benny wrote:
> Mikulas Patocka wrote:

> >BTW. how does (or how should?) NFS client deal with cache coherency if 
> >filehandles for the same file differ?
> >
> 
> Trond can probably answer this better than me...
> As I read it, currently the nfs client matches both the fileid and the
> filehandle (in nfs_find_actor). This means that different filehandles
> for the same file would result in different inodes :(.
> Strictly following the nfs protocol, comparing only the fileid should
> be enough IF fileids are indeed unique within the filesystem.
> Comparing the filehandle works as a workaround when the exported filesystem
> (or the nfs server) violates that.  From a user stand point I think that
> this should be configurable, probably per mount point.

Matching files by fileid instead of filehandle is a lot more trouble
since fileids may be reused after a file has been deleted. Every time
you look up a file, and get a new filehandle for the same fileid, you
would at the very least have to do another GETATTR using one of the
'old' filehandles in order to ensure that the file is the same object as
the one you have cached. Then there is the issue of what to do when you
open(), read() or write() to the file: which filehandle do you use, are
the access permissions the same for all filehandles, ...

All in all, much pain for little or no gain.

Most servers therefore take great pains to ensure that clients can use
filehandles to identify inodes. The exceptions tend to be broken in
other ways (Note: knfsd without the no_subtree_check option is one of
these exceptions - it can break in the case of cross-directory renames).

Cheers,
  Trond

