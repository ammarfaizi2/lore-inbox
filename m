Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbULOX53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbULOX53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 18:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbULOX53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 18:57:29 -0500
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:7342 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S262541AbULOX4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 18:56:50 -0500
Message-ID: <41C0CF3B.1030705@slaphack.com>
Date: Wed, 15 Dec 2004 17:56:43 -0600
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
CC: Hans Reiser <reiser@namesys.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory
References: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl>	 <41ACA7C9.1070001@namesys.com>	 <1103043518.21728.159.camel@pear.st-and.ac.uk>	 <41BF21BC.1020809@namesys.com>	 <1103059622.2999.17.camel@grape.st-and.ac.uk>	 <41BFC1C5.1070302@slaphack.com> <1103102854.30601.12.camel@pear.st-and.ac.uk>
In-Reply-To: <1103102854.30601.12.camel@pear.st-and.ac.uk>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Peter Foldiak wrote:
| On Wed, 2004-12-15 at 04:47, David Masover wrote:
|
|>Peter Foldiak wrote:
|>| Also, a pseudofile (e.g. dirname/..../structure ?) could be used to
|>| specify how the files should be glued together. A simple question is,
|>| for instance, what separators to use between the components, and what
|>| ordering to use when putting the component objects together. (This
|>| pseudofile could also determine more complicated ways of composing
|>| objects.)
|>
|>If the filesystem does caching, I'd rather have a type of executable
|>which, read normally, appears as a stream of its own standard output.
|>You'd get the actual file as something like bar/.../source.
|
|
| This sounds better and more general than my proposed ..../structure
| file. So could you explain this in a bit more detail?
| Would for instance the simplest (and default?) glueing code in your
| bar/..../source file be
|
| cat *
|
| which just concatenates all the subcomponents in no particular order?

Sounds right.  Well, actually, you need a shebang, as this would be
called from kernel space.

Speaking of which, how much speed is lost by starting up a process?

The idea of caching is that running

cat *; cat *; cat *; cat *; cat *

is probably slower than

cat * > baz; cat baz; cat baz; cat baz; cat baz; cat baz

The kernel is the right place to do such caching.  It is not the right
place to implement almost any kind of "cool new kind of file" that Hans
wants us to develop.

|>This could be done with pipes and daemons, but it's not as easy to
|>manage and seems impossible to do as efficiently (with built-in caching,
|>etc.)
|
|
| How would you do it?

With two kernel reiser4 plugins -- one for files and one for
directories.  Others could come later, but I don't see this being so
important for things like symlinks.

Then, I'd let reiser4 cache things (in RAM and in free space on the
filesystem) which are generated through these plugins.

Directory plugins allow inheritence, too -- just have the plugin install
itself on all of its children.

Compression, encryption, etc. could all be done through the same mechanism.

[...]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQcDPO3gHNmZLgCUhAQIYhg//VeuJvEG2cbwANaka136xXDSy5blo71f0
ulgVBIe7XK8SMpLigNwVQQlTpmIncccu4ymOZG8egf4ex9d269Zv47TSmP+QkJEi
UU8Oky+oMFE/ntg5ZEoVxXe+oz2fCxzyYKwyjdWwHJZnylsHSaSsIpziaIZR+UXG
hcxZ9Cs3sLSlK0iYWM/R3dFBgRDMKR3/spz9gHGtyicLYbGvhzdHo6jSE1V8bqrg
44gt3XbB/SgKQTSeqBMr2/QCPpHKrFKqFhrsbVNzcjL7GftLOBeGRvVAWF9QIlUv
qDbIubfchr2KxYxE8qCsKTYqX5+VgDj0GDuwuymiq7fy4cIO0VIr3br1vJRWDUy3
VZeTbrQd3LJ6gSiTPN8+0CQQlpjEduS5EZfeIiygrQed1xHZBUbR59xV7KfIaHLz
lY06VKpwstmPjHueNx9T7T18aOjMVLWZbA+IWbRHdqLs0VqNltttVIz0e8WgFJHJ
3ISA0N+WNYCeR75XjWnD78e6vzhvTlGKLe2PjAdWDtuiSKTITV1HCKjSzMFL3JEd
CymOFhxddxx+aZrd8w1s0unjdGzkxdPfmpdd0XdBnB7vHYPpkw4ELacIqHt0OOTg
UYnBMem/UhLxisllfBOc0lunbxFynPOjsqYFTDTcHYHoZh0Kyel98m25uXeEr9VL
m2R6SMkl49k=
=oNG7
-----END PGP SIGNATURE-----
