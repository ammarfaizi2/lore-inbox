Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbUDIVM5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 17:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUDIVM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 17:12:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:13989 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261766AbUDIVMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 17:12:55 -0400
Date: Fri, 9 Apr 2004 14:15:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: brking@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] call_usermodehelper hang
Message-Id: <20040409141511.4e372554.akpm@osdl.org>
In-Reply-To: <20040409205344.GA5236@kroah.com>
References: <4072F2B7.2070605@us.ibm.com>
	<20040406172903.186dd5f1.akpm@osdl.org>
	<20040407061146.GA10413@kroah.com>
	<407487A6.8020904@us.ibm.com>
	<20040408224713.GD15125@kroah.com>
	<40770AD0.4000402@us.ibm.com>
	<20040409205344.GA5236@kroah.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Fri, Apr 09, 2004 at 03:42:56PM -0500, Brian King wrote:
> > Would you prefer a fix in call_usermodehelper itself? It could certainly
> > be argued that calling call_usermodehelper with wait=0 should be allowed
> > even when holding locks. Although, fixing it here is less obvious to me
> > how to do because of the arguments to call_usermodehelper. I would imagine
> > it would consist of creating a kernel_thread to preserve the caller's stack.
> 
> Yes, I think call_usermodehelper should be changed to create a new
> kernel thread for every call.

It does that already.  But that thread is parented by keventd.  This was
done to avoid all the various nasty things which can happen when you have a
kernel thread and a hotplug helper which are parented by a random userspace
process.  All the crap which it might have inherited: uid?  gid?  signals? 
nice?  rtprio?  rlimits?  namespace?


The deadlock opportunity occurs during the call_usermodehelper() handoff to
keventd, which is synchronous.

2-3 years back I did have a call_usermodehelper() which was fully async. 
It was pretty unpleasant because of the need to atomically allocate
arbitrary amounts of memory to hold the argv[] and endp[] arrays, to pass
them between a couple of threads and to then correctly free it all up
again.
