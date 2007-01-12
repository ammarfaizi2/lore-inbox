Return-Path: <linux-kernel-owner+w=401wt.eu-S932229AbXALQc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbXALQc0 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 11:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbXALQcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 11:32:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37044 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932228AbXALQcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 11:32:24 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Steven Fernandez <sfernand@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: [patch] raw: don't allow the creation of a raw device with minor number 0
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
From: Jeff Moyer <jmoyer@redhat.com>
Date: Fri, 12 Jan 2007 11:32:11 -0500
Message-ID: <x49bql48aus.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Minor number 0 (under the raw major) is reserved for the rawctl device
file, which is used to query, set, and unset raw device bindings.
However, the ioctl interface does not protect the user from specifying
a raw device with minor number 0:

$ sudo ./raw /dev/raw/raw0 /dev/VolGroup00/swap
/dev/raw/raw0:  bound to major 253, minor 2
$ ls -l /dev/rawctl
ls: /dev/rawctl: No such file or directory
$ ls -l /dev/raw/raw0 
crw------- 1 root root 162, 0 Jan 12 10:51 /dev/raw/raw0
$ sudo ./raw -qa
Cannot open master raw device '/dev/rawctl' (No such file or directory)

As you can see, this prevents any further raw operations from
succeeding.  The fix (from Steve Fernandez) is quite simple--do not
allow the allocation of minor number 0.

Thanks!

Jeff

diff --git a/drivers/char/raw.c b/drivers/char/raw.c
index 645e20a..1f0d7c6 100644
--- a/drivers/char/raw.c
+++ b/drivers/char/raw.c
@@ -154,7 +154,7 @@ static int raw_ctl_ioctl(struct inode *i
 			goto out;
 		}
 
-		if (rq.raw_minor < 0 || rq.raw_minor >= MAX_RAW_MINORS) {
+		if (rq.raw_minor <= 0 || rq.raw_minor >= MAX_RAW_MINORS) {
 			err = -EINVAL;
 			goto out;
 		}
