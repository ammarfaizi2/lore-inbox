Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262504AbVCaGaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbVCaGaL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 01:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVCaGaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 01:30:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:32930 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262504AbVCaG2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 01:28:52 -0500
Date: Wed, 30 Mar 2005 22:28:43 -0800
From: Chris Wright <chrisw@osdl.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: LSM hooks
Message-ID: <20050331062843.GR28536@shell0.pdx.osdl.net>
References: <424B78F9.2040606@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424B78F9.2040606@comcast.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* John Richard Moser (nigelenki@comcast.net) wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Well the LSM mailing list seems to be dead, even the archives stop at
> Jan 15 2005.  My own mails don't come back to me (I'm subscribed).

They're coming through just fine, not sure why the archives are stale
though (I'll take a look).

> So, Which version of Linux will first implement stacking in LSM as per
> Serge Hallyn's patches?

None are ready yet.  Serge is still wading through performance testing.
There's no telling about merging without a magic eightball, a handle on
the performance issues, and some bonafide users.

> Where is the new documentation?

It's in the archives ;-)  There's not much to document.  Each hook would
potentially call a chain of modules rather than just one.

> As for hooks, a few questions.
> 
> 1.  With shm_shmctl(), can I control permissions assigned to shared
> memory using shmctl()?  I want to prevent memory protections on the shm
> segment from being in certain combinations; however, if any changes
> AFTER creation go through mprotect(), I can use file_mprotect() because
> I will be preventing the same transitions everywhere.
> 
> Shared memory mappings seem to always be in VM_WRITE | VM_MAYWRITE,
> so they're sane by default at creation time.  Control over mprotect()
> has this covered beyond that.

And VM_MAYREAD and VM_MAYEXEC typically as well (mmap does that
naturally), so mprotect is rather open for abuse here.

> 2.  Is shared memory always attached to without PROT_EXEC?  If not, how
> would I control this?  What is the best hook?

No, shamt(SHM_EXEC), for example, will attach to the segment with
PROT_EXEC.

> 3.  I want control over the memory protections on the stack and heap.
> PT_GNU_STACK allows for an executable stack/heap.  Is there a way for me
> to control this so that I can i.e. mandatorily make the stack/heap
> PROT_READ|PROT_WRITE and never PROT_EXEC?  The only way I can see is to
> add a hook in load_elf_binary(). . . .
> 
> In other words, I want a module to be able to force the heap and stack
> to be !EXEC.

Thus far we intentionally left that type of work out, rather left it as
something for access control. (you can easily stop from creating or
changing such vmas).

>  do_brk() only has a check, but I wish to elegantly control what may
> happen here.  I would need a hook that would allow me to supply
> something to AND flags with after the following line:
> 
>         flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
> 
> So for example:
> 
>         flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
> 	/* stacking should AND together each value and return the
> 	 * result
> 	 */
> 	flags &= security_vm_brk();
> 
> I would of course have my module returning (~VM_MAYEXEC) as in PaX.

I'm not convinced it makes sense as lsm work.

> 4.  file_mmap() is only a check; however, to be very unintrusive, I want
> to be able to alter vm_flags in do_mmap_pgoff().  Particularly, I want
> to be able to supply a mask to AND them with.  The current code looks like:
> 
>         error = security_file_mmap(file, prot, flags);
>         if (error)
>                 return error;
> 
> To accomplish this task, one of two venues would be taken.  The first,
> shown below, adds a new hook in the same place:
> 
>         error = security_file_mmap(file, prot, flags);
>         if (error)
>                 return error;
> 	/* Serge's stacking code should AND together each thing we get
> 	 * back from each module to produce the most restrictive set
> 	 */
> 	vm_flags &= security_file_mmap_vm_flags(file, prot, flags);
> 
> The second alters the current hook, requiring all LSMs using the
> file_mmap() hook to be rewritten:
> 
> 	{
> 		int my_vm_flags = ~0;
> 	        error = security_file_mmap(file, prot, flags,
> 		  &my_vm_flags);
> 	        if (error)
>         	        return error;
> 		/* Serge's stacking code should AND together each
> 		 *  my_vm_flags
> 		 */
> 		vm_flags &= my_vm_flags;
> 	}
> 
> Having one hook is most elegant; breaking an API is least elegant.
> Which would be more likely to be genuinely accepted as an LSM hook
> modification?  I'm thinking adding a second hook, as it won't break
> SeLinux and friends. . . .

Honestly, neither at this point.  This is access control, which is
intended not to have side-effects like changing flags, rather look at
the request and allowing/denying based on subject/object and request
type.  Especially when you consider stacking as you mentioned.  Does a
module down the chain get to boost the bits in my_vm_flags?  But the
earlier module turned those bits off on purpose.  See the trouble?
Serge's stacker work already identified some hooks that could have
problematic interactions like this, and we changed them in prep for
possible stacker work.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
