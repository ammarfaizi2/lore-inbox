Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbTJAMkb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 08:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbTJAMkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 08:40:31 -0400
Received: from scanmail1.cableone.net ([24.116.0.121]:38916 "EHLO
	scanmail1.cableone.net") by vger.kernel.org with ESMTP
	id S262055AbTJAMk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 08:40:28 -0400
Subject: File Permissions are incorrect. Security flaw in Linux
From: "Lisa R. Nelson" <lisanels@cableone.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eUJ3Nbpl7Vq1lUrEUBiE"
Organization: 
Message-Id: <1065012013.4078.2.camel@lisaserver>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Oct 2003 06:40:13 -0600
X-SMTP-HELO: 24-117-5-213.cpe.cableone.net
X-SMTP-MAIL-FROM: lisanels@cableone.net
X-SMTP-PEER-INFO: 24-117-5-213.cpe.cableone.net [24.117.5.213]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eUJ3Nbpl7Vq1lUrEUBiE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

[1.] One line summary of the problem:   =20
A low level user can delete a file owned by root and belonging to group
root even if the files permissions are 744.  This is not in agreement
with Unix, and is a major security issue.

[2.] Full description of the problem/report:=20
    Permissions on a file basis take precedence over directory
permissions (for most cases), but in Linux they do not.  In order to
secure a file, you have to secure the directory which effects all files
within it. =20
    As user 'lisa', I do all my work on my server.  One task is to move
pictures from my digital camera to my server picture directory that is
wide open to everyone.  All users can create sub-folders and put
pictures in there.  But every hour I have a cron job run that changes
the ownership to root, and sets the permissions to 644 on all files in
that directory structure.  Thinking the files could no longer be altered
by anyone but root (as would be the case in unix), and found anyone
could delete them.  That's when I discovered this major bug.
    I verified this on a sun station today, by simply creating a file in
a wide open directory with 444 permissions and was then able to delete
it after the "Ok to delete write-protected file(y/n), but could NOT
delete a similar file with the same permissions owned by root...  As it
should be...
Try this:

[lisa@localhost lisa]$ su - root
Password:
[root@localhost root]# cd /
[root@localhost /]# mkdir junk
[root@localhost /]# chmod 777 junk
[root@localhost /]# ls -l
total 225
...
drwxrwxrwx    2 root     root         4096 Sep 29 07:30 junk
...
[root@localhost /]#
[root@localhost /]# cd junk
[root@localhost junk]# ls .. > rootfile
[root@localhost junk]# ls -l
total 4
-rw-r--r--    1 root     root           95 Sep 29 07:31 rootfile
[root@localhost junk]# cp rootfile rootfile2
[root@localhost junk]# cp rootfile rootfile3
[root@localhost junk]# ls -l
total 12
-rw-r--r--    1 root     root           95 Sep 29 07:31 rootfile
-rw-r--r--    1 root     root           95 Sep 29 07:32 rootfile2
-rw-r--r--    1 root     root           95 Sep 29 07:32 rootfile3
[root@localhost junk]# chmod 444 rootfile2
[root@localhost junk]# chmod 000 rootfile3
[root@localhost junk]# ls -l
total 12
-rw-r--r--    1 root     root           95 Sep 29 07:31 rootfile
-r--r--r--    1 root     root           95 Sep 29 07:32 rootfile2
--    1 root     root           95 Sep 29 07:32 rootfile3
[root@localhost junk]#exit
[lisa@localhost lisa]$ cd /junk
[lisa@localhost junk]$ ls -l
total 12
-rw-r--r--    1 root     root           95 Sep 29 07:31 rootfile
-r--r--r--    1 root     root           95 Sep 29 07:32 rootfile2
--    1 root     root           95 Sep 29 07:32 rootfile3
[lisa@localhost junk]$
[lisa@localhost junk]$ rm root*
rm: remove write-protected regular file `rootfile'? y
rm: remove write-protected regular file `rootfile2'? y
rm: remove write-protected regular file `rootfile3'? y
[lisa@localhost junk]$ ls -l
total 0
[lisa@localhost junk]$
Notice that all three files that 'lisa' does not have write permissions
to are gone! =20


[3.] Keywords (i.e., modules, networking, kernel):
kernel file permissions security

[4.] Kernel version (from /proc/version):=20
[root@localhost proc]# cat version
Linux version 2.4.20-20.9 (root@rwbp4) (gcc version 3.2.2 20030222 (Red
Hat Linux 3.2.2-5)) #1 Wed Aug 20 17:41:55 EDT 2003
[root@localhost proc]#

[5.] Output of Oops.. message
None=20
[6.] A small shell script or example
See Above

http://www.auburn.edu/oit/software/os/unix_files.html
http://www.dartmouth.edu/~rc/help/faq/permissions.html
http://www.december.com/unix/tutor/permissions.html
http://www.itc.virginia.edu/desktop/web/permissions/



--=-eUJ3Nbpl7Vq1lUrEUBiE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/esst1/1mqQZ8DYsRAqmSAJ9psuNfH1TYwDL8CQFSEPM9s8nMVACgyh6y
dE8bZViGLrs835TSzpsgd60=
=GRTy
-----END PGP SIGNATURE-----

--=-eUJ3Nbpl7Vq1lUrEUBiE--

