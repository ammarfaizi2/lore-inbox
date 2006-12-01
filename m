Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162329AbWLAXY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162329AbWLAXY6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162264AbWLAXYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:24:15 -0500
Received: from cantor.suse.de ([195.135.220.2]:55949 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162248AbWLAXYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:24:03 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Maier <balagi@justmail.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 29/36] sysfs: sysfs_write_file() writes zero terminated data
Date: Fri,  1 Dec 2006 15:21:59 -0800
Message-Id: <11650154221716-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650154181661-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com> <1165015366759-git-send-email-greg@kroah.com> <11650153704007-git-send-email-greg@kroah.com> <11650153733277-git-send-email-greg@kroah.com> <11650153763330-git-send-email-greg@kroah.com> <11650153792132-git-send-email-greg@kroah.com> <11650153833896-git-send-email-greg@kroah.com> <11650153861854-git-send-email-greg@kroah.com> <11650153891878-git-send-email-greg@kroah.com> <11650153
 922117-git-send-email-greg@kroah.com> <11650153961479-git-send-email-greg@kroah.com> <11650154001320-git-send-email-greg@kroah.com> <11650154032080-git-send-email-greg@kroah.com> <11650154071138-git-send-email-greg@kroah.com> <11650154123942-git-send-email-greg@kroah.com> <1165015415131-git-send-email-greg@kroah.com> <11650154181661-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Maier <balagi@justmail.de>

since most of the files in sysfs are text files,
it would be nice, if the "store" function called
during sysfs_write_file() gets a zero terminated
string / data.
The current implementation seems not to ensure this.
(But only if it is the first time the zeroed buffer
page is allocated.)

So the buffer can be scanned by sscanf() easily,
for example.

This patch simply sets a \0 char behind the
data in buffer->page.

Signed-off-by: Thomas Maier <balagi@justmail.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/sysfs/file.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 298303b..95c1651 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -190,6 +190,9 @@ fill_write_buffer(struct sysfs_buffer *
 		count = PAGE_SIZE - 1;
 	error = copy_from_user(buffer->page,buf,count);
 	buffer->needs_read_fill = 1;
+	/* if buf is assumed to contain a string, terminate it by \0,
+	   so e.g. sscanf() can scan the string easily */
+	buffer->page[count] = 0;
 	return error ? -EFAULT : count;
 }
 
-- 
1.4.4.1

