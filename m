Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbUKVJKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbUKVJKw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 04:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUKVJKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 04:10:51 -0500
Received: from artemisa.fzk.de ([141.52.8.53]:63881 "EHLO artemisa.fzk.de")
	by vger.kernel.org with ESMTP id S262003AbUKVJHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 04:07:49 -0500
From: Ariel Garcia <garcia@iwr.fzk.de>
Subject: Strange ssh hang with kernel 2.6.9
Date: Mon, 22 Nov 2004 10:07:44 +0100
User-Agent: KMail/1.7.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1208292.qY7jiXn9y8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411221007.47237.garcia@iwr.fzk.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1208292.qY7jiXn9y8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

after i upgraded to  2.6.9 (from 2.6.8-rc4), I started having a similar
problem to the one somebody else reported on Oct. 27 (thread "SSH and
2.6.9"), namely my ssh client hanging soon after doing some cat to
screen...
Actually, dissabling CONFIG_LEGACY_PTYS, or SOFTWARE_SUSPEND does not
 solve the problem for me.

Also, the problem happens only when i do a ssh to my desktop running also
2.6.9 (or at least only in that case it happens fast enough so i can
trigger it simply by opening the mc or cat'ing something to screen).

Appended is the strace of the client Andrew requested, details follow.

Client is OpenSSH_3.8.1p1 Debian-8.sarge.3, OpenSSL 0.9.7d 17 Mar 2004
on Debian testing/unstable and i have a plain old /dev , no udev or devfs.

Symptoms:

=2D they happen even with a very slow output:
    while true; do
         echo -n "a"
         sleep 1
    done
This went ok for the first ~40 chars, then blocked and printed a block of
~170chars toghether, this happened twice, then it blocked forever after
printing a couple of short 8 char long lines (ie, "aaaaaaaa\n")

=2D If i kill the forked sshd receiving my connection at the desktop, the
client at the laptop stays "blocked" (no reaction to keys, escape commands)=
 =20
and it exists after a while with=20
"Read from remote host <desktop>: Connection reset by peer"

=2D I can also directly kill the ssh client with a plain kill (kill -15),
 and it is not in any strange state, just S+ in ps. However, it does not
 answer to the escape commands (~., ~B, ~*)

=2D Actually, i tested also while running a kernel compile, and with that
load ssh did not hang as fast as without load.

=2D tested from Xwin, (konsole, TERM=3Dxterm) but also from a text console,
TERM=3Dlinux, same results

=2D scp also hangs with  "0%  0.0KB/s stalled"

=2D putting the daemon in debugging mode (ssh -ddd) does not help, i get no
additional debugging output after the connection is made, but in that case
the client responds to ~. after the "hang". If i let it stay "hanged"
however, the daemon sends keepalives, it prints
debug2: channel 0: request keepalive@openssh.com
and the connection stays indefinitely.

=2D I tested several configurations, between the following machines:

laptop:  2.6.9 (with or w/o swsuspend and LEGACY_PTYS, plain /dev),
        Debian, OpenSSH_3.8.1p1
desktop: 2.6.9 (CONFIG_LEGACY_PTYS=3Dy, plain /dev), Debian, OpenSSH_3.8.1p1
H:       2.4.27+skas3 (plain /dev), Debian, OpenSSH_3.8.1p1
U:       2.4.20, RedHat 7.3, OpenSSH_3.1p1

all work ok except the first one:

laptop -> desktop: hangs
laptop -> laptop: OK
laptop -> {H,U} -> desktop -> desktop: OK
laptop -> {H,U} -> desktop -> laptop: OK
desktop -> {H,U}: OK   (day long sessions completely fine)


Debugging output:

=2D I made a "strace -f -o ssh-strace.txt ssh <desktop>"
Immediately after log in i run:
    for i in `seq 1 200` ; do echo -n =3D; done
the client hanged after 171 chars (but this is not always so, once it
hanged before giving me the prompt, other time after much more chars),
then i pressed <enter> once, then i killed the process after a while. You
can see all this in the attached log (ssh-strace1.txt). (remark that the 3
"write(5, "=3D=3D=3D"....) lines near the end of the log add up to exactly =
171
chars)

=2D i also attach strace logs made for both the client and the server at the
same time,
strace -f -r -o sshd-desktop-strace.txt sshd -D -e -p 24
strace -f -r -o ssh-laptop-strace.txt ssh artemisa -p 24
This time i run
  cat /etc/services
to hang the client.

Hope it helps, feel free to request some other test/strace.
[[ Please, CC directly to me in replys, thanks! ]]

Sorry, the attachments make the mail bigger than 100K, or are simply not=20
accepted by majordomo... Please, find the files here:
            http://cvs.fzk.de/~ariel/linux/

Regards, Ariel


PGP Key: http://cvs.fzk.de/~ariel/ag-pubkey.asc

--nextPart1208292.qY7jiXn9y8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBoaxjJTvErkMlPvkRArmnAJ9ZjEMgqLOopz03kyTlWhf0SxXU0QCffRUV
OsLw+a+vIeJYwhfVgOJgoLo=
=+Fg+
-----END PGP SIGNATURE-----

--nextPart1208292.qY7jiXn9y8--
