Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVCZMxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVCZMxe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 07:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVCZMxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 07:53:34 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44050 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261776AbVCZMxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 07:53:03 -0500
Date: Sat, 26 Mar 2005 13:53:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jean Delvare <khali@linux-fr.org>
Cc: Urban Widmark <urban@teststation.com>, samba@samba.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [2.6 patch] fs/smbfs/request.c: turn NULL dereference into BUG()
Message-ID: <20050326125301.GA3237@stusta.de>
References: <20050325001540.GF3966@stusta.de> <20050326100253.3edbb2fc.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050326100253.3edbb2fc.khali@linux-fr.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 10:02:53AM +0100, Jean Delvare wrote:

> Hi all,

Hi Jean,

> Patch is broken, see:
> http://bugzilla.kernel.org/show_bug.cgi?id=4403
> 
> Andrew, please back out from -mm.

agreed, thanks for reporting this.

> The smb_request_recv function is a complex one. The NULL dereference
> spotted by Coverity exists, but the fix proposed here doesn't properly
> address the problem.
> 
> The big switch with fallthroughs and breaks all around the place is
> really tricky and hard to understand, admittedly. Not sure it is the
> best approach, BTW, but that's beyond the point.
>...
> The same is true for the SMB_RECV_END and SMB_REQUEST, but according to
> the comment these shouldn't happen anyway. As a side note, I wonder why
> there isn't even a warning thrown in the logs here, as we certainly
> would love to know when something happens that wasn't supposed to.
> 
> My own proposed replacement patch follows. What to do in the
> SMB_RECV_END and SMB_REQUEST (and default?) cases depends on what the
> comment really means. If it means that the case should never happen
> unless there's a bug elsewhere in the kernel, then what I did is
> probably correct. But if the state is received from the outside and we
> have no control on it, then maybe attempting to still process the
> request the best we can might make sense. I don't know, people who do,
> please speak out.
>...

My impression is that your patch is incorrect, too.

The real problem seems to be:

<--   snip  -->

...
                /* We should never be called with any of these states */
        case SMB_RECV_END:
        case SMB_RECV_REQUEST:
                server->rstate = SMB_RECV_END;
                break;
...
        if (server->rstate != SMB_RECV_END)
                return 0;

        result = 0;
        if (req->rq_trans2_command && req->rq_rcls == SUCCESS)
                result = smb_recv_trans2(server, req);
[more code]
...

<--  snip  -->


A second try:

The problem is actually only in the SMB_RECV_END and SMB_RECV_REQUEST 
cases and all code after the NULL pointer dereference is actually dead 
code.

It turned out it removes much code, but unless I've made another mistake 
in understanding the code in question, all it actually does is replacing 
a NULL pointer dereference with a BUG().

The code after the NULL/BUG is also changed by this, but I'd expect that 
in this "impossible" case the problems are bigger and there's no proper 
handling anyway.

> Thanks.
>...

cu
Adrian


<--  snip  -->


In a case documented as

  We should never be called with any of these states

, replace a NULL pointer dereference with a BUG() and remove all code 
that would only have been called after the NULL pointer dereference.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/smbfs/request.c |  171 ---------------------------------------------
 1 files changed, 1 insertion(+), 170 deletions(-)

