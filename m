Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVCWJMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVCWJMR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 04:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbVCWJJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 04:09:35 -0500
Received: from alt.aurema.com ([203.217.18.57]:34494 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262889AbVCWJHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 04:07:30 -0500
Date: Wed, 23 Mar 2005 20:02:54 +1100
From: kingsley@aurema.com
To: Tom Zanussi <zanussi@us.ibm.com>, Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel@vger.kernel.org
Subject: read() on relayfs channel returns premature 0
Message-ID: <20050323090254.GA10630@aurema.com>
Mail-Followup-To: Tom Zanussi <zanussi@us.ibm.com>,
	Karim Yaghmour <karim@opersys.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi 

I'm using relayfs to relay data from a kernel module to user space on
a SuSE 2.6.5 kernel.  I'm not absolutely sure what version of relayfs
has been back ported to it.

While reading data from the channel I've been seeing read() return 0
prematurely.  However, the 0 does not signify that the file is being
closed for there is still data available afterwards.  

I've noticed that zeros occur when roughly one page of data has been
read.  I suspect that they occur whenever there is a read across the
relayfs sub-buffers.

Now I understand that this is not the latest release of relayfs (there
are the redux patches, which I have yet to try).  Nonetheless I'd like
to know whether this behaviour is deliberate.  Is it? 

Thanks,
-- 
		Kingsley

P.S. I've been able to get around this by deliberately modifying
do_read() with the attached patch.  I'm not absolutely sure its
correct but it seems to work.

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="relayfs-premature-zero.patch"

Index: fs/relayfs/relay.c
===================================================================
RCS file: /export/cvsroot/SuSE-Kernel-2.4.21/fs/relayfs/Attic/relay.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 relay.c
--- fs/relayfs/relay.c	18 Feb 2005 00:00:51 -0000	1.1.2.1
+++ fs/relayfs/relay.c	23 Mar 2005 09:00:42 -0000
@@ -1445,26 +1445,22 @@
 
 	avail_offset = cur_idx = relay_get_offset(rchan, &max_offset);
 
+	last_buf_byte_offset = (read_bufno + 1) * buf_size - 1;
 	if (cur_idx == read_offset) {
 		if (atomic_read(&rchan->suspended) == 1) {
-			read_offset += 1;
+			read_offset = last_buf_byte_offset + 1;
 			if (read_offset >= max_offset)
 				read_offset = 0;
 			*actual_read_offset = read_offset;
 		} else {
-			*new_offset = read_offset;
+			*new_offset = read_offset; 
 			return 0;
 		}
-	} else {
-		last_buf_byte_offset = (read_bufno + 1) * buf_size - 1;
-		if (read_offset == last_buf_byte_offset) {
-			if (unused_bytes != 1) {
-				read_offset += 1;
-				if (read_offset >= max_offset)
-					read_offset = 0;
-				*actual_read_offset = read_offset;
-			}
-		}
+	} else if ((read_offset + unused_bytes) > last_buf_byte_offset) {
+		read_offset = last_buf_byte_offset + 1;
+		if (read_offset >= max_offset)
+			read_offset = 0;
+		*actual_read_offset = read_offset;
 	}
 
 	read_bufno = read_offset / buf_size;

--qMm9M+Fa2AknHoGS--
