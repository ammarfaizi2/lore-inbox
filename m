Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbUJ3OdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbUJ3OdO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 10:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUJ3OdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 10:33:14 -0400
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:12991 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261180AbUJ3OdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:33:09 -0400
Message-ID: <4183A602.7090403@kolivas.org>
Date: Sun, 31 Oct 2004 00:32:34 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH][plugsched 0/28] Pluggable cpu scheduler framework
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF2F827538C2032923B7D101C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF2F827538C2032923B7D101C
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

With the recent interest in varying the cpu schedulers in linux, this
set of patches provides a modular framework for adding multiple
boot-time selectable cpu schedulers. William Lee Irwin III came up with
the original design and I based my patchset on that.

This code was designed to touch the least number of files, be completely
arch-independant, and allow extra schedulers to be coded in by only
touching Kconfig, scheduler.c and scheduler.h. It should incur no
overhead when run and will allow you to compile in only the scheduler(s)
you desire. This allows, for example, embedded hardware to have a tiny
new scheduler that takes up minimal code space.

This works by taking all functions that will be common to all scheduler
designs and moving them from kernel/sched.c into kernel/scheduler.c.

Then it adds the scheduler driver struct into scheduler.h which is a set
of pointers to functions that will all have per-scheduler versions.
include/linux/scheduler.h has the definitions for the scheduler driver
structure

kernel/sched.c remains as the default cpu scheduler in the same place to
minimise the patch size and portability of the patch set.

All variables of the task_struct that could be unique to a different
scheduler are now in a private struct held within a union in
task_struct. rt_priority and static_priority are kept global for
userspace interface and for the possibility of adding run-time switching
later on.

The main disadvantage of this design is that there will (initially) be a
  lot of code duplication by different scheduler designs in their own
private space. This will mean that if a new scheduler uses the same smp
balancing algorithm then it will need to be modified to keep in sync
with changes to the default scheduler. If, for example, you modified
just the dynamic priority component of the current scheduler and left
the runqueue and task_struct the same, you could make it depend on the
default scheduler and point most functions to that one.

However, the same disadvantage can be a major advantage. The fact that
so much of the scheduler is privatised means that wildly different
designs can be plugged in without any reference to the number of
runqueues, frame schedulers could be plugged in, shared runqueues (eg on
numa designs), and we could even keep new balancing in a "developing"
arm of the scheduler that can be booted by testers and so on.

What is left to do is add a per-scheduler entry into /sys which can be
used to modify the unique controls each scheduler has, and write up some
documentation for this and staircase.

Anyway the patches will follow shortly, and then (not surprisingly) a
port of the staircase scheduler to plug into this framework which can
also be used as an example for others wishing to code up or port their
schedulers.

While I have tried to build this on as many configurations as possible,
I am sure breakage will creep in given the type of modification so I
apologise in advance.

Patches for those who want to download them separately here:

http://ck.kolivas.org/patches/plugsched/

Here is a diffstat of the patches rolled up.

  fs/proc/array.c           |    2
  fs/proc/proc_misc.c       |   14
  include/linux/init_task.h |    5
  include/linux/sched.h     |   39 -
  include/linux/scheduler.h |   83 ++
  init/Kconfig              |   37 +
  init/main.c               |   10
  kernel/Makefile           |    3
  kernel/sched.c            | 1313
++++++++--------------------------------------
  kernel/scheduler.c        | 1201
++++++++++++++++++++++++++++++++++++++++++
  mm/oom_kill.c             |    2
  11 files changed, 1599 insertions(+), 1110 deletions(-)

Thanks to William Lee Irwin III for design help, Alex Nyberg for testing
and a bootload of others for ideas and help with the coding.

Cheers,
Con


--------------enigF2F827538C2032923B7D101C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6YEZUg7+tp6mRURAqZtAJ96LPsgvElIaU6zeKwX5W4honxcKgCfaDBf
f78Rx+Fk5tcxu9LUDqiA3lo=
=tR3S
-----END PGP SIGNATURE-----

--------------enigF2F827538C2032923B7D101C--
