Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVF0FcC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVF0FcC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 01:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVF0FcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 01:32:01 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:57874 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261810AbVF0Fbx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 01:31:53 -0400
Message-ID: <42BF8F42.7030308@slaphack.com>
Date: Mon, 27 Jun 2005 00:31:46 -0500
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
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>            <42BF667C.50606@slaphack.com> <200506270423.j5R4Np9n004510@turing-police.cc.vt.edu>
In-Reply-To: <200506270423.j5R4Np9n004510@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Valdis.Kletnieks@vt.edu wrote:
> On Sun, 26 Jun 2005 21:37:48 CDT, David Masover said:
> 
> 
>>Assume we can do on-disk caching, similar to fscache/cachefs for nfs.
>>Now, benchmark:
>>
>>$ unzip linux-2.6.12.zip && make -C linux-2.6.12
>>
>>versus the hypothetical
>>
>>$ make -C linux-2.6.12.zip/.../contents
>>
>>This is an automatic performance gain, in theory, because the second
>>command is identical to unzipping just the parts you need into
>>linux-2.6.12, then running "make".
> 
> 
> Nope, they're not identical.  The first specifically unzips it into the file
> system, leaving the zip file intact.  The second, you're having to take all
> those .o files and other stuff that the 'make' generates and put them back
> into the .zip file *on the fly* - when the 'make' is half done, the .zip should
> reflect a directory tree that has had half the make execute....

This assumes we limit ourselves that way.  I doubt something I think of
in five minutes is the final API.

> (Think - after that hyptothetical 'make' completes, where is 'vmlinux'? ;)

In the cache where the stuff was unpacked to.

Anyone who wants to discuss things that will actually be done soon, or
anything relevant to merging reiser4 in the near future, can stop
reading now.

*If* we decide that this must go both ways, *then* we either turn off
write support inside the zipfile and do "make" with a symlink farm (cp
- -as isn't hard), or (better) we can set things up so that only on access
(most likely a read) of the original zipfile do we re-add all the changes.

I think copy-on-write files are planned sometime, too.  So one could
imagine doing a COW of the original zipfile, so that you have:

linux-2.6.12.zip	# original, for redistributing and patching
linux-2.6.12-mine.zip	# your own patchset, ready for redistributing

And, of course, there's always an option to treat the cache as its own
COW of the original zipfile.

This system (which I did discuss on "Silent Semantic") is also useful
for various other ways one would want to package something.  Imagine
someone's made a bootable iso which uses zisofs for transparent
compression.  You can set things up so that the iso->files plugin works
as zip does above, grabbing the files you need on the fly and putting
them in an on-disk cache, and files->iso takes only the files which have
changed and runs them through mkzftree, then takes the whole tree and
runs it through mkisofs.

This actually isn't a performance win at all, if you know what you're
doing.  You could always set up a script (as I did when playing with
this) which uses mkzftree's --crib-path option.

But, transparency is nice.  This way, all that's needed to build a new
image is to chroot into some_file.iso/.../contents and change whatever
you wanted, even use a package manager from the image, and when you're
done, "cdrecord some_file.iso" will build the image and burn it.

It also doesn't have to be lazy.  Files could be compressed as you go,
either in a blocking way or at a low priority, or they could be put off
until you actually want to burn the image.

I can imagine all kinds of packaging getting easier this way.  A
universal interface to peek inside of some sort of package, image, or
software distribution and change its contents, then build a modified
image.  I guess that makes it a sort of "make" plugin.




OK, here's an example where the "zip"-like behavior makes sense:

Suppose you buy a computer with a desktop Linux pre-installed.  But, on
your first boot, the system is entirely composed of one giant
copy-on-write tree, which refers to all the packages needed to build the
entire system.  All the packages in the standard distribution are
pre-loaded onto the hard drive as (say) .deb files.

In this situation, every time the user runs a program for the first
time, it unpacks from a (presumably compressed) package.  When a package
is entirely unpacked, it may be removed.  Since most users won't use a
majority of the software, there's a huge amount of disk space saved.
Yet when a user does want to use some random piece of software, they
simply run it, and it behaves as if it was already installed.

Download a package, and it can be run almost immediately after
"installation".  A bit of a slow startup, but maybe not as much as
trying to unpack absolutely everything in the package all at once and
get it set up.  For example, on Debian, the Foomatic PPDs all come in
one package, making it easy to find the right one from the CUPS web
interface -- but you only need a maximum of one PPD file per printer you
want to use, and there are hundreds of PPD files in the foomatic-ppds
package.  There are plenty of other programs (Mozilla, OpenOffice) which
install lots of components which you may never use, and certainly won't
use immediately on your very first run.

This way you save space and installation time.

I'm sure this was also discussed in "Silent Semantic", and I think it is
mostly not my idea.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr+PQXgHNmZLgCUhAQLwoQ//f2vNSd4ZGBPjoaZBq8VlZ5l+wWCzinCF
h21YI5f7l3d1uGO/oo/E4AESrAFN0A410fNNfAVEtNPJy64SlrrLY/PMBuOB5w7k
83ZNLSqExdblA64FkPkTB6/l+g1fmhey2xAIRvTUrSyAwnbs6fYD6sNq2oVV/czR
G4t01iWyEGNyt3Ik41Pl/UqVCepHWcNNRUJL5eQYEakbp1hSwTU3NVkzwHeq/MJ/
OPP81Pq5NMfUUkH5h+G3/zghM44czSTPezC2Be/VS7vx0BvLWOSmS2qaPCogr35o
QJwksZqaUirHtVotG353vShTyOSXlkEfhelyEKrMp7V+dK9ChP4hJeNTrS4eAxsF
Wg25ZhFWN2D3ALdYdiG4dG2qFqSgR/mM2wwxzgumXI1YY1g0ppHDBtgRi8feXfjn
COB+G0w1cM2ofGz2v2eCZIps2cS/5bWG6eyjdFN/z+KnlO6vuDiQ/z9y1KwUKURs
u8+VLr9aWDNKuFisDbRoIc2Emq9sHUFNVG9WxrTY2Yd7RXWQfv1+gzvJt8FOwKVW
49L1jU2YLR31Kj6cc7HnHowzzVBTuZxJV9nnZkvpVQNVa/NFM2n44Og+Uvm06ikG
1JK2oLNgQGwRWW+UXJIBDqABYqh5COx4PMeRI3/cRPOxBLUdk34Hp+35PnvNSx3D
pffWHDlDaew=
=MtUX
-----END PGP SIGNATURE-----
