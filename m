Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVBOWjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVBOWjy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 17:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVBOWjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 17:39:52 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:26830 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261922AbVBOWin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 17:38:43 -0500
Subject: Thoughts on the "No Linux Security Modules framework" old claims
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: rsbac@rsbac.org
Cc: "linux-security-module@wirex.com" <linux-security-module@wirex.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2G6jNhwJzbVAJJBRvxRo"
Date: Tue, 15 Feb 2005 23:38:09 +0100
Message-Id: <1108507089.3826.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2G6jNhwJzbVAJJBRvxRo
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

The purpose of this email is not re-opening the old flame on the
anti-LSM "pleas" that were subject of many discussion and
disappointments in certain developers and user groups.

I will try to answer some of those in as much as possible organized
manner, without any personal opinion being show in front of the
objective analysis, and talking from the side of the developer who is
looking at the advantages and shortcomings of different solutions to
achieve almost the same thing (or at least, help when achieving it):

[ http://www.rsbac.org/documentation/lsm.php ]

-> 1. Incompleteness

AFAIK, the LSM framework has evolved much more since it got accepted in
the kernel mainline, many independent hackers contributed to it because
they thought that it needed further improvement, but even if people
could think in the beginning that it was going to be more a weakness
than a real security enhancement, nowadays there are many available
hooks, demonstrating how complete it can be, also, hooks can be added
easily even if there's no (AFAIK, visible) documentation on it (a thing
I'm planning to solve in the forthcoming months, maybe updating the
current documentation at immunix.org), depending on how well the
developer knows about how LSM framework works and how the kernel DAC and
standard checks work themselves.

The point is that people must have in mind that hooks need to work as
they are supposed to do: no ABI/API breaking, no unexpected effects on
"normal operation flow" of the kernel (if it's not explicitly wanted),
no extra overhead or logics messing...etc.

In addition, LKMs using the LSM framework *don't need* to use *only* a
procfs sysctl interface or something alike for providing
user-land<->kernel space communication capabilities.
We have more options: registering a sysfs-based subsystem for example.

During the research I was doing recently on the current hook'ing
architecture, I wrote an useless patch to add a hook for sys_chmod(),
just because I forgot that notify_change() calls an existing LSM hook,
that can handle most file modes changing operation.
I just mean that I'm working daily with them and I forgot *ALL* about
it, so, it's not strange that many people could simply forget that LSM
makes developers and the kernel itself being able of hooks re-using
within similar or related syscalls that have in common some kernel
objects or standard checks.

In short, it's a complicated architecture that needs further research in
order to make solid critics on it, same for RSBAC (which it's not known
for me in terms of internal design and implementation, just having the
idea from the available documentation).
Both are good, but we must admit it, and we must admit that finally LSM
got in mainline and now seems getting more solid and stable.

-> 2. Access Control Only

Yes, and that's noticed from the "official" documentation.
But, who says that we can't place auditing facilities inside the
existing hooks? or even file system linking related tweaks?

Also, why disabling DAC? It's not a good idea if you have to handle
*ALL* at *your OWN*.
And it represents, BTW, a real performance hit because you do *double
checking* or logics overhead.

DAC checks normally *override* LSM checks, except in certain situations
when both pre- and post-processing LSM hooks are used.

An operation must at least be (if no override present): 1) DAC
compliant, 2) LSM->user compliant.

Going into personal thoughts, what's the point of having a *real pain*
and maintenance overhead due to modifying the by-default permissions and
access control basis with your own, even if they can live and have sex
together?

You can split up yours and maintain DAC alone and working with RSBAC
when the user chooses explicitly to use the RSBAC-basis checking, as LSM
does.

-> 3. Low Level Internal Data Structures

I agree that incorrect handling of the structures on-flow can lead to
kernel stack or runtime corruption, but this is nonsense to be claimed
as an LSM fault.

I had freezes many times when I started doing some development with the
LSM framework, but it was more because of my incompetency than the
framework itself.

When new kernel releases hit the streets, LSM framework is stable and
compatible with it, as many people contributes and also the folks
maintaining it are good and responsible ones.

