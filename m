Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVBUKVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVBUKVP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 05:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVBUKVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 05:21:15 -0500
Received: from moutng.kundenserver.de ([212.227.126.189]:8431 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261914AbVBUKTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 05:19:38 -0500
From: Amon Ott <ao@rsbac.org>
Organization: RSBAC
To: rsbac@rsbac.org
Subject: Re: [rsbac] Thoughts on the "No Linux Security Modules framework" old claims
Date: Mon, 21 Feb 2005 11:19:16 +0100
User-Agent: KMail/1.7.1
Cc: Lorenzo =?iso-8859-1?q?Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>
References: <1108507089.3826.83.camel@localhost.localdomain>
In-Reply-To: <1108507089.3826.83.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1737760.nVRbo8KpZ4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200502211119.24845.ao@rsbac.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e784f4497a7e52bfc8179ee7209408c3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1737760.nVRbo8KpZ4
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks,

this is a late reply, because I was away for a week.

On Dienstag 15 Februar 2005 23:38, Lorenzo Hern=E1ndez Garc=EDa-Hierro=20
wrote:
> The purpose of this email is not re-opening the old flame on the
> anti-LSM "pleas" that were subject of many discussion and
> disappointments in certain developers and user groups.
>=20
> I will try to answer some of those in as much as possible organized
> manner, without any personal opinion being show in front of the
> objective analysis, and talking from the side of the developer who=20
is
> looking at the advantages and shortcomings of different solutions to
> achieve almost the same thing (or at least, help when achieving it):
>=20
> [ http://www.rsbac.org/documentation/lsm.php ]

This is my text, written some time ago. Some of the arguments are=20
still valid, some others have been discussed in the mean time.
=20
> -> 1. Incompleteness
>=20
> AFAIK, the LSM framework has evolved much more since it got accepted=20
in
> the kernel mainline, many independent hackers contributed to it=20
because
> they thought that it needed further improvement, but even if people
> could think in the beginning that it was going to be more a weakness
> than a real security enhancement, nowadays there are many available
> hooks, demonstrating how complete it can be, also, hooks can be=20
added

I have no doubt that many small improvements have been done, and LSM=20
is more complete by now. My main objectives are still valid, though.

> easily even if there's no (AFAIK, visible) documentation on it (a=20
thing
> I'm planning to solve in the forthcoming months, maybe updating the
> current documentation at immunix.org), depending on how well the
> developer knows about how LSM framework works and how the kernel DAC=20
and
> standard checks work themselves.

Documentation is a general problem in all projects, not only the=20
kernel. For me, this has never been an issue against LSM, although=20
some things, especially the weird stacking, should be documented to=20
avoid errors in implementation.
=20
> The point is that people must have in mind that hooks need to work=20
as
> they are supposed to do: no ABI/API breaking, no unexpected effects=20
on
> "normal operation flow" of the kernel (if it's not explicitly=20
wanted),
> no extra overhead or logics messing...etc.

Agreed to "not breaking APIs", unless unavoidable to get some=20
important functionality. And certainly, all extensions must be=20
optional.

I strongly object against the "no overhead" argument, as I did many=20
times before. Overhead should be low, and it can be. Security comes=20
with some costs - you can either say "minimize overhead at all=20
costs", "maximize security at all costs", or try to make a good=20
balance. IMHO, the first has been selected as a guide for LSM to get=20
it accepted for mainline, which I still regard as a bad decision.

As pointed out in another reply, the actual real world overhead is=20
pretty small - even with more extensive and data gathering hooks like=20
those of RSBAC. Even making MAC decisions with logging checks before=20
the Linux DAC decisions should be acceptable, because in almost all=20
cases access will be granted anyway, so the order of calls does not=20
matter.
=20
> In addition, LKMs using the LSM framework *don't need* to use *only*=20
a
> procfs sysctl interface or something alike for providing
> user-land<->kernel space communication capabilities.
> We have more options: registering a sysfs-based subsystem for=20
example.

This is a portability issue, these interfaces are very Linux specific,=20
some are even kernel version specific. The good old syscall is very=20
portable, and you can use a dispatcher to march dozens of calls=20
through this.
=20
> -> 2. Access Control Only
>=20
> Yes, and that's noticed from the "official" documentation.
> But, who says that we can't place auditing facilities inside the
> existing hooks? or even file system linking related tweaks?

There is a separate auditing subsystem now, but this was not my point.=20
Access decisions can be logged where they happen, or in some central=20
dispatcher.

> Also, why disabling DAC? It's not a good idea if you have to handle
> *ALL* at *your OWN*.
> And it represents, BTW, a real performance hit because you do=20
*double
> checking* or logics overhead.

Some people even want to override DAC, because it is quite limited. I=20
agree that this is dangerous - overriding should be off by default,=20
and there must be a big warning.

Actually, in RSBAC you have separate decisions for every active=20
decision module - up to 13 decisions for each request, plus the=20
runtime loaded modules registered through the REG facility. This is=20
not a problem, if it gives you a real benefit. My usual configuration=20
has 7 modules active, and the overhead is still low.
=20
> DAC checks normally *override* LSM checks, except in certain=20
situations
> when both pre- and post-processing LSM hooks are used.

No, they do not override LSM checks - they cannot grant access, if LSM=20
wants to deny it.
=20
> An operation must at least be (if no override present): 1) DAC
> compliant, 2) LSM->user compliant.
>=20
> Going into personal thoughts, what's the point of having a *real=20
pain*
> and maintenance overhead due to modifying the by-default permissions=20
and
> access control basis with your own, even if they can live and have=20
sex
> together?

