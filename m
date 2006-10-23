Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbWJWFRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbWJWFRN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 01:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWJWFRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 01:17:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:53327 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751506AbWJWFRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 01:17:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=PlslRpIbQG4yjlHstqI6R56GGlfM69VUdBzj3eyk4y/eZTrIkX8omykEEbhxiGproBg01uysWyqwmVPm2cr5OIhUzEurAIA1IKnMk7J6DQqlJhryzpB6jb+WpGWQ6N7d6pAIiJuVPr5sR9E62C357QsG96E54GK4NZAFy1SPnaE=
Date: Sun, 22 Oct 2006 22:17:00 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19-rc2] sound/oss/i810_audio.c: check kmalloc() return
 value.
Message-Id: <20061022221700.0e33ce71.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Check the return value of kmalloc() in function i810_open(), in file sound/oss/i810_audio.c.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
index 240cc79..a415967 100644
--- a/sound/oss/i810_audio.c
+++ b/sound/oss/i810_audio.c
@@ -2580,8 +2580,13 @@ static int i810_open(struct inode *inode
 			if (card->states[i] == NULL) {
 				state = card->states[i] = (struct i810_state *)
 					kmalloc(sizeof(struct i810_state), GFP_KERNEL);
-				if (state == NULL)
+				if (state == NULL) {
+					for (--i; i >= 0; i--) {
+						kfree(card->states[i]);
+						card->states[i] = NULL;
+					}
 					return -ENOMEM;
+				}
 				memset(state, 0, sizeof(struct i810_state));
 				dmabuf = &state->dmabuf;
 				goto found_virt;
