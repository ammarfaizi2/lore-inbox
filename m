Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267251AbUGMXxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267251AbUGMXxw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 19:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267249AbUGMXxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 19:53:52 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:36796 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267248AbUGMXxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 19:53:35 -0400
Message-ID: <40F475FC.9090202@comcast.net>
Date: Tue, 13 Jul 2004 19:53:32 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040630)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: linux-kernel@vger.kernel.org,
       linux-c-programming <linux-c-programming@vger.kernel.org>
Subject: Re: Garbage Collection and Swap
References: <40EF3BCD.7080808@comcast.net> <40F45DEF.8060307@techsource.com>
In-Reply-To: <40F45DEF.8060307@techsource.com>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070708090607030302040904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070708090607030302040904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Timothy Miller wrote:
|
|
| John Richard Moser wrote:
|
|>
|> THE GARBAGE COLLECTOR WANDERS AROUND IN THE ENTIRE HEAP, AND IN SOME
|> CASES IN OTHER PARTS OF RAM, LOOKING FOR WHAT LOOKS LIKE POINTERS TO
|> YOUR ALLOCATED DATA.
|>
|
| Whose GC does this?
|

http://www.iecc.com/gclist/GC-faq.html


## C-compatible garbage collectors know where pointers may generally be
## found (e.g., "bss", "data", and stack), and maintain heap data
## structures that allow them to quickly determine what bit patterns
## might be pointers. Pointers, of course, look like pointers, so this
## heuristic traces out all memory reachable through pointers. What
## isn't reached, is reclaimed.

This just sticks out in my face
| I get the impression that the Java VM, for instance, knows what
[...]

blah blah java blah blah

Yeah Java was built around garbage collection, let's not talk about
this; I was talking about C.

|
| There is anecdotal evidence that this approach sometimes can improve
| performance over "manual" freeing because freeing can be done in bulk.
|

Dude.

if (check_for_tons_of_crap_that_says_I_am_not_used(p))
free(p);

Yeah.  It's a pain in the ass to check every time you turn around for
conditions that indicate that p is unused.  In some cases, it's a best
effort; you can't always tell.  I can believe that GC would be more
passive; hell, if it's not, just slow the GC down a bit.  Garbage
collection doesn't make sure there's no allocated ram that's not in use;
it only frees things it can determine as such.

| Java GC works very well, and it's a huge improvement over the "manual"

[...]

blah blah java blah blah

Everything is an improvement over manual mm.

|
| Now, if you're talking about trying to apply GC to C code, it's an
| entirely different matter.  C wasn't designed with GC in mind.  The very

[...huge paragraph that makes sense...]

Yeah my thoughts exactly.

|
| No, I don't think GC in C is feasible.

See above.

|

Incidently, I've compiled a list of pros/cons from legacy/refct/mm.

I'm going to point something out here though, about comparing these.

When you compare manual mm and reference counting, you're in the same
field:  Both of these set up deterministic points in program flow where
allocated blocks will be freed if it is determined that they are no
longer in use.  Both of these occur immediately when a specific body of
code is finished with a block of memory.

With garbage collection, it's different.  The garbage collector finds
out on its own at some undefined point after the block is no longer
needed that it can free it, and does so.  The GC is in no way obligated
to free the block as soon as it is no longer in use; it only does this
when it discovers this.  As such, a GC is not the same class of
operation as the other two.  You can show me a GC that imposes less
overhead than the other two methods; and I can retune that same GC to
use 99% of your CPU.

That being said, don't argue about the overhead of a GC, because it's
completely managable.

Attached is my list of pros/cons of each system.  It's just some scrap
for data I'm collecting, not presentation material.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA9HX5hDd4aOud5P8RAjyjAJ9bOxGUoRzGg66dgLHSEC7z5yUScgCfdc6+
cPaxYGWDN4Tx5IFA3bJgFIA=
=n2yk
-----END PGP SIGNATURE-----

--------------070708090607030302040904
Content-Type: text/plain;
 name="mmanagment.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmanagment.txt"

Manual
malloc() your ram manually
free() your memory manually

Pros:
High level of control
Autofreeing of temporary data is possible:  Dump pointers to temporary data into a pool that is deallocated later, and is destructed immediately before deallocation by deallocating all held pointers; then destruct and deallocate the pool before leaving the code body

Cons:
Have to determine when not using something before free()ing it
Can free stuff you're not done with easily
Can lose track of stuff without free()ing it easily

Con Caveats:
None

Reference Counting
Create objects holding your data
Retain those objects when using them
Release those objects when not using them

Pros:
Maintain high level of control over memory management
References are held within immediate code bodies such as companion functions, single functions, or objects; thus, when the end of the object's usefulness for that code is reached, it may be released.
Increased chance of properly freeing data:  Companion function to that which allocated it releases it; atomic functions retain/release in their own right
Lower chances of freeing in-use data:  Once all references to an object are gone, via releasing it, nobody can access it anymore anyway, and it is thus deallocated; threaded environments retain before splitting off into new thread to avoid race conditions of create-create_thread-release-retain-release, instead using create-retain-create_thread-release-release.
Autoreleasing temporary data is possible:  Add retained objects to the autorelease pool, which releases them for each time they're entered into it as it is destructed.

Cons:
Requires some level of object orientation, at least by encapsulating data into a structure with a reference count
Minor overhead from the retain counting and locking around retain counts
True, permenant circular references between objects retaining a reference to eachother causes orphanage

Con Caveats:
It's not that much more complex to code with this
Overhead is arguable versus the other two methods' needed checks
Good coding will avoid circular references where one object won't normally be aware of and tell the other to let go of it, thus causing the mutual deallocation of both

Garbage Collection
malloc() your ram manually
The garbage collector determines when you aren't using it anymore

Pros:
Recovers from memory leaks, where data is unreachable and thus freeing it is harmless anyway
Takes the job of freeing up ram off the programmer
Conservative garbage collectors usually don't free in-use data

Pro Caveats:
Freeing up memory when leaking doesn't make that memory any less important; if you lose critical data that you just can't get back (I.e. by clobbering a pointer), you simply lose it.
Taking the job of freing up ram off the programmer is significant versus manual memory management; however, it's a trivial task with reference counting, as even bugs caused by mistakes here are easily tracked down and fixed
Certain programming techniques like the XOR Linked LIst tirck or those which write pointers to files will have problems with the garbage collector; similar things may happen with object oriented programming in which a class member gets a thread and then references to the class are lost, depending on how the language implements things.  Objects may even have a permenant reference to self, which makes them never free.

Cons:
Takes most control away from the programmer
Even conservative garbage collectors free up things still in use, especially in strange situations such as where the pointers to the data aren't where the GC expects them to be; or when they're mangled or encoded
Minor overhead in the form of a second thread, or periodic pauses, depending on implementation
Collector may lag behind, allowing large numbers of small, temporary allocations to build into large amounts of used but unfreed memory
Not sane for Object Oriented Programming, unless it specifically can identify the language in use and its constructs

Con Caveats:
Control over memory management is usually a security blanket, although this is not always true
Conservative garbage collectors usually make the grade, although they do miss in many useful situations
Overhead is usually comparable to reference counting or explicite malloc()/free(), but grows with vm size (especially heap size)
Ram is usually cheap, unless you're wasting hundreds of megabytes from being in a long-running (3-4 seconds even) tight loop that allocates and frees ram repetedly
Garbage collectors exist for C and C++, but they don't work for Objective-C for example; similarly, there are garbage-collected Objective-C objects using a specially made collector

--------------070708090607030302040904--
