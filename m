Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264657AbRFPVIJ>; Sat, 16 Jun 2001 17:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264658AbRFPVH7>; Sat, 16 Jun 2001 17:07:59 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:27919 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S264657AbRFPVHo>;
	Sat, 16 Jun 2001 17:07:44 -0400
Date: Sat, 16 Jun 2001 18:06:48 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Pavel Machek <pavel@suse.cz>, John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: spindown [was Re: 2.4.6-pre2, pre3 VM Behavior]
In-Reply-To: <0106162250570J.00879@starship>
Message-ID: <Pine.LNX.4.21.0106161801220.2056-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jun 2001, Daniel Phillips wrote:

> In other words, any episode of pageouts is followed immediately by a
> short episode of preemptive cleaning.

linux/mm/vmscan.c::page_launder(), around line 666:
	        /* Let bdflush take care of the rest. */
                wakeup_bdflush(0);


> The definition of 'for a while' and 'plenty of disk bandwidth' can be
> tuned, but I don't think either is particularly critical.

Can be tuned a bit, indeed.

> As a side note, the good old multisecond delay before bdflush kicks in 
> doesn't really make a lot of sense - when bandwidth is available the 
> filesystem-initiated writeouts should happen right away.

... thus spinning up the disk ?

How about just making sure we write out a bigger bunch
of dirty pages whenever one buffer gets too old ?

Does the patch below do anything good for your laptop? ;)

regards,

Rik
--


--- buffer.c.orig	Sat Jun 16 18:05:15 2001
+++ buffer.c	Sat Jun 16 18:05:29 2001
@@ -2550,8 +2550,7 @@
 			   if the current bh is not yet timed out,
 			   then also all the following bhs
 			   will be too young. */
-			if (++flushed > bdf_prm.b_un.ndirty &&
-					time_before(jiffies, bh->b_flushtime))
+			if(time_before(jiffies, bh->b_flushtime))
 				goto out_unlock;
 		} else {
 			if (++flushed > bdf_prm.b_un.ndirty)

