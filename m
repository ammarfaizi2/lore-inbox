Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbULOErP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbULOErP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 23:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbULOErP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 23:47:15 -0500
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:39841 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S261871AbULOErE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 23:47:04 -0500
Message-ID: <41BFC1C5.1070302@slaphack.com>
Date: Tue, 14 Dec 2004 22:47:01 -0600
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040924)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
CC: Hans Reiser <reiser@namesys.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory
References: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl>	 <41ACA7C9.1070001@namesys.com>	 <1103043518.21728.159.camel@pear.st-and.ac.uk>	 <41BF21BC.1020809@namesys.com> <1103059622.2999.17.camel@grape.st-and.ac.uk>
In-Reply-To: <1103059622.2999.17.camel@grape.st-and.ac.uk>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Peter Foldiak wrote:
| On Tue, 2004-12-14 at 17:24, Hans Reiser wrote:
|
|>Peter, I think you are right, though it might be useful to have the
|>default be dirname/..../glued and to allow users to link
|>dirname/..../filebody to
|>dirname/..../something_else_if_they_want_it_to_not_be_glued, and to have
|>dirname/..../filebody or whatever it is linked to be what they get if
|>they read the directory as a file.
|
|
| Yes. I assume you mean that dirname in itself should always be
| interpreted as dirname/..../glued, which by default would be a linked to
| dirname/..../filebody, the latter being the file content, right?

I think he means the other way.
	cat foo
is the same as
	cat foo/.../filebody
where "filebody" is some sort of link to (maybe) foo/.../glued.

Understand that you want to allow "normal" files which are not "glued"
anything, but also "glued" files which are composed of sub-files.

| Also, a pseudofile (e.g. dirname/..../structure ?) could be used to
| specify how the files should be glued together. A simple question is,
| for instance, what separators to use between the components, and what
| ordering to use when putting the component objects together. (This
| pseudofile could also determine more complicated ways of composing
| objects.)

If the filesystem does caching, I'd rather have a type of executable
which, read normally, appears as a stream of its own standard output.
You'd get the actual file as something like bar/.../source.

This could be done with pipes and daemons, but it's not as easy to
manage and seems impossible to do as efficiently (with built-in caching,
etc.)

| The component objects themselves could be full objects, so they
| themselves could have sub-components.

Right.

Also, there should be an inverse. For instance, a file-as-directory type
object should have a "contents" object, usually a normal directory, but
which could conceivably be any type of object, including a code-ish
object which implements a filesystem. Accessing foo/ would be the same
as accessing foo/.../contents, only because "..." (or whatever we use
for meta-files) is outside the actual directory namespace,
foo/.../contents/... refers to the metas of object "contents", which are
different than the metas of object "foo".

These two steps essentially create userspace "plugins", and do away with
having to mount other kernel layers such as lufs (or whatever its
current implementation is). It does have one important implication, though:

It's important that "metas" or "..." or whatever we've decided on should
_not_ be mutable by a "userspace" plugin that I have described, nor
should any meta-files created by kernel plugins. There would be other
security implications, of course -- user should still not be able to
create files that are owned by other users and setuid. I'm not sure
where such checks should go, but we want mortal users to be able to add
whatever plugins they want, while super-users can feel safe using the
metas interface to manipulate user files.

I think the issues with directory-as-a-file were the same problems you
get when you allow hardlinked directories -- that you'd eventually have
to ditch reference counting for a garbage collector, which is hellishly
impractical. I don't have a solution to that, other than dropping
hardlinks entirely.

Hmm. Why do we need hardlinks? I forget.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQb/BxHgHNmZLgCUhAQJ4tA//ZVHoODSgxrIKgk2RtxGW4X8piQc0cGVq
KLwQmbCg/LRRld1VhPDikROMjZWrubzzsY5NujEmZFjdnA/m3mgO5DVsd6xtiGDJ
5B47aDTyygRWA6SONw6q+47me2lqFSBvZYOM9E468CNNKEExMys9R+sY82b1lbRi
iAesW49tWusZtonI66D1aK3a6ue9MEBjbZkGi+qR1DYK02+gc2SVbeDc7dbx4GrC
0GBfO92O+0OJKnYn3/e7wag57/cJYEOrDW2Dg9mOD2UOK+6fmJLf8lx6XIxI+QOp
YLp9dY4scac5PlC+z6DUPuv8rRGu7GUDJdffzNoG18MYQChZcE6e1lVWPpunMiqh
quWWr6wi09m5eoUq27w8fHS0UeJ/fn1+Ckr+4+zEZv3CluK0KMqPDYOcKfR5Hs/3
MYzrbVXFoaOZd59oMzBlikJoMbTikm0UNSQhaKlw3ZFH46V/lKrCzOjh3ZNQ3rqx
t0f0BrVgGKluX5cw5srzxOBjnOxw3OMtsuAlElHunNALeRn8xMFcc7tuVwVn0Wxv
hx48IUk3KwTrAomN0SS4m+a9MLUjtxXMkr/1hViJ8ofRRqXMFghXq/WTeIA4BLxM
9SnfZqHcldF3NKZq1bCQlv8nJFOPxwQE0Zt9gtFSBq6rndfexdO2XZtyH7pxm4FX
X/NK4MR5iSk=
=3BWI
-----END PGP SIGNATURE-----
