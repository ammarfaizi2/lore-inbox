Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWFFXh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWFFXh2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWFFXh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:37:28 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:25515 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751359AbWFFXh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:37:27 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Date: Wed, 7 Jun 2006 09:38:29 +1000
User-Agent: KMail/1.9.1
Cc: Don Zickus <dzickus@redhat.com>, ak@suse.de, shaohua.li@intel.com,
       miles.lane@gmail.com, jeremy@goop.org, linux-kernel@vger.kernel.org
References: <4480C102.3060400@goop.org> <20060606230504.GC11696@redhat.com> <20060606162201.f0f9f308.akpm@osdl.org>
In-Reply-To: <20060606162201.f0f9f308.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1355126.fKEuaJZOJk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606070938.34927.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1355126.fKEuaJZOJk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi guys.

Back on board after the big shift :)

On Wednesday 07 June 2006 09:22, Andrew Morton wrote:
> On Tue, 6 Jun 2006 19:05:04 -0400
>
> Don Zickus <dzickus@redhat.com> wrote:
> > On Tue, Jun 06, 2006 at 03:15:07PM -0700, Andrew Morton wrote:
> > > On Tue, 6 Jun 2006 17:45:53 -0400
> > >
> > > Don Zickus <dzickus@redhat.com> wrote:
> > > > On Tue, Jun 06, 2006 at 04:18:15PM +0200, Andi Kleen wrote:
> > > > > > Because he is using a i386 machine, the nmi watchdog is disabled
> > > > > > by default.
> > > > >
> > > > > I changed that - it's now on by default on i386 too.
> > > > >
> > > > > -Andi
> > > >
> > > > I am trying to create a patch for this problem and it just dawned on
> > > > me, how does one store the previous state in a suspend/resume path =
if
> > > > the code hotplugs all the cpus first?  CPU0 is easy because an
> > > > explicit suspend/resume path is called, but it seems to be called
> > > > last after all the other cpus have been removed.  How do I save the
> > > > state?
> > >
> > > I'm really struggling to understand this question.  If you're referri=
ng
> > > to some per-cpu state then a CPU hotplug handler would be appropriate?
> >
> > Sorry.  I got ahead of myself.  My concern is how the suspend/resume co=
de
> > works with device drivers on an SMP system.  My initial impression was
> > that the subsystem registers with the suspend/resume layer and upon such
> > actions those registered functions are called.
> >
> > Inside those functions I saved the previous state of the watchdog timer.
> > However, I learned today that my understanding was incorrect.  Instead
> > first the _hotplug_ code is called for every cpu _except_ cpu0.  The
> > _suspend/resume_ functions are only called in the context of _cpu0_.
> >
> > This breaks the design I have because upon resuming the watchdog timers
> > automatically start on all cpus (except cpu0 because I saved the previo=
us
> > state through the handlers), regardless of what the previous state was.
> >
> > So my question is/was what is the proper way to handle processor level
> > subsystems during the suspend/resume path on an SMP system.  I really
> > don't understand the hotplug path nor the suspend/resume path very well.
> >
> > I didn't want to register a hotplug handler because a hotplug event is
> > really different than a suspend event (I want to _save_ info during a
> > suspend event).  The documentation I was reading seemed to suggest that
> > hotplug/suspend/smp was a work-in-progress.
> >
> > Is the typical approach to just hack in an extra parameter to the
> > start/stop functions of the nmi_watchdog letting the function know it is
> > coming through the suspend/resume path?
> >
> > Any tips, code, other docs would be helpful.
>
> OK...  My understanding of how it works is that the cpu hotplug handlers
> are called early in the suspend process to take the CPUs down.  Once all
> the APs are shut down, CPU0 will then proceed to handle the devices.
>
> So if you want to save and restore per-cpu NMI state then doing it in the
> CPU hot-add and hot-remove handlers is appropriate.  It will affect the
> behaviour of _real_ CPU hot-add and hot-remove as well.  But in what
> appears to be a correct fashion.
>
> All the above applies to suspend-to-disk.  I don't know if suspend-to-RAM
> shuts down the APs.

I'm not sure about suspend to ram either, but I can confirm the rest:

* Hotplugging handlers should manage the state of secondary cpus, really=20
disabling NMIs on unplug and only enabling NMIs if the boot processor has=20
them enabled (assuming consistent behaviour across cpus is desired). At a=20
hotplug event, both the hardware state and values of variables may not matc=
h=20
the state at the end of a previous hotplug event (we may have powered off, =
or=20
may have switched from a boot kernel to a suspended-to-disk one), so even i=
f=20
you know the hotplug event is synthesised, you may still need to treat it a=
s=20
uninitialised.
* Driver suspend and resume calls should only handle cpu0, and should not=20
touch other processors. The same semantics regarding hardware state and=20
values of variables apply here.

If you _really_ need to store in a variable what the hardware state was at =
the=20
last suspend call, it is possible to use _nosave variables, but this isn't=
=20
done or recommended at the moment. (I think it's a good idea, but that's ju=
st=20
my opinion). The value of a _nosave variable will persist across the atomic=
=20
restore of a suspend to disk kernel context, and since a drivers_suspend ca=
ll=20
is made before doing the atomic restore, you'll never get uninitialised=20
values. I'm not sure what it would be helpful for, but there may be a case.

Hope this helps.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1355126.fKEuaJZOJk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEhhH6N0y+n1M3mo0RAsMDAKC8YcwOq4xpMTzQ3qg2BJgmgD982gCfWLFt
t0a0iKBW86cur9Mv6JbdDr0=
=rMN4
-----END PGP SIGNATURE-----

--nextPart1355126.fKEuaJZOJk--
