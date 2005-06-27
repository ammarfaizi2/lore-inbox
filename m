Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVF0Tj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVF0Tj1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVF0TjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:39:24 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:34235 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261154AbVF0Tio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:38:44 -0400
From: Tyson Whitehead <twhitehe@uwo.ca>
Reply-To: twhitehe@uwo.ca
To: linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
Date: Mon, 27 Jun 2005 15:39:22 -0400
User-Agent: KMail/1.8.1
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Hans Reiser <reiser@namesys.com>,
       Lincoln Dale <ltd@cisco.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Masover <ninja@slaphack.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
References: <200506241532.j5OFW79b013979@laptop11.inf.utfsm.cl>
In-Reply-To: <200506241532.j5OFW79b013979@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9112068.3n9Q1jY5Fi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506271539.34361.twhitehe@uwo.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart9112068.3n9Q1jY5Fi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On June 24, 2005 11:32, Horst von Brand wrote:
> Hans Reiser <reiser@namesys.com> wrote:
> >
> > VFS supplies instances, plugins are classes.  If a language can
> > instantiate an object, that does not eliminate the value of being able
> > to create classes.
>
> In OOP speak, VFS is an abstract class, each individual filesystem derives
> from this class giving a concrete class, a specific on-disk (or whereever)
> filesystem is an object of its (concrete) class. The rest of the kernel (=
as
> a client) doesn't care for the concrete classes, it speaks only (or mostl=
y)
> in terms of the abstract class (VFS). And concrete filesystems in turn use
> the generic block layer.
>
> > Does it make sense to you now?
>
> No. Sounds jumbled up and backwards. And I don't see how "languages" could
> even enter the picture here.

There seems to be a bit of confusion by the OO speak (I was initially confu=
sed=20
as well -- guess I've spend too much time in broken OO languages recently).=
 =20
*grin*  Thinking of interfaces, classes, and objects as a bunch of 1:M=20
relationships make it much clearer.

If you start at the bottom, an object (instantiation of a class) has the=20
per-object stuff (usually data).  A class (instantiation of a meta-class or=
=20
interface) has the shared object stuff (methods/functions that work on the=
=20
data and static/shared data).  An interface has the shared class stuff (inf=
o=20
on what the methods/functions and static/shared data are).

A class is a realization of an interface.  An object is a realization of a=
=20
class.  The standard C thing is to have only objects be dynamic at runtime.=
 =20
A slightly less common (but very flexible) thing to do is to make the class=
es=20
dynamic at runtime.  This introduces the following C -> OO talk:

=2DInstances of structures full of data are objects.
=2DInstances of structure full of function pointers are classes.
=2DInstances of structure that are a big mix of both are the crossbred=20
offsprings of programmers committing OO maintenance suicide by violating al=
l=20
the layering (or a savy programmers cleverly saving of one level of=20
indirection by caching an object's class' function pointers in the object -=
=2D=20
depends on your point of view *grin*).

In the Reiser4 FS I believe it goes like this (apologies Hans if I'm wrong)=
=2E =20
The objects are files, directories, etc.  The classes are the plugins. =20
Associated with each object is a number (plugin id/class pointer) identifyi=
ng=20
the set of functions (class/plugin) that provides the functions/methods to=
=20
manipulate that object (ids are required because the objects [files,=20
directories, etc.] live on the device while the plugins live in memory).

The good thing is that it is very easy to provide new plugins (instances of=
=20
the interface to manipulate the objects).  To create a new new plugin (a ne=
w=20
class) you just fill in a bunch of function pointer fields in a structure=20
(possibly mixing and matching existing functions) and give it a plugin id. =
=20
To use it, you just link appropriate objects (files for file plugins,=20
directories for directory plugins, etc.) back to it via the plugin id.

The VFS also has a bunch of OO stuff.  Looking at "include/linux/fs.h", the=
=20
inode structure is mostly data with a few pointers to structures full of=20
functions pointers.  Instances of it are most definitely objects.  Instance=
s=20
of the associated structures full of functions pointers (inode_operations,=
=20
file_operations, etc.) are most definitely classes (they give an implement =
of=20
their respective interfaces for that inode).  Likewise, instances of=20
super_block are objects, while instances of super_operations (and friends)=
=20
are classes.  In short, in Reiser4 FS talk, much of the VFS is done with=20
plugins (a plugin being an instance of one of the *_operations structures).

The current merge issue seems to be that apparently (I haven't actually loo=
ked=20
myself) lots of the VFS plugins that Reiser4 exports are just thunks.  This=
=20
might imply that there are Reiser4 class/plugin interfaces that correspond=
=20
very closely to the VFS class/plugin interfaces (the *_operations).  In thi=
s=20
case it might make good sense to lift those plugins from Reiser4 to VFS=20
plugins.

(If the VFS class/plugin interfaces are subsets of some Reiser4 class/plugi=
n=20
interfaces, you could also probably do the lifting.  The additional Reiser4=
=20
class/plugin interface parts could be added to the split off and added to t=
he=20
VFS objects via the generic pointer field [i.e., use it to attach the=20
additional data and class/plugin pointers to the objects].  As this adds so=
me=20
pointer pain for the additional parts you may not really be gaining anythin=
g. =20
Another possibly approach might be to just extend each of the VFS object=20
structures by making them the first entry in more flushed out Reiser4=20
specific structures [the Reiser4 code better be doing the allocating in thi=
s=20
case].  *grin*)

Later!  -T

=2D-=20
 Tyson Whitehead  (-twhitehe@uwo.ca -- WSC-)
 Computer Engineer                          Dept. of Applied Mathematics,
 Graduate Student- Applied Mathematics      University of Western Ontario,
 GnuPG Key ID# 0x8A2AB5D8                   London, Ontario, Canada

--nextPart9112068.3n9Q1jY5Fi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCwFX2RXbLmIoqtdgRApMPAKDeM0LjpbMaGt+WZC5FMdKmlwpTRwCfcb5/
BOpZIH/hheKMoMwR7/XIBEE=
=MkkW
-----END PGP SIGNATURE-----

--nextPart9112068.3n9Q1jY5Fi--
