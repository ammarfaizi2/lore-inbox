Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbTIWUPT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 16:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbTIWUPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 16:15:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:61575 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262190AbTIWUPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 16:15:01 -0400
Date: Tue, 23 Sep 2003 13:14:53 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Yu Chen <dychen@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu,
       trond.myklebust@fys.uio.no
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030923131453.G20572@osdlab.pdx.osdl.net>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>; from dychen@stanford.edu on Mon, Sep 15, 2003 at 09:35:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Yu Chen (dychen@stanford.edu) wrote:
> [FILE:  2.6.0-test5/net/sunrpc/auth_gss/gss_mech_switch.c]
> START -->
>   67:	if (!(gm = kmalloc(sizeof(*gm), GFP_KERNEL))) {
>   68:		printk("Failed to allocate memory in gss_mech_register");
>   69:		return -1;
>   70:	}
>   71:	gm->gm_oid.len = mech_type->len;
>   72:	if (!(gm->gm_oid.data = kmalloc(mech_type->len, GFP_KERNEL))) {
>   73:		printk("Failed to allocate memory in gss_mech_register");
> END -->
>   74:		return -1;
<snip>
> [FILE:  2.6.0-test5/net/sunrpc/auth_gss/gss_pseudoflavors.c]
> [FUNC:  gss_register_triple]
> START -->
>   74:	if (!(triple = kmalloc(sizeof(*triple), GFP_KERNEL))) {
>   75:		printk("Alloc failed in gss_register_triple");
> GOTO -->
>   86:		goto err_unlock;
> END -->
>   97:	return -1;

Yes, these are both bugs.  Patch below.  Trond, this look ok?

thanks,
-chris

===== net/sunrpc/auth_gss/gss_mech_switch.c 1.2 vs edited =====
--- 1.2/net/sunrpc/auth_gss/gss_mech_switch.c	Wed Jun 11 19:25:40 2003
+++ edited/net/sunrpc/auth_gss/gss_mech_switch.c	Tue Sep 23 12:18:26 2003
@@ -71,6 +71,7 @@
 	gm->gm_oid.len = mech_type->len;
 	if (!(gm->gm_oid.data = kmalloc(mech_type->len, GFP_KERNEL))) {
 		printk("Failed to allocate memory in gss_mech_register");
+		kfree(gm);
 		return -1;
 	}
 	memcpy(gm->gm_oid.data, mech_type->data, mech_type->len);
===== net/sunrpc/auth_gss/gss_pseudoflavors.c 1.1 vs edited =====
--- 1.1/net/sunrpc/auth_gss/gss_pseudoflavors.c	Sun Jan 12 13:40:13 2003
+++ edited/net/sunrpc/auth_gss/gss_pseudoflavors.c	Tue Sep 23 12:24:47 2003
@@ -93,6 +93,7 @@
 
 err_unlock:
 	spin_unlock(&registered_triples_lock);
+	kfree(triple);
 err:
 	return -1;
 }
