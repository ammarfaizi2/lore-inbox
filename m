Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264385AbTKURiP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 12:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbTKURiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 12:38:14 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:1001 "EHLO
	segfault.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264385AbTKURiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 12:38:13 -0500
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16318.19844.459348.435288@segfault.boston.redhat.com>
Date: Fri, 21 Nov 2003 12:38:12 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.22] PG_error is not cleared after I/O errors
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Currently, if a device returns an I/O error, the PG_error bit is set in the
page struct, but never cleared.  This patch clears the bit when the page is
not uptodate (and about to be read).  You'll find the same fix in the
2.6 stream of the kernel.

Regards,

Jeff

--- linux-2.4.22/mm/filemap.c.orig	2003-11-21 12:29:26.000000000 -0500
+++ linux-2.4.22/mm/filemap.c	2003-11-21 12:30:16.000000000 -0500
@@ -1491,6 +1491,8 @@
 			UnlockPage(page);
 			goto page_ok;
 		}
+		/* Clear any stale I/O errors */
+		ClearPageError(page);
 
 readpage:
 		/* ... and start the actual read. The read will unlock the page. */
