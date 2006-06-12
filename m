Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWFLRIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWFLRIy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWFLRIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:08:54 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:7082 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750921AbWFLRIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:08:52 -0400
Message-ID: <448D9F96.5030305@fr.ibm.com>
Date: Mon, 12 Jun 2006 19:08:38 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Kirill Korotaev <dev@openvz.org>
CC: Andrew Morton <akpm@osdl.org>, devel@openvz.org, xemul@openvz.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ebiederm@xmission.com, herbert@13thfloor.at, saw@sw.ru,
       serue@us.ibm.com, sfrench@us.ibm.com, sam@vilain.net,
       haveblue@us.ibm.com
Subject: Re: [PATCH 2/6] IPC namespace - utils
References: <44898BF4.4060509@openvz.org> <44898E39.3080801@openvz.org>
In-Reply-To: <44898E39.3080801@openvz.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------070209020203090101050506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070209020203090101050506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Kirill Korotaev wrote:

> +static struct ipc_namespace *clone_ipc_ns(struct ipc_namespace *old_ns)
> +{
> +	int err;
> +	struct ipc_namespace *ns;
> +
> +	err = -ENOMEM;
> +	ns = kmalloc(sizeof(struct ipc_namespace), GFP_KERNEL);
> +	if (ns == NULL)
> +		goto err_mem;
> +
> +	err = sem_init_ns(ns);
> +	if (err)
> +		goto err_sem;
> +	err = msg_init_ns(ns);
> +	if (err)
> +		goto err_msg;
> +	err = shm_init_ns(ns);
> +	if (err)
> +		goto err_shm;
> +
> +	kref_init(&ns->kref);
> +	return ns;
> +
> +err_shm:
> +	msg_exit_ns(ns);
> +err_msg:
> +	sem_exit_ns(ns);
> +err_sem:
> +	kfree(ns);
> +err_mem:
> +	return ERR_PTR(err);
> +}

I've used the ipc namespace patchset in rc6-mm2. Thanks for putting this
together, it works pretty well ! A few questions when we clone :

* We should do something close to what exit_sem() already does to clear the
sem_undo list from the task doing the clone() or unshare().

* I don't like the idea of being able to unshare the ipc namespace and keep
some shared memory from the previous ipc namespace mapped in the process mm.
Should we forbid the unshare ?

Small fix follows,

thanks,

C.

--------------070209020203090101050506
Content-Type: text/x-patch;
 name="ipc-namespace-unshare-fix.patch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipc-namespace-unshare-fix.patch.patch"

From: Cedric Le Goater <clg@fr.ibm.com>
Subject: ipc namespace : unshare fix

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>

---
 kernel/fork.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: 2.6.17-rc6-mm2/kernel/fork.c
===================================================================
--- 2.6.17-rc6-mm2.orig/kernel/fork.c
+++ 2.6.17-rc6-mm2/kernel/fork.c
@@ -1599,7 +1599,8 @@ asmlinkage long sys_unshare(unsigned lon
 	/* Return -EINVAL for all unsupported flags */
 	err = -EINVAL;
 	if (unshare_flags & ~(CLONE_THREAD|CLONE_FS|CLONE_NEWNS|CLONE_SIGHAND|
-				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|CLONE_NEWUTS))
+				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|
+				CLONE_NEWUTS|CLONE_NEWIPC))
 		goto bad_unshare_out;
 
 	if ((err = unshare_thread(unshare_flags)))

--------------070209020203090101050506--
