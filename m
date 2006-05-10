Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWEJUwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWEJUwM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 16:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWEJUwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 16:52:12 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60116 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964824AbWEJUwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 16:52:10 -0400
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, dev@sw.ru, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com, frankeh@us.ibm.com
Subject: Re: [PATCH 2/9] nsproxy: incorporate fs namespace
References: <29vfyljM-1.2006059-s@us.ibm.com>
	<20060510021135.GC32523@sergelap.austin.ibm.com>
	<m1k68uvyhq.fsf@ebiederm.dsl.xmission.com>
	<20060510132623.GB20892@sergelap.austin.ibm.com>
	<m1ac9pwves.fsf@ebiederm.dsl.xmission.com>
	<20060510203449.GA12215@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 10 May 2006 14:50:50 -0600
In-Reply-To: <20060510203449.GA12215@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Wed, 10 May 2006 15:34:49 -0500")
Message-ID: <m1ejz1vc2d.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> There are two additional things I can think of that are worth looking
>> at:
>> - moving copy_uts_namespace, and copy_namespace inside of copy_nsproxy
>>   so we only run those we create a new nsproxy instance.
>
> Was about to do that when I stopped because I was thinking I'd need to
> keep track of which namespace had been copied before a failaure, for
> the sake of clone.
>
> But of course I don't have to - copy_nsproxy could do the cleanup itself
> on failure.
>
> So this should be a nice little cleanup - especially as # namespaces
> increases.

Yes.  At least if nsproxy doesn't show a performance degradation...

>> - Attempting to optimize cache line utilization by placing the
>>   structures in line in struct ns_proxy:
>> 	struct nsproxy {
>> 		atomic_t count;
>> 	        struct namespace *namespace;
>> 	        struct uts_namespace *uts_ns;
>> 	        struct namespace namespace_data;
>> 	        struct new_utsname uts_data;
>> 	};
>>   With the nsproxy count severing as a count for both the embedded
>>   data and for the nsproxy itself.  I think it is a long shot but it
>>   could be interesting.
>> 
>> Given the frequency of use of the uts namespace and the filesystem
>> namespace simply I think not accessing those namespaces on fork is
>> likely to reduce the additional cache line miss rate enough so
>> that it is lost in the noise.
>
> Not getting this.  Are you saying the uts_data would be a copy of
> the contents of *uts_ns, or that uts_ns points to nsproxy->uts_data?
> If the latter, then just unsharing uts_ns but not mounts namespace
> is no longer possible, right?

The latter, uts_ns normally points to nsproxy->uts_data.  But it still
remains possible to unshare just the mounts namespace by simply coping
the pointer when we clone nsproxy, and incrementing the previous
ns_proxies count.

Like I said I think it is a long shot but if the data for namespaces
really does remain small and they are usually all unshared in a group
it could be a win.

Eric

