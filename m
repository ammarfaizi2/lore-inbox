Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbUKWCl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUKWCl0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 21:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbUKWCkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 21:40:41 -0500
Received: from siaag2ac.compuserve.com ([149.174.40.133]:60366 "EHLO
	siaag2ac.compuserve.com") by vger.kernel.org with ESMTP
	id S262546AbUKWCiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 21:38:25 -0500
Date: Mon, 22 Nov 2004 21:35:42 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [PATCH] SMB security fixes for 2.6.9
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200411222138_MC3-1-8F38-414@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  The SMB patch in 2.6.9-ac10 is broken.  When a reply is received and it
contains no data (only parms), the data_offset is zero.  Since no data will
be copied, zero offset is perfectly valid.  This patch, based on the one in
-ac, works for me.  I also cleaned up the message printing (%u vs. %d for
unsigned), added unlikely() where appropriate, and removed some extra code.

Comments welcome.  Like I said, at least I can use SMB servers now.
With the original patch very bad things happened, like trying to save
files from a text editor truncated them to 0 bytes, followed by editor
freezing for many seconds then asking for a new name to save the file as.


diff -upr linux-2.6.9/fs/smbfs/proc.c linux-2.6.9.1-pre3/fs/smbfs/proc.c
--- linux-2.6.9/fs/smbfs/proc.c	2004-10-19 15:28:35.000000000 -0400
+++ linux-2.6.9.1-pre3/fs/smbfs/proc.c	2004-11-21 02:26:04.000000000 -0500
@@ -1427,9 +1427,9 @@ smb_proc_readX_data(struct smb_request *
 	 * So we must first calculate the amount of padding used by the server.
 	 */
 	data_off -= hdrlen;
-	if (data_off > SMB_READX_MAX_PAD) {
-		PARANOIA("offset is larger than max pad!\n");
-		PARANOIA("%d > %d\n", data_off, SMB_READX_MAX_PAD);
+	if (data_off > SMB_READX_MAX_PAD || data_off < 0) {
+		PARANOIA("offset is larger than SMB_READX_MAX_PAD or negative!\n");
+		PARANOIA("%d > %d || %d < 0\n", data_off, SMB_READX_MAX_PAD, data_off);
 		req->rq_rlen = req->rq_bufsize + 1;
 		return;
 	}
diff -upr linux-2.6.9/fs/smbfs/request.c linux-2.6.9.1-pre3/fs/smbfs/request.c
--- linux-2.6.9/fs/smbfs/request.c	2004-10-19 15:33:10.000000000 -0400
+++ linux-2.6.9.1-pre3/fs/smbfs/request.c	2004-11-22 18:01:42.000000000 -0500
@@ -588,8 +588,18 @@ static int smb_recv_trans2(struct smb_sb
 	data_count  = WVAL(inbuf, smb_drcnt);
 
 	/* Modify offset for the split header/buffer we use */
-	data_offset -= hdrlen;
-	parm_offset -= hdrlen;
+	if (data_count || data_offset) {
+		if (unlikely(data_offset < hdrlen))
+			goto out_bad_data;
+		else
+			data_offset -= hdrlen;
+	}
+	if (parm_count || parm_offset) {
+		if (unlikely(parm_offset < hdrlen))
+			goto out_bad_parm;
+		else
+			parm_offset -= hdrlen;
+	}
 
 	if (parm_count == parm_tot && data_count == data_tot) {
 		/*
@@ -600,18 +610,22 @@ static int smb_recv_trans2(struct smb_sb
 		 * response that fits.
 		 */
 		VERBOSE("single trans2 response  "
-			"dcnt=%d, pcnt=%d, doff=%d, poff=%d\n",
+			"dcnt=%u, pcnt=%u, doff=%u, poff=%u\n",
 			data_count, parm_count,
 			data_offset, parm_offset);
 		req->rq_ldata = data_count;
 		req->rq_lparm = parm_count;
 		req->rq_data = req->rq_buffer + data_offset;
 		req->rq_parm = req->rq_buffer + parm_offset;
+		if (unlikely(parm_offset + parm_count > req->rq_rlen))
+			goto out_bad_parm;
+		if (unlikely(data_offset + data_count > req->rq_rlen))
+			goto out_bad_data;
 		return 0;
 	}
 
 	VERBOSE("multi trans2 response  "
-		"frag=%d, dcnt=%d, pcnt=%d, doff=%d, poff=%d\n",
+		"frag=%d, dcnt=%u, pcnt=%u, doff=%u, poff=%u\n",
 		req->rq_fragment,
 		data_count, parm_count,
 		data_offset, parm_offset);
@@ -634,16 +648,20 @@ static int smb_recv_trans2(struct smb_sb
 		req->rq_trans2buffer = smb_kmalloc(buf_len, GFP_NOFS);
 		if (!req->rq_trans2buffer)
 			goto out_no_mem;
+		memset(req->rq_trans2buffer, 0, buf_len);
 
 		req->rq_parm = req->rq_trans2buffer;
 		req->rq_data = req->rq_trans2buffer + parm_tot;
-	} else if (req->rq_total_data < data_tot ||
-		   req->rq_total_parm < parm_tot)
+	} else if (unlikely(req->rq_total_data < data_tot ||
+			    req->rq_total_parm < parm_tot))
 		goto out_data_grew;
 
-	if (parm_disp + parm_count > req->rq_total_parm)
+	if (unlikely(parm_disp + parm_count > req->rq_total_parm ||
+		     parm_offset + parm_count > req->rq_rlen))
 		goto out_bad_parm;
-	if (data_disp + data_count > req->rq_total_data)
+
+	if (unlikely(data_disp + data_count > req->rq_total_data ||
+		     data_offset + data_count > req->rq_rlen))
 		goto out_bad_data;
 
 	inbuf = req->rq_buffer;
@@ -657,15 +675,17 @@ static int smb_recv_trans2(struct smb_sb
 	 * Check whether we've received all of the data. Note that
 	 * we use the packet totals -- total lengths might shrink!
 	 */
-	if (req->rq_ldata >= data_tot && req->rq_lparm >= parm_tot)
+	if (req->rq_ldata >= data_tot && req->rq_lparm >= parm_tot) {
+		req->rq_ldata = data_tot;
+		req->rq_lparm = parm_tot;
 		return 0;
+	}
 	return 1;
 
 out_too_long:
-	printk(KERN_ERR "smb_trans2: data/param too long, data=%d, parm=%d\n",
+	printk(KERN_ERR "smb_trans2: data/param too long, data=%u, parm=%u\n",
 		data_tot, parm_tot);
-	req->rq_errno = -EIO;
-	goto out;
+	goto out_EIO;
 out_no_mem:
 	printk(KERN_ERR "smb_trans2: couldn't allocate data area of %d bytes\n",
 	       req->rq_trans2bufsize);
@@ -673,16 +693,15 @@ out_no_mem:
 	goto out;
 out_data_grew:
 	printk(KERN_ERR "smb_trans2: data/params grew!\n");
-	req->rq_errno = -EIO;
-	goto out;
+	goto out_EIO;
 out_bad_parm:
-	printk(KERN_ERR "smb_trans2: invalid parms, disp=%d, cnt=%d, tot=%d\n",
-	       parm_disp, parm_count, parm_tot);
-	req->rq_errno = -EIO;
-	goto out;
+	printk(KERN_ERR "smb_trans2: invalid parms, disp=%u, cnt=%u, tot=%u, ofs=%u\n",
+	       parm_disp, parm_count, parm_tot, parm_offset);
+	goto out_EIO;
 out_bad_data:
-	printk(KERN_ERR "smb_trans2: invalid data, disp=%d, cnt=%d, tot=%d\n",
-	       data_disp, data_count, data_tot);
+	printk(KERN_ERR "smb_trans2: invalid data, disp=%u, cnt=%u, tot=%u, ofs=%u\n",
+	       data_disp, data_count, data_tot, data_offset);
+out_EIO:
 	req->rq_errno = -EIO;
 out:
 	return req->rq_errno;
_

--Chuck Ebbert  22-Nov-04  19:18:11
