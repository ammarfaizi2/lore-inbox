Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264916AbUFHJWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbUFHJWI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 05:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264921AbUFHJWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 05:22:07 -0400
Received: from port-213-148-152-119.reverse.qsc.de ([213.148.152.119]:884 "EHLO
	mbs-software.de") by vger.kernel.org with ESMTP id S264916AbUFHJV7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 05:21:59 -0400
Date: Tue, 8 Jun 2004 11:21:54 +0200
From: Alex Riesen <fork0@users.sf.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] udev 026 release
Message-ID: <20040608092154.GA28969@linux-ari.internal>
Reply-To: Alex Riesen <fork0@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20040607231440.GB11257@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a handle leak in failure path in file_map, and the result of
file_map (or the result of the caller of the file_map) is not always
checked.

--- udev_lib.c	2004-06-08 11:08:35.812419586 +0200
+++ udev_lib.c	2004-06-08 11:10:53.203654065 +0200
@@ -124,11 +124,13 @@ int file_map(const char *filename, char 
 	}
 
 	if (fstat(fd, &stats) < 0) {
+		close(fd);
 		return -1;
 	}
 
 	*buf = mmap(NULL, stats.st_size, PROT_READ, MAP_SHARED, fd, 0);
 	if (*buf == MAP_FAILED) {
+		close(fd);
 		return -1;
 	}
 	*bufsize = stats.st_size;
