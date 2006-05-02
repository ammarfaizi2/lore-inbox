Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWEBRVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWEBRVB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 13:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWEBRVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 13:21:00 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:31468 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964938AbWEBRVA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 13:21:00 -0400
Date: Tue, 2 May 2006 12:20:31 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, herbert@13thfloor.at, dev@sw.ru,
       linux-kernel@vger.kernel.org, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com, frankeh@us.ibm.com
Subject: Re: [PATCH 7/7] uts namespaces: Implement CLONE_NEWUTS flag
Message-ID: <20060502172031.GA22923@sergelap.austin.ibm.com>
References: <20060501203906.XF1836@sergelap.austin.ibm.com> <p7364ko7w66.fsf@bragg.suse.de> <m1lktk97ks.fsf@ebiederm.dsl.xmission.com> <200605021017.19897.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605021017.19897.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andi Kleen (ak@suse.de):
> On Tuesday 02 May 2006 10:03, Eric W. Biederman wrote:
> 7 additional bits will probably not be enough. I still don't
> quite understand why you want individual bits for everything.
> Why not group them into logical pieces? 

I wouldn't be surprised if it makes sense to combine some of them.  For
instance, perhaps utsname and networking?

> Have a proxy structure which has pointers to the many name spaces and a bit
> mask for "namespace X is different".

different from what?

Oh, you mean in case we want to allow cloning a namespace outside of
fork *without* cloning the nsproxy struct?

> This structure would be reference
> counted. task_struct has a single pointer to it.

If it is reference counted, that implies it is shared between some
processes.  But namespace pointers themselves are shared between some of
these nsproxy's.  The lifetime mgmt here is one reason I haven't tried a
patch to do this.

Still, like Eric, I'm fine with trying that approach.  It just doesn't
seem like we can draw any meaningful conclusions with just one namespace
pointer, and adding a separate reference counted object around the
utsname pointer would seem to just make the code harder to review.

> With many name spaces you would have smaller task_struct, less cache 
> foot print, better cache use of task_struct because slab cache colouring
> will still work etc.

I suppose we could run some performance tests with some dummy namespace
pointers?  9 void *'s directly in the task struct, and the same inside a
refcounted container struct.  The results might add some urgency to
implementing the struct nsproxy.

-serge
