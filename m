Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVCZJDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVCZJDP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 04:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVCZJDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 04:03:15 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:17669 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261697AbVCZJCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 04:02:55 -0500
Date: Sat, 26 Mar 2005 10:02:53 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Urban Widmark <urban@teststation.com>, samba@samba.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] fs/smbfs/request.c: fix NULL dereference
Message-Id: <20050326100253.3edbb2fc.khali@linux-fr.org>
In-Reply-To: <20050325001540.GF3966@stusta.de>
References: <20050325001540.GF3966@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> The Coverity checker found that if req was NULL because find_request 
> returned NULL, this resulted in a break from the switch, but req was 
> later dereferenced (look at the last line of this patch).
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.12-rc1-mm2-full/fs/smbfs/request.c.old	2005-03-25 00:45:08.000000000 +0100
> +++ linux-2.6.12-rc1-mm2-full/fs/smbfs/request.c	2005-03-25 00:47:14.000000000 +0100
> @@ -783,20 +783,23 @@ int smb_request_recv(struct smb_sb_info 
>  			break;
>  		break;
>  
>  		/* We should never be called with any of these states */
>  	case SMB_RECV_END:
>  	case SMB_RECV_REQUEST:
>  		server->rstate = SMB_RECV_END;
>  		break;
>  	}
>  
> +	if (!req)
> +		return -ENOMEM;
> +
>  	if (result < 0) {
>  		/* We saw an error */
>  		return result;
>  	}
>  
>  	if (server->rstate != SMB_RECV_END)
>  		return 0;
>  
>  	result = 0;
>  	if (req->rq_trans2_command && req->rq_rcls == SUCCESS)

Patch is broken, see:
http://bugzilla.kernel.org/show_bug.cgi?id=4403

Andrew, please back out from -mm.

The smb_request_recv function is a complex one. The NULL dereference
spotted by Coverity exists, but the fix proposed here doesn't properly
address the problem.

The big switch with fallthroughs and breaks all around the place is
really tricky and hard to understand, admittedly. Not sure it is the
best approach, BTW, but that's beyond the point.

The problem with the patch proposed by Adrian is that it sometimes
breaks (ah ah) in the SMB_RECV_DROP, SMB_RECV_START and SMB_RECV_HEADER
cases, because req was initialized to NULL in the first place, and is
not touched in these cases. That's not a problem if we fall through the
switch cases down to at least SMB_RECV_COMPLETE, which will attempt to
allocate req, but we might as well exit in one the five early breaks in
SMB_RECV_DROP and SMB_RECV_HEADER. If we do, we'll get caught by the
check Adrian added, and -ENOMEM will be returned, while no memory
allocation was attempted!

The same is true for the SMB_RECV_END and SMB_REQUEST, but according to
the comment these shouldn't happen anyway. As a side note, I wonder why
there isn't even a warning thrown in the logs here, as we certainly
would love to know when something happens that wasn't supposed to.

My own proposed replacement patch follows. What to do in the
SMB_RECV_END and SMB_REQUEST (and default?) cases depends on what the
comment really means. If it means that the case should never happen
unless there's a bug elsewhere in the kernel, then what I did is
probably correct. But if the state is received from the outside and we
have no control on it, then maybe attempting to still process the
request the best we can might make sense. I don't know, people who do,
please speak out.

Patch testing in progress here, so far so good, and no warning message
in the logs either.

Thanks.

--- linux-2.6.12-rc1-mm3/fs/smbfs/request.c.orig	2005-03-26 08:39:48.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/smbfs/request.c	2005-03-26 09:48:24.000000000 +0100
@@ -754,8 +754,10 @@
 		/* fallthrough */
 	case SMB_RECV_HCOMPLETE:
 		req = find_request(server, WVAL(server->header, smb_mid));
-		if (!req)
+		if (!req) {
+			result = -ENOMEM;
 			break;
+		}
 		smb_init_request(server, req);
 		req->rq_rcls = *(req->rq_header + smb_rcls);
 		req->rq_err  = WVAL(req->rq_header, smb_err);
@@ -765,8 +767,10 @@
 	case SMB_RECV_PARAM:
 		if (!req)
 			req = find_request(server,WVAL(server->header,smb_mid));
-		if (!req)
+		if (!req) {
+			result = -ENOMEM;
 			break;
+		}
 		result = smb_recv_param(server, req);
 		if (result < 0)
 			break;
@@ -776,8 +780,10 @@
 	case SMB_RECV_DATA:
 		if (!req)
 			req = find_request(server,WVAL(server->header,smb_mid));
-		if (!req)
+		if (!req) {
+			result = -ENOMEM;
 			break;
+		}
 		result = smb_recv_data(server, req);
 		if (result < 0)
 			break;
@@ -786,8 +792,10 @@
 		/* We should never be called with any of these states */
 	case SMB_RECV_END:
 	case SMB_RECV_REQUEST:
-		server->rstate = SMB_RECV_END;
-		break;
+	default:
+		printk(KERN_WARNING "smbfs: unexpected server->rstate %d\n",
+		       server->rstate);
+		result = -EINVAL;
 	}
 
 	if (result < 0) {


-- 
Jean Delvare
