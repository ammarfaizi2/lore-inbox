Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbSLLSzb>; Thu, 12 Dec 2002 13:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbSLLSzb>; Thu, 12 Dec 2002 13:55:31 -0500
Received: from server.s8.com ([66.77.12.139]:2566 "EHLO server.s8.com")
	by vger.kernel.org with ESMTP id <S264954AbSLLSz3>;
	Thu, 12 Dec 2002 13:55:29 -0500
Subject: Re: using 2 TB  in real life
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Anders Henke <anders.henke@sysiphus.de>
Cc: linux-kernel@vger.kernel.org, peter@chubb.wattle.id.au
In-Reply-To: <20021212174814.GA18993@schlund.de>
References: <20021212111237.GA12143@schlund.de>
	 <029301c2a1d6$85cbe280$f6de11cc@black>
	 <1039713776.16887.4.camel@camp4.serpentine.com>
	 <20021212174814.GA18993@schlund.de>
Content-Type: multipart/mixed; boundary="=-MugFC05+w/3k90BOpPbC"
Organization: 
Message-Id: <1039719790.11897.9.camel@plokta.s8.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 12 Dec 2002 11:03:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MugFC05+w/3k90BOpPbC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2002-12-12 at 09:48, Anders Henke wrote:

> Peter's patch is not necessary for a 1.9TB device, but (from a quick
> glance at the source) should fix the display problem I mentioned.

No, my point was precisely that Peter's patch changes the display
problem into a different display problem.  It will report a 1.9TB
filesystem as a 300MB filesystem, because some of the bit-shuffling is
wrong.

I've attached a patch which illustrates a fix to the SCSI device size
reporting problem in Peter's 2TB patch (the fix was found by HJ Lu).  It
probably won't apply cleanly due to version drift (and of course it
definitely won't apply to a stock kernel), but it indicates what's
wrong.

	<b



--=-MugFC05+w/3k90BOpPbC
Content-Description: 
Content-Disposition: attachment; filename=2tb-scsi.patch
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linux-pchubb/drivers/scsi/sd.c	Thu Dec 12 10:58:29 2002
+++ linux/drivers/scsi/sd.c	Thu Dec 12 10:58:29 2002
@@ -1002,8 +1002,8 @@
 			 */
 			int m;
 			unsigned hard_sector = sector_size;
-			sector_t sz = rscsi_disks[i].capacity * (hard_sector/256);
-			sector_t mb = sz >>= 1;
+			sector_t sz = ((sector_t) rscsi_disks[i].capacity) * ((sector_t) (hard_sector/256));
+			sector_t mb = sz >> 1;
 			sector_div(sz, 1250);
 			mb -= sz - 974;
 			
@@ -1015,9 +1015,9 @@
 			}
 
 			printk("SCSI device %s: "
-			       "%u %u-byte hdwr sectors (%u MB)\n",
+			       "%u %u-byte hdwr sectors (%llu MB)\n",
 			       nbuff, rscsi_disks[i].capacity,
-			       hard_sector, sz);
+			       hard_sector, mb);
 		}
 
 		/* Rescale capacity to 512-byte units */

--=-MugFC05+w/3k90BOpPbC--

