Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268160AbUIFPoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268160AbUIFPoi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 11:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268159AbUIFPoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 11:44:38 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:9938 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S268156AbUIFPo3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 11:44:29 -0400
To: Spam <spam@tnonline.net>
Cc: Christer Weinigel <christer@weinigel.se>, Pavel Machek <pavel@suse.cz>,
       Tonnerre <tonnerre@thundrix.ch>, Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
	<Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org>
	<m3eklm9ain.fsf@zoo.weinigel.se> <20040905111743.GC26560@thundrix.ch>
	<1215700165.20040905135749@tnonline.net>
	<20040905115854.GH26560@thundrix.ch>
	<1819110960.20040905143012@tnonline.net>
	<20040906105018.GB28111@atrey.karlin.mff.cuni.cz>
	<6010544610.20040906143222@tnonline.net>
	<m3wtz7h2l6.fsf@zoo.weinigel.se>
	<826067315.20040906171320@tnonline.net>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 06 Sep 2004 17:44:28 +0200
In-Reply-To: <826067315.20040906171320@tnonline.net>
Message-ID: <m3sm9vh06b.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spam <spam@tnonline.net> writes:

> > When you add a new shared namespace, userspace must be taught about it
> > anyways.  So start with a userspace library, convince people to use
> > it, and when you know what people want, _then_ put it into the kernel
> > to increase performance or security.
> 
>   Several aspects of this;
> 
>   1) Programs will need to actually be coded against this shared
>   library which probably will be more advanced that just usning normal
>   file access code.

Not at all.  As many others have already shown, trying to use files as
directories won't work since then you can't have named streams or
attributes for real directories.  What does foo/icon refer to when foo
is a directory?  There must be some way of differentiating between
them, which in turn means that we need a new way of referring to the
stream.  So the simple, hackish, solution really won't fly.

Besides, it will probably break a lot of security critical assumptions
in todays software.  What if you have a filter in your web server that
excludes executable files or files that end with .php, can you imagine
the mess if you could just open "foo.php/main-stream" instead?

>   2) Then we redo it all again to fit in the kernel, as a kernel
>   plugin or user-level plugin.

No, we use the same user space library, but let the user space library
use helper functions in the kernel.

We could for example add a function that opens a named stream based on
a filename which uses a .xattr directory in the same directory as the
file, or in database in our home directory.  If we add a solaris-like
openat(3) syscall we modify the library to take advantage of it.

>   Plugins were just another thing that could extend the functionality
>   of these streams and meta data. Reiser4 has a plugin architecture,
>   although not yet any run-time support for loading them. Is this so
>   bad that we have to prevent it?

Take an example: "expose a tar-file as streams below the file" which
as been suggested here is IMNSHO plain silly.  I'm not saying anything
about mounting a tar file via userfs somewhere else in the file
system, that is quite ok, but trying to mount it on top of the same
file which suddenly and automagically turns into a sort-of-directory
breaks too many thing.  Let your file manager do the choice instead,
based on the users preferences.  For example, with a tar.gz-file, I'd
like to have a choice of "open file as a seekable file" which would
do:

    mount -t userfs -o driver=gunzip foo.tar.gz /tmp/xyzzy

Then I can work with /tmp/xyzzy as a normal file (maybe even with
write access if the userfs driver can handle this).  Another choice in
the same file manager would be "open file as a directory" which would
mount the same file in _another place_ as a directory, and I can even
have different views of the same file mounted at the same time.  With
the named streams junk that have been suggested here, having two
different views would be impossible.

Sure, we could say that we add another level of indirection to the
named streams, so that we specify the driver as the first component of
te magic file-as-directory, i.e. foo.tar.gz/ungzipped would refer to
the ungzipped stream and foo.tar.gz/ungzipped-and-untarred would show
the tar file as a directory, but really, this isn't any more useful
than doing a userfs mount.  The userfs mount does not break existing
semantics (anymore than mount -o loop does today), and it will work
with the existing infrastructure in the linux kernel.  The only
advantage of files-as-directories with magic plugins in the kernel is
that one can look at it and say "look, how neat, the filenames look
almost the same".

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
