Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSGYNwz>; Thu, 25 Jul 2002 09:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSGYNvo>; Thu, 25 Jul 2002 09:51:44 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:32773 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S315278AbSGYNvL>; Thu, 25 Jul 2002 09:51:11 -0400
Date: Thu, 25 Jul 2002 08:54:25 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200207251354.IAA06582@tomcat.admin.navo.hpc.mil>
To: imcol@unicyclist.com, linux-kernel@vger.kernel.org
Subject: Re: Alright, I give up.  What does the "i" in "inode" stand for?
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Mose <imcol@unicyclist.com>:
> What bothers my self a bit more in the kernel context, and thus 
> makes me an even more eager "Kernel alienate" than I believe Rob
> to be, are the "atomic_" calls/functions and their semantic origin.
> I believe that every Unix has "atomic_" calls all though perhaps 
> differently designed. And I totally fail to understand why some 
> one decided to name theese functions "atomic_"
> 
> To my own thinking, the atomical parts of any process in a 
> computer are puny little switches that are mostly referred to as 
> bits, and theese bits have all the software support they can get 
> even with out any "atomic_" call. I don't find anything even 
> remotely close to an electron microscope within Unix either.
> So I fail. 

This reference has to do with operations that must be completed
against memory WITHOUT any intervening accesses. The reference "atomic_"
comes from "non-divisible" operations where the operation cannot
or must not be subdivided any further (also from physics where atoms
cannot normally be subdivided).

Most of the time, a single memory reference is considered an atomic
operation. HOWEVER, this fails when you have various sized units. The
data structure is thought of as being composed of multiple elements
of the smallest size (and I'll get to what is considered "smallest size"
later).

First, on a uniprocessor, the processing unit minimum is a byte. Yet many
data elements require 2 or 4 bytes. Using a single instruction to access
the unit would seem to be indivisible... but isn't. Consider the possibility
of a 2 byte data fetch - if one byte is at the end of a memory page, and
the next byte is in the following page, AND that following page is out of
memory... This turns a simple 2 byte fetch (posed here as a single instruction
operation) may turn into several hundred, to several thousand, before that
2 byte sized unit may be fetched. This isn't atomic - meaning indivisible.

The "smallest size" of a system depends on the hardware implementation -
A two byte fetch may be implemented as a single 8 or 16 byte fetch depending
on how the CPU/cache/memory bus/memory are connected. This introduces other
conditions on the definition of "atomic_". If there are two CPUs active then
either, or both, CPUs may access the same data. These access will actually
not occur simultaneously (unless dual ported memory which is truly rare) but
what happens is an interleavling of access. Assuming a bus of 16 bits that
transfers 16 bytes per access - the first CPU would start the activity
transferring 2 bytes. After that transfer, the first CPU starts the next 2
bytes - and the second CPU starts the first 2 bytes. This repeats until all
16 bytes are transferred to both CPUs. This action is not atomic either.

This does not cause problems UNLESS you are updating data. Say removing a
node from a linked list. At this time one CPU may put 2 bytes of pointer back
into the structure (out of 4 bytes), while the second CPU reads the old data,
mixed with the new data. At this point, the operation must be treated more like
a database "transaction", where no access is granted until the transaction is
complete.

The "atomic_" functions implement a method to force all other access to the
data to wait UNTIL the operation (say removing a node from a linked list)
is complete. In many cases, instead of the entire operation being "atomic",
what is implemented is a flag that is "atomic". If the flag is set, wait.
if the flag is clear, set it and continue. NOTE: this is a complex operation
that requires more than on instruction (depending on CPU, instruction set, and
whether there are multiple CPUs). An instruction for this "test and set" can
exist, AND be atomic when used with one CPU. It doesn't necearily mean it is
atomic when used with multiple CPUs. Hence - the functions would implement
a method to support a system wide "atomic" operations that are guaranteed
to be indivisible, even with multiple CPUs in the system.

....
> I realize that most folks In LKML use "foo", "bar" and it's dad,
> "foobar" with outmost joy and that there is complete and utter 
> understanding of what the "foos" and "bars" actually stand for 
> in your contemporary discussion partners reasoning scheeme.

"foo", "bar" and "foobar" (and sometimes "fubar" which I believe is the
origin of the terms) are old slang (see hacker dictionary). They are used
to represent something much more complicated to write...

ie:
	void *foobar()

would mean "a function returning a pointer to a void type" where the actual
NAME of the function is not really relevent to the topic. This can be carried
to connect things like the above together as a form of prototype specification,
used only in describing the prototype, and is not the prototype itself.

No, it isn't 100% accurate. And it is easily misunderstood, especially if
english (the US style) is mixed with the (British syle) and mixed with
non-english transliterations of other idiomatic language structures.

But it means the participants in the discussion LEARN more about communicating
with others - sometimes emotionally, sometimes with laughter, sometimes just
a "oh, so that is what you mean...".

Sometimes it may take a little longer to get to a solution, but it seems to
be more fun, and the result is usually much better than what happens in more
regimented organizations.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
