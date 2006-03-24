Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWCXV1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWCXV1P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 16:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWCXV1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 16:27:15 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:13276 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932514AbWCXV1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 16:27:14 -0500
Date: Fri, 24 Mar 2006 22:27:13 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, xemul@sw.ru, ebiederm@xmission.com,
       linux-kernel@vger.kernel.org, devel@openvz.org, serue@us.ibm.com,
       sam@vilain.net
Subject: Re: [RFC][PATCH 2/2] Virtualization of IPC
Message-ID: <20060324212713.GC22308@MAIL.13thfloor.at>
Mail-Followup-To: Dave Hansen <haveblue@us.ibm.com>,
	Kirill Korotaev <dev@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, xemul@sw.ru, ebiederm@xmission.com,
	linux-kernel@vger.kernel.org, devel@openvz.org, serue@us.ibm.com,
	sam@vilain.net
References: <44242B1B.1080909@sw.ru> <44242DFE.3090601@sw.ru> <1143227600.19152.81.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143227600.19152.81.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 11:13:20AM -0800, Dave Hansen wrote:
> On Fri, 2006-03-24 at 20:35 +0300, Kirill Korotaev wrote:
> > This patch introduces IPC namespaces, which allow to create isolated IPC 
> > users or containers.
> > Introduces CONFIG_IPC_NS and ipc_namespace structure.
> > It also uses current->ipc_ns as a pointer to current namespace, which 
> > reduces places where additional argument to functions should be added.
> 
> In three words, I think this has "too many #ifdefs".
> 
> The non-containerized or namespaced case should probably just be one,
> static namespace variable that gets wrapped up in some nice #ifdefed
> hlper functions.
> 
> For instance, instead of this:
> 
> +#ifdef CONFIG_IPC_NS
> +#define msg_ids                (*(current->ipc_ns->msg_ids))
> +#endif
> 
> Have 
> 
> #ifdef CONFIG_IPC_NS
> static inline struct ipc_namespace *current_ipc_ns(void)
> {
> 	return current->ipc_ns;
> }
> #else
> static inline struct ipc_namespace *current_ipc_ns(void)
> {
> 	return &static_ipc_ns;
> }
> #endif
> 
> And use current_ipc_ns()->msg_ids.  I can't imagine that gcc can't
> figure that out and turn it back into effectively the same thing.

one issue here, not always 'current' is the right context,
often you handle stuff on behalf of a task, which would
then point to the 'proper' context ...

i.e. something like task_msg_ids(current) is probably
better and more flexible, also I'm still not convinced
that 'per process' is the proper context for those
things, 'per container' or 'per space' would be more
appropriate IMHO ...

more comments to follow, when I got to the patches ...

> I really dislike the idea of replacing nice variables with macros that
> add indirection.  They really might fool people.  Putting a function
> there is much nicer.
> 
> Why avoid to passing these things around as function arguments?  Doesn't
> that make it more explicit what is going on, and where the indirection
> is occurring?  Does it also make refcounting and lifetime issues easier
> to manage?
> 
> BTW, Did you see my version of this?

no, where is it?

maybe we should put all that stuff on a wiki too?

best,
Herbert

> 
> -- Dave
