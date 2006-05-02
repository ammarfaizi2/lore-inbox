Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbWEBIRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbWEBIRa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 04:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWEBIRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 04:17:30 -0400
Received: from mx1.suse.de ([195.135.220.2]:15074 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932503AbWEBIR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 04:17:29 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 7/7] uts namespaces: Implement CLONE_NEWUTS flag
Date: Tue, 2 May 2006 10:17:19 +0200
User-Agent: KMail/1.9.1
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, herbert@13thfloor.at, dev@sw.ru,
       linux-kernel@vger.kernel.org, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@us.ibm.com, frankeh@us.ibm.com
References: <20060501203906.XF1836@sergelap.austin.ibm.com> <p7364ko7w66.fsf@bragg.suse.de> <m1lktk97ks.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1lktk97ks.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605021017.19897.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 10:03, Eric W. Biederman wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> > "Serge E. Hallyn" <serue@us.ibm.com> writes:
> >
> >> Implement a CLONE_NEWUTS flag, and use it at clone and sys_unshare.
> >
> > I still think it's a design mistake to add zillions of pointers to task_struct
> > for every possible kernel object. Going through a proxy datastructure to 
> > merge common cases would be much better.
> 
> The design point is not every kernel object.  The target is one
> per namespace.  Or more usefully one per logical chunk of the kernel.

Which are likely tens or even hundreds if you go through all the source.
Even tens would bloat task_struct far too much.

 
> The UTS namespace is by far the smallest of these pieces.
> 
> The kernel networking stack is probably the largest.
> 
> At last count there were about 7 of these, enough so that the few
> remaining clone bits would be sufficient.

7 additional bits will probably not be enough. I still don't
quite understand why you want individual bits for everything.
Why not group them into logical pieces? 

If you really want individual bits you'll likely need to think
about a clone2() call with more flags soon.

> 
> Do you disagree that to be able to implement this properly we
> need to take small steps?

No, but at least the basic infrastructure for expansion should 
be added first.

> Are there any semantic differences between a clone bit and what you
> are proposing?

No just internals.

 > If it is just an internal implementation detail do you have a clear
> suggestion on how to implement this?  Possibly illustrated by the
> thread flags that are already in this situation, and more likely
> to always share everything.

Have a proxy structure which has pointers to the many name spaces and a bit
mask for "namespace X is different". This structure would be reference
counted. task_struct has a single pointer to it.

On clone check the clone flags against the bit mask. If there is any
difference allocate a new structure and clone the name spaces into it.
If no difference just use the old data structure after increasing its 
reference count. 

Possible name "nsproxy".
 
> Except for reducing reference counting I really don't see where
> we could have a marked improvement.  I also don't see us closing
> the door to that kind of implementation at this point, but instead
> taking the simple path.

With many name spaces you would have smaller task_struct, less cache 
foot print, better cache use of task_struct because slab cache colouring
will still work etc.

-Andi
