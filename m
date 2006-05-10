Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbWEJN01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWEJN01 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 09:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWEJN01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 09:26:27 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:64676 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964954AbWEJN00
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 09:26:26 -0400
Date: Wed, 10 May 2006 08:26:23 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, dev@sw.ru,
       sam@vilain.net, xemul@sw.ru, haveblue@us.ibm.com, clg@fr.ibm.com,
       frankeh@us.ibm.com
Subject: Re: [PATCH 2/9] nsproxy: incorporate fs namespace
Message-ID: <20060510132623.GB20892@sergelap.austin.ibm.com>
References: <29vfyljM-1.2006059-s@us.ibm.com> <20060510021135.GC32523@sergelap.austin.ibm.com> <m1k68uvyhq.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1k68uvyhq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> 
> > @@ -1727,11 +1727,16 @@ static void __init init_mount_tree(void)
> >  	namespace->root = mnt;
> >  	mnt->mnt_namespace = namespace;
> >  
> > -	init_task.namespace = namespace;
> > +	init_task.nsproxy->namespace = namespace;
> >  	read_lock(&tasklist_lock);
> >  	do_each_thread(g, p) {
> > +		/* do we want namespace count to be #nsproxies,
> > +		 * or # processes pointing to the namespace? */
> 
> I am fairly certain we want the count to be #nsproxies.
> 
> >  		get_namespace(namespace);
> > -		p->namespace = namespace;
> > +#if 0
> > +		/* should only be 1 nsproxy so far */
> > +		p->nsproxy->namespace = namespace;
> > +#endif
> >  	} while_each_thread(g, p);
> >  	read_unlock(&tasklist_lock);
> 
> So I think this bit is wrong.

Ok - in that case I need to audit the rest of namespace usage to make
certain nothing depends on the count being #tasks.

BTW - a first set of comparison results showed nsproxy to have better
dbench and tbench throughput, and worse kernbench performance.  Which
may make sense given that nsproxy results in lower memory usage but
likely increased cache misses due to extra pointer dereference.

-serge
