Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268487AbUIFTVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268487AbUIFTVE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 15:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268486AbUIFTUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 15:20:35 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:9125 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S268487AbUIFTO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 15:14:58 -0400
Message-ID: <413CB733.1040702@slaphack.com>
Date: Mon, 06 Sep 2004 14:14:59 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040813)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christer Weinigel <christer@weinigel.se>
CC: Spam <spam@tnonline.net>, Pavel Machek <pavel@suse.cz>,
       Tonnerre <tonnerre@thundrix.ch>, Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>	<Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org>	<m3eklm9ain.fsf@zoo.weinigel.se> <20040905111743.GC26560@thundrix.ch>	<1215700165.20040905135749@tnonline.net>	<20040905115854.GH26560@thundrix.ch>	<1819110960.20040905143012@tnonline.net>	<20040906105018.GB28111@atrey.karlin.mff.cuni.cz>	<6010544610.20040906143222@tnonline.net>	<m3wtz7h2l6.fsf@zoo.weinigel.se>	<826067315.20040906171320@tnonline.net> <m3sm9vh06b.fsf@zoo.weinigel.se>
In-Reply-To: <m3sm9vh06b.fsf@zoo.weinigel.se>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christer Weinigel wrote:
| Spam <spam@tnonline.net> writes:
|
|
|>>When you add a new shared namespace, userspace must be taught about it
|>>anyways.  So start with a userspace library, convince people to use
|>>it, and when you know what people want, _then_ put it into the kernel
|>>to increase performance or security.
|>
|>  Several aspects of this;
|>
|>  1) Programs will need to actually be coded against this shared
|>  library which probably will be more advanced that just usning normal
|>  file access code.
|
|
| Not at all.  As many others have already shown, trying to use files as
| directories won't work since then you can't have named streams or
| attributes for real directories.  What does foo/icon refer to when foo

Oh yes, you can.  That's what "metas" is for.  I wanted to call it ...
| is a directory?  There must be some way of differentiating between

When foo is a directory, foo/icon is a normal file.  But foo/metas/icon
(or foo/.../icon if you like) is the metadata.

This already works.  I can use it right now for file permissions:

echo 755 > /bin/bash/metas/rwx
echo 755 > ./metas/rwx

| Besides, it will probably break a lot of security critical assumptions
| in todays software.  What if you have a filter in your web server that
| excludes executable files or files that end with .php, can you imagine
| the mess if you could just open "foo.php/main-stream" instead?

Why would you have a foo.php/main-stream?

And what would be so hard about allowing read access to foo, but not
access to foo's metas?  This is essentially the same as having mode 6 on
a directory.

[...]
|>  Plugins were just another thing that could extend the functionality
|>  of these streams and meta data. Reiser4 has a plugin architecture,
|>  although not yet any run-time support for loading them. Is this so
|>  bad that we have to prevent it?
|
|
| Take an example: "expose a tar-file as streams below the file" which
| as been suggested here is IMNSHO plain silly.  I'm not saying anything
| about mounting a tar file via userfs somewhere else in the file
| system, that is quite ok, but trying to mount it on top of the same
| file which suddenly and automagically turns into a sort-of-directory
| breaks too many thing.  Let your file manager do the choice instead,

What things?  It's just dangerously different thinking.  I don't see it
breaking anything on my system right now.  If anything, the nvidia
binary drivers are a bigger issue...

| based on the users preferences.  For example, with a tar.gz-file, I'd
| like to have a choice of "open file as a seekable file" which would
| do:
|
|     mount -t userfs -o driver=gunzip foo.tar.gz /tmp/xyzzy
|
| Then I can work with /tmp/xyzzy as a normal file (maybe even with
| write access if the userfs driver can handle this).  Another choice in
| the same file manager would be "open file as a directory" which would
| mount the same file in _another place_ as a directory, and I can even
| have different views of the same file mounted at the same time.  With
| the named streams junk that have been suggested here, having two
| different views would be impossible.
|
| Sure, we could say that we add another level of indirection to the
| named streams, so that we specify the driver as the first component of
| te magic file-as-directory, i.e. foo.tar.gz/ungzipped would refer to
| the ungzipped stream and foo.tar.gz/ungzipped-and-untarred would show
| the tar file as a directory, but really, this isn't any more useful
| than doing a userfs mount.  The userfs mount does not break existing

Yes, it is more useful than doing a userfs mount.  The userfs mount has
to be done manually or by a file manager.  I do not use a file manager.
~ I am not alone here.  Unless you're going to have the entire FS mounted
userfs and have that be the file manager, which wouldn't be nearly as
fast as plugins.

I've heard autofs mentioned -- which only works on specific files which
it's been preconfigured for.  Not good here.

| semantics (anymore than mount -o loop does today), and it will work
| with the existing infrastructure in the linux kernel.  The only

That's true -- it's easier to implement if you ignore the number of apps
which need patching.

There's also the fact that most people here won't be patching apps,
they'll just be breathing a sigh of relief that they didn't have to
patch the kernel.

Just because someone else has to do it doesn't make it any less work.

| advantage of files-as-directories with magic plugins in the kernel is
| that one can look at it and say "look, how neat, the filenames look
| almost the same".

And this is a usability issue.  Not all newbies use Nautilus.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQTy3MngHNmZLgCUhAQJ/lQ//UmQOJLZAmsFFD8TJehD8WitMrImrcrBC
SJ/mCkIaPq5JNo9R/ovd1UoGlf47JUvaaT5G1d/yOMA+/0kPNqjJL49Km9A3Ze+C
00Uq12yP8yp6NjBzq9HKAjvyHVghl1A5ZllIdiwuc8Fywbl6UKUHlN1D4PpUp1uA
znKPjmGpBOsTzgNWJYbAfjns60C7DHZoD/S+ldt3af2PsJKOpx0v4fusV8Y2+XRG
kWybZLl1YPwPLfJLCaa3KpbY1KkSuk6TSeut90+zRV6s1WJ8LE98NpDBGUDt/+cm
AXcp/zyrUmbpvQtZBaUFYwZ8imizspiSHYnBwdhVm9tfERFOFI9diBidvanHk/s0
D+FSJhnQSeo/hMnbHlfv4E6p4k1jDvJk06XJ/U45sEym4hCp9roDPB0tUic7bOnE
mxNxzogp92KHfsVPuqkidq255ztAjRbzdnt8zsBOPImqTgfsO3xVfT3svIixNxWv
+qaAlrR7dAri9bi3wNLCjzRhp3id0fspetLJrrCHI/8hMlu7a6nsIHLocuvG069W
OzdXtTPRYsV8YlElsdL5d/3grZSL3CWNpQxoRb9gzj0hKHHPjrXw9ACcQthiknNc
DkjjcLxV2gPqhKq3WgMTKXHhLDWEfJpFVQ8PccJHsKaaUgGtDUg0ETBT54h8Mo8E
I0bkcYOLtHk=
=o3vQ
-----END PGP SIGNATURE-----
