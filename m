Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314088AbSDQOQ4>; Wed, 17 Apr 2002 10:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314089AbSDQOQz>; Wed, 17 Apr 2002 10:16:55 -0400
Received: from codepoet.org ([166.70.14.212]:64149 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S314088AbSDQOQy>;
	Wed, 17 Apr 2002 10:16:54 -0400
Date: Wed, 17 Apr 2002 08:16:53 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.8 IDE oops (TCQ breakage?)
Message-ID: <20020417141653.GA13627@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200204161749.TAA16333@harpo.it.uu.se> <3CBD45BD.4040209@evision-ventures.com> <20020417120817.GA800@suse.de> <20020417122502.GB800@suse.de> <3CBD5D93.30501@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Apr 17, 2002 at 01:33:39PM +0200, Martin Dalecki wrote:
> Yes I see. However for now I will just concentrate on ide-cd.c and
> await you to merge up with IDE 37 OK? (It should be easy this time :-).

While working on ide-cd, I think the bad sector handling needs
serious attention...  For example, I have a CD-ROM (a toddler
game for windoz) that my 2 year old son scratched into
non-functional oblivion.  I attempted to extract the contents in
the hope of burning it to a new CD.  Using dd conv=noerror, it
began ripping the content just fine -- till it hit the bad spot.
Then it took like 12 hours to progress by an additional 10 MB...

Looking at the ide-cd code (since I used to maintain it years
ago) it seems that on a bad sector, ide-cd retries ERROR_MAX (8)
times.  But the low level ide driver is _also_ doing ERROR_MAX
retries for each of those 8 retries from ide-cd....   Do we
really need to retry 64 times when the drive told us clearly the
_first_ time that it is an uncorrectable medium error?  

Perhaps something like this patch would make more sense?  With
this patch is place, error handling is still awful, but at least
a dd was able to make a bit of progress....  


--- linux/drivers/ide/ide-cd.c.orig	Tue Apr  16 06:59:56 2002
+++ linux/drivers/ide/ide-cd.c	Tue Apr  16 07:04:59 2002
@@ -657,6 +657,11 @@
 			   request or data protect error.*/
 			ide_dump_status (drive, "command error", stat);
 			cdrom_end_request (0, drive);
+		} else if (sense_key == MEDIUM_ERROR) {
+			/* No point in re-trying a zillion times on a bad 
+			 * sector...  If we got here the error is not correctable */
+			ide_dump_status (drive, "media error (bad sector)", stat);
+			cdrom_end_request (0, drive);
 		} else if ((err & ~ABRT_ERR) != 0) {
 			/* Go to the default handler
 			   for other errors. */

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