There are cases where Linux DAC and MAC cannot live happily together,=20
because Linux DAC is too limited.

If you look at the SELinux default policy, you will see that they try=20
to do everything with SELinux, because only MAC settings are trusted.=20
Well, sure, this is painful, but can be necessary in some cases.

In RSBAC, you can convert Linux DAC settings to ACLs before switching=20
DAC off for some directory tree. This gives you complete DAC=20
settings, but makes them more flexible, fine grained and more MAC=20
like than standard Linux, because administration is no longer "owner"=20
based.

> -> 3. Low Level Internal Data Structures
>=20
> I agree that incorrect handling of the structures on-flow can lead=20
to
> kernel stack or runtime corruption, but this is nonsense to be=20
claimed
> as an LSM fault.

Again, I disagree. If you look at the age old discussion RSBAC vs.=20
SELinux between Stephen Smalley and me, he criticized that even the=20
few structures available in RSBAC hooks were dangerous.

Now LSM exposes many, many more of them, and expects modules to use=20
them directly. Most RSBAC modules work without ever touching the few=20
structures.
=20
> I had freezes many times when I started doing some development with=20
the
> LSM framework, but it was more because of my incompetency than the
> framework itself.

It is easy to freeze the kernel, but it is much easier, if you must=20
access lots of structures under locking conditions you do not know=20
about (and which might change between kernel versions).
=20
> When new kernel releases hit the streets, LSM framework is stable=20
and
> compatible with it, as many people contributes and also the folks
> maintaining it are good and responsible ones.

It is stable for what it does - most of my points are against design,=20
not implementation.
=20
> -> 4. Stacking
>=20
> I agree with this, but AFAIK there has been work done in this area,=20
as
> far it comes to mind, Serge Hallyn is someone to be asked about it.

The stacking problem is a direct consequence of the design with=20
distributed single user hooks. It has been criticized from the very=20
beginning and since then people have been trying to solve it.

