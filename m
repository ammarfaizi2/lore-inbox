Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266846AbUHYKMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266846AbUHYKMx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 06:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266839AbUHYKLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 06:11:15 -0400
Received: from anubis.medic.chalmers.se ([129.16.30.218]:2793 "EHLO
	anubis.medic.chalmers.se") by vger.kernel.org with ESMTP
	id S266692AbUHYKKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 06:10:01 -0400
Message-ID: <412C65D6.4050105@fy.chalmers.se>
Date: Wed, 25 Aug 2004 12:11:34 +0200
From: Andy Polyakov <appro@fy.chalmers.se>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, axboe@suse.de, samuel.thibault@ens-lyon.org
Subject: 2.6.9-rcX cdrom.c is subject to "chaotic" behaviour
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As per 
http://marc.theaimsgroup.com/?l=bk-commits-head&m=109330228416908&w=2, 
cdrom.c becomes subject to chaotic behavior. The culprit is newly 
introduced if-statement such as following:

if (cdrom_get_disc_info(cdi, &di) < offsetof(typeof(di),disc_type))

The catch is that cdrom_get_disc_info returns signed value, most notably 
negative one upon error, while the offsetof on the other hand is 
unsigned. When signed and unsigned values are compared, signed one is 
treated as unsigned and therefore in case of error condition in 
cdrom_get_disc_info the if-statement is doomed to be evaluated false, 
which in turn results in random values from the stack being evaluated 
further down.

There is another subtle problem which was there and was modified in the 
same code commit:

-	if ((ret = cdrom_get_disc_info(cdi, &di)))
+	if ((ret = cdrom_get_disc_info(cdi, &di))
+			< offsetof(typeof(di), last_track_msb)
+			+ sizeof(di.last_track_msb))
  		goto use_last_written;

  	last_track = (di.last_track_msb << 8) | di.last_track_lsb;

last_track_msb was introduced in one of later MMC specifications. 
Previously the problem with the cdrom.c code was that the last_track_msb 
value might turn uninitialized when you talk to elder units, while now 
last_track_lsb value returned by elder units is simply disregarded for 
no valid reason. The more appropriate way to deal with the problem is:

	memset (&di,0,sizeof(di));
	if ((ret = cdrom_get_disc_info(cdi, &di))
			< (int)(offsetof(typeof(di), last_track_lsb)
			+ sizeof(di.last_track_lsb)))
  		goto use_last_written;

	last_track = (di.last_track_msb << 8) | di.last_track_lsb;

This way last_track_msb is forced to zero for elder units and last_track 
is maintained sane.

Further down we see:

         /* if this track is blank, try the previous. */
         if (ti.blank) {
                 last_track--;
                 ti_size = cdrom_get_track_info(cdi, last_track, 1, &ti);
         }

What if there is no previous track? It might turn out that we never get 
here, because if-statement elsewhere, and check for last_track>1 will be 
redundant. But what if the "elsewhere" will be changed at some later 
point? My point is that IMO check for last_track>1 is more than 
appropriate here.

If you prefer the above findings to be expressed in form of patch, then 
I might have some time only this weekend (unfortunately). A.
