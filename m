Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbVL0X1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVL0X1S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 18:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbVL0X1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 18:27:18 -0500
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:456 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932386AbVL0X1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 18:27:17 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Paolo Ornati <ornati@fastwebnet.it>
Subject: Re: [SCHED] Totally WRONG prority calculation with specific test-case (since 2.6.10-bk12)
Date: Wed, 28 Dec 2005 10:26:58 +1100
User-Agent: KMail/1.9
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
References: <20051227190918.65c2abac@localhost> <20051227224846.6edcff88@localhost>
In-Reply-To: <20051227224846.6edcff88@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1236337.oQmFIiGLjW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512281027.00252.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1236337.oQmFIiGLjW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 28 December 2005 08:48, Paolo Ornati wrote:
> On Tue, 27 Dec 2005 19:09:18 +0100
>
> Paolo Ornati <ornati@fastwebnet.it> wrote:
> > Hello,
> >
> > I've found an easy-to-reproduce-for-me test case that shows a totally
> > wrong priority calculation: basically a CPU-intensitive process gets
> > better priority than a disk-intensitive one (dd if=3Dbigfile
> > of=3D/dev/null ...).
> >
> > Seems impossible, isn't it?
> >
> > ---- THE NUMBERS with 2.6.15-rc7 -----
> >
> > The test-case is the Xvid encoding of dvd-ripped track with transcode
> > (using "dvd::rip" interface). The copied-and-pasted command line is
> > this:
> >
> > mkdir -m 0775 -p '/home/paolo/tmp/test/tmp' &&
> > cd /home/paolo/tmp/test/tmp && dr_exec transcode -H 10 -a 2 -x vob,null
> > -i /home/paolo/tmp/test/vob/003 -w 1198,50 -b 128,0,0 -s 1.972
> > --a52_drc_off -f 25 -Y 52,8,52,8 -B 27,10,8 -R 1 -y xvid4,null
> > -o /dev/null --print_status 20 && echo DVDRIP_SUCCESS mkdir -m 0775 -p
> > '/home/paolo/tmp/test/tmp' && cd /home/paolo/tmp/test/tmp && dr_exec
> > transcode -H 10 -a 2 -x vob -i /home/paolo/tmp/test/vob/003 -w 1198,50
> > -b 128,0,0 -s 1.972 --a52_drc_off -f 25 -Y 52,8,52,8 -B 27,10,8 -R 2 -y
> > xvid4 -o /home/paolo/tmp/test/avi/003/test-003.avi --print_status 20 &&
> > echo DVDRIP_SUCCESS
> >
> >
> > Here there is a TOP snapshot while running it:
> >
> >   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
> >  5721 paolo     16   0  115m  18m 2428 R 84.4  3.7   0:15.11 transcode
> >  5736 paolo     25   0 50352 4516 1912 R  8.4  0.9   0:01.53 tcdecode
> >  5725 paolo     15   0  115m  18m 2428 S  4.6  3.7   0:00.84 transcode
> >  5738 paolo     18   0  115m  18m 2428 S  0.8  3.7   0:00.15 transcode
> >  5734 paolo     25   0 20356 1140  920 S  0.6  0.2   0:00.12 tcdemux
> >  5731 paolo     25   0 47312 2540 1996 R  0.4  0.5   0:00.08 tcdecode
> >  5319 root      15   0  166m  16m 2584 S  0.2  3.2   0:25.06 X
> >  5444 paolo     16   0 87116  22m  15m R  0.2  4.6   0:04.05 konsole
> >  5716 paolo     16   0 10424 1160  876 R  0.2  0.2   0:00.06 top
> >  5735 paolo     25   0 22364 1436  932 S  0.2  0.3   0:00.01 tcextract
> >
> >
> > DD running alone:
> >
> > paolo@tux /mnt $ mount space/; time dd if=3Dspace/bigfile of=3D/dev/null
> > bs=3D1M count=3D128; umount space/ 128+0 records in
> > 128+0 records out
> >
> > real    0m4.052s
> > user    0m0.000s
> > sys     0m0.209s
> >
> > DD while transcoding:
> >
> > paolo@tux /mnt $ mount space/; time dd if=3Dspace/bigfile of=3D/dev/null
> > bs=3D1M count=3D128; umount space/ 128+0 records in
> > 128+0 records out
> >
> > real    0m26.121s
> > user    0m0.001s
> > sys     0m0.255s

Looking at your top output I see that transcode command generates 7 process=
es=20
all likely to be using cpu, and your DD slowdown is almost 7 times... I=20
assume it all goes away if you nice the transcode up by 3 or more.

> Hello Con and Ingo... I've found that the above problem goes away
> by reverting this:
>
> http://linux.bkbits.net:8080/linux-2.6/cset@41e054c6pwNQXzErMxvfh4IpLPXA5=
A?
>nav=3Dindex.html|src/|src/include|src/include/linux|related/include/linux/=
sche
>d.h
>
> --------------------------------------------------
>
> [PATCH] sched: remove_interactive_credit

The issue is that the scheduler interactivity estimator is a state machine =
and=20
can be fooled to some degree, and a cpu intensive task that just happens to=
=20
sleep a little bit gets significantly better priority than one that is full=
y=20
cpu bound all the time. Reverting that change is not a solution because it=
=20
can still be fooled by the same process sleeping lots for a few seconds or =
so=20
at startup and then changing to the cpu mostly-sleeping slightly behaviour.=
=20
This "fluctuating" behaviour is in my opinion worse which is why I removed=
=20
it.

Cheers,
Con

--nextPart1236337.oQmFIiGLjW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDsc3EZUg7+tp6mRURAvQMAJ0SdwcPPF6JhsYbO9GB0sNWntq9pwCfVnNS
TsCZe5wyyD3q5VNhQ0+uyQQ=
=gy+0
-----END PGP SIGNATURE-----

--nextPart1236337.oQmFIiGLjW--
