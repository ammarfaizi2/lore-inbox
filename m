Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262876AbSJGFdl>; Mon, 7 Oct 2002 01:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbSJGFdl>; Mon, 7 Oct 2002 01:33:41 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:39087 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S262876AbSJGFdi>; Mon, 7 Oct 2002 01:33:38 -0400
Date: Mon, 7 Oct 2002 00:38:53 -0500
From: Bob McElrath <mcelrath@draal.physics.wisc.edu>
To: Bob McElrath <bob+linux-kernel@vger.kernel.org>
Cc: Chris Wedgwood <cw@f00f.org>, Roberto Nibali <ratz@drugphish.ch>,
       linux-kernel@vger.kernel.org
Subject: Work queues
Message-ID: <20021007053853.GB5991@draal.physics.wisc.edu>
References: <20021006185412.GA3140@draal.physics.wisc.edu> <3DA0958A.9050809@drugphish.ch> <20021006203142.GD10884@draal.physics.wisc.edu> <20021006090255.GA13253@tapu.f00f.org> <20021006185412.GA3140@draal.physics.wisc.edu> <3DA0958A.9050809@drugphish.ch> <20021006090255.GA13253@tapu.f00f.org> <20021006185412.GA3140@draal.physics.wisc.edu> <20021006212215.GA17790@tapu.f00f.org> <20021007031855.GA5991@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <20021007031855.GA5991@draal.physics.wisc.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OaZoDhBhXzo6bW1J
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


--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2hHe0ACgkQjwioWRGe9K3VYACg7s8TeahQsBHGCWGWDhqhe6b9
Gx0An3uTN7YuUfri5CMcQPI3DEtaTtRd
=VUKb
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
