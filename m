Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbVHNDxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbVHNDxH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 23:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVHNDxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 23:53:06 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:52448 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932429AbVHNDxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 23:53:06 -0400
Message-ID: <42FEBFFF.7040701@comcast.net>
Date: Sat, 13 Aug 2005 23:52:31 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SELinux policies, memory protections
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I was writing a section of my paper ("Designing a Secure and Friendly
Operating System") and basically describing and explaining why the
memory protection policy ("mprotect() restrictions") supplied by PaX is
a powerful security tool; and I had a thought.  PaX places the policy in
the kernel; but with LSM hooks in mprotect() and friends, it may be
possible to implement it entirely in policy.  This would be interesting,
as it would allow a system implementing the suggested enhancements to
avoid additional kernel code.

What I want to know is, what facilities does SELinux supply in the
current policy format to control the abuse of mprotect(), mmap(), and
friends; and where can I find an online reference on this?

For reference, PaX defines the following "good" mapping states where new
code can't be introduced (note that VM_READ and VM_MAYREAD are
completely ignored as they are of no consequence):

      VM_WRITE
      VM_MAYWRITE
      VM_WRITE | VM_MAYWRITE
      VM_EXEC
      VM_MAYEXEC
      VM_EXEC | VM_MAYEXEC

Of course the kernel won't allow VM_WRITE or VM_EXEC without VM_MAYWRITE
or VM_MAYEXEC, so this leaves us with

      VM_MAYWRITE
      VM_MAYEXEC
      VM_WRITE | VM_MAYWRITE
      VM_EXEC | VM_MAYEXEC


This gives us a few target guarantees:

1.  No mapping may be created in any state other than those listed above
(VM_READ and VM_READ|VM_MAYREAD are permissible in addition to any
allowed state)

2.  No mapping may transition to any state not described in (1)

3.  No existing mapping without VM_EXEC is to have VM_MAYEXEC or be
given VM_EXEC or VM_MAYEXEC at any time in the remainder of its life
cycle; this includes mappings that started with and later dropped VM_EXEC



And there are a few other things that I want guaranteed:

1.  Anonymous mappings are always created without VM_EXEC or VM_MAYEXEC

2.  Shared memory mappings are always created without VM_EXEC or
VM_MAYEXEC (this is the current case)

3.  File backed mmap() segments requesting PROT_WRITE get
VM_WRITE|VM_MAYWRITE (and VM_READ|VM_MAYREAD if PROT_READ was
requested), but never VM_EXEC or VM_MAYEXEC even if requested

4.  For certain applications, it may be necessary that we can
automatically grant VM_EXEC|VM_MAYEXEC on file-backed mappings not
requesting PROT_WRITE, if those applications assume that PROT_READ
implies PROT_EXEC (this is how PaX works)


Finally, the ability to detect if the affected area is part of a
relocation and account for that in policy would be important, because
PaX set to disable ELF text relocations breaks quite a number of things;
trying to reconstruct the memory policy from PaX with an SELinux policy
without being able to mimic the special case allowance of ELF text
relocations would be disasterous.



REFERENCES:

  http://pax.grsecurity.net/docs/mprotect.txt


- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC/r/+hDd4aOud5P8RAkCIAJ4utVh8rEZqLb3WDvM75gnkZ/+LOgCaAizc
zTSxkvYL0MFtC+QqEt//hbA=
=idfj
-----END PGP SIGNATURE-----
