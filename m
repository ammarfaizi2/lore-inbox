Return-Path: <linux-kernel-owner+w=401wt.eu-S1030375AbXAEIon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbXAEIon (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 03:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbXAEIon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 03:44:43 -0500
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:44251 "EHLO
	mail-gw1.sa.eol.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030375AbXAEIom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 03:44:42 -0500
To: pavel@ucw.cz
CC: matthew@wil.cx, bhalevy@panasas.com, arjan@infradead.org,
       mikulas@artax.karlin.mff.cuni.cz, jaharkes@cs.cmu.edu,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
In-reply-to: <20070104225929.GC8243@elf.ucw.cz> (message from Pavel Machek on
	Thu, 4 Jan 2007 23:59:29 +0100)
Subject: Re: Finding hardlinks
References: <4593890C.8030207@panasas.com> <1167300352.3281.4183.camel@laptopd505.fenrus.org> <4593E1B7.6080408@panasas.com> <E1H01Og-0007TF-00@dorka.pomaz.szeredi.hu> <20070102191504.GA5276@ucw.cz> <E1H1qRa-0001t7-00@dorka.pomaz.szeredi.hu> <20070103115632.GA3062@elf.ucw.cz> <E1H25JD-0003SN-00@dorka.pomaz.szeredi.hu> <20070103135455.GA24620@parisc-linux.org> <E1H28Oi-0003kw-00@dorka.pomaz.szeredi.hu> <20070104225929.GC8243@elf.ucw.cz>
Message-Id: <E1H2kfa-0007Jl-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 05 Jan 2007 09:43:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > High probability is all you have.  Cosmic radiation hitting your
> > > > computer will more likly cause problems, than colliding 64bit inode
> > > > numbers ;)
> > > 
> > > Some of us have machines designed to cope with cosmic rays, and would be
> > > unimpressed with a decrease in reliability.
> > 
> > With the suggested samefile() interface you'd get a failure with just
> > about 100% reliability for any application which needs to compare a
> > more than a few files.  The fact is open files are _very_ expensive,
> > no wonder they are limited in various ways.
> > 
> > What should 'tar' do when it runs out of open files, while searching
> > for hardlinks?  Should it just give up?  Then the samefile() interface
> > would be _less_ reliable than the st_ino one by a significant margin.
> 
> You need at most two simultenaously open files for examining any
> number of hardlinks. So yes, you can make it reliable.

Well, sort of.  Samefile without keeping fds open doesn't have any
protection against the tree changing underneath between first
registering a file and later opening it.  The inode number is more
useful in this respect.  In fact inode number + generation number will
give you a unique identifier in time as well, which is a _lot_ more
useful to determine if the file you are checking is actually the same
as one that you've come across previously.

So instead of samefile() I'd still suggest an extended attribute
interface which exports the file's unique (in space and time)
identifier as an opaque cookie.

For filesystems like FAT you can basically only guarantee that two
files are the same as long as those files are in the icache, no matter
if you use samefile() or inode numbers.  Userpace _can_ make the
inodes stay in the cache by keeping the files open, which works for
samefile as well as checking by inode number.

Miklos
