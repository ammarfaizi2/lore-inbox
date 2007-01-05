Return-Path: <linux-kernel-owner+w=401wt.eu-S1422645AbXAERaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422645AbXAERaJ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 12:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422643AbXAERaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 12:30:08 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:46394 "EHLO
	janus.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422642AbXAERaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 12:30:06 -0500
Date: Fri, 5 Jan 2007 18:30:04 +0100
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: pavel@ucw.cz, matthew@wil.cx, bhalevy@panasas.com, arjan@infradead.org,
       mikulas@artax.karlin.mff.cuni.cz, jaharkes@cs.cmu.edu,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
Subject: Re: Finding hardlinks
Message-ID: <20070105173004.GA24513@janus>
References: <4593E1B7.6080408@panasas.com> <E1H01Og-0007TF-00@dorka.pomaz.szeredi.hu> <20070102191504.GA5276@ucw.cz> <E1H1qRa-0001t7-00@dorka.pomaz.szeredi.hu> <20070103115632.GA3062@elf.ucw.cz> <E1H25JD-0003SN-00@dorka.pomaz.szeredi.hu> <20070103135455.GA24620@parisc-linux.org> <E1H28Oi-0003kw-00@dorka.pomaz.szeredi.hu> <20070104225929.GC8243@elf.ucw.cz> <E1H2kfa-0007Jl-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1H2kfa-0007Jl-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-BotBait: val@frankvm.com, kuil@frankvm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 09:43:22AM +0100, Miklos Szeredi wrote:
> > > > > High probability is all you have.  Cosmic radiation hitting your
> > > > > computer will more likly cause problems, than colliding 64bit inode
> > > > > numbers ;)
> > > > 
> > > > Some of us have machines designed to cope with cosmic rays, and would be
> > > > unimpressed with a decrease in reliability.
> > > 
> > > With the suggested samefile() interface you'd get a failure with just
> > > about 100% reliability for any application which needs to compare a
> > > more than a few files.  The fact is open files are _very_ expensive,
> > > no wonder they are limited in various ways.
> > > 
> > > What should 'tar' do when it runs out of open files, while searching
> > > for hardlinks?  Should it just give up?  Then the samefile() interface
> > > would be _less_ reliable than the st_ino one by a significant margin.
> > 
> > You need at most two simultenaously open files for examining any
> > number of hardlinks. So yes, you can make it reliable.
> 
> Well, sort of.  Samefile without keeping fds open doesn't have any
> protection against the tree changing underneath between first
> registering a file and later opening it.  The inode number is more
> useful in this respect.  In fact inode number + generation number will
> give you a unique identifier in time as well, which is a _lot_ more
> useful to determine if the file you are checking is actually the same
> as one that you've come across previously.

Samefile with keeping fds open doesn't buy you much anyway. What exactly
would be the value of a directory tree seen by operating only on fds
(even for directories) when some rogue process is renaming, moving,
updating stuff underneath?  One ends up with a tree which misses alot
of files and hardly bears any resemblance with the actual tree at any
point in time and I'm not even talking about filedata.

It is futile to try to get a consistent tree view on a live filesystem,
with- or without using fds. It just doesn't work without fundamental
support for some kind of "freezing" or time-travel inside the
kernel. Snapshots at the block device level are problematic too.

> 
> So instead of samefile() I'd still suggest an extended attribute
> interface which exports the file's unique (in space and time)
> identifier as an opaque cookie.

But then you're just _shifting_ the problem instead of fixing it:
st_ino/st_mtime (st_ctime?) are designed for this purpose. If the
filesystem doesn't support it properly: live with the consequences
which are mostly minor. Notable exceptions are of course backup tools
but backups _must_ be verified anyway so you'll discover soon.

(btw, that's what I noticed after restoring a system from a CD (iso9660
 with RR): all hardlinks were gone)

-- 
Frank
