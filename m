Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWDEAAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWDEAAX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWDEAAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:00:23 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:63887
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750950AbWDEAAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:00:22 -0400
Date: Tue, 4 Apr 2006 16:59:39 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org, akpm@osdl.org,
       mgross@linux.intel.com
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 01/26] tlclk: fix handling of device major
Message-ID: <20060404235939.GB27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="tlclk-fix-handling-of-device-major.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Andrew Morton <akpm@osdl.org>

tlclk calls register_chrdev() and permits register_chrdev() to allocate the
major, but it promptly forgets what that major was.  So if there's no hardware
present you still get "telco_clock" appearing in /proc/devices and, I assume,
an oops reading /proc/devices if tlclk was a module.

Fix.

Mark, I'd suggest that that we not call register_chrdev() until _after_ we've
established that the hardware is present.

Cc: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/char/tlclk.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.16.1.orig/drivers/char/tlclk.c
+++ linux-2.6.16.1/drivers/char/tlclk.c
@@ -767,6 +767,7 @@ static int __init tlclk_init(void)
 		printk(KERN_ERR "tlclk: can't get major %d.\n", tlclk_major);
 		return ret;
 	}
+	tlclk_major = ret;
 	alarm_events = kzalloc( sizeof(struct tlclk_alarms), GFP_KERNEL);
 	if (!alarm_events)
 		goto out1;

--
