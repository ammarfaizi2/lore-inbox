Return-Path: <linux-kernel-owner+w=401wt.eu-S1161043AbXAEK3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbXAEK3j (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 05:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbXAEK3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 05:29:38 -0500
Received: from pat.uio.no ([129.240.10.15]:40210 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161043AbXAEK3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 05:29:37 -0500
Subject: Re: [nfsv4] RE: Finding hardlinks
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Benny Halevy <bhalevy@panasas.com>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, nfsv4@ietf.org,
       linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@poochiereds.net>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <459E0C11.4020203@panasas.com>
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
	 <1167388129.6106.45.camel@lade.trondhjem.org>
	 <E472128B1EB43941B4E7FB268020C89B149CF1@riverside.int.panasas.com>
	 <1167780097.6090.104.camel@lade.trondhjem.org>
	 <459BA30A.4020809@panasas.com>
	 <1167899796.6046.11.camel@lade.trondhjem.org>
	 <459CD11E.3000200@panasas.com>
	 <1167907640.6046.44.camel@lade.trondhjem.org>
	 <459E0C11.4020203@panasas.com>
Content-Type: text/plain
Date: Fri, 05 Jan 2007 11:29:13 +0100
Message-Id: <1167992953.6050.21.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.5, required=12.0, autolearn=disabled, AWL=2.500,UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: 0352CDEBA746EF61ADEE97B31D98111588B354F8
X-UiO-SPAM-Test: 83.109.147.16 spam_score -24 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2007-01-05 at 10:28 +0200, Benny Halevy wrote:
> Trond Myklebust wrote:
> > Exactly where do you see us violating the close-to-open cache
> > consistency guarantees?
> > 
> 
> I haven't seen that. What I did see is cache inconsistency when opening
> the same file with different file descriptors when the filehandle changes.
> My testing shows that at least fsync and close fail with EIO when the filehandle
> changed while there was dirty data in the cache and that's good. Still,
> not sharing the cache while the file is opened (even on a different file
> descriptors by the same process) seems impractical.

Tough. I'm not going to commit to adding support for multiple
filehandles. The fact is that RFC3530 contains masses of rope with which
to allow server and client vendors to hang themselves. The fact that the
protocol claims support for servers that use multiple filehandles per
inode does not mean it is necessarily a good idea. It adds unnecessary
code complexity, it screws with server scalability (extra GETATTR calls
just in order to probe existing filehandles), and it is insufficiently
well documented in the RFC: SECINFO information is, for instance, given
out on a per-filehandle basis, does that mean that the server will have
different security policies? In some places, people haven't even started
to think about the consequences:

      If GETATTR directed to the two filehandles does not return the
      fileid attribute for both of the handles, then it cannot be
      determined whether the two objects are the same.  Therefore,
      operations which depend on that knowledge (e.g., client side data
      caching) cannot be done reliably.

This implies the combination is legal, but offers no indication as to
how you would match OPEN/CLOSE requests via different paths. AFAICS you
would have to do non-cached I/O with no share modes (i.e. NFSv3-style
"special" stateids). There is no way in hell we will ever support
non-cached I/O in NFS other than the special case of O_DIRECT.


...and no, I'm certainly not interested in "fixing" the RFC on this
point in any way other than getting this crap dropped from the spec. I
see no use for it at all.

Trond

