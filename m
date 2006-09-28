Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752000AbWI1U1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbWI1U1o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 16:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbWI1U1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 16:27:44 -0400
Received: from mout0.freenet.de ([194.97.50.131]:15779 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1752000AbWI1U1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 16:27:43 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] Reset file->f_op in snd_card_file_remove(). Take 2
Date: Thu, 28 Sep 2006 22:28:02 +0200
User-Agent: KMail/1.9.4
Cc: mingo@elte.hu, alsa-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609282228.02611.annabellesgarden@yahoo.de>
X-Warning: yahoo.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

It oopses with 2.6.18-rt4 + alsa-kernel-1.0.13rc3 now.
I wrote before, 2.6.18-rt3 + alsa-driver-1.0.13rc3 would be ok,
but its not. bug showed again reliably under memory-pressure.

      Karsten

===

Reset file->f_op in snd_card_file_remove(). Take 2


i think what happens here is:

  us428control runs, kernel has allocated a struct file for /dev/hwC1D0.

  usb disconnect

  snd_usb_usx2y calls snd_card_disconnect,
  tells us428control to exit.

  snd_card_disconnect replaces /dev/hwC1D0's file->f_op
  with a kmalloc()ed version, that would only allow releases.

  us428control starts exiting

  __fput is called with struct file for /dev/hwC1D0.

  snd_card_file_remove() is called, alsa notices struct file
  for /dev/hwC1D0 is about to be closed.
  with patch below, file->f_op would be set NULL now.

  snd_usb_usx2y's free()s snd_card instance and /dev/hwC1D0's
  file->f_ops, those that would only allow releases.

  for reason I would like to know,
  __fput is called again with struct file for /dev/hwC1D0
  from us428control's do_exit().
  __fput see's file->f_op is still set.
  Without patch and under memory pressure, file->f_op can
  point to anything now.


Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>


diff -pur ../alsa/1.0.13/alsa-driver-1.0.13rc3/alsa-kernel/core/init.c rt4-kw/sound/core/init.c
--- ../alsa/1.0.13/alsa-driver-1.0.13rc3/alsa-kernel/core/init.c	2006-09-25 15:33:19.000000000 +0200
+++ rt4-kw/sound/core/init.c	2006-09-28 18:48:15.000000000 +0200
@@ -707,6 +707,8 @@ int snd_card_file_remove(struct snd_card
 	mfile = card->files;
 	while (mfile) {
 		if (mfile->file == file) {
+			fops_put(file->f_op);
+			file->f_op = NULL;
 			if (pfile)
 				pfile->next = mfile->next;
 			else
