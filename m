Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293089AbSCOShK>; Fri, 15 Mar 2002 13:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293088AbSCOShC>; Fri, 15 Mar 2002 13:37:02 -0500
Received: from cm.med.3284844210.kabelnet.net ([195.202.190.178]:2998 "EHLO
	phobos.hvrlab.org") by vger.kernel.org with ESMTP
	id <S293082AbSCOSgw>; Fri, 15 Mar 2002 13:36:52 -0500
Subject: Re: 2.4.19pre3aa2
From: Herbert Valerio Riedel <hvr@hvrlab.org>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, linux-crypto@nl.linux.org
In-Reply-To: <3C923120.B3AF105E@pp.inet.fi>
In-Reply-To: <20020314032801.C1273@dualathlon.random> 
	<3C912ACF.AF3EE6F0@pp.inet.fi>
	<1016194785.5713.200.camel@janus.txd.hvrlab.org> 
	<3C923120.B3AF105E@pp.inet.fi>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-y+DSGB1VglYtkynIMvf+"
X-Mailer: Evolution/1.0.2 
Date: 15 Mar 2002 19:36:36 +0100
Message-Id: <1016217396.5595.279.camel@janus.txd.hvrlab.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y+DSGB1VglYtkynIMvf+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hello!

On Fri, 2002-03-15 at 18:36, Jari Ruusu wrote:
> > /* definitions for IV metric */
> > #define LOOP_IV_SECTOR_BITS 9
> > #define LOOP_IV_SECTOR_SIZE (1 << LOOP_IV_SECTOR_BITS)
> >=20
> > typedef int loop_iv_t;

> Not changing IV parameter type in 2.4 kernels is important. Break that in
> 2.5/2.6 kernels, but not in stable 2.4, ok?=20

if you look closely at the typedef above, you'll notice that it doesn't
introduce a _new_ type, but only a synonym for the 'int' type, which
happens to be the type used in 2.4 kernels...

typedef int (* transfer_proc_t)(struct loop_device *, int cmd,
                                char *raw_buf, char *loop_buf, int size,
                                int real_block);

what I'm trying to do by the introduction of this _aesthetic_ syntactic
element, is to prepare the way to smoothly upgrade the type used for the
IV value; and more important to keep filter modules from having to add=20
ugly #ifdef LINUX_VERSION_CODE <=3D KERNEL(2,X,Y)... just for changes
which could be catched by kernel headers...

have you ever wondered, why even the C standard defines some typedefs as
size_t instead of using just a 'long'?

> Older 2.4 kernels dont't have
> loop_iv_t, and being able to compile _existing_ modules for them is
> important.=20
as older kernels will likely have the variable-IV-metric, they'll have
to be patched anyway (loop.[ch]), and after having patched them, the
problem vanishes...


>> ps: just to make one thing clear (again), I don't care too much whether
>> my loop-fix or jari's goes in; I primarily care for a fixed IV situation
>> (including the above mentioned #define's/typedef) and if possible anyhow
>> to allow for limited compatibility to the old metric...
> So the choice here is either break (or at least cause need to modify) all
> other implementations or cryptoapi implementation.
actually it's just -- either make my life harder w/ cryptoapi or not, as
it doesn't affect other implementations; but other implementations may
start to use those typedefs in the future, so when 2.6 (or whatever
comes out) the 'current' 2.6 has them already, and the 'ultra-stable'
2.4's will have them as well... and maybe everybody is happy, that he
can compile the same c source against both, 2.4 and 2.6, loop.h and
still get a correct filter module...

> Herbert, if this loop_iv_t type goes into mainline kernel, I will have to
> reverse that on loop-AES patches for backward compatibility.
I don't see why... loop_iv_t is just a 'reviced-declarator-type-list
int', i.e. it is is type compatible w/ an 'int'... so you won't even
notice the difference when compiling loop-AES against it...
=20
> Dependency on above mentioned #define's/typedef on kernel include files i=
s
> silly, as cryptoapi can define them on any of its own include files.
yeah, sure... at the expense of having to redundantly keep track (ugly
#ifdef's) of which kernel version is being used...

another reason I haven't mentioned so far is about the #define's;

#define LOOP_IV_SECTOR_BITS 9
#define LOOP_IV_SECTOR_SIZE (1 << LOOP_IV_SECTOR_BITS)

...if you don't see any reason for those 2 innocent #define then you
won't see any reason for other #define in the kernel headers as well;
e.g.:

fs.h:
#define BLOCK_SIZE_BITS 10
#define BLOCK_SIZE (1<<BLOCK_SIZE_BITS)

you may ask why those are used, since they are hardcoded anyway... well,
lemme show you an example where this would considerably help:

loop.c:
static unsigned long compute_loop_size(struct loop_device *lo, struct
dentry * lo_dentry, kdev_t lodev)
{
        if (S_ISREG(lo_dentry->d_inode->i_mode))
                return (lo_dentry->d_inode->i_size - lo->lo_offset) >> BLOC=
K_SIZE_BITS;
        if (blk_size[MAJOR(lodev)])
                return blk_size[MAJOR(lodev)][MINOR(lodev)] -
                                (lo->lo_offset >> BLOCK_SIZE_BITS);
        return MAX_DISK_SIZE;
}

and now imagine the same source fragment, with the #define's
evaluated... wouldn't that be less self-explaining?

well, I hope I could make clear to you, why using symbolic constants and
the use of typedefs in C are good practice in general wrt software
engineering...

regards,
--=20
Herbert Valerio Riedel       /    Phone: (EUROPE) +43-1-58801-18840
Email: hvr@hvrlab.org       /    Finger hvr@gnu.org for GnuPG Public Key
GnuPG Key Fingerprint: 7BB9 2D6C D485 CE64 4748  5F65 4981 E064 883F
4142

--=-y+DSGB1VglYtkynIMvf+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8kj80SYHgZIg/QUIRAgSbAKCq8MeABYcEmfCEDoGPmvda8ggP/QCginXM
edUfJD7SrhcS+yaSDe1FrG4=
=kIEP
-----END PGP SIGNATURE-----

--=-y+DSGB1VglYtkynIMvf+--

