Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131184AbRDBR3t>; Mon, 2 Apr 2001 13:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131194AbRDBR3k>; Mon, 2 Apr 2001 13:29:40 -0400
Received: from front2.grolier.fr ([194.158.96.52]:40629 "EHLO
	front2.grolier.fr") by vger.kernel.org with ESMTP
	id <S131184AbRDBR3a> convert rfc822-to-8bit; Mon, 2 Apr 2001 13:29:30 -0400
Date: Mon, 2 Apr 2001 16:16:21 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: Christian Kurz <shorty@getuid.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Assumption in sym53c8xx.c failed
In-Reply-To: <20010331234823.B1858@seteuid.getuid.de>
Message-ID: <Pine.LNX.4.10.10104021605310.926-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 31 Mar 2001, Christian Kurz wrote:

> Hi,
> 
> I'm currently running 2.4.2-ac28 and today I got a failing assumption in
> sym53c8xx.c. I'm not sure about the exact steps that I did to produce
> this error, but it must have been something like: cdparanoia -blank=all,
> then sending Ctrl+C to this process and after it's been killed
> cdparanoia -blank=fast. I then got assertion: k!=-1 failed. But I found
> no hint about this in the messages or syslog file. So I looked through
> sym53c8xx.c to find this code and it seems like line 10123 is
> responsible for creating this error and kernel panic. Should this be the
> normal behaviour or is this a bug in the code?

This might well be both at the same time. I mean normal behaviour given a
bug in the code. :-)

Could you try this tiny patch and let me know:

--- sym53c8xx.c.0402	Mon Apr  2 15:58:32 2001
+++ sym53c8xx.c	Mon Apr  2 16:02:43 2001
@@ -10167,14 +10167,13 @@
 				if (i >= MAX_START*2)
 					i = 0;
 			}
-			assert(k != -1);
 			if (k != 1) {
 				np->squeue[k] = np->squeue[i]; /* Idle task */
 				np->squeueput = k; /* Start queue pointer */
-				cp->host_status = HS_ABORTED;
-				cp->scsi_status = S_ILLEGAL;
-				ncr_complete(np, cp);
 			}
+			cp->host_status = HS_ABORTED;
+			cp->scsi_status = S_ILLEGAL;
+			ncr_complete(np, cp);
 		}
 		break;
 	/*

What happens is that this part of the driver code assumed that the CCB for
an IO to abort is queued to the SCSI SCRIPTS. This is not always true
since the driver may temporarily not queue all IOs to SCRIPTS. This may
happens on QUEUE FULL condition or for devices that donnot accept tagged
commands, for example.

Regards,
  Gérard.

