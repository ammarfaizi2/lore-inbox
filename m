Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbUCOSw0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 13:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbUCOSwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 13:52:25 -0500
Received: from mout0.freenet.de ([194.97.50.131]:37904 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S262678AbUCOSwU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 13:52:20 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: sys_swapoff() symlink bug
Date: Mon, 15 Mar 2004 19:52:05 +0100
User-Agent: KMail/1.6.50
Cc: andrea@e-mind.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403151952.17430.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

The following script demonstrates a bug in the swapon/swapoff
syscalls in the latest 2.6 kernel (I did not check 2.4).

#/bin/sh
# 3:12 is hda12, which is a swap partition on my system.
SWAP_MAJOR=3
SWAP_MINOR=12
echo "running swaps:"
cat /proc/swaps
echo "--"
mkdir /testdev
mknod /testdev/testnode b $SWAP_MAJOR $SWAP_MINOR
ln -s /testdev/testnode /testdev/testlink
swapon /testdev/testlink
echo "swapon returned $?"
echo "running swaps:"
cat /proc/swaps
echo "--"
swapoff /testdev/testdev
echo "swapoff returned $?"
echo "running swaps:"
cat /proc/swaps
echo "--"
rm -Rf /testdev


The output of this script on my system is:

running swaps:
- --
swapon returned 0
running swaps:
Filename                                Type            Size    Used    Priority
/testdev/testnode                        partition      976712  0       -32
- --
swapoff returned 255
running swaps:
Filename                                Type            Size    Used    Priority
/testdev/testnode                        partition      976712  0       -32
- --


As you can see the swapoff fails, because it is called on
the node instead of the symlink that was used for swapon.
I think this should not fail.

The code that fails to detect, that the symlink _is_ actually
the same swapspace as the node itself, is mm/swapfile.c:1038

	for (type = swap_list.head; type >= 0; type = swap_info[type].next) {
		p = swap_info + type;
		if ((p->flags & SWP_ACTIVE) == SWP_ACTIVE) {

/* I'm not really sure about what we should check here, instead
 * of f_mapping to detect it.
 */
			if (p->swap_file->f_mapping == mapping)
				break;
		}
		prev = type;
	}

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAVftgFGK1OIvVOP4RAqMeAKCa8YNIziH6/HCYLjTxg98MBzUE+wCgv6pw
qUptbBGt+jCXeDdJpQk71l4=
=+JkD
-----END PGP SIGNATURE-----
