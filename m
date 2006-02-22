Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWBVVfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWBVVfK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 16:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWBVVfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 16:35:09 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:17880 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751464AbWBVVfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 16:35:07 -0500
Subject: Re: cifs hang patch idea - reduce sendtimeo on socket
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Steve French <smfrench@austin.rr.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060216205623.GA8784@stusta.de>
References: <43F3FA4E.2050608@austin.rr.com>
	 <20060216205623.GA8784@stusta.de>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 15:35:00 -0600
Message-Id: <1140644100.9942.15.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-16 at 21:56 +0100, Adrian Bunk wrote:
> 
> I'm a bit lost now, but I hope this information helps you in finding 
> what is going wrong?

Steve and I think we have figured this out.  In some cases, CIFSSMBRead
was returning a recently freed buffer.

CIFS: CIFSSMBRead was returning an invalid pointer in buf

Thanks to Adrian Bunk for debugging the problem

Also added a fix for 64K pages we found in loosely-related testing

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>
Signed-off-by: Steve French <sfrench@us.ibm.com>

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 38ab9f6..9d7bbd2 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -1076,13 +1076,14 @@ CIFSSMBRead(const int xid, struct cifsTc
 			cifs_small_buf_release(iov[0].iov_base);
 		else if(resp_buf_type == CIFS_LARGE_BUFFER)
 			cifs_buf_release(iov[0].iov_base);
-	} else /* return buffer to caller to free */ /* BB FIXME how do we tell caller if it is not a large buffer */ {
-		*buf = iov[0].iov_base;
+	} else if(resp_buf_type != CIFS_NO_BUFFER) {
+		/* return buffer to caller to free */ 
+		*buf = iov[0].iov_base;		
 		if(resp_buf_type == CIFS_SMALL_BUFFER)
 			*pbuf_type = CIFS_SMALL_BUFFER;
 		else if(resp_buf_type == CIFS_LARGE_BUFFER)
 			*pbuf_type = CIFS_LARGE_BUFFER;
-	}
+	} /* else no valid buffer on return - leave as null */
 
 	/* Note: On -EAGAIN error only caller can retry on handle based calls
 		since file handle passed in no longer valid */
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 0e1560a..16535b5 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1795,10 +1795,10 @@ cifs_mount(struct super_block *sb, struc
 			   conjunction with 52K kvec constraint on arch with 4K
 			   page size  */
 
-		if(cifs_sb->rsize < PAGE_CACHE_SIZE) {
-			cifs_sb->rsize = PAGE_CACHE_SIZE; 
-			/* Windows ME does this */
-			cFYI(1,("Attempt to set readsize for mount to less than one page (4096)"));
+		if(cifs_sb->rsize < 2048) {
+			cifs_sb->rsize = 2048; 
+			/* Windows ME may prefer this */
+			cFYI(1,("readsize set to minimum 2048"));
 		}
 		cifs_sb->mnt_uid = volume_info.linux_uid;
 		cifs_sb->mnt_gid = volume_info.linux_gid;

-- 
David Kleikamp
IBM Linux Technology Center

