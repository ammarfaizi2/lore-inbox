Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272632AbRIPRnZ>; Sun, 16 Sep 2001 13:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272636AbRIPRnQ>; Sun, 16 Sep 2001 13:43:16 -0400
Received: from cr954407-a.ym1.on.wave.home.com ([24.43.79.205]:63749 "EHLO
	home.igolnik.com") by vger.kernel.org with ESMTP id <S272632AbRIPRnJ>;
	Sun, 16 Sep 2001 13:43:09 -0400
Date: Sun, 16 Sep 2001 13:42:52 -0400 (EDT)
From: Leonid Igolnik <lim@igolnik.com>
To: <linux-kernel@vger.kernel.org>
Subject: semadj overflow in ipc/sem.c
Message-ID: <Pine.LNX.4.33.0109161324510.10058-200000@home.igolnik.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1634371218-1000662172=:10058"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1634371218-1000662172=:10058
Content-Type: TEXT/PLAIN; charset=US-ASCII

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Short description of the problem: incorrect use of SEM_UNDO flag for
semaphore operations and overflow of the semadj value causes the process
to leave semaphore locked after it exits.

Longer version:
	while working on the project at work I've came across the bug that
would only manifest itself after the application run for long period of
time. The problem was narrowed down to a semaphore handling that was used
to synchronize access to shared memory region, and for some reason the
semaphore would be left locked after one of the processes exits. I've
found out that the code in question was setting SEM_UNDO flag for lock
operations and was not setting it for unlocks. At first it seemed normal,
but I've noticed that problem manifests itself after large number of
operations on the semaphore.

	It appears that the problem is caused by semajd overflow in
following code in sem.c :
Line 258:
               if (sop->sem_flg & SEM_UNDO)
                        un->semadj[sop->sem_num] -= sem_op;

semajd is not checked for overflows, and since only lock operations are
counted it overflows after 32768 operations. Than when processes if killed
or exits, semadj is applied to the current value of the semaphore at line
1028:
                        sem->semval += u->semadj[i];
                        if (sem->semval < 0)
                                sem->semval = 0; /* shouldn't happen */
                        sem->sempid = current->pid;

At this stage semval is 32767 since which is the value of the semadj after
it overflows.

AFAIK SYSV will not let the application to overflow semadj, but I don't
have a Solaris box handy.

See attached example that demonstrates the problem, after it exits
semaphore is left locked (which can be verified by running it again and
watching it waiting for the sem to become free).



- ----

Leonid Igolnik.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7pOSeRrKFtN3cJpMRAk6ZAJwIq2cqbdT6xc//IGz8kljsS5LHMgCgnfpd
nZaAW4KIcFTnnOPPWyhdnFU=
=wm6F
-----END PGP SIGNATURE-----

--8323328-1634371218-1000662172=:10058
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="semadj.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0109161342520.10058@home.igolnik.com>
Content-Description: 
Content-Disposition: attachment; filename="semadj.c"

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3RkbGliLmg+DQojaW5j
bHVkZSA8c3lzL3R5cGVzLmg+DQojaW5jbHVkZSA8c3lzL2lwYy5oPg0KI2lu
Y2x1ZGUgPHN5cy9zZW0uaD4NCg0KaW50IG1haW4oaW50IGFyZ2MsIGNoYXIg
KmFyZ3ZbXSkgew0KICAgIGludCBzZW1faWQsIGk7DQogICAgc3RydWN0IHNl
bWJ1ZiBvcF9vblsyXTsNCiAgICBzdHJ1Y3Qgc2VtYnVmIG9wX29mZjsNCg0K
ICAgIHNlbV9pZCA9IHNlbWdldCgxMjMsIDEsIElQQ19DUkVBVCB8IDA2MDAp
Ow0KICAgIGlmIChzZW1faWQgPCAwKSB7DQoJcGVycm9yKCJzZW1nZXQiKTsN
CglleGl0KC0xKTsNCiAgICB9DQoNCiAgICBvcF9vblswXS5zZW1fbnVtID0g
MDsNCiAgICBvcF9vblswXS5zZW1fb3AgPSAwOw0KICAgIG9wX29uWzBdLnNl
bV9mbGcgPSAwOw0KICAgIG9wX29uWzFdLnNlbV9udW0gPSAwOw0KICAgIG9w
X29uWzFdLnNlbV9vcCA9IDE7DQogICAgb3Bfb25bMV0uc2VtX2ZsZyA9IFNF
TV9VTkRPOw0KDQogICAgb3Bfb2ZmLnNlbV9udW0gPSAwOw0KICAgIG9wX29m
Zi5zZW1fb3AgPSAtMTsNCiAgICBvcF9vZmYuc2VtX2ZsZyA9IDA7DQoNCiAg
ICBmb3IgKGkgPSAwOyBpIDwgMzI3Njk7IGkrKykgew0KCWlmIChzZW1vcChz
ZW1faWQsIG9wX29uLCAyKSA8IDApIHsNCgkgICAgcGVycm9yKCJzZW1vcCIp
Ow0KCX0NCg0KCWlmIChzZW1vcChzZW1faWQsICZvcF9vZmYsIDEpIDwgMCkg
ew0KCSAgICBwZXJyb3IoInNlbW9wIik7DQoJfQ0KICAgIH0NCg0KICAgIHJl
dHVybiAwOw0KfQ0K
--8323328-1634371218-1000662172=:10058--
