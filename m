Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbVCaHhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVCaHhN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 02:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVCaHhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 02:37:12 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:4295 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262546AbVCaHap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 02:30:45 -0500
Message-ID: <424BA71C.8030204@comcast.net>
Date: Thu, 31 Mar 2005 02:30:36 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: LSM hooks
References: <424B78F9.2040606@comcast.net> <20050331062843.GR28536@shell0.pdx.osdl.net>
In-Reply-To: <20050331062843.GR28536@shell0.pdx.osdl.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Chris Wright wrote:
> * John Richard Moser (nigelenki@comcast.net) wrote:
> 
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>Well the LSM mailing list seems to be dead, even the archives stop at
>>Jan 15 2005.  My own mails don't come back to me (I'm subscribed).
> 
> 
> They're coming through just fine, not sure why the archives are stale
> though (I'll take a look).
> 
> 
>>So, Which version of Linux will first implement stacking in LSM as per
>>Serge Hallyn's patches?
> 
> 
> None are ready yet.  Serge is still wading through performance testing.
> There's no telling about merging without a magic eightball, a handle on
> the performance issues, and some bonafide users.
> 
> 
>>Where is the new documentation?
> 
> 
> It's in the archives ;-)  There's not much to document.  Each hook would
> potentially call a chain of modules rather than just one.
> 
> 
>>As for hooks, a few questions.
>>
>>1.  With shm_shmctl(), can I control permissions assigned to shared
>>memory using shmctl()?  I want to prevent memory protections on the shm
>>segment from being in certain combinations; however, if any changes
>>AFTER creation go through mprotect(), I can use file_mprotect() because
>>I will be preventing the same transitions everywhere.
>>
>>Shared memory mappings seem to always be in VM_WRITE | VM_MAYWRITE,
>>so they're sane by default at creation time.  Control over mprotect()
>>has this covered beyond that.
> 
> 
> And VM_MAYREAD and VM_MAYEXEC typically as well (mmap does that
> naturally), so mprotect is rather open for abuse here.
> 

Dang, I want read/write but never execute for shm.

> 
>>2.  Is shared memory always attached to without PROT_EXEC?  If not, how
>>would I control this?  What is the best hook?
> 
> 
> No, shamt(SHM_EXEC), for example, will attach to the segment with
> PROT_EXEC.
> 

Again, I need to control that. . . .

> 
>>3.  I want control over the memory protections on the stack and heap.
>>PT_GNU_STACK allows for an executable stack/heap.  Is there a way for me
>>to control this so that I can i.e. mandatorily make the stack/heap
>>PROT_READ|PROT_WRITE and never PROT_EXEC?  The only way I can see is to
>>add a hook in load_elf_binary(). . . .
>>
>>In other words, I want a module to be able to force the heap and stack
>>to be !EXEC.
> 
> 
> Thus far we intentionally left that type of work out, rather left it as
> something for access control. (you can easily stop from creating or
> changing such vmas).
> 
> 
>> do_brk() only has a check, but I wish to elegantly control what may
>>happen here.  I would need a hook that would allow me to supply
>>something to AND flags with after the following line:
>>
>>        flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
>>
>>So for example:
>>
>>        flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
>>	/* stacking should AND together each value and return the
>>	 * result
>>	 */
>>	flags &= security_vm_brk();
>>
>>I would of course have my module returning (~VM_MAYEXEC) as in PaX.
> 
> 
> I'm not convinced it makes sense as lsm work.
> 

Well, it's in PaX; I could just split it out from PaX directly, but I'm
feeling creative.  Besides, it seems dismally unlikely that porting in
chunks of PaX just "here set this in mainline and here's a config option
to disable it" is going to work; I'd suspect an LSM has a much higher
chance of getting in for some reason.

Pretty much, I'm fairly sure that with PT_PAX_FLAGS processing, parts of
PaX could survive just fine in pieces.  Particularly, mprotect()
restrictions and the high-entropy ASLR (the kernel will have ES'
low-entropy ASLR in 2.6.12, basically a performance boost due to some
issues with cache hits/misses that I don't care to pretend to fully
understand).  I'd also consider trampoline emulation to replace the
executable stack in some apps, on a per-binary basis of course.

In the case of ASLR, I'd also like to port over Brad Spengler's brute
force deterrance from GrSecurity.  The deterrance would extend the brute
force period of the 64K stack ASLR to 34.13 hours, ignoring the
potential for stack stuffing.  The 2M randomization would hold up for
1092 hours under a brute force.

With the 256M randomization from PaX, the period is 2,236,962 hours.
Obviously more is better, whether you want to argue "overkill" or not;
PT_PAX_FLAGS has some room, so perhaps a flag to lighten ASLR could
allow {Heavy,Light} along with the basic {On,Off}, and the higher level
of ASLR could be used in many cases (this is also well tested).

In either case, I need some way of controlling the stuff I want to split
out from PaX.  I have the code that reads PT_PAX_FLAGS; but I have
serious doubts that that control mechanism would actually get in, even
though in my experience it works rather well.

At the very least, Arjan doesn't seem to hot on the following logic:

executable_stack = EXSTACK_DISABLE_X;
if (binary_has(PT_PAX_FLAGS)) {
  if (!(PT_PAX_FLAGS & FL_PAX_PAGEEXEC))
    executable_stack = EXSTACK_ENABLE_X;
}
else {
  if (PT_GNU_STACK)
    executable_stack = EXSTACK_ENABLE_X;
}

In other words, if the binary has a PT_PAX_FLAGS header, use that in
place of PT_GNU_STACK for determining if the stack/heap is executable;
else use PT_GNU_STACK.  PaX uses this in particular for pretty much the
same function as PT_GNU_STACK; I wanted to get everyone on the same
page.  The idea is of course that while nobody uses PT_PAX_FLAGS, the
changes are a noop; but anyone who supports PaX/ES/Vanilla_AMD64 would
have one-step proper marking rather than PT_GNU_STACK and PT_PAX_FLAGS.

While discussing it, Arjan also pointed out that Linus probably wouldn't
be too keen on hunking various settings into a single field (I can't see
why not).  It's a lot more likely (being that the patch for producing
PT_PAX_FLAGS in binutils exists already) that I could work PT_PAX_FLAGS
rather than a mythical other set of fields; this is kind of a
requirement for the mprotect() stuff I want to get into mainline,
because it breaks a handfull of programs (anything using nVidia's
libGLcore.so.1; mono; java; qemu).

