Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264035AbRFTQ0n>; Wed, 20 Jun 2001 12:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264056AbRFTQ0d>; Wed, 20 Jun 2001 12:26:33 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:18054 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S264035AbRFTQ02>; Wed, 20 Jun 2001 12:26:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Aaron Lehmann <aaronl@vitelus.com>, hps@intermeta.de
Subject: Re: [OT] Threads, inelegance, and Java
Date: Wed, 20 Jun 2001 07:25:23 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010620042544.E24183@vitelus.com>
In-Reply-To: <20010620042544.E24183@vitelus.com>
MIME-Version: 1.0
Message-Id: <01062007252301.00776@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 June 2001 07:25, Aaron Lehmann wrote:
> On Wed, Jun 20, 2001 at 09:00:47AM +0000, Henning P. Schmiedehausen wrote:
> > Just the fact that some people use Java (or any other language) does
> > not mean, that they don't care about "performance, system-design or
> > any elegance whatsoever" [2].
>
> However, the very concept of Java encourages not caring about
> "performance, system-design or any elegance whatsoever".

The same arguments were made 30 years ago about writing the OS in a high 
level language like C rather than in raw assembly.  And back in the days of 
the sub-1-mhz CPU, that really meant something.

> If you cared
> about any of those things you would compile to native code (it exists
> for a reason). Need run-anywhere support? Distribute sources instead.
> Once they are compiled they won't need to be reinterpreted on every
> run.

I don't know about that.  The 8 bit nature of java bytecode means you can 
suck WAY more instructions in across the memory bus in a given clock cycle, 
and you can also hold an insane amount of them in cache.  These are the real 
performance limiting factors, since the inside of your processor is clock 
multiplied into double digits nowdays, and that'll only increase as die sizes 
shrink, transistor budgets grow, and cache sizes get bigger.

In theory, a 2-core RISC or 3-core VLIW processor can execute an interpretive 
JVM pretty darn fast.  Think a jump-table based version (not quite an array 
of function pointers dereferenced by the bytecode, instead something that 
doesn't push anything on the stack since you know where they all return to).  
The lookup is seperate enough that it can be done by another (otherwise idle) 
processor core.  Dunno how that would affect speculative execution.  But the 
REAL advantage of this is, you run straight 8 bit java code that you can fit 
GOBS of in the L1 and L2 caches.

Or if you like the idea of a JIT, think about transmeta writing a code 
morphing layer that takes java bytecodes.  Ditch the VM and have the 
processor do it in-cache.

This doesn't mean java is really likely to outperform native code.  But it 
does mean that the theoretical performance problems aren't really that bad.  
Most java programs I've seen were written by rabid monkeys, but that's not 
the fault of the language. [1].

I've done java on a 486dx75 with 24 megabytes of ram (my old butterfly 
keyboard thinkpad laptop), and I got decent performance out of it.  You don't 
make a lot of objects, you make one object with a lot of variables and 
methods in it.  You don't unnecessarily allocate and discard objects 
(including strings, the stupid implementation of string+string+string is 
evil,) to bulk up the garbage collector and fragment your memory.  The 
garbage collector does NOT shrink the heap allocated from the OS, the best 
you can hope for is that some of it'll be swapped out, which is evil, but an 
implementation problem rather than a language design problem.)

For a while I was thinking of fixing java's memory problems by implementing a 
bytecode interpreter based on an object table.  (Yeah, one more layer of 
indirection, but it allowed a 64 bit address space, truly asynchronous 
garbage collection, and packing the heap asynchronously as well.  I was 
actually trying to get it all to work within hard realtime constraints for a 
while.  (No, you can't allocate a new object within hard realtime.  But you 
could do just about everything else.)  But Sun owns java and I didn't feel 
like boxing myself in with one of thier oddball licenses.  Maybe I'll look at 
python's bytecode stuff someday and see if any of the ideas transfer over...)

How many instructions does your average processor really NEED?  MIT's first 
computer had 4 instructions: load, save, add, and test/jump.  We only need 32 
or 64 bits for the data we're manipulating.  8 bit code is a large part of 
what allowed people to write early video games in 8k of ram.

By the way: Python's approach to memory management is to completely ignore 
it.  Have you seen the way it deals with loops?  (Hint: allocate an object 
for each iteration through the loop, and usually this is done up front 
creating a big array of them that is then iterated through.)  And this turns 
out to be a usable enough approach that people are writing action games in 
python via SDL bindings.  The largest contributing factor to Java's 
reputation for bad performance is that most java programmers really really 
suck.  (Considering that most of them were brand new to the language in 1998 
and even veterans like me only learned it in 1995, it's not entirely 
suprising.  And that for many of them, it's their first language period...)

So if it's possible to write efficient code in python, it's GOT to be 
possible to write efficient code in Java, which can at least loop without 
allocating objects in the process.  (Yeah, I know about map, I'm trying to 
make a point here. :)

Rob

[1] Java 1.1 anyway.  1.0 hadn't seen the light of day in real usage yet, and 
as such doesn't actually work very well.  1.1 was revised based on the 
complaints from the field, and is in my opinion where the language peaked.  
(And that's still what I teach to students whenever I do an intro to Java 
course at the local community college.)

Java 1.2 is bloated, and Swing is just evil.  I haven't even looked at 3.  
Sun has the same case of featuritis that infests netscape navigator, 
microsoft word, and every other piece of proprietary software that's already 
sold a bunch of copies to users and now has to figure out how to get MORE 
money out of them.  Where "one more feature" may cause yet another customer 
to buy it, and is therefore worth money.  Open Source doesn't have that 
problem because we have to maintain this gorp ourselves, and we're far too 
lazy to include anything in there unless there would be serious and 
widespread complaints if it were removed.  About the only proprietary 
software that DOESN'T have this problem is games, because people solve old 
games and put them aside, so you can always write another game and sell it to 
the same people.
