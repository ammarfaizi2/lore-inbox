Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267447AbUBSR4o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 12:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267458AbUBSR4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 12:56:43 -0500
Received: from [62.116.46.196] ([62.116.46.196]:43015 "EHLO it-loops.com")
	by vger.kernel.org with ESMTP id S267447AbUBSR4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 12:56:21 -0500
Date: Thu, 19 Feb 2004 18:55:18 +0100
From: Michael Guntsche <mike@it-loops.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 Problems with firewire DVD-writer (caused by SCSI change)
Message-Id: <20040219185518.6ba26a65.mike@it-loops.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__19_Feb_2004_18_55_18_+0100_stJ6oey=RT4rM8l2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__19_Feb_2004_18_55_18_+0100_stJ6oey=RT4rM8l2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


> While trying to burn some files to it with growisofs I got the following
> error message
> and the program froze.

> --- syslog ---

> Feb 18 22:20:56 localhost kernel: SCSI error : <0 0 0 0> return code =
> 0x8000002
> Feb 18 22:20:56 localhost kernel: Current sr0: sense = 70  4
> Feb 18 22:20:56 localhost kernel: ASC=1b ASCQ= 0
> Feb 18 22:20:56 localhost kernel: Raw sense data:0x70 0x00 0x04 0x00
> 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x1b 0x00 0x00 0x00 0x00 0x00
> <repeating>

> --- syslog ---

> Trying the same with USB 2.0 worked without a problem.
<snip>

Ok, digging through the sources I found out that the following change causes
the problems I have.

---------------
diff -Nru a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c Fri Feb  6 18:08:14 2004
+++ b/drivers/scsi/scsi_lib.c Fri Feb  6 18:08:14 2004
@@ -1287,6 +1284,15 @@
  blk_queue_max_sectors(q, shost->max_sectors);
  blk_queue_bounce_limit(q, scsi_calculate_bounce_limit(shost));
  blk_queue_segment_boundary(q, shost->dma_boundary);
+ 
+ /*
+  * Set the queue's mask to require a mere 8-byte alignment for
+  * DMA buffers, rather than the default 512.  This shouldn't
+  * inconvenience any user programs and should be okay for most
+  * host adapters.  A host driver can alter this mask in its
+  * slave_alloc() or slave_configure() callback if necessary.
+  */
+ blk_queue_dma_alignment(q, (8 - 1));

  if (!shost->use_clustering)
    clear_bit(QUEUE_FLAG_CLUSTER, &q->queue_flags);
---------------

Commenting out this change made my burner work again.
Can someone tell me why?


/Michael



--Signature=_Thu__19_Feb_2004_18_55_18_+0100_stJ6oey=RT4rM8l2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFANPiI9lrUeNl8Hv8RArIFAKC2g+pf96oy1CB00csDVyEN/xhoGgCdHYTp
82LlL4MGv1+ur0LHs2/wymg=
=zK8B
-----END PGP SIGNATURE-----

--Signature=_Thu__19_Feb_2004_18_55_18_+0100_stJ6oey=RT4rM8l2--