--- linux-2.6.12-rc1-mm3-full/fs/smbfs/request.c.old	2005-03-26 13:19:19.000000000 +0100
+++ linux-2.6.12-rc1-mm3-full/fs/smbfs/request.c	2005-03-26 13:41:30.000000000 +0100
@@ -564,152 +564,8 @@ out:
 	return result;
 }
 
 /*
- * Receive a transaction2 response
- * Return: 0 if the response has been fully read
- *         1 if there are further "fragments" to read
- *        <0 if there is an error
- */
-static int smb_recv_trans2(struct smb_sb_info *server, struct smb_request *req)
-{
-	unsigned char *inbuf;
-	unsigned int parm_disp, parm_offset, parm_count, parm_tot;
-	unsigned int data_disp, data_offset, data_count, data_tot;
-	int hdrlen = SMB_HEADER_LEN + req->rq_resp_wct*2 - 2;
-
-	VERBOSE("handling trans2\n");
-
-	inbuf = req->rq_header;
-	data_tot    = WVAL(inbuf, smb_tdrcnt);
-	parm_tot    = WVAL(inbuf, smb_tprcnt);
-	parm_disp   = WVAL(inbuf, smb_prdisp);
-	parm_offset = WVAL(inbuf, smb_proff);
-	parm_count  = WVAL(inbuf, smb_prcnt);
-	data_disp   = WVAL(inbuf, smb_drdisp);
-	data_offset = WVAL(inbuf, smb_droff);
-	data_count  = WVAL(inbuf, smb_drcnt);
-
-	/* Modify offset for the split header/buffer we use */
-	if (data_count || data_offset) {
-		if (unlikely(data_offset < hdrlen))
-			goto out_bad_data;
-		else
-			data_offset -= hdrlen;
-	}
-	if (parm_count || parm_offset) {
-		if (unlikely(parm_offset < hdrlen))
-			goto out_bad_parm;
-		else
-			parm_offset -= hdrlen;
-	}
-
-	if (parm_count == parm_tot && data_count == data_tot) {
-		/*
-		 * This packet has all the trans2 data.
-		 *
-		 * We setup the request so that this will be the common
-		 * case. It may be a server error to not return a
-		 * response that fits.
-		 */
-		VERBOSE("single trans2 response  "
-			"dcnt=%u, pcnt=%u, doff=%u, poff=%u\n",
-			data_count, parm_count,
-			data_offset, parm_offset);
-		req->rq_ldata = data_count;
-		req->rq_lparm = parm_count;
-		req->rq_data = req->rq_buffer + data_offset;
-		req->rq_parm = req->rq_buffer + parm_offset;
-		if (unlikely(parm_offset + parm_count > req->rq_rlen))
-			goto out_bad_parm;
-		if (unlikely(data_offset + data_count > req->rq_rlen))
-			goto out_bad_data;
-		return 0;
-	}
-
-	VERBOSE("multi trans2 response  "
-		"frag=%d, dcnt=%u, pcnt=%u, doff=%u, poff=%u\n",
-		req->rq_fragment,
-		data_count, parm_count,
-		data_offset, parm_offset);
-
-	if (!req->rq_fragment) {
-		int buf_len;
-
-		/* We got the first trans2 fragment */
-		req->rq_fragment = 1;
-		req->rq_total_data = data_tot;
-		req->rq_total_parm = parm_tot;
-		req->rq_ldata = 0;
-		req->rq_lparm = 0;
-
-		buf_len = data_tot + parm_tot;
-		if (buf_len > SMB_MAX_PACKET_SIZE)
-			goto out_too_long;
-
-		req->rq_trans2bufsize = buf_len;
-		req->rq_trans2buffer = smb_kmalloc(buf_len, GFP_NOFS);
-		if (!req->rq_trans2buffer)
-			goto out_no_mem;
-		memset(req->rq_trans2buffer, 0, buf_len);
-
-		req->rq_parm = req->rq_trans2buffer;
-		req->rq_data = req->rq_trans2buffer + parm_tot;
-	} else if (unlikely(req->rq_total_data < data_tot ||
-			    req->rq_total_parm < parm_tot))
-		goto out_data_grew;
-
-	if (unlikely(parm_disp + parm_count > req->rq_total_parm ||
-		     parm_offset + parm_count > req->rq_rlen))
-		goto out_bad_parm;
-	if (unlikely(data_disp + data_count > req->rq_total_data ||
-		     data_offset + data_count > req->rq_rlen))
-		goto out_bad_data;
-
-	inbuf = req->rq_buffer;
-	memcpy(req->rq_parm + parm_disp, inbuf + parm_offset, parm_count);
-	memcpy(req->rq_data + data_disp, inbuf + data_offset, data_count);
-
-	req->rq_ldata += data_count;
-	req->rq_lparm += parm_count;
-
-	/*
-	 * Check whether we've received all of the data. Note that
-	 * we use the packet totals -- total lengths might shrink!
-	 */
-	if (req->rq_ldata >= data_tot && req->rq_lparm >= parm_tot) {
-		req->rq_ldata = data_tot;
-		req->rq_lparm = parm_tot;
-		return 0;
-	}
-	return 1;
-
-out_too_long:
-	printk(KERN_ERR "smb_trans2: data/param too long, data=%u, parm=%u\n",
-		data_tot, parm_tot);
-	goto out_EIO;
-out_no_mem:
-	printk(KERN_ERR "smb_trans2: couldn't allocate data area of %d bytes\n",
-	       req->rq_trans2bufsize);
-	req->rq_errno = -ENOMEM;
-	goto out;
-out_data_grew:
-	printk(KERN_ERR "smb_trans2: data/params grew!\n");
-	goto out_EIO;
-out_bad_parm:
-	printk(KERN_ERR "smb_trans2: invalid parms, disp=%u, cnt=%u, tot=%u, ofs=%u\n",
-	       parm_disp, parm_count, parm_tot, parm_offset);
-	goto out_EIO;
-out_bad_data:
-	printk(KERN_ERR "smb_trans2: invalid data, disp=%u, cnt=%u, tot=%u, ofs=%u\n",
-	       data_disp, data_count, data_tot, data_offset);
-out_EIO:
-	req->rq_errno = -EIO;
-out:
-	return req->rq_errno;
-}
-
-/*
  * State machine for receiving responses. We handle the fact that we can't
  * read the full response in one try by having states telling us how much we
  * have read.
  *
@@ -785,39 +641,14 @@ int smb_request_recv(struct smb_sb_info 
 
 		/* We should never be called with any of these states */
 	case SMB_RECV_END:
 	case SMB_RECV_REQUEST:
-		server->rstate = SMB_RECV_END;
-		break;
+		BUG();
 	}
 
 	if (result < 0) {
 		/* We saw an error */
 		return result;
 	}
 
-	if (server->rstate != SMB_RECV_END)
-		return 0;
-
-	result = 0;
-	if (req->rq_trans2_command && req->rq_rcls == SUCCESS)
-		result = smb_recv_trans2(server, req);
-
-	/*
-	 * Response completely read. Drop any extra bytes sent by the server.
-	 * (Yes, servers sometimes add extra bytes to responses)
-	 */
-	VERBOSE("smb_len: %d   smb_read: %d\n",
-		server->smb_len, server->smb_read);
-	if (server->smb_read < server->smb_len)
-		smb_receive_drop(server);
-
-	server->rstate = SMB_RECV_START;
-
-	if (!result) {
-		list_del_init(&req->rq_queue);
-		req->rq_flags |= SMB_REQ_RECEIVED;
-		smb_rput(req);
-		wake_up_interruptible(&req->rq_wait);
-	}
 	return 0;
 }

