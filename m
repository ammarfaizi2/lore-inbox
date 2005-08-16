Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbVHPTnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVHPTnk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 15:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVHPTnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 15:43:39 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:646 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932392AbVHPTnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 15:43:39 -0400
Subject: Re: SELinux policies, memory protections
From: Stephen Smalley <sds@tycho.nsa.gov>
To: John Richard Moser <nigelenki@comcast.net>
Cc: James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org
In-Reply-To: <42FEBFFF.7040701@comcast.net>
References: <42FEBFFF.7040701@comcast.net>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 16 Aug 2005 15:41:21 -0400
Message-Id: <1124221281.29692.175.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-13 at 23:52 -0400, John Richard Moser wrote:
> I was writing a section of my paper ("Designing a Secure and Friendly
> Operating System") and basically describing and explaining why the
> memory protection policy ("mprotect() restrictions") supplied by PaX is
> a powerful security tool; and I had a thought.  PaX places the policy in
> the kernel; but with LSM hooks in mprotect() and friends, it may be
> possible to implement it entirely in policy.  This would be interesting,
> as it would allow a system implementing the suggested enhancements to
> avoid additional kernel code.
> 
> What I want to know is, what facilities does SELinux supply in the
> current policy format to control the abuse of mprotect(), mmap(), and
> friends; and where can I find an online reference on this?

Consider cc'ing the listed maintainers of SELinux in the future when you
have a question about it - it can only help in getting a quick response.
Or asking on the public selinux mailing list.  With regard to your
question, I think you want to look at the execmem and execmod permission
checks.  See 
http://marc.theaimsgroup.com/?l=bk-commits-head&m=110491550432114&w=2

> For reference, PaX defines the following "good" mapping states where new
> code can't be introduced (note that VM_READ and VM_MAYREAD are
> completely ignored as they are of no consequence):
> 
>       VM_WRITE
>       VM_MAYWRITE
>       VM_WRITE | VM_MAYWRITE
>       VM_EXEC
>       VM_MAYEXEC
>       VM_EXEC | VM_MAYEXEC
> 
> Of course the kernel won't allow VM_WRITE or VM_EXEC without VM_MAYWRITE
> or VM_MAYEXEC, so this leaves us with
> 
>       VM_MAYWRITE
>       VM_MAYEXEC
>       VM_WRITE | VM_MAYWRITE
>       VM_EXEC | VM_MAYEXEC
> 
> 
> This gives us a few target guarantees:
> 
> 1.  No mapping may be created in any state other than those listed above
> (VM_READ and VM_READ|VM_MAYREAD are permissible in addition to any
> allowed state)
> 
> 2.  No mapping may transition to any state not described in (1)
> 
> 3.  No existing mapping without VM_EXEC is to have VM_MAYEXEC or be
> given VM_EXEC or VM_MAYEXEC at any time in the remainder of its life
> cycle; this includes mappings that started with and later dropped VM_EXEC
> 
> 
> 
> And there are a few other things that I want guaranteed:
> 
> 1.  Anonymous mappings are always created without VM_EXEC or VM_MAYEXEC

mmap/mprotect PROT_EXEC on an anon mapping will trigger an execmem
permission check in SELinux.  Hence, a process must have that permission
in the policy in order to create an executable anonymous mapping.
Otherwise, the mmap/mprotect will fail.

> 2.  Shared memory mappings are always created without VM_EXEC or
> VM_MAYEXEC (this is the current case)
> 
> 3.  File backed mmap() segments requesting PROT_WRITE get
> VM_WRITE|VM_MAYWRITE (and VM_READ|VM_MAYREAD if PROT_READ was
> requested), but never VM_EXEC or VM_MAYEXEC even if requested

mmap/mprotect PROT_EXEC|PROT_WRITE on a private file mapping will also
trigger an execmem permission check in SELinux.  For the case where
mmap/mprotect PROT_EXEC is applied to a previously modified private file
mapping, see discussion of execmod below.

> 4.  For certain applications, it may be necessary that we can
> automatically grant VM_EXEC|VM_MAYEXEC on file-backed mappings not
> requesting PROT_WRITE, if those applications assume that PROT_READ
> implies PROT_EXEC (this is how PaX works)

The core kernel already has a read-implies-exec logic, and this is
applied to the protection value before SELinux is called to check
permissions.  How SELinux deals with it depends on a setting
(checkreqprot); SELinux can either check permissions based on the
protection requested by the application (i.e. don't check
execute-related permissions when the kernel automatically granted them)
or based on the effective protection that is being applied (i.e. check
execute-related permissions even if the kernel automatically granted
them).  See
http://marc.theaimsgroup.com/?l=bk-commits-head&m=111048146105861&w=2

> Finally, the ability to detect if the affected area is part of a
> relocation and account for that in policy would be important, because
> PaX set to disable ELF text relocations breaks quite a number of things;
> trying to reconstruct the memory policy from PaX with an SELinux policy
> without being able to mimic the special case allowance of ELF text
> relocations would be disasterous.

mprotect PROT_EXEC on a private file mapping that has had some COW done
(typically indicating previous modification) triggers an execmod
permission check.  This is a process-to-file check, so you can allow it
for selected processes and selected objects.  It typically only occurs
for text relocations.  Hence, by labeling such objects appropriately,
you can limit this permission to particular objects.

The benefit of having these checks:
http://marc.theaimsgroup.com/?l=selinux&m=111348610311179&w=2

More recently, some additional checks have been introduced:
http://marc.theaimsgroup.com/?l=bk-commits-head&m=111974870402956&w=2
http://marc.theaimsgroup.com/?l=bk-commits-head&m=111974871308442&w=2

These checks provide some restrictions in the event that execmem must be
allowed to a process, e.g. for runtime code generation, by still
disabling the ability to make the primary stack executable or the heap
executable.

-- 
Stephen Smalley
National Security Agency

