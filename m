Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284445AbRLHTon>; Sat, 8 Dec 2001 14:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284452AbRLHTod>; Sat, 8 Dec 2001 14:44:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4620 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284448AbRLHToQ>;
	Sat, 8 Dec 2001 14:44:16 -0500
Date: Sat, 8 Dec 2001 20:44:03 +0100
From: Jens Axboe <axboe@suse.de>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1-pre7 ide-cd module
Message-ID: <20011208194403.GY11567@suse.de>
In-Reply-To: <3C1235C4.BC20AC8E@wanadoo.fr> <20011208161847.GK11567@suse.de> <3C126634.F3BBC941@delusion.de> <20011208191515.GX11567@suse.de> <3C1269E1.53347A2A@delusion.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
In-Reply-To: <3C1269E1.53347A2A@delusion.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 08 2001, Udo A. Steinberg wrote:
> Jens Axboe wrote:
> > 
> > Yes please -- try 2.5.1-pre1 and 2.5.1-pre2, it probably broke there.
> 
> Indeed. pre1 works, pre2 doesn't:

Ah, I think I see the problem. Very first mode page capabilities probe
fails, which is expected and therefore retried. But now we've killed the
correct length of command, which should only be done on success. The
second time you load ide-cd, it succeeds on first probe and thus works.

Attached patch should fix it.

-- 
Jens Axboe


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ide-cd-stat

--- /opt/kernel/linux-2.5.1-pre7/drivers/ide/ide-cd.c	Fri Dec  7 20:38:44 2001
+++ drivers/ide/ide-cd.c	Sat Dec  8 14:39:43 2001
@@ -2145,7 +2145,8 @@
 	pc.timeout = cgc->timeout;
 	pc.sense = cgc->sense;
 	cgc->stat = cdrom_queue_packet_command(drive, &pc);
-	cgc->buflen -= pc.buflen;
+	if (!cgc->stat)
+		cgc->buflen -= pc.buflen;
 	return cgc->stat;
 }
 

--gr/z0/N6AeWAPJVB--
