Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVF1U7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVF1U7F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVF1UZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:25:12 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:18949 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261406AbVF1UW5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:22:57 -0400
Message-ID: <42C1B19F.6010808@slaphack.com>
Date: Tue, 28 Jun 2005 15:22:55 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hubert Chan <hubert@uhoreg.ca>
Cc: Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>	<200506251420.j5PEKce4006891@turing-police.cc.vt.edu>	<42BDA377.6070303@slaphack.com>	<200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu>	<42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com>	<e692861c05062522071fe380a5@mail.gmail.com>	<42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com>	<200506261816.j5QIGMdI010142@turing-police.cc.vt.edu>	<42BF08CF.2020703@slaphack.com>	<200506262105.j5QL5kdR018609@turing-police.cc.vt.edu>	<42BF2DC4.8030901@slaphack.com>	<200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>	<42BF667C.50606@slaphack.com>	<5284F665-873C-45B7-8DDB-5F475F2CE399@mac.com>	<42BF7167.80201@slaphack.com>	<EC02A684-815A-4DF8-B5C1-9029FE45E187@mac.com>	<42C06D59.2090200@slaphack.com>	<CD59AE36-FD15-4A4C-9E1D-AB2F8B52D653@mac.com>	<42C08B5E.2080000@slaphack.com> <87y88vrzkg.fsf@evinrude.uhoreg.ca>
In-Reply-To: <87y88vrzkg.fsf@evinrude.uhoreg.ca>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hubert Chan wrote:
> On Mon, 27 Jun 2005 18:27:26 -0500, David Masover <ninja@slaphack.com> said:
> 
> 
>>Kyle Moffett wrote:
>>
>>>I think the '...' is just a bad idea in general, because it breaks
>>>tar and such.  An interface like this might be simpler to design and
>>>use:
>>>
>>># mkdir /attr
>>># mount -t attrfs attrfs /attr
>>>
>>>/attr/fd/$FD_NUM == '...' directory for a filedescriptor
>>>/attr/fs/$DEV_NUM/$INODE_NUM == '...' directory for an inode
> 
> 
> The most obvious (at least obvious for me) complaint about this is that
> the attributes are separate from the file.  (In other words, it's a bit
> ugly. ;-) ) So if you want to backup a file, along with all its
> (extended) attributes (or substreams, or ... etc. ...), you need to
> backup the file, and find the appropriate /attr/fs/$DEV_NUM/$INODE_NUM
> and back that up.  If I want to edit an attribute, I need to find
> $DEV_NUM and $INODE_NUM (which I have no idea how to do), rather than
> just "edit foo/.../extended_attribute".  (Or using your "getattrpath"
> command, it would be a two-step process -- run getattrpath, then run
> editor -- rather than a one-step process.  Of course, this is only
> mildly annoying.)

Especially considering you could add a tar/rsync flag to handle it for
you.  And most likely, each meta dir would have its own serialization
method (read: file) so that you didn't find yourself trying to back up
huge infinitely recursive structures, or accidentally triggering a huge
tar operation, or something...

> It also exposes a difference between attributes and regular files.
> e.g. can I add attributes to an attribute?

Under my scheme, yes, and it works the same way.

> (say, I have a thumbnail
> attribute for the file ~/foo, and I want to add a mime-type attribute to
> that thumbnail attribute.)  If you want to allow it, you have to be
> careful not to run into a big loop generating an infinite number of
> inodes in the attrfs.

I'm not sure if inodes are a problem, but this kind of stuff would be up
to the fs, not the attrfs or metafs.

> That said, I prefer that interface over xattr or openat.

Absolutely.  But I think both should exist, so that programs currently
using xattr will still work.  Maybe you'd have:

/meta/vfs/home/foo/attrs

or something...

Come to think of it, that changes the proposal a bit.  You need a
different way to access the meta-dir for files than for directories, if
we're going to support /meta/vfs.  No biggie:

/meta/vfs/file/home/bob/sue.mpg/acl
/meta/vfs/dir/home/bob/acl

>>>It would be usable from a shell with a simple "getattrpath" command
>>>which returns "fs/$DEV_NUM/$INODE_NUM" by stat-ing any given path.
> 
> 
>>Still pretty annoying, but maybe a good idea, especially if the shell
>>gets extended to support it.  Not sure I like using inode numbers,
>>though -- I like the idea of being able to symlink to stuff inside the
>>meta-file dir.
> 
> 
> The advantage of using inodes rather than pathnames is that it is robust
> with respect to file renaming/moving.  It also allows things like
> adding attributes to symlinks (since the inode number for a symlink is
> different from the inode number for the file that it points to).

I think we need both interfaces, especially because the /meta/vfs
interface makes looping easy.

> You can still symlink.  It just takes a little more effort to figure out
> what $DEV_NUM/$INODE_NUM to use.

Doesn't have the same effect.

>>Actually, I like this.  Give me some time to let it percolate.
> 
> 
>>Hans, thoughts?  Seems to be namespace fragmentation, but seems
>>usable, less breakage, and so on.  And should it be /attr or /meta?
> 
> 
> For the mount point, it doesn't matter; it's up to the user.

No, it's not.  It's up to the user and the application developers.
Sure, I could mount /proc somewhere else, but that would confuse some
things.  Mounting /meta somewhere else would confuse even more things.

> It's the
> attrfs or metafs or ???fs that matters (but which will greatly influence
> whether people user /attr or /meta).

True, but I think they should still hand down a decree of where it is to
be mounted by default.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQsGxn3gHNmZLgCUhAQLWkg/+MIzXbygGoHubwLcw5SI1eeanVssukzF7
9kl+3qYcpbC6l/4fFkezBA8YCb8yy/VCfadAJ4Vgsr7T0rvGq1fvKIER6Q4LfU22
YCkHfU6dCnTmTjqHTFyYqZX95J6JXKUT/HCXn5AaYC5DIOYMp1gFHgj6P1wKOb/o
KRvuOSIO0ta8fpPg6tBe6ve92sp99zqbacUplN+38+eBEIZUI7s7Dkg1lWX7ScyZ
LVtHDEDJUuP0/Frq3xZHFKdgsVhoDtCm5Cl6EBX0OSubExPa/7ID2ANA+W01lqbm
9KMtXAcp/K8uOVkM8YDpFvvP2Ru/gp+iKy993lpGY9bEhIZ6BVz4zpVMvloHQe3a
GCdsvub1yP7qQa/7LpkN6Shbw8W25iXcG0QUXa6XuiaJZIsVvRThrWOPXstx9GGQ
KDZtMGIzH5vJcXQzIKzHMrfJBIKMmu3c/Et1EmdJy1t1PkH95+gGCrYc/nfBizfk
NMYIp8S+RdGXwIcOWcwu4WspTJEZg1w7spXuydBZHd55YCq5JJE7lLNoK8Y3ZXks
xC7b6Eo/0FgsxUmoQ9QYl9kzrxAejBGWmmTfsQGjFhu0Ep7jVCZHRRSq8r2RwRj/
AYY2JeFu7yRHsKy29BYipo0etR38Z5+Z0ZOn3iZZHHVz7D6u12U+69LXUEeyp46H
mYzXXJOmIVA=
=h/Gv
-----END PGP SIGNATURE-----