Another big problem is that there is only one pointer at some kernel=20
structures for attribute data - which module is allowed to use this?=20
The first? Any? How do you know whether it is used or not?
=20
> -> 5. Posix Capabilities Without Stacking Support
>=20
> I don't get the point of these claims.
> The LSM framework currently has full support for dynamic and
> logic-changeable POSIX.1e capabilities, using the capable() hook and
> calling capable(from whatever location inside any other hook to=20
apply
> further logic checks (ie. in capable() check for jailed @current=20
process
> and deny use of CAP_SYS_CHROOT and CAP_SYS_ADMIN or what-ever-else
> capabilities) or in syslog() to deny access to kernel messages stack=20
to
> unprivileged users.

Without rechecking the current state: At least the last time I=20
checked, the hardwired kernel capabilities were explicitely disabled=20
when LSM got switched on. You had to use the capabilities LSM module=20
instead, which was not able to stack. It always had to be the last in=20
the chain, thus effectively sealing against any other LSM module to=20
be loaded later.

Make a short google search for LSM and capabilities, and you will find=20
loads of user problem reports for this topic. Again, this is only a=20
consequence of previous design decisions for the hooks, although a=20
complete implementation of the capability module would have avoided=20
the problem to show.

> -> 6. No Guaranteed Decision Call
>=20
> LSM hook architecture is designed (at least on current 2.6 brand) to
> return the decision calls results only if they have been=20
successfully
> defined and initialized (ie. typical if (ret) { return ret; } ).

You completely missed my point: The first LSM module decides, whether=20
to call all the others or not, and so on through the chain. Most LSM=20
modules do not call the others, if they want to deny access=20
themselves.

This works fine with stateless security models, but it gives you a=20
hell of a pain for a stateful model - or with non-access control=20
modules, e.g. for virus scanners, which always want to check even for=20
denied accesses.

> -> 7. Split Up Code=20
>=20
> That's just a personal remark, and, at least for me, the framework=20
looks
> pretty well structured and code seems as well distributed and=20
organized
> In The Right Way (tm).

Well, this "personal" and the other problems happen to make LSM=20
unusable for RSBAC, GRSecurity and others.

The split code argument has another, severe variant:

As all hooks stand independent beside each other and there is no=20
central decision function, you can never be sure that your LSM module=20
catches all relevant events in a given kernel version - unless you=20
inspect every kernel version and either add lots of #ifdefs, or=20
restrict your module to one single kernel version.

The problem is getting worse (again) with stacking - you can never be=20
sure, that you pass all relevant events to the modules registered=20
after yours.
=20
The concept behind the central function is the "reference monitor", a=20
central component, which is guaranteed to get requests for all=20
accesses to make access control decisions.

> It's a good point that even a child can understand it and do=20
something
> out of it too (I couldn't avoid to make this one).

Sorry, but unfortunately, security is usually more complex than what=20
most children can comprehend. A simple interface does not=20
automatically make its usage simple. The side effects with locking=20
and races can be severe.
=20
> -> 8. Stateless Calls
>=20
> As shown above, the hooks get as arguments all the necessary data to
> handle the operation and do anything on it to return the "right"=20
result
> depending on the followed logic.
>=20
> Most calls that make use of properties transition such as id's=20
changing
> ones (ie. old_suid -> new_suid) are handled with both values.
>=20
> In short, most time you don't need and *shouldn't* initialize=20
structures
> or whatever else, as you may have them available globally, or at=20
least
> passed as arguments from the original call to hook in the origin
> syscall.

Again, this was not my point. For decisions in most real security=20
models, you need some metadata. You can gather this in the hooks, and=20
thus avoid direct kernel data structure access, or gather it in the=20
decision logic. If you do the latter, you have to redo the gathering=20
in the post call - with possibly different results because of=20
parallel processes.
=20
> -> 9. Amount of Work
>=20
> Again it's a personal remark, not objective.
> At least from my point of view, I've needed less time to achieve the
> same goal by using the LSM framework.

What where your goals? Did you have a complete, more extensive=20
infrastructure, which you had to change to LSM? What models did you=20
implement?

Similar remarks, but the other way round, have been made for the RSBAC=20
REG facility. It is also a matter of what you know better and how you=20
work.
=20
> Indeed, at least in 2.6 brand, if you know how to handle it and how
> things work or even change between releases, the maintenance=20
overhead is
> *minimal*.

Let me express it this way: I am pretty sure that the implementation=20
of a given security model is much smaller, less error prone, easier=20
to port to new kernel versions and probably even significantly faster=20
without further optimization, if you use the existing RSBAC=20
infrastructure, than when using LSM hooks.

There are some examples of small LSM modules, which have been quickly=20
ported to RSBAC and now live in the rsbac/adf/reg subdir as examples=20
for runtime registration. As they do no longer need to implement=20
stacking, the code became very small.

> -> Final Remarks <-
>=20
> My thoughts on the personal remarks shown at
> http://www.rsbac.org/documentation/lsm.php are pretty short ones:
>=20
> Immunix, which seems to be the subject of the political,
> marketing-related comments has no hand-over-overall-project, and=20
they
> failed in most of the things they tried to do, at least from the=20
public
> eye such as supporting proprietary modules to do stacking, inode id
> structures tweaks and such.

Your guess is wrong, I was hinting more at SELinux than at Immunix=20
here. My statements were political, because many decisions look very=20
political. And, as explicitely written, they presented my personal=20
impressions on the whole process.
=20
> Think that they investors may dislike the model they followed when=20
the
> merge happened, anyways, and as an example, I pretty ignore those
> patents claims,for example, think that Type Enforcement (TE) is=20
patented
> and before SELinux got in mainline the enterprise with rights on the
> patent made a public announcement about their "opening" and=20
"for-free"
> use of their patented model.

When this happened, it seemed clear, that after selling the patents=20
anything could happen. Think of SCO and how they hindered Linux, and=20
then rethink what problems might appear with clearly accepted patents=20
all over the business and in various distributions.

Well, I am sure most people here agree that software patents are bad=20
for free software, so let's not dig into this.
=20
> I'm not a lawyer, but if they protest to get that rights back and=20
put
> price in our holy heads, they will get in trouble, with investors=20
and
> both users and developers.Nobody likes to listen to lies, and if=20
they
> did a one, then too much people will be disappointed with them.
> I don't think they will do anything like that if they haven't=20
already
> done it ;).

Companies are there to make money, not to provide public benefits.=20
Sad, but true.
=20
> As a little disclaimer, just to say that I'm pretty new here so,=20
maybe
> I'm not the best one recall on this, but at least I'm making use of=20
my
> rights to comment on it.

I appreciate you continued struggle against us thick headed developers=20
to get a better common solution. Still, some problems are deeper than=20
they appear, and you will often have politics or even massive company=20
interests involved.

Amon.
=2D-=20
http://www.rsbac.org - GnuPG: 2048g/5DEAAA30 2002-10-22

--nextPart1737760.nVRbo8KpZ4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCGbWsq9yn6h5RTo8RAtiEAJwOAP3GsnNzMHGX0YQUmT+Kw2E17wCfTsXx
BRRKycgAwLx+ymKBYhUjino=
=Ss2X
-----END PGP SIGNATURE-----

--nextPart1737760.nVRbo8KpZ4--
