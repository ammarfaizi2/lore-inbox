Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVCaEN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVCaEN5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 23:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVCaEN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 23:13:57 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:24487 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261930AbVCaENs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 23:13:48 -0500
Message-ID: <424B78F9.2040606@comcast.net>
Date: Wed, 30 Mar 2005 23:13:45 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: LSM hooks
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Well the LSM mailing list seems to be dead, even the archives stop at
Jan 15 2005.  My own mails don't come back to me (I'm subscribed).


So, Which version of Linux will first implement stacking in LSM as per
Serge Hallyn's patches?

Where is the new documentation?


As for hooks, a few questions.

1.  With shm_shmctl(), can I control permissions assigned to shared
memory using shmctl()?  I want to prevent memory protections on the shm
segment from being in certain combinations; however, if any changes
AFTER creation go through mprotect(), I can use file_mprotect() because
I will be preventing the same transitions everywhere.

Shared memory mappings seem to always be in VM_WRITE | VM_MAYWRITE,
so they're sane by default at creation time.  Control over mprotect()
has this covered beyond that.


2.  Is shared memory always attached to without PROT_EXEC?  If not, how
would I control this?  What is the best hook?


3.  I want control over the memory protections on the stack and heap.
PT_GNU_STACK allows for an executable stack/heap.  Is there a way for me
to control this so that I can i.e. mandatorily make the stack/heap
PROT_READ|PROT_WRITE and never PROT_EXEC?  The only way I can see is to
add a hook in load_elf_binary(). . . .

In other words, I want a module to be able to force the heap and stack
to be !EXEC.

 do_brk() only has a check, but I wish to elegantly control what may
happen here.  I would need a hook that would allow me to supply
something to AND flags with after the following line:

        flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;

So for example:

        flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
	/* stacking should AND together each value and return the
	 * result
	 */
	flags &= security_vm_brk();

I would of course have my module returning (~VM_MAYEXEC) as in PaX.

4.  file_mmap() is only a check; however, to be very unintrusive, I want
to be able to alter vm_flags in do_mmap_pgoff().  Particularly, I want
to be able to supply a mask to AND them with.  The current code looks like:

        error = security_file_mmap(file, prot, flags);
        if (error)
                return error;

To accomplish this task, one of two venues would be taken.  The first,
shown below, adds a new hook in the same place:

        error = security_file_mmap(file, prot, flags);
        if (error)
                return error;
	/* Serge's stacking code should AND together each thing we get
	 * back from each module to produce the most restrictive set
	 */
	vm_flags &= security_file_mmap_vm_flags(file, prot, flags);

The second alters the current hook, requiring all LSMs using the
file_mmap() hook to be rewritten:

	{
		int my_vm_flags = ~0;
	        error = security_file_mmap(file, prot, flags,
		  &my_vm_flags);
	        if (error)
        	        return error;
		/* Serge's stacking code should AND together each
		 *  my_vm_flags
		 */
		vm_flags &= my_vm_flags;
	}

Having one hook is most elegant; breaking an API is least elegant.
Which would be more likely to be genuinely accepted as an LSM hook
modification?  I'm thinking adding a second hook, as it won't break
SeLinux and friends. . . .


5.  It looks as if I can modify the vma to handle relocations the same
way PaX does from security_file_mprotect().  That's fine.  Now all I
have to do is figure out htf pip's logic works, mainly where the data
that is set for certain checks comes from.  Relocations aren't magically
MAY_WRITE, even if they come like that by default.


It seems to me that in total, I must create at least two hooks:

1.  security_file_mmap_vm_flags(file, prot, flags)
	mm/mmap.c:do_mmap_pgoff()
	This will allow control over how mmap() segments are created,
	with unintrusive modifications to their vma permissions.  The
	modifications I intend to impliment are quite well tested.

	This hook will return a bitmask to be ANDed with vm_flags.  The
	stacking implementation can simply AND every result from every
	module together to get the least restrictive set.

2.  security_vm_brk();
	mm/mmap.c:do_brk()
	This will allow the permissions on the heap to be unintrusively
	controlled.

	This hook will return a bitmask to be ANDed with flags.  The
	stacking implimentation can AND every result from every module
	together to get the least restrictive set.

There may be a third needed to control the stack's permissions; but I
don't know yet, as I can't find how that's even done.  For now, the
kernel is oopsing when i try to mount another xfs partition (from a 64
bit system), so I need to reboot.  :/


In case anyone is wondering, as an excercise (but potentially as
something I may aim at mainline), I'm trying to port some of the stuff
from PaX into an LSM; particularly, the memory protection enhancements.
 As a proof of concept, I'm considering supporting PT_PAX_FLAGS from the
module; but I'm also considering a security label.  My concern with a
security label is conflicting with SeLinux and having issues with ReiserFS.

Particularly, I'm trying to port over stuff from
http://pax.grsecurity.net/docs/mprotect.txt

I would not be so insane as to attempt to place ASLR into a security
module; it could be done if the right hooks were there, but the results
would be insane, and mixing such modules would be dangerous.  When
2.6.12 rolls around with ASLR, however, I may consider taking a crack at
it.  Controling (increasing to a predefined maximum) the entropy of the
ASLR in bits may be viable.  Brute force deterrance (from GrSecurity)
may also be viable in an LSM, but is useless with very small order ASLR.

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

iD8DBQFCS3j4hDd4aOud5P8RAqMaAJ9xu5oUsgakfrtnczSeOLvsYTm0KQCcDwNJ
nb3iGOkcUwYCQpQtWP7t7o4=
=v51V
-----END PGP SIGNATURE-----
