Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264647AbUEENOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbUEENOg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 09:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUEENOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 09:14:36 -0400
Received: from ns.suse.de ([195.135.220.2]:61836 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264647AbUEENMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 09:12:53 -0400
Date: Wed, 5 May 2004 15:12:52 +0200
From: Olaf Dabrunz <od@suse.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] report size of printk buffer
Message-ID: <20040505131252.GA23800@suse.de>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	Andries.Brouwer@cwi.nl
References: <UTC200405041609.i44G9CH29412.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <UTC200405041609.i44G9CH29412.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-May-04, Andries.Brouwer@cwi.nl wrote:
> In the old days the printk log buffer had a constant size,
> and dmesg asked for the 4096, later 8192, later 16384 bytes in there.
> These days the printk log buffer has variable size, and it is not
> easy for dmesg to do the right thing, especially when doing a
> "read and clear".
> The patch below adds a syslog subfuntion that reports the buffer size.
> 
> [...]

Please also consider allowing everyone to read the ring buffer size.
This way dmesg will continue to behave the same for users and root when
they read the log buffer. (And other options will continue to be denied
to the user.)

Please note that users are already allowed to read the ring buffer (case
3).

Short security analysis:
There is no dynamic information provided. So system behaviour cannot be
infered from reading the ring buffer size.

The information provided can already be infered from the architecture and
release of the distribution. And there are other methods as well.

--- ./security/selinux/hooks.c	2004-05-04 16:36:25.000000000 +0200
+++ ./security/selinux/hooks.c	2004-05-04 16:36:27.000000000 +0200
@@ -1467,6 +1467,7 @@
 
 	switch (type) {
 		case 3:         /* Read last kernel messages */
+		case 10:        /* Return size of the log buffer */
 			rc = task_has_system(current, SYSTEM__SYSLOG_READ);
 			break;
 		case 6:         /* Disable logging to console */
--- ./security/commoncap.c	2004-05-04 17:26:08.758271491 +0200
+++ ./security/commoncap.c	2004-05-04 17:25:05.256269096 +0200
@@ -293,7 +293,7 @@
 
 int cap_syslog (int type)
 {
-	if ((type != 3) && !capable(CAP_SYS_ADMIN))
+	if ((type != 3 && type != 10) && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	return 0;
 }
--- ./security/dummy.c	2004-05-04 16:36:38.000000000 +0200
+++ ./security/dummy.c	2004-05-04 16:34:22.000000000 +0200
@@ -97,7 +97,7 @@
 
 static int dummy_syslog (int type)
 {
-	if ((type != 3) && current->euid)
+	if ((type != 3 && type != 10) && current->euid)
 		return -EPERM;
 	return 0;
 }

-- 
Olaf Dabrunz (od/odabrunz), SUSE Linux AG, Nürnberg

