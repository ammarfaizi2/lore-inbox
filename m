Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264598AbUBRMO1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 07:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbUBRMO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 07:14:27 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:45454 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264598AbUBRMOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 07:14:24 -0500
Date: Wed, 18 Feb 2004 13:14:16 +0100
From: bert hubert <ahu@ds9a.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, christophe@saout.de
Subject: dmcrypt works well on 2.6.3 WAS: Re: 2.6.3-mm1
Message-ID: <20040218121416.GA13364@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	christophe@saout.de
References: <20040217232130.61667965.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217232130.61667965.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   People need to test and use this please.  There is documentation at
>   http://www.saout.de/misc/dm-crypt/.

Works amazingly well. Starting from stock 2.6.3 I applied 'dm*' from the
broken out 2.6.3-mm1, no fuzz or offset, and ran make on the kernel I had
built this morning.

I then turned on the device mapper and its crypto support and loaded the
modules, without rebooting.

Downloaded ftp://ftp.sistina.com/pub/LVM2/device-mapper/device-mapper-latest.tgz
	./configure && make && sudo make install
	sudo ./scripts/devmap_mknod.sh (to create /dev/mapper)
Downloaded http://www.stwing.org/~sluskyb/util-linux/hashalot-0.2.0.tar.gz
	./configure && make && sudo make install	
Downloaded http://www.saout.de/misc/cryptsetup
	ran: cryptsetup -h plain create crypted /dev/hdb1
  		(the -h plain isn't necessary, I didn't have hashalot
		 earlier, and even with -h plain it wants hashalot)
		entered a passphrase (already forgotten though)
	e2fsck /dev/mapper/crypted
	mount /dev/mapper/crypted /mnt

mke2fs proved to be a significant CPU load (all sy) and took a minute or two
to run, which could be forgiven, it had to mke2fs 200G.

I then copied the entire Linux build tree to /mnt, ran make clean, make, and
12 minutes later I had a new kernel. System load was below <10% at all
times, mostly <5%.

Then I did the whole thing again but then with ext3, which worked too. System
load appeared slightly higher, the build however took 12 minutes as well.

Kudos!

Suggestions 
-----------
1) Add a reference to the hashalot location to
   http://www.saout.de/misc/dm-crypt/ and add some units to 'cryptsetup',
   something like this (probably tab/space damaged):

--- cryptsetup  2003-12-26 21:27:08.000000000 +0100
+++ cryptsetup.ahu      2004-02-18 12:46:18.000000000 +0100
@@ -229,10 +229,10 @@
                gettable "$NAME"
                echo "$DMPATH$NAME is active:"
                echo "  cipher:  $CIPHER"
-               echo "  keysize: $[${#KEY}/2]"
+               echo "  keysize: $[${#KEY}/2] bytes"
                echo "  device:  $DEVICE"
                echo "  offset:  $SKIPPED"
-               echo "  size:    $SIZE"
+               echo "  size:    $SIZE sectors"
                [ $SKIPPED -gt 0 ] && echo "   skipped: $SKIPPED"
                unset KEY
        else

  The output can be mighty confusing otherwise.

2) Remove dependence on hashalot for -h plain
3) Add pointer to hashalot on the main page
4) make make install of the device mapper userspace run the mknod script

>   filesystems.  ie: ext3 on cryptoloop will no longer be crash-proof.
(...)
>   After that we should remove cryptoloop altogether.

Big fat warnings might be wise in the meantime. I sincerely hope that 
dm-crypt can be merged sooner rather than later. It feels good and it Just
Works.

Thanks!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
