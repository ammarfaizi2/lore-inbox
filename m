Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWJOQBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWJOQBs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 12:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWJOQBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 12:01:48 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:26960 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751089AbWJOQBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 12:01:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=kWixw2FiD8IleYLCNHpEb00cIK6Zg5IhkYl7k3ybCgcpu6W/mtoSnBw4klxERydSgDiKyKoQjxAGAtZiujMf/4IZNSGvhlPDGU5giT3AoOzCQJ74DY49t/Xt+g3sAXutgsILyV0hH0NWBa5T43mSTeZxhbJpKh8N+pq/oAdW9Pw=
Message-ID: <45325B9E.1030808@gmail.com>
Date: Sun, 15 Oct 2006 12:02:38 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Trent Piepho <xyzzy@speakeasy.org>
CC: Mauro Carvalho Chehab <mchehab@infradead.org>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] [PATCH] V4L/DVB: potential leak in dvb-bt8xx
References: <453120EC.8030503@gmail.com> <Pine.LNX.4.58.0610141720560.13331@shell2.speakeasy.net>
In-Reply-To: <Pine.LNX.4.58.0610141720560.13331@shell2.speakeasy.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trent Piepho wrote:
> I believe that 'state' will be kfree'd by the dst_attach() function if there
> is a failure.  Not what you would expect, to have it allocated in the bt8xx
> driver (why do is there??) and freed on error in a different function.
>   

Hm, you're right - it is kfreed in dst_attach(). But we're still missing
the kmalloc result check...

Signed-off-by: Florin Malita <fmalita@gmail.com>
---

 dvb-bt8xx.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/dvb/bt8xx/dvb-bt8xx.c b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
index fb6c4cc..d22ba4e 100644
--- a/drivers/media/dvb/bt8xx/dvb-bt8xx.c
+++ b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
@@ -665,6 +665,9 @@ static void frontend_init(struct dvb_bt8
 	case BTTV_BOARD_TWINHAN_DST:
 		/*	DST is not a frontend driver !!!		*/
 		state = (struct dst_state *) kmalloc(sizeof (struct dst_state), GFP_KERNEL);
+		if (!state)
+			break;
+
 		/*	Setup the Card					*/
 		state->config = &dst_config;
 		state->i2c = card->i2c_adapter;


