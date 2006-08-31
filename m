Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWHaL7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWHaL7N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 07:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWHaL7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 07:59:13 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:8892 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750727AbWHaL7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 07:59:12 -0400
Date: Thu, 31 Aug 2006 06:59:07 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Pavel <xemul@openvz.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Serge Hallyn <serue@us.ibm.com>, ebiederm@xmission.com, clg@fr.ibm.com,
       Kirill Korotaev <dev@openvz.org>
Subject: Re: [PATCH] nsproxy cloning error path fix
Message-ID: <20060831115906.GA26365@sergelap.austin.ibm.com>
References: <44F6B846.9090405@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F6B846.9090405@openvz.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pavel (xemul@openvz.org):
> This patch fixes copy_namespaces()'s error path.
> 
> when new nsproxy (new_ns) is created pointers to namespaces (ipc, uts)
> are copied from the old nsproxy. Later in copy_utsname, copy_ipcs, etc.
> according namespaces are get-ed. On error path needed namespaces are
> put-ed, so there's no need to put new nsproxy itelf as it woud cause
> putting namespaces for the second time.
> 
> Found when incorporating namespaces into OpenVZ kernel.
> 
> Signed-off-by: Pavel Emelianov <xemul@openvz.org>

Acked-by: Serge Hallyn <serue@us.ibm.com>

> ---
> 
>  nsproxy.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> --- ./kernel/nsproxy.c.veboot	2006-08-30 17:48:59.000000000 +0400
> +++ ./kernel/nsproxy.c	2006-08-31 10:54:56.000000000 +0400
> @@ -115,7 +115,7 @@ out_uts:
>  		put_namespace(new_ns->namespace);
>  out_ns:
>  	tsk->nsproxy = old_ns;
> -	put_nsproxy(new_ns);
> +	kfree(new_ns);
>  	goto out;
>  }

Yes, thanks.

The logic has subtly changed since the last version I'd sent out.  I
have tests which should have caught this, and need to start firing off
jobs to periodically test them against -mm.

In fact I notice that it is currently no longer putting old_ns on the
error path.  Seems to me the following patch should be needed on top
of yours.

Meanwhile I'll start firing off a test against v2.6.18-rc4-mm3.

thanks,
-serge

>From c4d187c3c1534c22e7879d52eeceed55412c9559 Mon Sep 17 00:00:00 2001
From: Serge E. Hallyn <serue@us.ibm.com>
Date: Thu, 31 Aug 2006 06:54:15 -0500
Subject: [PATCH 1/1] nsproxy: free the old_ns on copy_namespaces error

copy_namespaces increments the usage count on old_ns at top.
On successful exit it properly decrements that usage count.
On error path it failed to do so.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 kernel/nsproxy.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index e25d97c..575155a 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -121,6 +121,7 @@ out_uts:
 out_ns:
 	tsk->nsproxy = old_ns;
 	kfree(new_ns);
+	put_nsproxy(old_ns);
 	goto out;
 }
 
-- 
1.4.2

