Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261342AbRFJRjP>; Sun, 10 Jun 2001 13:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261297AbRFJRiz>; Sun, 10 Jun 2001 13:38:55 -0400
Received: from m280-mp1-cvx1b.col.ntl.com ([213.104.73.24]:2944 "EHLO
	[213.104.73.24]") by vger.kernel.org with ESMTP id <S261238AbRFJRiw>;
	Sun, 10 Jun 2001 13:38:52 -0400
To: Michael Johnson <johnsom@home.com>
Cc: Jens Axboe <axboe@suse.de>, <Andries.Brouwer@cwi.nl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Changes to ide-cd for 2.4.1 are broken?
In-Reply-To: <001801c09e3a$4a189270$653b090a@sulaco>
	<m27l29tj87.fsf@boreas.yi.org.>
From: John Fremlin <vii@users.sourceforge.net>
Date: 10 Jun 2001 18:37:53 +0100
In-Reply-To: <m27l29tj87.fsf@boreas.yi.org.> (John Fremlin's message of "01 Mar 2001 18:52:24 +0000")
Message-ID: <m28zj05j7y.fsf@boreas.yi.org.>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


Hi all, this is an old thread. It was started because the return value
from cd info was changed in 2.4.1 in the case when the tray might be
open or there simply be no disc in the drive for an IDE
CD-ROM. 

John Fremlin <chief@bandits.org> writes:

> "Michael Johnson" <johnsom@home.com> writes:

[...]

> > >Right, old ATAPI has 3a/02 as the only possible condition, so we
> > >can't really tell between no disc and tray open. I guess the safest
> > >is to just keep the old behaviour for !ascq and report open.
> 
> > I don't understand why the current(2.4.1) behavior is a problem...

Unfortunately changing the return code means that the generic cdrom.c
code is broekn, in particular wrt to having the cdrom drive open
automatically when umounted, and to close when attempted to be
mounted. 

(You can set this mode with "cdd auto" if you have my asm-toys installed
        http://ape.n3.net/programs/linux/asm-toys 
)

The following patch fixes that. I also attempted to fix up similar
problems (where checking CDS_TRAY_OPEN is used to see if the tray is
open, which is obviously broekn).


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=linux-2.4.4-cd-ret-fixup.patch

--- linux-2.4.4-orig/drivers/cdrom/cdrom.c	Tue May  1 14:32:05 2001
+++ linux-2.4.4/drivers/cdrom/cdrom.c	Sun Jun 10 15:32:48 2001
@@ -515,8 +515,8 @@ int open_for_data(struct cdrom_device_in
 	if (cdo->drive_status != NULL) {
 		ret = cdo->drive_status(cdi, CDSL_CURRENT);
 		cdinfo(CD_OPEN, "drive_status=%d\n", ret); 
-		if (ret == CDS_TRAY_OPEN) {
-			cdinfo(CD_OPEN, "the tray is open...\n"); 
+		if (ret == CDS_TRAY_OPEN || ret == CDS_NO_DISC) {
+			cdinfo(CD_OPEN, "the tray might be open...\n"); 
 			/* can/may i close it? */
 			if (CDROM_CAN(CDC_CLOSE_TRAY) &&
 			    cdi->options & CDO_AUTO_CLOSE) {
@@ -622,7 +622,7 @@ int check_for_audio_disc(struct cdrom_de
 	if (cdo->drive_status != NULL) {
 		ret = cdo->drive_status(cdi, CDSL_CURRENT);
 		cdinfo(CD_OPEN, "drive_status=%d\n", ret); 
-		if (ret == CDS_TRAY_OPEN) {
+		if (ret == CDS_TRAY_OPEN || ret == CDS_NO_DISC) {
 			cdinfo(CD_OPEN, "the tray is open...\n"); 
 			/* can/may i close it? */
 			if (CDROM_CAN(CDC_CLOSE_TRAY) &&

--=-=-=


-- 

	http://ape.n3.net

--=-=-=--
