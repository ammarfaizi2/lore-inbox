Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946027AbWGOLei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946027AbWGOLei (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 07:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946029AbWGOLei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 07:34:38 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:2003 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946027AbWGOLeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 07:34:37 -0400
Date: Sat, 15 Jul 2006 06:33:34 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Dave Hansen <haveblue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH -mm 5/7] add user namespace
Message-ID: <20060715113334.GB29897@sergelap.austin.ibm.com>
References: <1152815391.7650.58.camel@localhost.localdomain> <m1wtahz5u2.fsf@ebiederm.dsl.xmission.com> <1152821011.24925.7.camel@localhost.localdomain> <m17j2gzw5u.fsf@ebiederm.dsl.xmission.com> <1152887287.24925.22.camel@localhost.localdomain> <m17j2gw76o.fsf@ebiederm.dsl.xmission.com> <20060714162935.GA25303@sergelap.austin.ibm.com> <m18xmwuo5r.fsf@ebiederm.dsl.xmission.com> <20060714170523.GD25303@sergelap.austin.ibm.com> <7D4E3699-E082-495D-8A08-543DF057F2B9@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7D4E3699-E082-495D-8A08-543DF057F2B9@mac.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kyle Moffett (mrmacman_g4@mac.com):
> On Jul 14, 2006, at 13:05:23, Serge E. Hallyn wrote:
> >Quoting Eric W. Biederman (ebiederm@xmission.com):
> >>Capabilities have always fitted badly in with the normal unix  
> >>permissions.
> >
> >Well they're not supposed to fit in.
> >
> >If we keep permchecks as uid==0 on files which invoke kernel  
> >callbacks, then we can only say once what root is allowed to do.   
> >If we make them capability checks, then for differnet uses of  
> >namespaces we can have them do different things.  For instance if  
> >we're making a separate user namespace for a checkpoint/restart  
> >purpose, we might want root to retain more privs than if we're  
> >making a vserver.
> >
> >Look I just have to keep responding because you keep provoking :),  
> >but I'm looking at other code and don't even know which entries  
> >we're talking about.  If when I get to looking at them I find they  
> >really should be done by capabilities, I'll submit a patch and we  
> >can argue then.
> 
> Capabilities are not a single fundamental privilege set and they  

But they are exactly that.

> don't interact at all nicely with virtualization.  If we're going to  

There are three ways caps can deal with virtualization.

First, we can stick with the idea that a child process inherits
capabilities from the parent.  In that case, while starting up a child
container, we give the init process the caps we want it to have (i.e.
perhaps we just don't give it CAP_NET_ADMIN).  It can then dole those
out as usual, and it's children then can't regain the others.  Problem
is setuid binaries are a special case.  Though if we implement fs caps,
we could then put a max_caps limit on the fs caps for a vfsmount.

Second, we can actually create a separate capabilities namespace  :)
Sounds silly, but when you consider that you're recommending passing
several namespaces into capable() to have some magic calculation
performed on them, maybe it's not so bad.  This way, an suid binary
ends up with just the capabilities specified in the namespace.

Third is to do what you suggest below.  Fortunately that's easy enough
to experiment with, since we can just define a new capability_virt LSM.
I don't think any of the capable calls need to be extended, since we can
grab the namespace pointers needed from the task_struct->nsproxy's.

IMO, capabilities are already complicated past the point of danger, and
the solution keeping things simplest is the second.  Since capabilities
are an LSM, the namespace creation and configuration would likely be
done differently from other namespace, i.e. through a securityfs
interface.

This is of course something which could fit under the security/LSM
portion of the containers topic at ksummit...  Along with the uid/keys
discussion.

> do this properly we need to divide capabilities up into different  
> sets applied to different objects.  For example, the CAP_DAC_OVERRIDE  
> capability should _really_ be per (PID,vfsmount) pair, although that  
> would probably be exceptionally inefficient, so as an optimization we  
> could make it per (PID,target_uid_ns) pair.  That maps very  
> conveniently to the kernel keyring system, where we can make a "uid"  
> keytype indexed by target_uid_ns and containing three things:  A  
> process-manipulation UID (think euid), a file-manipulation UID (think  
> fsuid), and a set of per-uid-ns capabilities.  Similar mappings  
> should be set up for most of the other capabilities.  Normal cap_set  
> and cap_get and capable() calls on those particular capabilities  
> should look up and modify the "uid" key associated with the current- 
> >nsproxy->uidns namespace, and extra calls should be added to modify  
> capabilities with respect to specific UID namespaces.
> 
> Here's a list of capabilities that should probably be in each "uid" key:
> CAP_CHOWN
> CAP_DAC_OVERRIDE
> CAP_DAC_READ_SEARCH
> CAP_FOWNER
> CAP_FSETID
> CAP_FS_MASK
> CAP_SETGID
> CAP_SETUID
> CAP_LINUX_IMMUTABLE
> CAP_IPC_OWNER

But this gets away from the idea of capabilities being an inherited set
of privileges independent of uid.  Really it should be file
capabilities, not (set)uid, which have the ability subsequently raise
caps.

Of course few people love capabilities, so maybe that would actually be
preferred...

> Cheers,
> Kyle Moffett

-serge
