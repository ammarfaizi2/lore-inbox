Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbUKDLT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbUKDLT3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 06:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbUKDLSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 06:18:23 -0500
Received: from sd291.sivit.org ([194.146.225.122]:13785 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262166AbUKDLOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 06:14:41 -0500
Date: Thu, 4 Nov 2004 12:14:54 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 4/12] meye: do lock properly when waiting for buffers
Message-ID: <20041104111453.GJ3472@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20041104111231.GF3472@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104111231.GF3472@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

ChangeSet@1.2343, 2004-11-02 15:46:59+01:00, stelian@popies.net
  meye: do lock properly when waiting for buffers
  
  Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 meye.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/media/video/meye.c b/drivers/media/video/meye.c
--- a/drivers/media/video/meye.c	2004-11-04 11:21:51 +01:00
+++ b/drivers/media/video/meye.c	2004-11-04 11:21:52 +01:00
@@ -929,19 +929,25 @@
 		if (*i < 0 || *i >= gbuffers)
 			return -EINVAL;
 
+		down(&meye.lock);
+
 		switch (meye.grab_buffer[*i].state) {
 
 		case MEYE_BUF_UNUSED:
+			up(&meye.lock);
 			return -EINVAL;
 		case MEYE_BUF_USING:
 			if (wait_event_interruptible(meye.proc_list,
-						     (meye.grab_buffer[*i].state != MEYE_BUF_USING)))
+						     (meye.grab_buffer[*i].state != MEYE_BUF_USING))) {
+				up(&meye.lock);
 				return -EINTR;
+			}
 			/* fall through */
 		case MEYE_BUF_DONE:
 			meye.grab_buffer[*i].state = MEYE_BUF_UNUSED;
 			kfifo_get(meye.doneq, (unsigned char *)&unused, sizeof(int));
 		}
+		up(&meye.lock);
 		break;
 	}
 
@@ -1059,20 +1065,25 @@
 		if (*i < 0 || *i >= gbuffers)
 			return -EINVAL;
 
+		down(&meye.lock);
 		switch (meye.grab_buffer[*i].state) {
 
 		case MEYE_BUF_UNUSED:
+			up(&meye.lock);
 			return -EINVAL;
 		case MEYE_BUF_USING:
 			if (wait_event_interruptible(meye.proc_list,
-						     (meye.grab_buffer[*i].state != MEYE_BUF_USING)))
+						     (meye.grab_buffer[*i].state != MEYE_BUF_USING))) {
+				up(&meye.lock);
 				return -EINTR;
+			}
 			/* fall through */
 		case MEYE_BUF_DONE:
 			meye.grab_buffer[*i].state = MEYE_BUF_UNUSED;
 			kfifo_get(meye.doneq, (unsigned char *)&unused, sizeof(int));
 		}
 		*i = meye.grab_buffer[*i].size;
+		up(&meye.lock);
 		break;
 	}
 
