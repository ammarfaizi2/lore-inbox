Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277564AbRJLH7O>; Fri, 12 Oct 2001 03:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277565AbRJLH7F>; Fri, 12 Oct 2001 03:59:05 -0400
Received: from trillium-hollow.org ([209.180.166.89]:47621 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S277564AbRJLH6t>; Fri, 12 Oct 2001 03:58:49 -0400
To: Eric Sandeen <sandeen@sgi.com>
cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: RH 7.1 gcc 2.96 bug (was Re: TAKE - work around gcc bug during xfs_growfs )
In-Reply-To: Your message of "Thu, 11 Oct 2001 11:59:20 CDT."
             <3BC5CFE8.84FDB6FC@sgi.com> 
Date: Fri, 12 Oct 2001 00:59:04 -0700
From: erich@uruk.org
Message-Id: <E15rxDk-0005tf-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eric Sandeen <sandeen@sgi.com> wrote:

> > You may want to check it against the rawhide -99 version, since you know
> > exactly what to test for.  If you'd like I could try that tonight for
> > you.
> 
> Sure, if you'd like to test it that would be great.  I was going to
> install that compiler RPM, but it needs a new binutils which needs a
> new glibc which needs...  :)
> 
> Take a look at that URL for the diff I posted, and back it out.
> 
> To test for the error,
...[example creating an XFS filesystem about 1/2 the partition size,
    then growing it to the full partition size]...
> If you see any errors, it didn't work.  :)

Well, I wasn't able to reproduce with your test case at all.  I suspect
that maybe it's the fact that I only had a 2GB spare partition to try it
on.

On the positive (??!?) side, I looked at the disassembly and found
what the compiler is doing wrong in the case you worked around
(ok, so you probably already know this, but I'm putting this here
so that someone can fix the bug or convince RedHat to move to
away from 2.96, maybe to 3.x).

In the second one of the 5 cases of where you added a temporary rather
than a putting the macro in the function parameter sequence directly,
there are some operations done to what appear to be spill locations,
but the spill and reload are never performed...  so it seems these
locations were allocated for spill/reload, but then wires got crossed
somewhere.

In the "fixed" version, the exact same operations are performed
on the same stack locations, but the spill happens before and a reload
happens afterward, hence my suspicions.

Here is the assembly output difference (from the original and recently
"fixed" version of "linux/fs/xfs/xfs_fsops.c" in the linux-xfs CVS
tree):

   "original version":

	sall    %cl, %eax
	testb   $32, %cl
	cmovne  %eax, %edx
	cmovne  %edi, %eax

    [no spill?!?]

  -->	addl    $2, 16(%esp)
  -->	adcl    $0, 20(%esp)

    [no reload!?!]

	shldl   $9, %eax, %edx
	sall    $9, %eax
	pushl   %edx
	pushl   %eax


   "fixed version":

	sall    %cl, %eax
	testb   $32, %cl
	cmovne  %eax, %edx
	cmovne  %ebx, %eax
  S->	movl    %eax, 8(%esp)
  -->	addl    $2, 8(%esp)
  S->	movl    %edx, 12(%esp)
  -->	adcl    $0, 12(%esp)
	pushl   $8708
	movl    80(%esp), %ecx
	sall    $9, %ecx
	pushl   %ecx
  R->	movl    16(%esp), %eax
  R->	movl    20(%esp), %edx
	shldl   $9, %eax, %edx
	sall    $9, %eax
	pushl   %edx
	pushl   %eax


Note the ending code sequence to push the parameters on the stack
are the same, but in the first sequence, the operations are done
on memory locations that have no connection with the rest of the
code.  Ack.

It is very reproducable and happens in all the RedHat 7.1 gcc 2.96
series compiler versions I tried:  -81 (the one in the base release),
-85 (the one in RedHat's update set), -88, and -99 (the most recent
currently in RawHide).  Personally, this problem is weird enough to
kind of spook me...  seems they've had busted register spill/reload
logic for a while.

The RawHide GCC 3.0.1 compiler I grabbed doesn't have this problem,
and the rest of the code in that file appears to be correct regardless
of your workaround.  Same with "kgcc".


Do you want me to send this to RedHat?  ...or have you got as good/
better explanation to hand to them already?


--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
