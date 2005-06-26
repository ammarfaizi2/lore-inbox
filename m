Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVFZT6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVFZT6e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 15:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVFZT6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 15:58:34 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:22285 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261585AbVFZT6P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 15:58:15 -0400
Message-ID: <42BF08CF.2020703@slaphack.com>
Date: Sun, 26 Jun 2005 14:58:07 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com>            <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu>
In-Reply-To: <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Valdis.Kletnieks@vt.edu wrote:
> On Sun, 26 Jun 2005 02:48:06 CDT, David Masover said:
> 
> 
>>Lincoln Dale wrote:
> 
> 
>>>this is the WHOLE point of standardization .. i don't think its that
>>>Reiser4's EAs offer any more or less capabilities than standard EAs -
>>
>>They do.  Reiser4's EAs can look like any other object -- files,
>>folders, symlinks, whatever.  This is important, especially for
>>transparency.
> 
> 
> No, you want them to look like the same objects that {get|set}xattr() manage
> currently.  You don't want programs to have to guess what an EA looks like
> this week, with this user's combination of plugins that's different from
> everybody else's.

"Plugins" is a bad word.  This user's combination of plugins is most
likely identical to other users', it's just which ones are enabled, and
which aren't?  If they are all included, I assume they play nice.

And just because they are called "plugins" doesn't mean the EA looks
different every week.

I cannot stress this enough.  In Reiser4, EVERYTHING is some sort of
plugin.  We now have a standard disk format plugin, and a standard set
of plugins providing UNIX filesystem-like things (vanilla files,
directories, symlinks, device nodes, named pipes...) which has been
stable for some time.

I see no problems with providing at least as consistent an EA interface
as any other FS, only more extensible because it's not flat.

>>>lets take this a step further.  what about compression?  do we accept
>>>that each filesystem can implement its own proprietary compression via
>>>its own API - and now we need individual user-space tools to understand
>>
>>No, that's the beauty of these "EAs" in Reiser4.  The API is standard
>>write(2) commands.  sys_reiser4 supposedly implements an interface to
>>make this scale better, but otherwise have the same semantics.  And who
>>said anything about proprietary compression?  I think we were planning
>>on the kernel's zlib, though we might have been planning to make it a
>>bit more seekable...
>>
>>
>>>each of these APIs?
>>
>>So, the API becomes something like:
>>
>>cat crypto/inflated/foo		# transparently decompressed
>>cat crypto/raw/foo.gz		# raw, gzip-compressed
> 
> 
> And 'cat crypto/raw/foo' or 'crypto/inflated/foo.gz' gets you what, exactly?
> 
> Now throw some .bz2 and .zip files into the mix... ;)

Interface is the same.  Only, zip files aren't just compression, so
maybe the interface changes a little there.

Point is, now you have a standard interface for any program to access
any simple lossless compression, transparently.

>>Another possibility, if you like file-as-a-directory:
>>
>>cat foo.gz			# raw
>>cat foo.gz/inflated		# decompressed
>>
>>One could easily imagine things like these two potentially equivalent
>>commands:
>>
>>cp foo bar.zip/
>>zip bar foo
> 
> 
> Unless of course the user had done 'mkdir sorted.by.city.zip' to make
> a directory of files containing data sorted by USPS Zip code.

What's this got to do with anything?

> And what happens if the user has a file 'bar' that's not a ZIP file,
> and a directory 'bar.zip' isn't a view into 'bar'?

In file-as-a-directory (which is probably NOT happening soon), bar.zip
is both the actual zipfile and the view inside, depending on whether you
try to open() it directly or peek inside it as a directory.

I've used that interface for some simpler things like file permissions.
 I could do things like "echo 0 > some_file/metas/uid".  The interface
is gone for now, because it broke some things, I'm told, but nothing
serious for me while I was using it.  I don't think the problem is
insurmountable.

However, let's not discuss this now.  I do NOT want to start another
"silent semantic changes with reiser4" thread.  File-as-directory is not
happening this time, so don't worry about it -- this time.

> Most of the time, if I have a file 'linux-2.6.12.tar.bz2' and a
> directory 'linux-2.6.12', what is under the directory is *NOT* the same
> data as what's in the .bz2 - I've done 'make oldconfig' and a few builds
> and some variable amount of patching, usually with rejects, and I *don't*
> want that .bz2 being updated during all this (hint - what's my next command
> after 'rm -rf linux-2.6.12' likely to be, and why, and  what expectations
> do I have when I do it?)

You're misunderstanding.  man zip.
$ zip bar foo
creates/modifies a file named "bar.zip", not "bar", which contains the
file "foo".

> You want to think this sort of thing through *really* thoroughly, because
> there's a *lot* of things, both users and programs, that have expectations
> about The Way Things Work.

Or, I can avoid those issues altogether, and simply delegate this kind
of stuff to user-created-but-magic directories.  For instance, I could
have a directory called "/foo" which contains encrypted files, and
"/foo/decrypted" which has transparently decrypted representations of them.

>>The whole point is to have less userland tools, not more.  I'm not
>>saying we move zip into the kernel, just that the user now has one less
>>command to remember.
> 
> 
> But now instead of having to remember the one meme "I can manage any
> compressed-archive format that's stored in a file, and put other files in it,
> and all I need is the appropriate userspace tool", they have to remember "the
> cp trick works for .zip and .tar, but I'll get a "not a directory" error if I
> try it with a .hqx file, and that other file format may or may not work,
> because I can't remember if this kernel has a working out-of-tree module for
> this kernel...."

True, for now.  But for me, it's not hard at all to try "cp" first, and
after it fails, Google and install the required tool.  After all, most
users already have to do that with GUI interfaces, this just takes the
GUI way of doing things (like in file-roller) and makes it perform
better and work with all programs.  Not necessarily all formats, but all
programs.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr8IzngHNmZLgCUhAQKS9A/+K+Nkq0sLynA0ltiA7o+BnA4cRSLYnu0t
LdVI+yvYMUocvZt1HcIuU1LN2y3//Xm7hh7Lsyf3moNCIFMkDUN/xuzUcmfpUs5W
NpyYPS4M3h8bX7nAMI9SmJ2KPoQNJxiEMToi5cYkQvafAeAlR2xw+z9nQ7Cv2PAi
PCKROYSbZ1MdyCVLDPYkIpk9Z9EnOZ7zE+nbMaippqAnwfoqMoe8OMBKt1qxBROS
tSPn4h1+JQZTs5OY18Cg/km7J6SM3SmHEWtsicil9/AVMFoOCpUXkeuiBLgVZ7Vk
hh79SLjmuAOgU5hTBhEwvtEjB5uGqbjRtp+quIWNO4tmHqPuSv+TP0YaOgMTqbf7
9Cr+iq/YrWMDCA3fYrnq/TiSCNK/YHGNlQG4rZtnKDXUFUZRuItMhbRaiYYfv/Cl
wQjBrknKci4xFNB9gIOoykS9Vs3JDdZc8oj26rFhHGqkGE+xo6b0z1EaZMvBfes9
L+VqU6B7YnyDWnhDbK6TiLZ/Qg83SigTyoLORVIDzyo3k2SVA8kmy8NgdA9NlmIT
ko/g0+7zHtu64LuEtQEdL/FULnI/YcMtxQDjYuhCqtUo/x4y3hi5685P00iZDfdp
RpuZnOT/esiw/RLashgGRK3xsVik9R+WX2psrEXp7HvNYvr5X4BpFovyVYeTxSnj
jV201bzTv6A=
=z+xB
-----END PGP SIGNATURE-----
