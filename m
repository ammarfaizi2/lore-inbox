Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWATVr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWATVr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWATVr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:47:26 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:36771 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750903AbWATVrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:47:25 -0500
Message-ID: <43D15A69.9000104@watson.ibm.com>
Date: Fri, 20 Jan 2006 16:47:21 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       "Alan Cox <alan@lxorguk.ukuu.org.uk> Dave Hansen" 
	<haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC: Multiple instances of kernel namespaces.
References: <43CD32F0.9010506@FreeBSD.org> <1137521557.5526.18.camel@localhost.localdomain> <1137522550.14135.76.camel@localhost.localdomain> <1137610912.24321.50.camel@localhost.localdomain> <1137612537.3005.116.camel@laptopd505.fenrus.org> <1137613088.24321.60.camel@localhost.localdomain> <1137624867.1760.1.camel@localhost.localdomain> <m1bqy6oevn.fsf_-_@ebiederm.dsl.xmission.com> <20060120201353.GA13265@sergelap.austin.ibm.com> <43D14695.3000102@watson.ibm.com> <20060120203555.GC13265@sergelap.austin.ibm.com>
In-Reply-To: <20060120203555.GC13265@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn wrote:
> Quoting Hubertus Franke (frankeh@watson.ibm.com):
> 
>>However, question here is whether the container (as we used it) provides
>>the "binding" object for these clones. One question for me then is
>>whether cloning of namespaces is always done in tandem.
> 
> 
> No.

Thought so..

> 
> 
>>As you are bringing the migration up, we can only clone fully contained
> 
> 
> By clone do you actually mean clone(), or did you mean restart from
> checkpoint?

clone_<namespace>  , so its neither nor ...
Essentially creating a new namespace ! That's what Eric was suggesting.

> 
> If clone, then I don't understand the problem.
> 
> If restart from checkpoint/migrate, then I think the answer has to be
> that that is a special case which we have to handle.  Note that to clone
> a fs namespace, you need CAP_SYS_ADMIN.  We could add another check in
> there to deny CLONE_NEWNS when CLONE_NEWPID is not specified IF and ONLY
> IF we are already no longer in container_id==0.  Or even better, when
> a pid-namespace has been designated as migrateable.
> 
> Anything other than that would be too limiting.  Note that fs namespaces
> are going to be used for multi-level directories, for instance.

That's a reasonable approach. Give the general capability (since C/R + migration
is an additional capability that might not be utilized by many) and leave it to
the sys_admin to specify what is allowed or not
>  
>>namespaces ! One could make that a condition of the migration or build
>>it right into the initial structure. Any thoughts on that ?
>  
> So in other words I'm saying that this is the admin/user's problem to
> keep straight.  Dealing with fs-namespaces in this sense could perhaps be
> dealt with later by hand in checkpoint/migrate/restore code by
> 	a) at checkpoint:
> 		i) checking the fs-namespace of each process or thread
> 		ii) storing /proc/mounts for each fs-namespace
> 	b) at restore, do CLONE_NEWNS for each process which needs it,
> 		and using the stored /proc/mounts to rebuild the
> 		namespace.
> 
Something like it .. yes...

> Of course /proc mounts is itself relative to a namespace in the
> case of bind mounts, so I'm actually not sure this is feasible.
> 
> -serge
> 