My hacked-up solution was gonna be to use a security label; though I
hated that idea more.  I'm more keen on throwing a hook into the
PT_PAX_FLAGS processing routine and ANDing with whatever I get from there.

Not that any of this is actually going to get anything into the kernel;
Linus will probably just laugh and shake his head like he did the first
time PaX was submitted.

> 
>>4.  file_mmap() is only a check; however, to be very unintrusive, I want
>>to be able to alter vm_flags in do_mmap_pgoff().  Particularly, I want
>>to be able to supply a mask to AND them with.  The current code looks like:
>>
>>        error = security_file_mmap(file, prot, flags);
>>        if (error)
>>                return error;
>>
>>To accomplish this task, one of two venues would be taken.  The first,
>>shown below, adds a new hook in the same place:
>>
>>        error = security_file_mmap(file, prot, flags);
>>        if (error)
>>                return error;
>>	/* Serge's stacking code should AND together each thing we get
>>	 * back from each module to produce the most restrictive set
>>	 */
>>	vm_flags &= security_file_mmap_vm_flags(file, prot, flags);
>>
>>The second alters the current hook, requiring all LSMs using the
>>file_mmap() hook to be rewritten:
>>
>>	{
>>		int my_vm_flags = ~0;
>>	        error = security_file_mmap(file, prot, flags,
>>		  &my_vm_flags);
>>	        if (error)
>>        	        return error;
>>		/* Serge's stacking code should AND together each
>>		 *  my_vm_flags
>>		 */
>>		vm_flags &= my_vm_flags;
>>	}
>>
>>Having one hook is most elegant; breaking an API is least elegant.
>>Which would be more likely to be genuinely accepted as an LSM hook
>>modification?  I'm thinking adding a second hook, as it won't break
>>SeLinux and friends. . . .
> 
> 
> Honestly, neither at this point.  This is access control, which is
> intended not to have side-effects like changing flags, rather look at
> the request and allowing/denying based on subject/object and request
> type.  Especially when you consider stacking as you mentioned.  Does a
> module down the chain get to boost the bits in my_vm_flags?

Nope, see above, you AND all the results together and get the lowest
common denominator out of all.

>  But the
> earlier module turned those bits off on purpose.  See the trouble?
> Serge's stacker work already identified some hooks that could have
> problematic interactions like this, and we changed them in prep for
> possible stacker work.
> 
> thanks,
> -chris

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCS6cbhDd4aOud5P8RAga9AJ9bPywoHv+fDcv7LJOlb9bb3pZn1wCeLDqA
VEvBw2XMa7tuhDVB6MtCUZw=
=+U//
-----END PGP SIGNATURE-----
