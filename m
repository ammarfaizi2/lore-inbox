Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422673AbWGNRvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422673AbWGNRvX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422687AbWGNRvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:51:23 -0400
Received: from smtpout.mac.com ([17.250.248.184]:38399 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1422673AbWGNRvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:51:22 -0400
In-Reply-To: <20060714170523.GD25303@sergelap.austin.ibm.com>
References: <20060713174721.GA21399@sergelap.austin.ibm.com> <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com> <1152815391.7650.58.camel@localhost.localdomain> <m1wtahz5u2.fsf@ebiederm.dsl.xmission.com> <1152821011.24925.7.camel@localhost.localdomain> <m17j2gzw5u.fsf@ebiederm.dsl.xmission.com> <1152887287.24925.22.camel@localhost.localdomain> <m17j2gw76o.fsf@ebiederm.dsl.xmission.com> <20060714162935.GA25303@sergelap.austin.ibm.com> <m18xmwuo5r.fsf@ebiederm.dsl.xmission.com> <20060714170523.GD25303@sergelap.austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7D4E3699-E082-495D-8A08-543DF057F2B9@mac.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Dave Hansen <haveblue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
Date: Fri, 14 Jul 2006 13:50:43 -0400
To: "Serge E. Hallyn" <serue@us.ibm.com>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 14, 2006, at 13:05:23, Serge E. Hallyn wrote:
> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> Capabilities have always fitted badly in with the normal unix  
>> permissions.
>
> Well they're not supposed to fit in.
>
> If we keep permchecks as uid==0 on files which invoke kernel  
> callbacks, then we can only say once what root is allowed to do.   
> If we make them capability checks, then for differnet uses of  
> namespaces we can have them do different things.  For instance if  
> we're making a separate user namespace for a checkpoint/restart  
> purpose, we might want root to retain more privs than if we're  
> making a vserver.
>
> Look I just have to keep responding because you keep provoking :),  
> but I'm looking at other code and don't even know which entries  
> we're talking about.  If when I get to looking at them I find they  
> really should be done by capabilities, I'll submit a patch and we  
> can argue then.

Capabilities are not a single fundamental privilege set and they  
don't interact at all nicely with virtualization.  If we're going to  
do this properly we need to divide capabilities up into different  
sets applied to different objects.  For example, the CAP_DAC_OVERRIDE  
capability should _really_ be per (PID,vfsmount) pair, although that  
would probably be exceptionally inefficient, so as an optimization we  
could make it per (PID,target_uid_ns) pair.  That maps very  
conveniently to the kernel keyring system, where we can make a "uid"  
keytype indexed by target_uid_ns and containing three things:  A  
process-manipulation UID (think euid), a file-manipulation UID (think  
fsuid), and a set of per-uid-ns capabilities.  Similar mappings  
should be set up for most of the other capabilities.  Normal cap_set  
and cap_get and capable() calls on those particular capabilities  
should look up and modify the "uid" key associated with the current- 
 >nsproxy->uidns namespace, and extra calls should be added to modify  
capabilities with respect to specific UID namespaces.

Here's a list of capabilities that should probably be in each "uid" key:
CAP_CHOWN
CAP_DAC_OVERRIDE
CAP_DAC_READ_SEARCH
CAP_FOWNER
CAP_FSETID
CAP_FS_MASK
CAP_SETGID
CAP_SETUID
CAP_LINUX_IMMUTABLE
CAP_IPC_OWNER

Cheers,
Kyle Moffett



