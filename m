Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312308AbSDSUBP>; Fri, 19 Apr 2002 16:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312570AbSDSUBO>; Fri, 19 Apr 2002 16:01:14 -0400
Received: from codepoet.org ([166.70.14.212]:19906 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S312308AbSDSUBN>;
	Fri, 19 Apr 2002 16:01:13 -0400
Date: Fri, 19 Apr 2002 14:01:13 -0600
From: Erik Andersen <andersen@codepoet.org>
To: "Dr. Death" <drd@homeworld.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while reading damadged files
Message-ID: <20020419200112.GA16209@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"Dr. Death" <drd@homeworld.ath.cx>, linux-kernel@vger.kernel.org
In-Reply-To: <3CBEC67F.3000909@filez>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Apr 18, 2002 at 03:13:35PM +0200, Dr. Death wrote:
> Problem:
> 
> I use SuSE Linux 7.2 and when I create md5sums from damaged files on a 
> CD, the WHOLE system  freezes or is ugly slow untill md5 has passed the 
> damaged part of the file !

This should help somewhat.  Currently, ide-cd.c retries ERROR_MAX
(8) times when it sees an error.  But ide.c is also retrying
ERROR_MAX times when _it_ sees an error, and does a bus reset
after evey 4 failures.  So for each bad sector, you get 64
retries (with typical timouts of 7 seconds each) plus 16 bus
resets per bad sector.

The funny thing is though, we knew after the first read that we
had an uncorrectable medium error.  Try this patch vs 2.4.19-pre7

--- linux/drivers/ide/ide-cd.c.orig	Tue Apr  9 06:59:56 2002
+++ linux/drivers/ide/ide-cd.c	Tue Apr  9 07:04:59 2002
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
