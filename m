Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbTIYTMk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 15:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbTIYTMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 15:12:40 -0400
Received: from imr2.ericy.com ([198.24.6.3]:63118 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id S261704AbTIYTMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 15:12:34 -0400
Message-ID: <3F733FD3.60502@ericsson.ca>
Date: Thu, 25 Sep 2003 15:19:47 -0400
From: Makan Pourzandi <Makan.Pourzandi@ericsson.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       Makan Pourzandi <Makan.Pourzandi@ericsson.ca>,
       Axelle Apvrille <Axelle.Apvrille@ericsson.ca>,
       Vincent Roy <vincent.roy@ericsson.ca>,
       David Gordon <davidgordonca@yahoo.ca>, socrate@infoiasi.ro
Subject: [ANNOUNCE] DigSig 0.2: kernel module for digital signature verification
 for binaries 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

DSI development team would like to announce the release 0.2 of digsig.

This kernel module (for 2.5.66 and higher) checks
the signature of the binary before running it.  The main goal is to 
insert digital
signatures inside the ELF binary and verify this signature before
loading the binary. It is based on the Linux Security Module hooks.

The code is GPL and available from: http://sourceforge.net/projects/disec/,
download digsig-0.2.

I hope that it'll be useful to you.
All bug reports and feature requests or general feedback are welcome 
(please CC me in your answer or feedback to the mailing list).

Regards,
Makan Pourzandi


overview
=======

Instead of writing a long detailed explication, I rather give you an 
example of how you can use it.

A Very simple scenraio to show how to use it  
=======================================

1) Generate gpg key and export your public key in order to use it for
 signature verification.
 
$gpg --gen-key

=> careful generate RSA key

$gpg --export >> my_public_key.pub

2) Sign your binaries using Bsign

Before using bsign to sign all your binaries, try out with a simple
example.

$cp `which ps` ps-test
$bsign -s ps-test // sign the binary
$bsign -v ps-test // be sure that the signature is valid  

3) Make the digsig module

 From ./digsig, do make -C /usr/src/linux-2.5.66 SUBDIRS=$PWD modules. 
You need rw acess to /usr/src/linux-2.5.66.

CAREFULL: we advice you to compile the module in debug mode at your
first tries (see -DDSI_DEBUG -DDSI_DIGSIG_DEBUG in the Makefile). In
this mode, the module verifies the signatures but does not enforce the
security (if not any signature present in your binary, you'll have a
message in /var/log/messages but the execution is not
aborted.). However, the execution of the bianaries with invalid
signatures is aborted. Once, you're sure of your binary signature
procedure you can recompile the whole on non-debug mode.

4) load digsig, use the public key exported in step 1 as argument

root@colby digsig-dev]# ./digsig.init start pubkey.pub
Loading Digsig module.
Making device for communication with the module.
Loading public key.
Done.
root@colby digsig-dev]#

5) In debug mode:

$./ps-test

$tail -f /var/log/messages
Sep 16 15:49:16 colby kernel: DSI-LSM MODULE - binary is ./ps-test
Sep 16 15:49:16 colby kernel: DSI-LSM MODULE - dsi_bprm_compute_creds: 
Found signature section
Sep 16 15:49:16 colby kernel: DSI-LSM MODULE - dsi_bprm_compute_creds: 
Signature verification successful

$ps

// no check for not signed binaries
$tail -f /var/log/messages
Sep 16 15:49:16 colby kernel: DSI-LSM MODULE - binary is ./ps


6) In restrictive mode, normal mode

You need to use bsign to sign all binaries that you want to run in
normal mode.

// signed binary
[lmcmpou@reblochon lmcmpou]$ ps
  PID TTY          TIME CMD
 6897 pts/2    00:00:00 bash
 6941 pts/2    00:00:00 ps

// not signed binary
[lmcmpou@reblochon lmcmpou]$ ./ps-makan-1
bash: ./ps-makan: cannot execute binary file

// binary with wrong signature
[lmcmpou@reblochon lmcmpou]$ ./ps-makan-2
bash: ./ps-makan-colby: Operation not permitted

7) Unload the module.

[root@colby digsig-dev]# ./digsig.init stop
Unloading Digsig.

Performances
===============

This is release 0.2. We have done some benchmarks.

We ran lmbench on a Pentium IV, 2.4 GHz, 500 mega bytes of memory,
running Linux 2.5.66. Our benchmarks show that the execution time
(exec function call) multiplies by a factor of 4 when the module is
loaded (no changes for fork call, as the binary is not loaded into
memory).

Some details
==========

The module is independent from DSI (parent project) and you don't need 
to download
the whole dsi tar ball to play with the digsig module (even if we'll be 
more
than happy to have your feedback about dsi project :-)).

Our approach has been to use the existing solutions like gpg and bsign
rather than reinventing the whole thing from scratch.

However, in order to reduce the overhead in the kernel, we took only the
minimum code necessary from GPG. We took only the MPI (Multi Precision
Integer) source code and the RSA crypto source code. This helped much
to reduce the amount of code imported to the kernel in sourc code of
the original (only 1/10 of the original gnupg 1.2.2 sourc code has
been imported to the kernel module). On the other hand, we avoided
OpenSSL source code for the fact that the licensing was not clear to
us. We did some tests at user level and found out that OpenSSL is 4
times faster than GPG regarding RSA verification. As a future
direction, we plan to clarify this licensing issue and use OpenSSL
instead of GPG.

Requirements:
==============

Linux OS kernel 2.5.66 or  higher. We tested against 2.5.66 and 
2.6.0-test5.

Bsign version
0.4.5. (http://packages.debian.org/unstable/admin/bsign.html)

GPG 1.2.2 or higher.

Merits
=====

This work has been done by (alphabetical order)

A Apvrille (axelle.apvrille@ericsson.ca),
D Gordon (davidgordonca@yahoo.ca),  
M Pourzandi (makan.pourzandi@ericsson.ca),
V Roy (vincent.roy@ericsson.ca).

Special merits go to David who wrote big chunks of the source code.

Thanks to Radu Filip (socrate@infoiasi.ro) which has done the initial 
study for this work.

Thanks also to Marc Singer who helped us in using Bsign.

Regards,
Makan Pourzandi
-------------------------------------------------------
Makan Pourzandi,
Ericsson Research Canada      makan.pourzandi@ericsson.ca
This email does not represent or express the opinions of
Ericsson Inc.
-------------------------------------------------------

