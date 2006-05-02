Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWEBIt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWEBIt3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 04:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWEBIt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 04:49:28 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64459 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932514AbWEBIt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 04:49:27 -0400
To: Andi Kleen <ak@suse.de>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, herbert@13thfloor.at, dev@sw.ru,
       linux-kernel@vger.kernel.org, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@us.ibm.com, frankeh@us.ibm.com
Subject: Re: [PATCH 7/7] uts namespaces: Implement CLONE_NEWUTS flag
References: <20060501203906.XF1836@sergelap.austin.ibm.com>
	<p7364ko7w66.fsf@bragg.suse.de>
	<m1lktk97ks.fsf@ebiederm.dsl.xmission.com>
	<200605021017.19897.ak@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 02 May 2006 02:48:23 -0600
In-Reply-To: <200605021017.19897.ak@suse.de> (Andi Kleen's message of "Tue,
 2 May 2006 10:17:19 +0200")
Message-ID: <m14q0895ig.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Tuesday 02 May 2006 10:03, Eric W. Biederman wrote:
>> Andi Kleen <ak@suse.de> writes:
>> 
>> > "Serge E. Hallyn" <serue@us.ibm.com> writes:
>> >
>> >> Implement a CLONE_NEWUTS flag, and use it at clone and sys_unshare.
>> >
>> > I still think it's a design mistake to add zillions of pointers to
> task_struct
>> > for every possible kernel object. Going through a proxy datastructure to 
>> > merge common cases would be much better.
>> 
>> The design point is not every kernel object.  The target is one
>> per namespace.  Or more usefully one per logical chunk of the kernel.
>
> Which are likely tens or even hundreds if you go through all the source.
> Even tens would bloat task_struct far too much.

We don't have that many places where we put global names in
the linux api.  Yes there are several and it is painful,
but we are nowhere near as high as you expect.

>> The UTS namespace is by far the smallest of these pieces.
>> 
>> The kernel networking stack is probably the largest.
>> 
>> At last count there were about 7 of these, enough so that the few
>> remaining clone bits would be sufficient.
>
> 7 additional bits will probably not be enough. I still don't
> quite understand why you want individual bits for everything.
> Why not group them into logical pieces? 

Each bit currently maps to one logical piece, that is why I expect
to have enough bits.

> If you really want individual bits you'll likely need to think
> about a clone2() call with more flags soon.

Being short on bits should keep us thinking about keeping things
in logical chunks.

>> Do you disagree that to be able to implement this properly we
>> need to take small steps?
>
> No, but at least the basic infrastructure for expansion should 
> be added first.
>
>> Are there any semantic differences between a clone bit and what you
>> are proposing?
>
> No just internals.

Good that means we can still optimize this.

>  > If it is just an internal implementation detail do you have a clear
>> suggestion on how to implement this?  Possibly illustrated by the
>> thread flags that are already in this situation, and more likely
>> to always share everything.
>
> Have a proxy structure which has pointers to the many name spaces and a bit
> mask for "namespace X is different". This structure would be reference
> counted. task_struct has a single pointer to it.
>
> On clone check the clone flags against the bit mask. If there is any
> difference allocate a new structure and clone the name spaces into it.
> If no difference just use the old data structure after increasing its 
> reference count. 
>
> Possible name "nsproxy".

Sounds reasonable, and I have nothing against it.
I simply think at this point where we are still struggling to
get the simplest namespace merged and working correctly that is a premature
optimization.
  
>> Except for reducing reference counting I really don't see where
>> we could have a marked improvement.  I also don't see us closing
>> the door to that kind of implementation at this point, but instead
>> taking the simple path.
>
> With many name spaces you would have smaller task_struct, less cache 
> foot print, better cache use of task_struct because slab cache colouring
> will still work etc.

Makes sense.  I have no problem against that as an optimization,
and it is firmly on the todo list as something to try.  Right now with
only 2 non-thread clone flags I believe it will obfuscate the code more
than help performance. 

Eric
