Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWD2OK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWD2OK2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 10:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWD2OK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 10:10:28 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:26875 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1750731AbWD2OK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 10:10:27 -0400
Date: Sat, 29 Apr 2006 23:11:01 +0900 (JST)
Message-Id: <20060429.231101.115906349.anemo@mba.ocn.ne.jp>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, alessandro.zummo@towertech.it
Subject: Re: [PATCH] genrtc: fix read on 64-bit platforms
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060428233421.72e2faed.akpm@osdl.org>
References: <20060429.013857.37531336.anemo@mba.ocn.ne.jp>
	<20060428233421.72e2faed.akpm@osdl.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2006 23:34:21 -0700, Andrew Morton <akpm@osdl.org> wrote:
> > Fix genrtc's read() routine for 64-bit platforms.
> 
> When fixing something, please provide a description of what the problem was
> and also a description of how the patch fixes it (unless it's obvious, of
> course).

Thanks.  Here is a same patch with an updated description.


Fix genrtc's read() routine for 64-bit platforms.  Current
gen_rtc_read() stores 64bit integer and returns 8 even if an user
tried to read a 32bit integer.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/drivers/char/genrtc.c b/drivers/char/genrtc.c
index d3a2bc3..588fca5 100644
--- a/drivers/char/genrtc.c
+++ b/drivers/char/genrtc.c
@@ -200,13 +200,13 @@ static ssize_t gen_rtc_read(struct file 
 	/* first test allows optimizer to nuke this case for 32-bit machines */
 	if (sizeof (int) != sizeof (long) && count == sizeof (unsigned int)) {
 		unsigned int uidata = data;
-		retval = put_user(uidata, (unsigned long __user *)buf);
+		retval = put_user(uidata, (unsigned int __user *)buf) ?:
+			sizeof(unsigned int);
 	}
 	else {
-		retval = put_user(data, (unsigned long __user *)buf);
+		retval = put_user(data, (unsigned long __user *)buf) ?:
+			sizeof(unsigned long);
 	}
-	if (!retval)
-		retval = sizeof(unsigned long);
  out:
 	current->state = TASK_RUNNING;
 	remove_wait_queue(&gen_rtc_wait, &wait);
