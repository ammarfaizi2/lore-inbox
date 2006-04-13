Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbWDMXJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbWDMXJV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWDMXJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:09:18 -0400
Received: from cantor2.suse.de ([195.135.220.15]:37838 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965010AbWDMXI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:08:58 -0400
Date: Thu, 13 Apr 2006 16:07:51 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Miklos Szeredi <miklos@szeredi.hu>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 09/22] fuse: fix oops in fuse_send_readpages()
Message-ID: <20060413230751.GJ5613@kroah.com>
References: <20060413230141.330705000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fuse-fix-oops-in-fuse_send_readpages.patch"
In-Reply-To: <20060413230637.GA5613@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
During heavy parallel filesystem activity it was possible to Oops the
kernel.  The reason is that read_cache_pages() could skip pages which
have already been inserted into the cache by another task.
Occasionally this may result in zero pages actually being sent, while
fuse_send_readpages() relies on at least one page being in the
request.

So check this corner case and just free the request instead of trying
to send it.

Reported and tested by Konstantin Isakov.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/fuse/file.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- linux-2.6.16.5.orig/fs/fuse/file.c
+++ linux-2.6.16.5/fs/fuse/file.c
@@ -397,8 +397,12 @@ static int fuse_readpages(struct file *f
 		return -EINTR;
 
 	err = read_cache_pages(mapping, pages, fuse_readpages_fill, &data);
-	if (!err)
-		fuse_send_readpages(data.req, file, inode);
+	if (!err) {
+		if (data.req->num_pages)
+			fuse_send_readpages(data.req, file, inode);
+		else
+			fuse_put_request(fc, data.req);
+	}
 	return err;
 }
 

--
