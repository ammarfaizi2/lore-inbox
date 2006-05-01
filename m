Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWEBAeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWEBAeg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 20:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWEBAeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 20:34:36 -0400
Received: from over.co.us.ibm.com ([32.97.110.157]:43950 "EHLO
	over.co.us.ibm.com") by vger.kernel.org with ESMTP id S932332AbWEBAef
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 20:34:35 -0400
Date: Mon, 1 May 2006 16:11:09 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, ebiederm@xmission.com,
       herbert@13thfloor.at, dev@sw.ru, linux-kernel@vger.kernel.org,
       sam@vilain.net, xemul@sw.ru, clg@us.ibm.com, frankeh@us.ibm.com
Subject: Re: [PATCH 7/7] uts namespaces: Implement CLONE_NEWUTS flag
Message-ID: <20060501211109.GA21799@sergelap.austin.ibm.com>
References: <20060501203906.XF1836@sergelap.austin.ibm.com> <20060501203907.XF1836@sergelap.austin.ibm.com> <1146515316.32079.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146515316.32079.27.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dave Hansen (haveblue@us.ibm.com):
> On Mon, 2006-05-01 at 14:53 -0500, Serge E. Hallyn wrote:
> > +struct uts_namespace *clone_uts_ns(struct uts_namespace *old_ns)
> > +{
> > +	struct uts_namespace *ns;
> > +
> > +	ns = kmalloc(sizeof(struct uts_namespace), GFP_KERNEL);
> > +	if (ns) {
> > +		memcpy(&ns->name, &old_ns->name, sizeof(ns->name));
> > +		kref_init(&ns->kref);
> > +	}
> > +	return ns;
> > +}
> 
> Very small nit...
> 
> Would this memcpy be more appropriate as a strncpy()?
> 
> > +int unshare_utsname(unsigned long unshare_flags, struct uts_namespace **new_uts)
> > +{
> > +	if (unshare_flags & CLONE_NEWUTS) {
> > +		if (!capable(CAP_SYS_ADMIN))
> > +			return -EPERM;
> > +
> > +		*new_uts = clone_uts_ns(current->uts_ns);
> > +		if (!*new_uts)
> > +			return -ENOMEM;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> Would it be a bit nicer to use the ERR_PTR() mechanism here instead of
> the double-pointer bit?
> 
> I've always liked those a bit better because there's no hiding the fact
> of what is actually a return value from a function.

I agree.  I was (grudgingly) copying the style from the other helpers
in fs/fork.c.  Then I had to pull it out so it could cleanly return
-ENOMEM if !CONFIG_UTS, but I expect CONFIG_UTS to be yanked, and
this fn to be returned to fs/fork.c...

Might be worth a separate patch to change over all those helpers in
fork.c?  (I think they were all brought in along with the sys_unshare
syscall)

Agreed on all your other points, thanks.

-serge
