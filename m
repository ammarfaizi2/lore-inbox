Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965278AbWFIPUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965278AbWFIPUX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965283AbWFIPUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:20:23 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:23445 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965278AbWFIPUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:20:22 -0400
Message-ID: <448991AF.2060503@fr.ibm.com>
Date: Fri, 09 Jun 2006 17:20:15 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Kirill Korotaev <dev@openvz.org>
CC: Andrew Morton <akpm@osdl.org>, devel@openvz.org, xemul@openvz.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ebiederm@xmission.com, herbert@13thfloor.at, saw@sw.ru,
       serue@us.ibm.com, sfrench@us.ibm.com, sam@vilain.net,
       haveblue@us.ibm.com
Subject: Re: [PATCH 1/6] IPC namespace core
References: <44898BF4.4060509@openvz.org> <44898D52.4080506@openvz.org>
In-Reply-To: <44898D52.4080506@openvz.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------040601050404050504090403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040601050404050504090403
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Kirill Korotaev wrote:
> This patch implements core IPC namespace changes:
> - ipc_namespace structure
> - new config option CONFIG_IPC_NS
> - adds CLONE_NEWIPC flag
> - unshare support
> 
> Signed-Off-By: Pavel Emelianov <xemul@openvz.org>
> Signed-Off-By: Kirill Korotaev <dev@openvz.org>
> 
> 
> ------------------------------------------------------------------------
> 
> --- ./include/linux/init_task.h.ipcns	2006-06-06 14:47:58.000000000 +0400
> +++ ./include/linux/init_task.h	2006-06-08 14:28:23.000000000 +0400
> @@ -73,6 +73,7 @@ extern struct nsproxy init_nsproxy;
>  	.count		= ATOMIC_INIT(1),				\
>  	.nslock		= SPIN_LOCK_UNLOCKED,				\
>  	.uts_ns		= &init_uts_ns,					\
> +	.ipc_ns		= &init_ipc_ns,					\
>  	.namespace	= NULL,						\
>  }
>  
> --- ./include/linux/ipc.h.ipcns	2006-04-21 11:59:36.000000000 +0400
> +++ ./include/linux/ipc.h	2006-06-08 15:43:43.000000000 +0400
> @@ -2,6 +2,7 @@
>  #define _LINUX_IPC_H
>  
>  #include <linux/types.h>
> +#include <linux/kref.h>
>  
>  #define IPC_PRIVATE ((__kernel_key_t) 0)  
>  
> @@ -68,6 +69,41 @@ struct kern_ipc_perm
>  	void		*security;
>  };
>  
> +struct ipc_ids;
> +struct ipc_namespace {
> +	struct kref	kref;
> +	struct ipc_ids	*ids[3];
> +
> +	int		sem_ctls[4];
> +	int		used_sems;
> +
> +	int		msg_ctlmax;
> +	int		msg_ctlmnb;
> +	int		msg_ctlmni;
> +
> +	size_t		shm_ctlmax;
> +	size_t		shm_ctlall;
> +	int		shm_ctlmni;
> +	int		shm_tot;
> +};

you could probably simplify your patch by moving struct ipc_ids to ipc.h
and not allocating ids.

see patch bellow. I've been working all week on this patchset :)

C.




--------------040601050404050504090403
Content-Type: text/x-patch;
 name="namespaces-sysvipc-move-struct-ipc-ids.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="namespaces-sysvipc-move-struct-ipc-ids.patch"

From: Cedric Le Goater <clg@fr.ibm.com>
Subject: namespaces sysvipc : move struct ipc_ids to ipc.h  

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>

---
 include/linux/ipc.h |   17 +++++++++++++++++
 ipc/util.h          |   15 ---------------
 2 files changed, 17 insertions(+), 15 deletions(-)

Index: 2.6.17-rc5-mm3/include/linux/ipc.h
===================================================================
--- 2.6.17-rc5-mm3.orig/include/linux/ipc.h
+++ 2.6.17-rc5-mm3/include/linux/ipc.h
@@ -51,6 +51,8 @@ struct ipc_perm
 
 #ifdef __KERNEL__
 
+#include <linux/mutex.h>
+
 #define IPCMNI 32768  /* <= MAX_INT limit for ipc arrays (including sysctl changes) */
 
 /* used by in-kernel data structures */
@@ -68,6 +70,21 @@ struct kern_ipc_perm
 	void		*security;
 };
 
+struct ipc_id_ary {
+	int size;
+	struct kern_ipc_perm *p[0];
+};
+
+struct ipc_ids {
+	int in_use;
+	int max_id;
+	unsigned short seq;
+	unsigned short seq_max;
+	struct mutex mutex;
+	struct ipc_id_ary nullentry;
+	struct ipc_id_ary* entries;
+};
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_IPC_H */
Index: 2.6.17-rc5-mm3/ipc/util.h
===================================================================
--- 2.6.17-rc5-mm3.orig/ipc/util.h
+++ 2.6.17-rc5-mm3/ipc/util.h
@@ -15,21 +15,6 @@ void sem_init (void);
 void msg_init (void);
 void shm_init (void);
 
-struct ipc_id_ary {
-	int size;
-	struct kern_ipc_perm *p[0];
-};
-
-struct ipc_ids {
-	int in_use;
-	int max_id;
-	unsigned short seq;
-	unsigned short seq_max;
-	struct mutex mutex;
-	struct ipc_id_ary nullentry;
-	struct ipc_id_ary* entries;
-};
-
 struct seq_file;
 void __init ipc_init_ids(struct ipc_ids* ids, int size);
 #ifdef CONFIG_PROC_FS

--------------040601050404050504090403--
