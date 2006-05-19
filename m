Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWESGRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWESGRj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 02:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWESGRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 02:17:39 -0400
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:7305 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932236AbWESGRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 02:17:38 -0400
Message-ID: <446D61EE.4010900@comcast.net>
Date: Fri, 19 May 2006 02:13:02 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Stealing ur megahurts (no, really)
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I saw someone bench Windows XP on a 66MHz CPU with 20MB RAM (Pentium
clocked down), and had an interesting thought.. try to bear with me on
this one.

Often times software engineers will seek out old machines, like 486DX
based or Pentium Pro or whatnot, whatever they can find.  This is
because of something apparently called "Requirements Engineering," which
a colleague of mine explained to me as a bunch of programming students
stopping by his dorm to use his slow ass machine so they can figure out
what the "Minimum System Requirements" for their projects should be.

Scrambling for an old machine is ridiculous.  Down-clocking makes sense
because you can adjust to varied levels; but it's difficult and usually
infeasible.  Pulling memory and mix and matching is not much better.

On Linux we have mem= to toy with memory, which I personally HAVE used
to evaluate how various distributions and releases of GNOME operate
under memory pressure.  This is a lot more convenient than pulling chips
and trying to find the right combination.  This option was, apparently,
designed for situations where actual system memory capacity is
mis-detected (mandrake 7.2 and its insistence that a 256M memory stick
is 255M....); but is very useful in this application too.

This brings the idea of a cpumhz= parameter to adjust CPU clock rate.
Obviously we can't do this directly, as convenient as this would be; but
the idea warrants some thought, and some thought I gave it.  What I came
up with was simple:  Adjust time slice length and place a delay between
time slices so they're evenly spaced.

The idea here would be to determine first the ratio of CPU real MHz to
target MHz and use that for adjustment.  We need to calculate a number
of things to do this:

 - The normal length of a time slice, in mS.  I believe this is 20mS.
 - The normal number of time slices per second.  This should be 50.
 - The ratio of real_mhz to target_mhz
 - The new length of a time slice, (target_mhz/real_mhz) * 20mS
 - The spacing between time slices, 20 - time_slice (*)

(*) (1000mS - (time_slice * time_slices)) / time_slices
  == 1000mS/time_slices - ((time_slice*time_slices) / time_slices)
  == 1000/time_slices - time_slice
  == 20 - time_slice WHERE time_slices = 20 per second

What this means is the scheduler sits idle between time slices, and uses
shorter time slices that reflect what a full time slice would have time
to do on a lower clocked CPU.  This of course isn't perfect, but it's near.

A modern 2GHz CPU with cpumhz=200 would result in the following data:

time_slice           = 2mS
time_slices          = 50 per second
delay_between_slices = 18mS

This should be sufficient that 1/10 the time (2 of 20mS) is allotted to
a time slice; and the CPU wastes 9/10 of the time idle.  This would
somewhat simulate a 200MHz system.  Probably not very well though.

Questions?  Comments?  Particular ideas on what would happen?

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRG1h7As1xW0HCTEFAQKeug//ei2tmEZpwexhhm1mh3VE693VZWE2rryG
Dnfq8g08RT0SnmS5GPXLcux/tyjLnt4aSI4MthCWpPrz32C+j3dkwTHz+HAW8/hT
Dl4om6lHL1cFGJG7asbCfjjA6TEYU2yIAWBbCYyrdoFU64Xt4Itb6oBwLkJcVwVJ
VqYbKmF2uc6VBblWlDUqSFs+imlwMzlli6BiUyUC1cm8y4GibQhFkcvoNBMv9b3d
Zzag+Azhs/Bc7RT69tSFOzlRlImAMARrhtZVrANCMo3cf8klvtXunBQe3YS1ygFq
yB/GdZC/tzWkds7aSpTniAeuzNC4/kfCFdV9p/V3ZBTBM9xkcque+OE/p5E3YGZY
b3HqNXXBqP+AjPba5vFti4wQMM7ZzPFouw5CmIGlOdjIRPzGb22HWGMikMtmcrnt
uD+2olJHIk9cJ5wK9A7ForY9eldyELTJTa+Vn5rUe7jZAEUPil17E0gktchYC1es
NPrerDP1KDANdnIFHjhA9uZPcehtj594Dbk3Mgrq55Rsn5IuKmGntfSnc4aI1YiH
uqi5J++pH/UfhlkdUOwZlRbiHxl+wjPN+4PGGUqXnknJphLHiSSRzEAzmlm9TDP3
bovPzD+Q27ddXjs3s28W94QvSHzdAP2dyqrWb55E9LmAUIBtLBLt+jrHdfhcRIJc
Zxr5jX514Y8=
=Mc6F
-----END PGP SIGNATURE-----
