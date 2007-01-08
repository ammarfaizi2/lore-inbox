Return-Path: <linux-kernel-owner+w=401wt.eu-S1161238AbXAHL3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161238AbXAHL3h (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 06:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161237AbXAHL3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 06:29:37 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37394 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161233AbXAHL3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 06:29:36 -0500
Date: Mon, 8 Jan 2007 12:29:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mikulas@artax.karlin.mff.cuni.cz, matthew@wil.cx, bhalevy@panasas.com,
       arjan@infradead.org, jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@ietf.org
Subject: Re: Finding hardlinks
Message-ID: <20070108112916.GB25857@elf.ucw.cz>
References: <20070103135455.GA24620@parisc-linux.org> <E1H28Oi-0003kw-00@dorka.pomaz.szeredi.hu> <20070104225929.GC8243@elf.ucw.cz> <E1H2kfa-0007Jl-00@dorka.pomaz.szeredi.hu> <20070105131235.GB4662@ucw.cz> <E1H2pXI-0007jY-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.64.0701051502120.28914@artax.karlin.mff.cuni.cz> <E1H2qhP-0007qc-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.64.0701080652220.3506@artax.karlin.mff.cuni.cz> <E1H3qCY-0004mP-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1H3qCY-0004mP-00@dorka.pomaz.szeredi.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >> No one guarantees you sane result of tar or cp -a while changing the tree.
> > >> I don't see how is_samefile() could make it worse.
> > >
> > > There are several cases where changing the tree doesn't affect the
> > > correctness of the tar or cp -a result.  In some of these cases using
> > > samefile() instead of st_ino _will_ result in a corrupted result.
> > 
> > ... and those are what?
> 
>   - /a/p/x and /a/q/x are links to the same file
> 
>   - /b/y and /a/q/y are links to the same file
> 
>   - tar is running on /a
> 
>   - meanwhile the following commands are executed:
> 
>      mv /a/p/x /b/x
>      mv /b/y /a/p/x
> 
> With st_ino checking you'll get a perfectly consistent archive,
> regardless of the timing.  With samefile() you could get an archive
> where the data in /a/q/y is not stored, instead it will contain the
> data of /a/q/x.
> 
> Note, this is far nastier than the "normal" corruption you usually get
> with changing the tree under tar, the file is not just duplicated or
> missing, it becomes a completely different file, even though it hasn't
> been touched at all during the archiving.
> 
> The basic problem with samefile() is that it can only compare files at
> a single snapshot in time, and cannot take into account any changes in
> the tree (unless keeping files open, which is impractical).

> There's really no point trying to push for such an inferior interface
> when the problems which samefile is trying to address are purely
> theoretical.

Oh yes, there is. st_ino is powerful, *but impossible to implement*
on many filesystems. You are of course welcome to combine st_ino with
samefile.

> Currently linux is living with 32bit st_ino because of legacy apps,
> and people are not constantly agonizing about it.  Fixing the
> EOVERFLOW problem will enable filesystems to slowly move towards 64bit
> st_ino, which should be more than enough.

50% probability of false positive on 4G files seems like very ugly
design problem to me.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
