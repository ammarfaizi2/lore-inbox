Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263308AbUKAXbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263308AbUKAXbm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S382009AbUKAXbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:31:20 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:38030 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S288847AbUKAWwl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 17:52:41 -0500
Message-ID: <4186BE21.8050000@free.fr>
Date: Mon, 01 Nov 2004 23:52:17 +0100
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040804
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-mm1: LVM stopped working
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC1DE3449AB4A69A7B5EE3606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC1DE3449AB4A69A7B5EE3606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hello,

Lvm2 stopped working since 2.6.9-mm1 for me too : 2.6.9-rc4-mm1 was 
fine, 2.6.9-mm1 to 2.6.10-mm2 break lvm2. Reverting 
dio-handle-eof.patch on these kernel solves the problem.

I have a simple test case here.

With 2.6.9-rc4-mm1, "pvdisplay /dev/hda4" shows :
 --- Physical volume ---
 PV Name               /dev/hda4
 VG Name               vglinux1
 PV Size               19,07 GB / not usable 0
 Allocatable           yes
 PE Size (KByte)       4096
 Total PE              4882
 Free PE               3424
 Allocated PE          1458
 PV UUID               Kvi5oA-d8NL-DU0n-vJpt-TKb3-RmDP-nrZoaz

With later -mm kernel, "pvdisplay /dev/hda4" shows :
 No physical volume label read from /dev/hda4
 Failed to read physical volume "/dev/hda4"

I tracked down the problem to this code section in fs/direct-io.c (function direct_io_worker) :

  1012                 dio->total_pages = 0;
  1013                 if (user_addr & (PAGE_SIZE-1)) {
  1014                         dio->total_pages++;
  1015                         bytes -= PAGE_SIZE - (user_addr & (PAGE_SIZE - 1));
  1016                 }
  1017                 dio->total_pages += (bytes + PAGE_SIZE - 1) / PAGE_SIZE;
  1018                 dio->curr_user_address = user_addr;
  1019
  1020                 ret = do_direct_IO(dio);
  1021
  1022                 dio->result += bytes -
  1023                         ((dio->final_block_in_request - dio->block_in_file) <<
  1024                                         blkbits);

In my case, direct_io_worker is called to read 2048 bytes at the beginning of /dev/hda4 :
 user_addr=0xbfff9800 (half page aligned)
 bytes=2048 (half page)
So "bytes" is zeroed line 1015.
And dio->result is zeroed line 1023.
As a result, direct_io_worker returns 0.

Before dio-handle-eof.patch, line 1022 was :
	dio->result += iov[seg].iov_len -

What is the semantic of "bytes" line 1015 : bytes to read on the next page ?
Did I miss something ?

hope this helps... 
I will do some tests if needed.

-- 
laurent



--------------enigC1DE3449AB4A69A7B5EE3606
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBhr4sUqUFrirTu6IRAp8QAJ9ghZvzKkhdb8Q34z+vX8azfdj/OACgrtxC
dq2POmeBIVDca7cTVEGdKDA=
=ILOQ
-----END PGP SIGNATURE-----

--------------enigC1DE3449AB4A69A7B5EE3606--
