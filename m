Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268083AbUHZKWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268083AbUHZKWz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 06:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268049AbUHZKUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 06:20:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:50653 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268085AbUHZKQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 06:16:03 -0400
Date: Thu, 26 Aug 2004 03:14:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Polyakov <appro@fy.chalmers.se>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, samuel.thibault@ens-lyon.org
Subject: Re: 2.6.9-rcX cdrom.c is subject to "chaotic" behaviour
Message-Id: <20040826031414.56052871.akpm@osdl.org>
In-Reply-To: <412C65D6.4050105@fy.chalmers.se>
References: <412C65D6.4050105@fy.chalmers.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Polyakov <appro@fy.chalmers.se> wrote:
>
> As per 
> http://marc.theaimsgroup.com/?l=bk-commits-head&m=109330228416908&w=2, 
> cdrom.c becomes subject to chaotic behavior. The culprit is newly 
> introduced if-statement such as following:
> 
> if (cdrom_get_disc_info(cdi, &di) < offsetof(typeof(di),disc_type))
> 
> The catch is that cdrom_get_disc_info returns signed value, most notably 
> negative one upon error, while the offsetof on the other hand is 
> unsigned. When signed and unsigned values are compared, signed one is 
> treated as unsigned and therefore in case of error condition in 
> cdrom_get_disc_info the if-statement is doomed to be evaluated false, 
> which in turn results in random values from the stack being evaluated 
> further down.

OK.

> There is another subtle problem which was there and was modified in the 
> same code commit:
> 
> -	if ((ret = cdrom_get_disc_info(cdi, &di)))
> +	if ((ret = cdrom_get_disc_info(cdi, &di))
> +			< offsetof(typeof(di), last_track_msb)
> +			+ sizeof(di.last_track_msb))
>   		goto use_last_written;
> 
>   	last_track = (di.last_track_msb << 8) | di.last_track_lsb;
> 
> last_track_msb was introduced in one of later MMC specifications. 
> Previously the problem with the cdrom.c code was that the last_track_msb 
> value might turn uninitialized when you talk to elder units, while now 
> last_track_lsb value returned by elder units is simply disregarded for 
> no valid reason. The more appropriate way to deal with the problem is:
> 
> 	memset (&di,0,sizeof(di));
> 	if ((ret = cdrom_get_disc_info(cdi, &di))
> 			< (int)(offsetof(typeof(di), last_track_lsb)
> 			+ sizeof(di.last_track_lsb)))
>   		goto use_last_written;
> 
> 	last_track = (di.last_track_msb << 8) | di.last_track_lsb;
> 
> This way last_track_msb is forced to zero for elder units and last_track 
> is maintained sane.

OK.

> Further down we see:
> 
>          /* if this track is blank, try the previous. */
>          if (ti.blank) {
>                  last_track--;
>                  ti_size = cdrom_get_track_info(cdi, last_track, 1, &ti);
>          }
> 
> What if there is no previous track? It might turn out that we never get 
> here, because if-statement elsewhere, and check for last_track>1 will be 
> redundant. But what if the "elsewhere" will be changed at some later 
> point? My point is that IMO check for last_track>1 is more than 
> appropriate here.
> 

OK.

How about this?

--- 25/drivers/cdrom/cdrom.c~cdrom-range-fixes	2004-08-26 03:06:40.533279808 -0700
+++ 25-akpm/drivers/cdrom/cdrom.c	2004-08-26 03:12:17.208097456 -0700
@@ -609,8 +609,9 @@ static int cdrom_mrw_exit(struct cdrom_d
 {
 	disc_information di;
 	int ret = 0;
+	int info = cdrom_get_disc_info(cdi, &di);
 
-	if (cdrom_get_disc_info(cdi, &di) < offsetof(typeof(di),disc_type))
+	if (info < 0 || info < offsetof(typeof(di), disc_type))
 		return 1;
 
 	if (di.mrw_status == CDM_MRW_BGFORMAT_ACTIVE) {
@@ -2911,19 +2912,19 @@ int cdrom_get_last_written(struct cdrom_
 	disc_information di;
 	track_information ti;
 	__u32 last_track;
-	int ret = -1, ti_size;
+	int ret, ti_size;
 
 	if (!CDROM_CAN(CDC_GENERIC_PACKET))
 		goto use_toc;
 
-	if ((ret = cdrom_get_disc_info(cdi, &di))
-			< offsetof(typeof(di), last_track_msb)
-			+ sizeof(di.last_track_msb))
+	ret = cdrom_get_disc_info(cdi, &di);
+	if (ret < 0 || ret < offsetof(typeof(di), last_track_msb)
+				+ sizeof(di.last_track_msb))
 		goto use_toc;
 
 	last_track = (di.last_track_msb << 8) | di.last_track_lsb;
 	ti_size = cdrom_get_track_info(cdi, last_track, 1, &ti);
-	if (ti_size < offsetof(typeof(ti), track_start))
+	if (ti_size < 0 || ti_size < offsetof(typeof(ti), track_start))
 		goto use_toc;
 
 	/* if this track is blank, try the previous. */
_

