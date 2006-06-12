Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWFLSDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWFLSDB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWFLSDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:03:01 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60862 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751353AbWFLSDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:03:00 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       devel@openvz.org, xemul@openvz.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       herbert@13thfloor.at, saw@sw.ru, serue@us.ibm.com, sfrench@us.ibm.com,
       sam@vilain.net, haveblue@us.ibm.com
Subject: Re: [PATCH 2/6] IPC namespace - utils
References: <44898BF4.4060509@openvz.org> <44898E39.3080801@openvz.org>
	<448D9F96.5030305@fr.ibm.com>
Date: Mon, 12 Jun 2006 12:01:48 -0600
In-Reply-To: <448D9F96.5030305@fr.ibm.com> (Cedric Le Goater's message of
	"Mon, 12 Jun 2006 19:08:38 +0200")
Message-ID: <m1bqsy6ynn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater <clg@fr.ibm.com> writes:

> I've used the ipc namespace patchset in rc6-mm2. Thanks for putting this
> together, it works pretty well ! A few questions when we clone :
>
> * We should do something close to what exit_sem() already does to clear the
> sem_undo list from the task doing the clone() or unshare().

Possibly which case are you trying to prevent?

> * I don't like the idea of being able to unshare the ipc namespace and keep
> some shared memory from the previous ipc namespace mapped in the process mm.
> Should we forbid the unshare ?

No.  As long as the code handles that case properly we should be fine.
As a general principle we should be able to keep things from other namespaces
open if we get them.  The chroot or equivalent binary is the one that needs
to ensure these kinds of issues don't exist if we care.

Speaking of we should put together a small test application probably similar
to chroot so people can access these features at least for testing.

> Small fix follows,
>
> thanks,
>
> C.

Ack.  For the unshare fix below.  Could you resend this one separately with
patch in the subject so Andrew sees it and picks  up?

> From: Cedric Le Goater <clg@fr.ibm.com>
> Subject: ipc namespace : unshare fix
>
> Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
>
> ---
>  kernel/fork.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Index: 2.6.17-rc6-mm2/kernel/fork.c
> ===================================================================
> --- 2.6.17-rc6-mm2.orig/kernel/fork.c
> +++ 2.6.17-rc6-mm2/kernel/fork.c
> @@ -1599,7 +1599,8 @@ asmlinkage long sys_unshare(unsigned lon
>  	/* Return -EINVAL for all unsupported flags */
>  	err = -EINVAL;
>  	if (unshare_flags & ~(CLONE_THREAD|CLONE_FS|CLONE_NEWNS|CLONE_SIGHAND|
> -				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|CLONE_NEWUTS))
> +				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|
> +				CLONE_NEWUTS|CLONE_NEWIPC))
>  		goto bad_unshare_out;
>  
>  	if ((err = unshare_thread(unshare_flags)))
