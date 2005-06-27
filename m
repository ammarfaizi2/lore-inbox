Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVF0CiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVF0CiM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 22:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVF0CiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 22:38:12 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:25604 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261706AbVF0Chu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 22:37:50 -0400
Message-ID: <42BF667C.50606@slaphack.com>
Date: Sun, 26 Jun 2005 21:37:48 -0500
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
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu>            <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>
In-Reply-To: <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Valdis.Kletnieks@vt.edu wrote:
> On Sun, 26 Jun 2005 17:35:48 CDT, David Masover said:
> 
> 
>>>Right. So please explain what crypto/raw/foo and crypto/inflated/foo.gz give you.
>>
>>In that example (shouldn't have used the name "crypto", but oh well), it
>>should be crypto/raw/foo.gz and crypto/inflated/foo -- where foo.gz is
>>the gzip'ed file and foo is the transparently compressed/decompressed
>>file.  Basically, these are equivalent:
>>
>>$ zcat crypto/raw/foo.gz
>>$ cat crypto/inflated/foo
> 
> 
> I'm *quite* aware of what your preconceived notions think it *should* be.
> 
> Maybe the two examples I asked for have *real-world* meanings that you should
> be allowing for.  Like, for instance, on a mail server, where the A/V software
> may need to unzip a file 5 or 6 times to find out if there's malicious content.
> 
> Or seeing if it's a ".zip bomb", where a small .zip will decompress to gigabytes.
> 
> Or I'm testing a new compression algorithm, to see if multiple compressions help
> (yes, I know that it *shouldn't* help - but I've seen real-world cases where the
> algorithm could only look at a 4K or 8K window at a time, and if you hit a *very*
> long run of duplicate 4K segments, a second compression would compress all the
> identical or near-identical "this is a 4K chunk" tokens...)
> 
> 
> 
>>>It's got a *LOT* to do with it if I created a *DIRECTORY*, to use *AS A DIRECTORY*,
>>>the way Unix-style systems have done for 3 decades, and suddenly my system is
>>>running like a pig because the kernel decided that it's a .zip file.
>>
>>The kernel does not decide that.  You do.  And it doesn't automatically
>>decide that every time you create a file.  You have to use some
>>interface to trigger the plugins.
> 
> 
> Oh, I'm waiting for the fun the first time somebody deploys a plugin that
> has similar semantics to 'chmod g+s dirname/' ;)
> 
> 
>>I guess I need a new name for this approach.  That's three possible ways
>>of doing this?
> 
> 
> I *said* you need to think this through in detail, didn't I? ;)
>  
> 
>>I remember discussing that, actually.  It wouldn't automatically do this
>>if you didn't want it to, but it would be nice if, say, it was something
>>truly seekable like linux-2.6.12.zip, and linux-2.6.12 was a
>>user-created symlink to linux-2.6.12.zip/.../contents, and we had a nice
>>caching system...
> 
> 
> I think you're highly deluded as to just how much or little performance gain
> this will get you. Model what happens with a kernel 'make' on a 256M machine
> with and without all that zipping and compressing, and assume that a constant
> 48M is available for caching of the linux-2.6.12/ tree.

Ignoring Hans' point, there is still a performance gain.

Assume we can do on-disk caching, similar to fscache/cachefs for nfs.
Now, benchmark:

$ unzip linux-2.6.12.zip && make -C linux-2.6.12

versus the hypothetical

$ make -C linux-2.6.12.zip/.../contents

This is an automatic performance gain, in theory, because the second
command is identical to unzipping just the parts you need into
linux-2.6.12, then running "make".  The one disadvantage is that because
the unzipping is done on demand, it only really performs well if you can
keep the "zip" binary cached.  Even on most embedded systems, 54K of RAM
is really not much to ask these days.

Also, once you've run "make" once, you get to run it as many times as
you like, and so long as the on-disk cache of the zipfile is still there
and valid, you never have the overhead of unzipping again.

Of course, this probably saves only a minute or two at most per kernel
compile.  But that doesn't mean there aren't real-world situations where
this kind of architecture would be much more beneficial.

>>This is nice because then you get exactly the same performance during
>>"make" as you would with "unzip && make", only better, because files you
>>don't ever use (lots of arch, for instance) are not unpacked.
> 
> 
> Go read http://www.tux.org/lkml/#s7-7 and ponder until enlightenment arrives.

So what?  I don't intend to convince anyone based on how much
slower/faster their kernel compiles.  It's meant to illustrate the
principle of the thing.

Besides, your point was that you could not run make inside of a kernel
tarball/zipfile.  Nobody ever suggested that you would actually want to.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr9mfHgHNmZLgCUhAQJi0g//RGxFXWi8Om4EnKsZHcI0J7X3G6T9pj2a
nwkWwjLdyg6jykdt3a5MTELBgOM2uT87k7CeO7TasA/T1ZkZ/y2Yw7x50YIgrb7j
W1u5N/vfDLw3C2Nd6O2fe/b4ygReyBB6HQtNTw/k+XxDswxtEp0mcZHpNxt+W9B4
s0naezawRjF51P4ISqa6HoRo7vZUkXv+3CwuZinC5m8KnW2Us8Ww5uDjtNBLpJGR
zs79w24zaj6VSHjF8lO6CuMKQLjSelMDXKDEkFHaybJgz7AckkcZg5c6VDTrc3/t
m8HM5oyHWfRqVeQt9cMdLdcBZnhdbspSwQaNQkdkrZx1IX96mPoMNDUwk1B/TIi7
++iqpkDYeOdg+DWzGPVpwQ+5LQC+7m8vRHv5dROIM6T89TnlUck2clBiPovzSP+8
KMR1R6F7qBPxJMkPcy2MNOVMkjN+VLSOCzOeOXVEUkNYdXjrJB5h3XIN5MyRR7C/
pRmjB2crzPTUz2yBatP+QUFNUMadikMqj44sEc/ie8iHbo9pfxQC/wY4M4VkJcf2
03spe2e8M+k3txj63O9TmJYgobkjx+d+cJ5Zm7DbKJmGlVaAGqmCXeNjxhTtBSwU
yP2Jrz6Awu+nDxFxMAsN4GP17/0/aXdBhIYLPGyAJ9/HV7KHENIqIjnvD4e3bXnU
shBrM+G1N5E=
=BXCi
-----END PGP SIGNATURE-----
