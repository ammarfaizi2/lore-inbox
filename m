Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265178AbSJWTpU>; Wed, 23 Oct 2002 15:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265180AbSJWTpU>; Wed, 23 Oct 2002 15:45:20 -0400
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:51251 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S265178AbSJWTpN>;
	Wed, 23 Oct 2002 15:45:13 -0400
Date: Wed, 23 Oct 2002 21:51:17 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: [RFC] CONFIG_TINY
Message-ID: <20021023215117.A29134@jaquet.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Inspired by the recent lowmem threads on l-k and in loose
conjunction with acme, I am trying to do a CONFIG_TINY
patchset which would reduce the kernel image size and memory
footprint. Below is my list of ideas, collected from the
aforementioned threads and from acme's input. Note that some
of these are already being persued by other people (notably
[by me] Andrew Morton).

Not all, if any, of this will ever be fit to go into the
kernel proper. This is fine, since that is not the primary
purpose for me right now.  Starting off, the idea is to
explore whether certain things are doable or not and what
their actual payoffs are. From there cleanliness will be
considered. I expect to learn as I go, tying neatly into the
'cleanliness later' approach :)

Nevertheless, some of these are also painful enough that I
won't do them if directly told that they never will makes it
into the kernel (the printk and __initstr changes comes to
mind here) (acme, I think you wrote that you had gotten
encouraging noises from linus on the __initstr one?)

The purpose of this mail is to get feedback in form of further
areas where kernel size could be reduced, to learn if others
are looking at some of these points and to see if I get some
of the aforementioned 'never going to make it' noises.

Anyway, the list, terse form (there is no other):

Compile time:
o acme's __initstr (mark strings from __init functions as
  __initdata).
o reduce usage of prinkt in kernel by #defining iprintk for
  INFO messages etc and let the desired (minimum) logging=20
  level be decided at compile time.
o configure out #! exec stuff (Mentioned by Alan Cox in the
  'end of embedded linux' thread).
o configure out procfs in ide (arjan's CONFIG_SMALL from
  redhat kernels) (I might have missed the point here, I
  only inspected briefly). Make procfs configurable for the
  IDE subsystem?
o reduce usage of inlines in the kernel. (Andrew Morton has
  an old patch I need to play a bit more with).
o SWAP and BLOCK_DEV as modules

Runtime:
o vfsmounts hash reduced to one page
o TCP(networking?) hashes reduced
o mempools reduced (Andrew Morton seems to be attacking this)



I have made a few crude, preliminary stabs at patches for some
of the above against 2.5.43, applies against 44 as well. The noswap
and noinline ones have been boot tested, the printk one compile
tested. Comments welcome:

Config is 'allnoconfig', base kernel size is

   text    data     bss     dec     hex filename
 478401   50720  254816  783937   bf641 vmlinux



No swap: I stubbed out all swap calls in mm/ by jackhammer.
New kernel size:

   text    data     bss     dec     hex filename
 469133   50433  252192  771758   bc6ae vmlinux

(Patch at www.jaquet.dk/kernel/config_tiny/2.5.43-noswap)



printk: So far I have defined {i,d,n,w}prink corresponding to
KERN_ {INFO,DEBUG,NOTICE,WARNING} and have converted files to
use this. Higher levels are left untouched.

Comments:
 1) It may seem inconsistent to have iprintk("Fine day today")
    followed by printk(KERN_CRIT "Aiee. Drive on fire!!"). But
    converting _all_ printks seems quite intrusive. Or I am just
    waffling here?
 2) The WARNING level is included in this cleanup since it is
    the default log level and lots of places dont specify a
    log level. If higher log levels are not converted to this
    printk format, it might make sense to make these places
    use KERN_WARNING instead of letting these be configured
    away at compile time?
 3) The current names are short. However, the dprintk is
    troublesome for obvious reasons. Currently, I am using
    raa_printk :) but that would change. printk_info etc
    have been suggested as an alternative.

File touched so far is kernel/*, init/*, fs/*, ipc/*, mm/* and
kernel.h (where I stuck the #defines).
New kernel size:

   text    data     bss     dec     hex filename
 478109   50337  254560  783006   bf29e vmlinux   (woo! :)

(Patch at www.jaquet.dk/kernel/config_tiny/2.5.43-printk)



Reduce inlines: This is an old patch I got from Andrew Morton,
eliminating some inlines in fs/, mm/, kernel/ and lib/. So far=20
I have only brought it forward to 2.5.43, I plan to do a more
aggressive version soon.

   text    data     bss     dec     hex filename
 474129   50720  254816  779665   be591 vmlinux

(Patch at www.jaquet.dk/kernel/config_tiny/2.5.43-noinlines)


Your comments will be appreciated.

Regards,
  Rasmus

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9tv20lZJASZ6eJs4RAgH1AJ9aSilkR/TBzcQQ6iUMYh7JAxkaiACfQsiI
fmZtyTF7PfWFdCZyyHKiHpg=
=k0WZ
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
