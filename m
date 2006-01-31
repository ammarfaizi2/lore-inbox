Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbWAaVDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWAaVDF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 16:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWAaVDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 16:03:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59279 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751486AbWAaVDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 16:03:03 -0500
Date: Tue, 31 Jan 2006 13:02:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Hubertus Franke <frankeh@watson.ibm.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
In-Reply-To: <43D14578.6060801@watson.ibm.com>
Message-ID: <Pine.LNX.4.64.0601311248180.7301@g5.osdl.org>
References: <20060117143258.150807000@sergelap> <20060117143326.283450000@sergelap>
 <1137511972.3005.33.camel@laptopd505.fenrus.org> <20060117155600.GF20632@sergelap.austin.ibm.com>
 <1137513818.14135.23.camel@localhost.localdomain> <1137518714.5526.8.camel@localhost.localdomain>
 <20060118045518.GB7292@kroah.com> <1137601395.7850.9.camel@localhost.localdomain>
 <m1fyniomw2.fsf@ebiederm.dsl.xmission.com> <43D14578.6060801@watson.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(I'm coming in late, it's not been a high priority for me)

On Fri, 20 Jan 2006, Hubertus Franke wrote:
> 
> 2nd:
> ====	Issue: we don't need pid virtualization, instead simply use
> <container,pid> pair.
> 
> This requires a bit more thought. Essentially that's what I was doing, 
> but I mangled them into the same pid and using masking to add/remove the 
> container for internal use. As pointed out by Alan(?), we can indeed 
> reused the same pid internally many times as long as we can distinguish 
> during the pid-to-task_struct lookup. This is easily done because, the 
> caller provides the context hence the container for the lookup.

This is my preferred approach BY FAR.

Doing a <container,pid> approach is very natural, and avoids almost all 
issues. At most, you might want to have a new system call (most naturally 
just the one that is limited to the "init container" - it the one that we 
boot up with) that can specify both container and pid explicitly, and see 
all processes and access all processes. But all "normal" system calls 
would only ever operate within their container.

The fact is, we want "containers" anyway for any virtualization thing, ie 
vserver already adds them. And if we have containers, then it's very easy 
("easyish") to split up the current static "pid_hash[]", "pidmap_array[]" 
and "pidmap_lock", and make them per-container, and have a pointer to the 
container for each "struct task_struct".

After that, there wouldn't even be a lot else to do. The normal system 
calls would just use their own container, and the (few) places that save 
away pid's for later (ie things that use "kill_proc_info_as_uid()" and 
"struct fown_struct" friends) would have to also squirrell away the 
container, but then you should be pretty much done.

Of course, you'll have to do the system calls to _create_ the containers 
in the first place, but that's at a higher level and involves much more 
than just the pid-space (ie a container would normally have more than just 
the uid mappings, it would have any network knowledge too etc - hostname, 
perhaps list of network devices associated with that context etc etc)

			Linus
