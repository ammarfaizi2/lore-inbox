Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbSJGFg3>; Mon, 7 Oct 2002 01:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262878AbSJGFg2>; Mon, 7 Oct 2002 01:36:28 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:40111 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S262877AbSJGFgV>; Mon, 7 Oct 2002 01:36:21 -0400
Date: Mon, 7 Oct 2002 00:41:39 -0500
From: Bob McElrath <bob+linux-kernel@mcelrath.org>
To: linux-kernel@vger.kernel.org
Subject: Work queues
Message-ID: <20021007054138.GC5991@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Bob McElrath [bob+linux-kernel@vger.kernel.org] wrote:
> If you give the [nvisr/0] process a negative priority, the stalls go
> away.  I just played through a level of Chromium BSU and it performed
> flawlessly (with the nvisr process at -20 priority).  With the latest bk
> tree there are also no oopses.

So it seems the way to do this is:

    my_workqueue =3D create_workqueue("mywork");
    if (!my_workqueue) {
        printk("Unable to create workqueue\n");
        return -EIO;
    }
    pri.sched_priority =3D 1; /* BM: any nonzero should do, is there any re=
ason=20
                               to chose a larger priority? */
    rc =3D security_ops->task_setscheduler(isr_workqueue->cpu_wq[0]->pid, S=
CHED_FIFO, &pri);
    if(rc < 0) {
        printk("Unable to set real-time priority for NV (err=3D%d)\n", rc);
    }

The above code doesn't work though because the struct workqueue_struct is
hidden away in workqueue.c, invisible to modules.  The line:
    isr_workqueue->cpu_wq[0]->pid
bombs because the struct is not defined (dereferencing pointer to incomplete
type).  Is there a better way to get the pid of a workqueue I just created?=
  Or
for that matter is there a better way to set the scheduler for a workqueue I
just created?  I imagine many drivers would want to do this...

I notice the sched_setscheduler system call is not available in any kernel
header.  What is the proper procedure for calling such a function from a
module?

Cheers,
-- Bob

Bob McElrath
Univ. of Wisconsin at Madison, Department of Physics

    "The purpose of separation of church and state is to keep forever from
    these shores the ceaseless strife that has soaked the soil of Europe in
    blood for centuries." -- James Madison

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEUEARECAAYFAj2hHpIACgkQjwioWRGe9K2joQCXT/oKum6oTCQnOXyk1vdS5egq
WACg1H5Zafn0P/p7wA/aXqkfb8zvZ0Y=
=g8L+
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
