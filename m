Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWCXTPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWCXTPj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWCXTPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:15:39 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:5040 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964786AbWCXTPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:15:13 -0500
Subject: Re: [RFC][PATCH 2/2] Virtualization of IPC
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       xemul@sw.ru, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, devel@openvz.org, serue@us.ibm.com,
       sam@vilain.net
In-Reply-To: <44242DFE.3090601@sw.ru>
References: <44242B1B.1080909@sw.ru>  <44242DFE.3090601@sw.ru>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 11:13:20 -0800
Message-Id: <1143227600.19152.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 20:35 +0300, Kirill Korotaev wrote:
> This patch introduces IPC namespaces, which allow to create isolated IPC 
> users or containers.
> Introduces CONFIG_IPC_NS and ipc_namespace structure.
> It also uses current->ipc_ns as a pointer to current namespace, which 
> reduces places where additional argument to functions should be added.

In three words, I think this has "too many #ifdefs".

The non-containerized or namespaced case should probably just be one,
static namespace variable that gets wrapped up in some nice #ifdefed
hlper functions.

For instance, instead of this:

+#ifdef CONFIG_IPC_NS
+#define msg_ids                (*(current->ipc_ns->msg_ids))
+#endif

Have 

#ifdef CONFIG_IPC_NS
static inline struct ipc_namespace *current_ipc_ns(void)
{
	return current->ipc_ns;
}
#else
static inline struct ipc_namespace *current_ipc_ns(void)
{
	return &static_ipc_ns;
}
#endif

And use current_ipc_ns()->msg_ids.  I can't imagine that gcc can't
figure that out and turn it back into effectively the same thing.

I really dislike the idea of replacing nice variables with macros that
add indirection.  They really might fool people.  Putting a function
there is much nicer.

Why avoid to passing these things around as function arguments?  Doesn't
that make it more explicit what is going on, and where the indirection
is occurring?  Does it also make refcounting and lifetime issues easier
to manage?

BTW, Did you see my version of this?

-- Dave

