Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVANE60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVANE60 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 23:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVANE6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 23:58:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63943 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261910AbVANE5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 23:57:31 -0500
Message-ID: <41E7509E.4030802@redhat.com>
Date: Thu, 13 Jan 2005 20:54:54 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: short read from /dev/urandom
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF7E5E94D398A6E70B65D6C7B"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF7E5E94D398A6E70B65D6C7B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

The /dev/urandom device is advertised as always returning the requested 
number of bytes.  Yet, it fails to do this under some situations. 
Compile this

int main (void)
{
   alarm (100);
   char buf[32];
   int fd = open ("/dev/urandom", 0);
   while (1)
     if (read (fd, buf, sizeof buf) != sizeof (buf))
       abort ();
}

with

   gcc -o r r.c -g -O2 -pg


Note the -pg at the end to enable profiling.  Running this code fails 
for me after less than a second.

The relevant code in the kernel is this 
(drivers/char/random.c:extract_entropy)

         while (nbytes) {
                 /*
                  * Check if we need to break out or reschedule....
                  */
                 if ((flags & EXTRACT_ENTROPY_USER) && need_resched()) {
                         if (signal_pending(current)) {
                                 if (ret == 0)
                                         ret = -ERESTARTSYS;
                                 break;
                         }


Here the loop is left prematurely if a signal is pending.

One solution is to redefine the /dev/urandom interface.  The problem is 
that this will cause program to fail.  I know since I found this while 
debugging such a program.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖

--------------enigF7E5E94D398A6E70B65D6C7B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFB51Ce2ijCOnn/RHQRAuZ2AJsFGJHItPGM/LaOsSRZLJgWrUDp5wCfY5bw
rHu2V5NIhouXoXdmtW/bS04=
=xStf
-----END PGP SIGNATURE-----

--------------enigF7E5E94D398A6E70B65D6C7B--
