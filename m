Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269132AbUHZQj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269132AbUHZQj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269165AbUHZQhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:37:21 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:7615 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S269132AbUHZQeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:34:13 -0400
Date: Thu, 26 Aug 2004 12:32:34 -0400
To: Markus =?iso-8859-1?Q?T=F6rnqvist?= <mjt@nysv.org>
Cc: Matt Mackall <mpm@selenic.com>, Nicholas Miell <nmiell@gmail.com>,
       Wichert Akkerman <wichert@wiggy.net>, Jeremy Allison <jra@samba.org>,
       Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826163234.GA9047@delft.aura.cs.cmu.edu>
Mail-Followup-To: Markus =?iso-8859-1?Q?T=F6rnqvist?= <mjt@nysv.org>,
	Matt Mackall <mpm@selenic.com>, Nicholas Miell <nmiell@gmail.com>,
	Wichert Akkerman <wichert@wiggy.net>,
	Jeremy Allison <jra@samba.org>, Andrew Morton <akpm@osdl.org>,
	Spam <spam@tnonline.net>, torvalds@osdl.org, reiser@namesys.com,
	hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, flx@namesys.com,
	reiserfs-list@namesys.com
References: <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040826075348.GT1284@nysv.org>
User-Agent: Mutt/1.5.6+20040803i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 10:53:48AM +0300, Markus   Törnqvist wrote:
> On Thu, Aug 26, 2004 at 12:32:00AM -0500, Matt Mackall wrote:
> >What it breaks is the concept of a file. In ways that are ill-defined,
> >not portable, hard to work with, and needlessly complex. Along the
> >way, it breaks every single application that ever thought it knew what
> >a file was.
> 
> It breaks the concept of a file. In ways that offer more versatility,
> challenge the imagination to make even better progress and keeps
> Linux competing with competitors who are implementing this stuff
> as we speak.

Sigh, it really isn't all that groundbreaking. The only special feature
is the fact that it introduces directory hardlinks.

Just turn the phrase 'file-as-dir' around and you might see the point.
As far as userspace is concerned the implementation would behave 99%
identical if we provided a 'dir-as-file' semantics. i.e. opening a
directory without 'O_DIRECTORY' would return a filehandle to a default
file within the directory. Something like open("/path/to/dir", O_RDONLY)
would be translated to open('/path/to/dir/_contents', O_RDONLY).

So I could simply replace all my files with directories and move the
original file contents into a '_contents' file. Applications can still
open them by the same name, although the attributes would look a bit
different. Poof, we have the same file-as-dir concept, but now we play
fair with the existing VFS and don't introduced races/deadlocks and
other issues. Also existing backup tools will be able to back up and
restore these 'streams'.

(btw. the same could be implemented completely in userspace, for
instance in glibc. Whenever an open call gets an EISDIR error, simply
retry the open, but this time with /_contents appended).

> I for one would truly welcome the coming of thumbnails and descriptions
> in picture files, because I have a real-life project going on where
> that would be extremely handy to have in the actual file.

Ehhh, that already exists and doesn't require meta-data streams,

    http://www.exif.org/

> >Find some silly person with an iBook and open a shell on OS X. Use cp
> >to copy a file with a resource fork. Oh look, the Finder has no idea
> >what the new file is, even though it looks exactly identical in the
> >shell. Isn't that _wonderful_? Now try cat < a > b on a file with a
> >fork. How is that ever going to work?
> 
> Then I guess OS X ships a broken implementation of cp, yes?

No cp is working just fine, there is no copy syscall in the VFS, so any
file system specific features such meta data streams will have to be
handled by the application.

So at some point 'cp' will have to be taught about macos resource forks,
posix acls, xattrs, afs acls, reiserfs file-as-dir, freebsd attributes,
samba/ntfs streams. And possibly even learn the semantical differences
between these so that it can copy metadata between the various file
systems types.

Jan

