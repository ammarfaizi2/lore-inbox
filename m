Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWHOCYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWHOCYH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 22:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWHOCYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 22:24:06 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:32144 "EHLO
	asav13.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1751443AbWHOCYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 22:24:05 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAMXK4ESBUQ
From: Dmitry Torokhov <dtor@insightbb.com>
To: Ben B <kernel@bb.cactii.net>
Subject: Re: 2.6.18-rc4-mm1
Date: Mon, 14 Aug 2006 22:23:48 -0400
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Maciej Rutecki <maciej.rutecki@gmail.com>,
       linux-kernel@vger.kernel.org
References: <20060813012454.f1d52189.akpm@osdl.org> <d120d5000608140645y585d987fj1d4927879e9b180e@mail.gmail.com> <20060814214417.GB30680@cactii.net>
In-Reply-To: <20060814214417.GB30680@cactii.net>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1499
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200608142223.49275.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 August 2006 17:44, Ben B wrote:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> uttered the following thing:
> > On 8/14/06, Ben B <kernel@bb.cactii.net> wrote:
> > >I can try to get a full boot log later when I get home.
> > >
> > 
> > Please.
> 
> It was impossible to get. I set the 'init' kernel option to a dedicated
> script to dump dmesg, but even that went way past the messages.
> 

Could you please try increasing the buffer size (using log_buf_len=xxx
option). 131072 shoudl work I think.

Also please try the patch below. Thanks!

-- 
Dmitry

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)

Index: work/drivers/input/serio/i8042.c
===================================================================
--- work.orig/drivers/input/serio/i8042.c
+++ work/drivers/input/serio/i8042.c
@@ -631,8 +631,14 @@ static int __devinit i8042_check_aux(voi
 		goto out;
 
 	if (wait_for_completion_timeout(&i8042_aux_irq_delivered,
-					msecs_to_jiffies(250)) == 0)
+					msecs_to_jiffies(250)) == 0) {
+/*
+ * AUX IRQ was never delivered so we need to flush the controller to
+ * get rid of the byte we put there; otherwise keyboard may not work.
+ */
+		i8042_flush();
 		retval = -1;
+	}
 
  out:
 