Common mistakes that lead to system take down are more pointer and
structures wrong initialization, but again, those are related with the
developer side.
(It's the cost of doing "low level" sexy-thing development ;) )

-> 4. Stacking

I agree with this, but AFAIK there has been work done in this area, as
far it comes to mind, Serge Hallyn is someone to be asked about it.

Stacking seems not fully support in a out-of-the-box working manner,
nope, you need further work from your side to let other modules using
the framework being subjects of redirection from your hooks.

Anyways, we can even work together on the complete nifty-smooth-good
smelling solution and avoid the need of module stacking :P.

Apart of the joke, yes, this is, at least from my point of view (and I
may be, not may be, sure, mistaken as I've done near to nothing work on
LSM module stacking) a remaining task/feature.

-> 5. Posix Capabilities Without Stacking Support

I don't get the point of these claims.
The LSM framework currently has full support for dynamic and
logic-changeable POSIX.1e capabilities, using the capable() hook and
calling capable(from whatever location inside any other hook to apply
further logic checks (ie. in capable() check for jailed @current process
and deny use of CAP_SYS_CHROOT and CAP_SYS_ADMIN or what-ever-else
capabilities) or in syslog() to deny access to kernel messages stack to
unprivileged users.

Again, I'm not someone to make further comments on stacking-related
issues.

-> 6. No Guaranteed Decision Call

LSM hook architecture is designed (at least on current 2.6 brand) to
return the decision calls results only if they have been successfully
defined and initialized (ie. typical if (ret) { return ret; } ).

Let's see the truth that is out there:
-----
asmlinkage long sys_setgid(gid_t gid)
{
	int old_egid =3D current->egid;
	int retval;

	retval =3D security_task_setgid(gid, (gid_t)-1, (gid_t)-1, LSM_SETID_ID);
	if (retval)
		return retval;
(...)
-----
The developer should decide on what logic to use for return a value or
either just return without touching the returned value (this depend
slightly on the operation where are handling and what syscall is
called).

In certain cases we will see teo calls: pre and post processing as I
commented before in this email:
-----
asmlinkage long sys_setuid(uid_t uid)
{
	int old_euid =3D current->euid;
	int old_ruid, old_suid, new_ruid, new_suid;
	int retval;

	retval =3D security_task_setuid(uid, (uid_t)-1, (uid_t)-1, LSM_SETID_ID);
	if (retval)
		return retval;
(...)
return security_task_post_setuid(old_ruid, old_euid, old_suid,
LSM_SETID_ID);
}
-----

-> 7. Split Up Code=20

That's just a personal remark, and, at least for me, the framework looks
pretty well structured and code seems as well distributed and organized
In The Right Way (tm).

It's a good point that even a child can understand it and do something
out of it too (I couldn't avoid to make this one).

-> 8. Stateless Calls

As shown above, the hooks get as arguments all the necessary data to
handle the operation and do anything on it to return the "right" result
depending on the followed logic.

Most calls that make use of properties transition such as id's changing
ones (ie. old_suid -> new_suid) are handled with both values.

In short, most time you don't need and *shouldn't* initialize structures
or whatever else, as you may have them available globally, or at least
passed as arguments from the original call to hook in the origin
syscall.

-> 9. Amount of Work

Again it's a personal remark, not objective.
At least from my point of view, I've needed less time to achieve the
same goal by using the LSM framework.

Indeed, at least in 2.6 brand, if you know how to handle it and how
things work or even change between releases, the maintenance overhead is
*minimal*.

-> Final Remarks <-

My thoughts on the personal remarks shown at
http://www.rsbac.org/documentation/lsm.php are pretty short ones:

Immunix, which seems to be the subject of the political,
marketing-related comments has no hand-over-overall-project, and they
failed in most of the things they tried to do, at least from the public
eye such as supporting proprietary modules to do stacking, inode id
structures tweaks and such.

Also, it was a pretty good thing from them this piece of work.
Think that they investors may dislike the model they followed when the
merge happened, anyways, and as an example, I pretty ignore those
patents claims,for example, think that Type Enforcement (TE) is patented
and before SELinux got in mainline the enterprise with rights on the
patent made a public announcement about their "opening" and "for-free"
use of their patented model.

I'm not a lawyer, but if they protest to get that rights back and put
price in our holy heads, they will get in trouble, with investors and
both users and developers.Nobody likes to listen to lies, and if they
did a one, then too much people will be disappointed with them.
I don't think they will do anything like that if they haven't already
done it ;).

All I can say at the end is that we must take a lot of care when looking
at others solutions and try to figure how we can work and improve them
together.

I like both LSM and RSBAC frameworks, RSBAC developers did a great job
and they continue doing it, but, please, we *must* be at least polite
with others work.I don't mean that RSBAC folks didn't be, but we all
know that a lot of bad things were said around.We all do mistakes, is
matter of good intention and effort to don't make them again.

As a little disclaimer, just to say that I'm pretty new here so, maybe
I'm not the best one recall on this, but at least I'm making use of my
rights to comment on it.
Amen or what-ever-else.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-2G6jNhwJzbVAJJBRvxRo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCEnnRDcEopW8rLewRAo4tAJ9onodfFCHFinlomc+AYNM4osmQtQCeIbEo
I0uvut89DXnqFhJmIM+vT8s=
=81Tr
-----END PGP SIGNATURE-----

--=-2G6jNhwJzbVAJJBRvxRo--

