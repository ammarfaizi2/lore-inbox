Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUBTVHb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 16:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbUBTVFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 16:05:04 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:12493 "EHLO
	ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S261414AbUBTVDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 16:03:37 -0500
Date: Fri, 20 Feb 2004 16:03:24 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, brugolsky@telemetry-investments.com
Subject: [PATCH][3/4] poll()/select() timeout behavior
Message-ID: <20040220210324.GD1912@ti19.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes select() and poll() to not wait forever when a valid,
but large timeout value is supplied.  The SUSv3 manual page for select(2)
states:

  "If the timeout argument specifies a timeout interval greater than the
  implementation-defined maximum value, the maximum value shall be used as
  the actual timeout value."

Both select() and poll() have a well-defined mechanism to wait forever,
so there is no need for the existing behavior.

Please apply.

    Bill Rugolsky
            
--- linux/fs/select.c	2004-02-20 14:27:24.784616879 -0500
+++ linux/fs/select.c	2004-02-20 14:27:28.264660774 -0500
@@ -316,6 +316,8 @@
 		if ((unsigned long) sec < (MAX_SCHEDULE_TIMEOUT-1) / HZ - 1) {
 			timeout = ROUND_UP(usec, 1000000/HZ);
 			timeout += sec * (unsigned long) HZ;
+		} else {
+			timeout = MAX_SCHEDULE_TIMEOUT-1;
 		}
 	}
 
@@ -476,7 +478,7 @@
 			if (seconds <= (MAX_SCHEDULE_TIMEOUT-2) / HZ - 1)
 				timeout += seconds*HZ;
 			else
-				timeout = MAX_SCHEDULE_TIMEOUT;
+				timeout = MAX_SCHEDULE_TIMEOUT-1;
 		}
 	}
 
