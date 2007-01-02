Return-Path: <linux-kernel-owner+w=401wt.eu-S1752879AbXABXrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbXABXrG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752874AbXABXrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:47:06 -0500
Received: from pat.uio.no ([129.240.10.15]:57055 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752871AbXABXrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:47:05 -0500
Subject: RE: Finding hardlinks
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Halevy, Benny" <bhalevy@panasas.com>
Cc: Jeff Layton <jlayton@poochiereds.net>,
       Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Arjan van de Ven <arjan@infradead.org>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
In-Reply-To: <E472128B1EB43941B4E7FB268020C89B149CF0@riverside.int.panasas.com>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
	 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>
	 <20061221185850.GA16807@delft.aura.cs.cmu.edu>
	 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
	 <1166869106.3281.587.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
	 <4593890C.8030207@panasas.com> <4593C524.8070209@poochiereds.net>
	 <4593DEF8.5020609@panasas.com>
	 <1167387128.6106.32.camel@lade.trondhjem.org>
	 <E472128B1EB43941B4E7FB268020C89B149CF0@riverside.int.panasas.com>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 00:46:44 +0100
Message-Id: <1167781604.6090.120.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.6, required=12.0, autolearn=ham, BAYES_00=-2.599,UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: 315E5F58653822D50F1E647A0575E5A5CECB8247
X-UiO-SPAM-Test: 83.109.147.16 spam_score -75 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-31 at 16:19 -0500, Halevy, Benny wrote:

> Even for NFSv3 (that doesn't have the unique_handles attribute I think
> that the linux nfs client can do a better job.  If you'd have a filehandle
> cache that points at inodes you could maintain a many to one relationship
> from multiple filehandles into one inode.  When you discover a new filehandle
> you can look up the inode cache for the same fileid and if one is found you
> can do a getattr on the old filehandle (without loss of generality you should 
> always use the latest filehandle that was returned for that filesystem object,
> although any filehandle that refers to it can be used).
> If the getattr succeeded then the filehandles refer to the same fs object and
> you can create a new entry in the filehandle cache pointing at that inode.
> Otherwise, if getattr says that the old filehandle is stale I think you should
> mark the inode as stale and keep it around so that applications can get an
> appropriate error until last close, before you clean up the fh cache from the
> stale filehandles. A new inode structure should be created for the new filehandle.

There are, BTW, other reasons why the above is a bad idea: it breaks on
a bunch of well known servers. Look back at the 2.2.x kernels and the
kind of hacks they had in order to deal with crap like the Netapp
'.snapshot' directories which contain files with duplicate fileids that
do not represent hard links, but rather represent previous revisions of
the same file.

That kind of hackery was part of the reason why I ripped out that code.
The other reasons were
        - that you end up playing unnecessary getattr games like the
        above for little gain.
        - the only servers that implemented the above were borken pieces
        of crap that encoded parent directories in the filehandle, and
        which end up breaking anyway under cross-directory renames.
        - the world is filled with non-posix filesystems that frequently
        don't have real fileids. They are often just generated on the
        fly and can change at the drop of a hat.

Trond

