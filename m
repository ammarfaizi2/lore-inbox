Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUDJRCj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 13:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUDJRCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 13:02:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:28550 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262060AbUDJRCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 13:02:37 -0400
Date: Sat, 10 Apr 2004 09:53:22 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: brking@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] call_usermodehelper hang
Message-ID: <20040410165322.GG1317@kroah.com>
References: <4072F2B7.2070605@us.ibm.com> <20040406172903.186dd5f1.akpm@osdl.org> <20040407061146.GA10413@kroah.com> <407487A6.8020904@us.ibm.com> <20040408224713.GD15125@kroah.com> <40770AD0.4000402@us.ibm.com> <20040409205344.GA5236@kroah.com> <20040409141511.4e372554.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040409141511.4e372554.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2004 at 02:15:11PM -0700, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > On Fri, Apr 09, 2004 at 03:42:56PM -0500, Brian King wrote:
> > > Would you prefer a fix in call_usermodehelper itself? It could certainly
> > > be argued that calling call_usermodehelper with wait=0 should be allowed
> > > even when holding locks. Although, fixing it here is less obvious to me
> > > how to do because of the arguments to call_usermodehelper. I would imagine
> > > it would consist of creating a kernel_thread to preserve the caller's stack.
> > 
> > Yes, I think call_usermodehelper should be changed to create a new
> > kernel thread for every call.
> 
> It does that already.  But that thread is parented by keventd.  This was
> done to avoid all the various nasty things which can happen when you have a
> kernel thread and a hotplug helper which are parented by a random userspace
> process.  All the crap which it might have inherited: uid?  gid?  signals? 
> nice?  rtprio?  rlimits?  namespace?

Yeah, good point.

> The deadlock opportunity occurs during the call_usermodehelper() handoff to
> keventd, which is synchronous.
> 
> 2-3 years back I did have a call_usermodehelper() which was fully async. 
> It was pretty unpleasant because of the need to atomically allocate
> arbitrary amounts of memory to hold the argv[] and endp[] arrays, to pass
> them between a couple of threads and to then correctly free it all up
> again.

Ok, you've convinced me of the mess that would cause.  So what should we
do to help fix this?  Serialize call_usermodehelper()?

thanks,

greg k-h
