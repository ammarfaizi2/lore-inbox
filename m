Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVCCLxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVCCLxS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVCCLuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:50:21 -0500
Received: from dea.vocord.ru ([217.67.177.50]:54994 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261632AbVCCLqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 06:46:24 -0500
Subject: Re: [PATCH 2.6.11-rc4-mm1] connector: Add a fork connector
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Jay Lan <jlan@engr.sgi.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Erich Focht <efocht@hpce.nec.com>, Netlink List <netdev@oss.sgi.com>
In-Reply-To: <20050303084656.A15197@2ka.mipt.ru>
References: <1109240677.1738.196.camel@frecb000711.frec.bull.fr>
	 <1109753292.8422.117.camel@frecb000711.frec.bull.fr>
	 <42268201.80706@ak.jp.nec.com>  <20050303084656.A15197@2ka.mipt.ru>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Y2avb3PiOApOFwKGRSS9"
Organization: MIPT
Date: Thu, 03 Mar 2005 14:51:29 +0300
Message-Id: <1109850689.28266.144.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Thu, 03 Mar 2005 14:45:09 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Y2avb3PiOApOFwKGRSS9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Simple program to test fork() performance.
#include <sys/signal.h>
#include <sys/time.h>

int main(int argc, char *argv[])
{
        int pid;
        int i =3D 0, max =3D 100000;
        struct timeval tv0, tv1;
        struct timezone tz;
        long diff;

        if (argc >=3D 2)
                max =3D atoi(argv[1]);

        signal(SIGCHLD, SIG_IGN);

        gettimeofday(&tv0, &tz);
        while (i++ < max) {
                pid =3D fork();
                if (pid =3D=3D 0) {
                        sleep(1);
                        exit (0);
                }
        }
        gettimeofday(&tv1, &tz);

        diff =3D (tv1.tv_sec - tv0.tv_sec)*1000000 + (tv1.tv_usec - tv0.tv_=
usec);

        printf("Average per process fork+exit time is %ld usecs [diff=3D%lu=
, max=3D%d].\n", diff/max, diff, max);
        return 0;
}

Creating 10k forks 100 times.
Results on 2-way SMP(1+1HT) Xeon for one fork()+exit():

2.6.11-rc4-mm1                                   494 usec
2.6.11-rc4-mm1-fork-connector-no_userspace       509 usec
2.6.11-rc4-mm1-fork-connector-userspace          520 usec

5% fork() degradation(connector with userspace vs. vanilla) with fork() con=
nector.
On my test system global fork lock does not cost anything
(tested both with and without userspace listener), but it is only 2-way(pse=
udo).

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-Y2avb3PiOApOFwKGRSS9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCJvpBIKTPhE+8wY0RAj0zAKCJ/A7aoAESI9UixrOG10zAsbYuXgCgj/4B
aDKR9Xur0lNOTjFTzLD+OOg=
=oHmK
-----END PGP SIGNATURE-----

--=-Y2avb3PiOApOFwKGRSS9--

