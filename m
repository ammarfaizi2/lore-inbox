Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbWEJTJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbWEJTJF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 15:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWEJTJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 15:09:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47315 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965016AbWEJTJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 15:09:03 -0400
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, dev@sw.ru, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com, frankeh@us.ibm.com
Subject: Re: [PATCH 2/9] nsproxy: incorporate fs namespace
References: <29vfyljM-1.2006059-s@us.ibm.com>
	<20060510021135.GC32523@sergelap.austin.ibm.com>
	<m1k68uvyhq.fsf@ebiederm.dsl.xmission.com>
	<20060510132623.GB20892@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 10 May 2006 13:07:39 -0600
In-Reply-To: <20060510132623.GB20892@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Wed, 10 May 2006 08:26:23 -0500")
Message-ID: <m1ac9pwves.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> "Serge E. Hallyn" <serue@us.ibm.com> writes:
>> 
>> 
>> > @@ -1727,11 +1727,16 @@ static void __init init_mount_tree(void)
>> >  	namespace->root = mnt;
>> >  	mnt->mnt_namespace = namespace;
>> >  
>> > -	init_task.namespace = namespace;
>> > +	init_task.nsproxy->namespace = namespace;
>> >  	read_lock(&tasklist_lock);
>> >  	do_each_thread(g, p) {
>> > +		/* do we want namespace count to be #nsproxies,
>> > +		 * or # processes pointing to the namespace? */
>> 
>> I am fairly certain we want the count to be #nsproxies.
>> 
>> >  		get_namespace(namespace);
>> > -		p->namespace = namespace;
>> > +#if 0
>> > +		/* should only be 1 nsproxy so far */
>> > +		p->nsproxy->namespace = namespace;
>> > +#endif
>> >  	} while_each_thread(g, p);
>> >  	read_unlock(&tasklist_lock);
>> 
>> So I think this bit is wrong.
>
> Ok - in that case I need to audit the rest of namespace usage to make
> certain nothing depends on the count being #tasks.

Ok.  Thats makes sense.

> BTW - a first set of comparison results showed nsproxy to have better
> dbench and tbench throughput, and worse kernbench performance.  Which
> may make sense given that nsproxy results in lower memory usage but
> likely increased cache misses due to extra pointer dereference.

There are two additional things I can think of that are worth looking
at:
- moving copy_uts_namespace, and copy_namespace inside of copy_nsproxy
  so we only run those we create a new nsproxy instance.

- Attempting to optimize cache line utilization by placing the
  structures in line in struct ns_proxy:
	struct nsproxy {
		atomic_t count;
	        struct namespace *namespace;
	        struct uts_namespace *uts_ns;
	        struct namespace namespace_data;
	        struct new_utsname uts_data;
	};
  With the nsproxy count severing as a count for both the embedded
  data and for the nsproxy itself.  I think it is a long shot but it
  could be interesting.

Given the frequency of use of the uts namespace and the filesystem
namespace simply I think not accessing those namespaces on fork is
likely to reduce the additional cache line miss rate enough so
that it is lost in the noise.

Eric
