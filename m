Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbTISXEa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 19:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTISXEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 19:04:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:40591 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261800AbTISXEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 19:04:24 -0400
Date: Fri, 19 Sep 2003 16:04:14 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Yu Chen <dychen@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, sds@epoch.ncsc.mil
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030919160414.I27079@osdlab.pdx.osdl.net>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>; from dychen@stanford.edu on Mon, Sep 15, 2003 at 09:35:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Yu Chen (dychen@stanford.edu) wrote:
> [FILE:  2.6.0-test5/security/selinux/ss/mls.c]
> [VAR:   r]
>  538:		goto out;
>  539:	}
>  540:	nel = le32_to_cpu(buf[0]);
>  541:	l = NULL;
>  542:	for (i = 0; i < nel; i++) {
> START -->
>  543:		r = kmalloc(sizeof(*r), GFP_ATOMIC);
>  544:		if (!r) {
>  545:			rc = -ENOMEM;
>  546:			goto out;
>  547:		}
>  548:		memset(r, 0, sizeof(*r));
>  549:
>  550:		rc = mls_read_range_helper(&r->range, fp);
>  551:		if (rc)
> GOTO -->
>  552:			goto out;

Yes, this looks like a bug.  Stephen, does this fix look ok?
thanks
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net


===== security/selinux/ss/mls.c 1.1 vs edited =====
--- 1.1/security/selinux/ss/mls.c	Thu Jul 17 02:38:01 2003
+++ edited/security/selinux/ss/mls.c	Fri Sep 19 13:56:50 2003
@@ -548,8 +548,10 @@
 		memset(r, 0, sizeof(*r));
 
 		rc = mls_read_range_helper(&r->range, fp);
-		if (rc)
+		if (rc) {
+			kfree(r);
 			goto out;
+		}
 
 		if (l)
 			l->next = r;
