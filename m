Return-Path: <linux-kernel-owner+w=401wt.eu-S1750824AbXAOP23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbXAOP23 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 10:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbXAOP23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 10:28:29 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:55904 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbXAOP22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 10:28:28 -0500
Date: Mon, 15 Jan 2007 09:28:25 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 7/8] user_ns: handle file sigio
Message-ID: <20070115152825.GA20350@sergelap.austin.ibm.com>
References: <20070104180635.GA11377@sergelap.austin.ibm.com> <20070104181257.GH11377@sergelap.austin.ibm.com> <20070111212039.68e57e65.akpm@osdl.org> <20070115072653.GA7385@sergelap.austin.ibm.com> <45AB97D5.6010503@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45AB97D5.6010503@fr.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cedric Le Goater (clg@fr.ibm.com):
> Serge E. Hallyn wrote:
> > Quoting Andrew Morton (akpm@osdl.org):
> >> On Thu, 4 Jan 2007 12:12:57 -0600
> >> "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> >>
> >>> A process in one user namespace could set a fowner and sigio on a file in a
> >>> shared vfsmount, ending up killing a task in another user namespace.
> >>>
> >>> Prevent this by adding a user namespace pointer to the fown_struct, and
> >>> enforcing that a process causing a signal to be sent be in the same
> >>> user namespace as the file owner.
> >> This patch breaks the X server (stock FC5 install) with CONFIG_USER_NS=n.
> >> Neither the USB mouse nor the trackpad work.  They work OK under GPM.
> >>
> >> Setting CONFIG_USER_NS=y "fixes" this.  This bug was not observed in
> >> 2.6.20-rc3-mm1 because that kernel had user-ns-always-on.patch for other
> >> reasons.  (I'll restore that patch).
> >>
> >> There's nothing very interesting here:
> >
> [ ... ]
> >
> > I can't see any reason for this in the code or comparative ltp runs.
> > Cedric is testing on a fc6 laptop, hopefully he can reproduce it.
> 
> I did reproduce it on a FC5 desktop finally.
> 
> get_user_ns() returns NULL when CONFIG_USER_NS=n and this breaks
> sigio_perm() which does not expect NULL values for ->user_ns.

Argh.

Thanks, Cedric.

Rewriting the userns testcases right now.  Clearly, in addition to
separately testing clone and unshare, I need to add a sigioperm check,
and have a separate set of testcases for CONFIG_USER_NS=n.

thanks,
-serge

> I would fix this with the following patch.
> 
> C.
> 
> 
> Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>

Acked-off-by: Serge E Hallyn <serue@us.ibm.com>

> ---
>  include/linux/user_namespace.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: 2.6.20-rc4-mm1/include/linux/user_namespace.h
> ===================================================================
> --- 2.6.20-rc4-mm1.orig/include/linux/user_namespace.h
> +++ 2.6.20-rc4-mm1/include/linux/user_namespace.h
> @@ -49,7 +49,7 @@
> 
>  static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
>  {
> -	return NULL;
> +	return &init_user_ns;
>  }
> 
>  static inline int unshare_user_ns(unsigned long flags,
