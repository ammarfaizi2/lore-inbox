Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319311AbSIGRxa>; Sat, 7 Sep 2002 13:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319313AbSIGRxa>; Sat, 7 Sep 2002 13:53:30 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:33289 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S319311AbSIGRx3>; Sat, 7 Sep 2002 13:53:29 -0400
Date: Sat, 7 Sep 2002 19:57:35 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Lite-On cdwriter detected as 12x instead of 40x
Message-ID: <20020907175735.GA884@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a LITE-ON LTR-40125W cdwriter, which can write at 40x.
The kernel sees it as 12x. This happens in 2.4.19ac4 up to
2.4.20pre4ac2, I didn't test later kernels due to the instable IDE
situation. It has the latest firmware (WS05) - I'm not sure if bothering
the manufacturer about this is worth it.

If I don't pass the drive on to ide-scsi, and patch 
drivers/ide/ide-cd.c with this small patch,

+	/* brain-dead LiteOn model reports itself as 12x */
+	if ((cap != NULL) && (strcmp (drive->id->model, "LITE-ON LTR-40125W") == 0))
+	  cap->maxspeed = htons(40 * 176);

all is well, and the kernel reports 40x.

But I can't find out where to put this for the ide-scsi part.
All the probing routines in drivers/scsi/ide-cd.c seem to access some
sort of atapi-buffer that already exists. I can tweak it to display 40x
in the bootup-messages by changing the idescsi_transform_pc? functions
in drivers/scsi/ide-cd.c:

+	                if (strcmp (drive->id->model, "LITE-ON LTR-40125W") == 0)
+			{
+				int n = scsi_buf[3] + 4;
+                   	        scsi_buf[n+8] = scsi_buf[n+14] = (u8) ((40 * 176) >> 8);
+                   	        scsi_buf[n+9] = scsi_buf[n+15] = (u8) ((40 * 176) & 0xff);
+				printk("ide-scsi.c: LITE-ON tweak activated\n");
+			}

but that doesn't fool cdrdao nor cdrecord - they still think the drive
is 12x.

Can anyone help me by pointing out where I should tweak the kernel to
get correct results when using ide-scsi with my drive?

Thanks,
Jurriaan
-- 
Remember, Unix on some machines is nUxi.
GNU/Linux 2.4.19-ac4 SMP/ReiserFS 2x1402 bogomips load av: 0.39 0.28 0.11
