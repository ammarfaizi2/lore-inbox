Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUIIQGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUIIQGb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 12:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUIIQGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 12:06:23 -0400
Received: from imr2.ericy.com ([198.24.6.3]:29430 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id S266073AbUIIQEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 12:04:24 -0400
Message-ID: <41407CF6.2020808@ericsson.com>
Date: Thu, 09 Sep 2004 11:55:34 -0400
From: Makan Pourzandi <Makan.Pourzandi@ericsson.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Axelle Apvrille <axelle.apvrille@trusted-logic.fr>, serue@us.ibm.com,
       david.gordon@ericsson.com, gaspoucho@yahoo.com,
       Makan Pourzandi <Makan.Pourzandi@ericsson.com>
Subject: [ANNOUNCE] Release Digsig 1.3.1: kernel module for run-time authentication
 of binaries
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

DSI development team would like to announce the release 1.3.1 of digsig.

This kernel module helps system administrators control Executable and
Linkable Format (ELF) binary execution and library loading based on
the presence of a valid digital signature.  The main functionality is
to help system administrators distinguish applications he/she trusts
(and therefore signs) from viruses, worms (and other nuisances). It is
based on the Linux Security Module hooks.

The code is GPL and available from:
http://sourceforge.net/projects/disec/, download digsig-1.3.1. For
more documentation, please refer to disec.sourcefrge.net.

I hope that it'll be useful to you.

All bug reports and feature requests or general feedback are welcome
(please CC me or disec-devel@lists.sourceforge.net in your answer or
feedback to the mailing list).

Regards,
Makan Pourzandi

Changes from Digsig release 0.2 announced in this mailing list:
================================================================

     - the verification of signatures for the shared binaries has been
     added.
     - added support for caching of signatures
     - added documentation for digsig
     - added support for revoked signatures
     - support to avoid vulnerability for rewrite of shared
     libraries
     - use sysfs to connect to the module instead of the char device
     - code clean up, and some bug fixes

Future works
=============

     - improving the caching and revocation: it is currently tested
       and will be sent out soon after stability testing


overview
=======

Instead of writing a long detailed explication, I rather give you an
example of how you can use it.

A Very simple scenario to show how to use it
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
You need rw access to /usr/src/linux-2.5.66.

CAREFUL: we advice you to compile the module in debug mode at your
first tries (see -DDSI_DEBUG -DDSI_DIGSIG_DEBUG in the Makefile). In
this mode, the module verifies the signatures but does not enforce the
security (if not any signature present in your binary, you'll have a
message in /var/log/messages but the execution is not
aborted.). However, the execution of the binaries with invalid
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

Finally, to provide a better insight into the actual impact of DigSig
on real workloads, three kernel compiles were timed on a non-DigSig
system, and three on a digsig system.  The tests were performed using
a 2.6.7 kernel on a Pentium 4 2.4GHz with 512 MB of RAM.  The kernel
being compiled was a 2.6.4 kernel, and the same .config was used for
each compile.  Each compile was preceded by a ``make clean''.  The
first execution both with and without DigSig appears to reflect extra
time needed to load the kernel source data files from disk.

The results are presented below:
------------------------
Kernel without DigSig   |
------------------------|
real       |    sys     |
19m21.890s |  1m27.992s |
19m9.276s  |  1m26.584s |
19m9.464s  |  1m26.191s |
19m7.717s  |  1m25.799s |
------------------------


Kernel with DigSig
------------------------
real       |    sys     |
19m19.957s | 1m28.541s  |
19m7.485s  | 1m26.832s  |
19m7.883s  | 1m26.549s  |
19m6.494s  | 1m26.618s  |
------------------------


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

A Apvrille  (axelle.apvrille@trusted-logic.fr),
D Gordon    (david.gordon@ericsson.com),
S Hallyn    (serue@us.ibm.com)
M Pourzandi (makan.pourzandi@ericsson.com),
V Roy       (gaspoucho@yahoo.com).

Special Thanks to Greg Kroah-Hartman for his feedback and to Marc Singer 
who helped us with the use of Bsign.

Regards,
Makan Pourzandi
-------------------------------------------------------
Makan Pourzandi, Open Systems Lab
Ericsson Research Canada      makan.pourzandi@ericsson.com
This email does not represent or express the opinions of
Ericsson Inc.
-------------------------------------------------------


