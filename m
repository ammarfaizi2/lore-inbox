Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161393AbWJKV3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161393AbWJKV3u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161390AbWJKVFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:05:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:12958 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161384AbWJKVEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:04:39 -0400
Date: Wed, 11 Oct 2006 14:03:48 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Hans Verkuil <hverkuil@xs4all.nl>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 05/67] Video: Fix msp343xG handling regression
Message-ID: <20061011210348.GF16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="video-fix-msp343xg-handling-regression.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Hans Verkuil <hverkuil@xs4all.nl>

The msp3430G and msp3435G models cannot do Automatic Standard Detection,
so these should be forced to BTSC. These chips are early production
versions for the msp34xxG series and are quite rare.

The workaround for kernel 2.6.18 is to use 'standard=32' as msp3400 module
option.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/media/video/msp3400-driver.c   |    2 ++
 drivers/media/video/msp3400-driver.h   |    1 +
 drivers/media/video/msp3400-kthreads.c |    5 +++--
 3 files changed, 6 insertions(+), 2 deletions(-)

--- linux-2.6.18.orig/drivers/media/video/msp3400-driver.c
+++ linux-2.6.18/drivers/media/video/msp3400-driver.c
@@ -904,6 +904,8 @@ static int msp_attach(struct i2c_adapter
 	state->has_virtual_dolby_surround = msp_revision == 'G' && msp_prod_lo == 1;
 	/* Has Virtual Dolby Surround & Dolby Pro Logic: only in msp34x2 */
 	state->has_dolby_pro_logic = msp_revision == 'G' && msp_prod_lo == 2;
+	/* The msp343xG supports BTSC only and cannot do Automatic Standard Detection. */
+	state->force_btsc = msp_family == 3 && msp_revision == 'G' && msp_prod_hi == 3;
 
 	state->opmode = opmode;
 	if (state->opmode == OPMODE_AUTO) {
--- linux-2.6.18.orig/drivers/media/video/msp3400-driver.h
+++ linux-2.6.18/drivers/media/video/msp3400-driver.h
@@ -64,6 +64,7 @@ struct msp_state {
 	u8 has_sound_processing;
 	u8 has_virtual_dolby_surround;
 	u8 has_dolby_pro_logic;
+	u8 force_btsc;
 
 	int radio;
 	int opmode;
--- linux-2.6.18.orig/drivers/media/video/msp3400-kthreads.c
+++ linux-2.6.18/drivers/media/video/msp3400-kthreads.c
@@ -960,9 +960,10 @@ int msp34xxg_thread(void *data)
 
 		/* setup the chip*/
 		msp34xxg_reset(client);
-		state->std = state->radio ? 0x40 : msp_standard;
-		/* start autodetect */
+		state->std = state->radio ? 0x40 :
+			(state->force_btsc && msp_standard == 1) ? 32 : msp_standard;
 		msp_write_dem(client, 0x20, state->std);
+		/* start autodetect */
 		if (state->std != 1)
 			goto unmute;
 

--
