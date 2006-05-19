Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWESCVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWESCVY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 22:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWESCVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 22:21:24 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:18127 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932166AbWESCVY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 22:21:24 -0400
Date: Thu, 18 May 2006 21:21:14 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, xemul@sw.ru, haveblue@us.ibm.com, akpm@osdl.org,
       clg@fr.ibm.com
Subject: Re: [PATCH 4/9] namespaces: utsname: switch to using uts namespaces
Message-ID: <20060519022114.GB19373@sergelap.austin.ibm.com>
References: <20060518154700.GA28344@sergelap.austin.ibm.com> <20060518154936.GE28344@sergelap.austin.ibm.com> <20060518170234.07c8fe4c.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060518170234.07c8fe4c.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Randy.Dunlap (rdunlap@xenotime.net):
> > --- a/arch/i386/kernel/sys_i386.c
> > +++ b/arch/i386/kernel/sys_i386.c
> > @@ -210,7 +210,7 @@ asmlinkage int sys_uname(struct old_utsn
> >  	if (!name)
> >  		return -EFAULT;
> >  	down_read(&uts_sem);
> > -	err=copy_to_user(name, &system_utsname, sizeof (*name));
> > +	err=copy_to_user(name, utsname(), sizeof (*name));
> 
> It would be really nice if you would fix spacing while you are here,
> like a space a each side of '='.
> 
> and a space after ',' in the function calls below.

Ok.  Then in blocks like the following:

> > -	error = __copy_to_user(&name->sysname,&system_utsname.sysname,__OLD_UTS_LEN);
> > +	error = __copy_to_user(&name->sysname,&utsname()->sysname,__OLD_UTS_LEN);
> >  	error |= __put_user(0,name->sysname+__OLD_UTS_LEN);
> > -	error |= __copy_to_user(&name->nodename,&system_utsname.nodename,__OLD_UTS_LEN);
> > +	error |= __copy_to_user(&name->nodename,&utsname()->nodename,__OLD_UTS_LEN);
> >  	error |= __put_user(0,name->nodename+__OLD_UTS_LEN);
> > -	error |= __copy_to_user(&name->release,&system_utsname.release,__OLD_UTS_LEN);
> > +	error |= __copy_to_user(&name->release,&utsname()->release,__OLD_UTS_LEN);
> >  	error |= __put_user(0,name->release+__OLD_UTS_LEN);
> > -	error |= __copy_to_user(&name->version,&system_utsname.version,__OLD_UTS_LEN);
> > +	error |= __copy_to_user(&name->version,&utsname()->version,__OLD_UTS_LEN);
> >  	error |= __put_user(0,name->version+__OLD_UTS_LEN);
> > -	error |= __copy_to_user(&name->machine,&system_utsname.machine,__OLD_UTS_LEN);
> > +	error |= __copy_to_user(&name->machine,&utsname()->machine,__OLD_UTS_LEN);
> >  	error |= __put_user(0,name->machine+__OLD_UTS_LEN);

Should I leave it as is, to keep the consistent look?  Change just the
lines I'm editing, making it inconsistent?  Or change the whole block,
making my patch seem a bit larger than it really is, but giving the
nicest end result?

I suppose I could insert a separate patchset fixing up the spacing in
those blocks but making no real changes at all, then apply my patch on
top of that...?

> > --- a/arch/mips/kernel/syscall.c
> > +++ b/arch/mips/kernel/syscall.c
> > @@ -232,7 +232,7 @@ out:
> >   */
> >  asmlinkage int sys_uname(struct old_utsname __user * name)
> >  {
> > -	if (name && !copy_to_user(name, &system_utsname, sizeof (*name)))
> > +	if (name && !copy_to_user(name, utsname(), sizeof (*name)))
> 
> 
> OK, here's my big comment/question.  I want to see <nodename> increased to
> 256 bytes (per current POSIX), so each field of struct <variant>_utsname
> needs be copied individually (I think) instead of doing a single
> struct copy.
> 
> I've been working on this for the past few weeks (among other
> things).  Sorry about the timing.
> I could send patches for this against mainline in a few days,
> but I'll be glad to listen to how it would be easiest for all of us
> to handle.
> 
> I'm probably a little over half done with my patches.
> They will end up adding a lib/utsname.c that has functions for:
>   put_oldold_unmame()	// to user
>   put_old_uname()	// to user
>   put_new_uname()	// to user
>   put_posix_uname()	// to user

Ok, so long as these functions accept a utsname, we should be able to
just change what we pass in to these functions to being the namespace's
utsname, right?  Or am I missing the really nasty part?

thanks,
-serge
