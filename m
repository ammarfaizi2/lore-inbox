Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280043AbRKNDSA>; Tue, 13 Nov 2001 22:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280041AbRKNDRl>; Tue, 13 Nov 2001 22:17:41 -0500
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:51726 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S280043AbRKNDR1>;
	Tue, 13 Nov 2001 22:17:27 -0500
Date: Tue, 13 Nov 2001 19:17:21 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: hogsberg@users.sourceforge.net, jamesg@filanet.com,
        Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: sbp2.c on SMP
Message-ID: <20011113191721.A9276@lucon.org>
In-Reply-To: <3BEF27D1.7793AE8E@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BEF27D1.7793AE8E@zip.com.au>; from akpm@zip.com.au on Sun, Nov 11, 2001 at 05:37:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2001 at 05:37:21PM -0800, Andrew Morton wrote:
> Guys,
> 
> drivers/ieee1394/sbp2.c deadlocks immediately on SMP, because
> io_request_lock is not held over its call to scsi_old_done().
> 

Here is another patch. It fixes:

# modprobe ohci1394
# rmmod ohci1394


H.J.
--- linux-2.4.9-12.2mod/drivers/ieee1394/nodemgr.c.rmmod	Tue Nov 13 19:15:44 2001
+++ linux-2.4.9-12.2mod/drivers/ieee1394/nodemgr.c	Tue Nov 13 19:11:38 2001
@@ -570,7 +570,8 @@ static void nodemgr_remove_host(struct h
 	write_lock_irqsave(&node_lock, flags);
 	list_for_each(lh, &node_list) {
 		ne = list_entry(lh, struct node_entry, list);
-
+		if (!ne)
+			break;
 		/* Only checking this host */
 		if (ne->host != host)
 			continue;
@@ -582,6 +583,8 @@ static void nodemgr_remove_host(struct h
 	spin_lock_irqsave (&host_info_lock, flags);
 	list_for_each(lh, &host_info_list) {
 		struct host_info *myhi = list_entry(lh, struct host_info, list);
+		if (!myhi)
+			break;
 		if (myhi->host == host) {
 			hi = myhi;
 			break;
