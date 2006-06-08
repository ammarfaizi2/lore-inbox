Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWFHPEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWFHPEY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 11:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWFHPEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 11:04:24 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:12714 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964855AbWFHPEX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 11:04:23 -0400
Date: Thu, 8 Jun 2006 08:04:44 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu
Subject: Re: [PATCH] Further alterations for memory barrier document
Message-ID: <20060608150444.GA12322@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <10121.1149759081@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10121.1149759081@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2006 at 10:31:21AM +0100, David Howells wrote:
> 
> The attached patch applies some alterations to the memory barrier document that
> I worked out with Paul McKenney of IBM, plus some of the alterations suggested
> by Alan Stern.
> 
> The following changes were made:
> 
>  (*) One of the examples given for what can happen with overlapping memory
>      barriers was wrong.
> 
>  (*) The description of general memory barriers said that a general barrier is
>      a combination of a read barrier and a write barrier.  This isn't entirely
>      true: it implies both, but is more than a combination of both.
> 
>  (*) The first example in the "SMP Barrier Pairing" section was wrong: the
>      loads around the read barrier need to touch the memory locations in the
>      opposite order to the stores around the write barrier.
> 
>  (*) Added a note to make explicit that the loads should be in reverse order to
>      the stores.
> 
>  (*) Adjusted the diagrams in the "Examples Of Memory Barrier Sequences"
>      section to make them clearer.  Added a couple of diagrams to make it more
>      clear as to how it could go wrong without the barrier.
> 
>  (*) Added a section on memory speculation.
> 
>  (*) Dropped any references to memory allocation routines doing memory
>      barriers.  They may do sometimes, but it can't be relied on.  This may be
>      worthy of further documentation later.
> 
>  (*) Made the fact that a LOCK followed by an UNLOCK should not be considered a
>      full memory barrier more explicit and gave an example.

Good stuff!

							Thanx, Paul

Acked-By: Paul E. McKenney <paulmck@us.ibm.com>
> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> warthog>diffstat -p1 /tmp/mb.diff 
>  Documentation/memory-barriers.txt |  348 +++++++++++++++++++++++++++++---------
>  1 file changed, 270 insertions(+), 78 deletions(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index c61d8b8..4710845 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -19,6 +19,7 @@ Contents:
>       - Control dependencies.
>       - SMP barrier pairing.
>       - Examples of memory barrier sequences.
> +     - Read memory barriers vs load speculation.
>  
>   (*) Explicit kernel barriers.
>  
> @@ -248,7 +249,7 @@ And there are a number of things that _m
>       we may get either of:
>  
>  	STORE *A = X; Y = LOAD *A;
> -	STORE *A = Y;
> +	STORE *A = Y = X;
>  
>  
>  =========================
> @@ -344,9 +345,12 @@ Memory barriers come in four basic varie
>  
>   (4) General memory barriers.
>  
> -     A general memory barrier is a combination of both a read memory barrier
> -     and a write memory barrier.  It is a partial ordering over both loads and
> -     stores.
> +     A general memory barrier gives a guarantee that all the LOAD and STORE
> +     operations specified before the barrier will appear to happen before all
> +     the LOAD and STORE operations specified after the barrier with respect to
> +     the other components of the system.
> +
> +     A general memory barrier is a partial ordering over both loads and stores.
>  
>       General memory barriers imply both read and write memory barriers, and so
>       can substitute for either.
> @@ -546,9 +550,9 @@ write barrier, though, again, a general 
>  	===============	===============
>  	a = 1;
>  	<write barrier>
> -	b = 2;		x = a;
> +	b = 2;		x = b;
>  			<read barrier>
> -			y = b;
> +			y = a;
>  
>  Or:
>  
> @@ -563,6 +567,18 @@ Or:
>  Basically, the read barrier always has to be there, even though it can be of
>  the "weaker" type.
>  
> +[!] Note that the stores before the write barrier would normally be expected to
> +match the loads after the read barrier or data dependency barrier, and vice
> +versa:
> +
> +	CPU 1                           CPU 2
> +	===============                 ===============
> +	a = 1;           }----   --->{  v = c
> +	b = 2;           }    \ /    {  w = d
> +	<write barrier>        \        <read barrier>
> +	c = 3;           }    / \    {  x = a;
> +	d = 4;           }----   --->{  y = b;
> +
>  
>  EXAMPLES OF MEMORY BARRIER SEQUENCES
>  ------------------------------------
> @@ -600,8 +616,8 @@ STORE B, STORE C } all occuring before t
>  	|       |       +------+
>  	+-------+       :      :
>  	                   |
> -	                   | Sequence in which stores committed to memory system
> -	                   | by CPU 1
> +	                   | Sequence in which stores are committed to the
> +	                   | memory system by CPU 1
>  	                   V
>  
>  
> @@ -683,14 +699,12 @@ then the following will occur:
>  	                               |        :       :       |       |
>  	                               |        :       :       | CPU 2 |
>  	                               |        +-------+       |       |
> -	                                \       | X->9  |------>|       |
> -	                                 \      +-------+       |       |
> -	                                  ----->| B->2  |       |       |
> -	                                        +-------+       |       |
> -	     Makes sure all effects --->    ddddddddddddddddd   |       |
> -	     prior to the store of C            +-------+       |       |
> -	     are perceptible to                 | B->2  |------>|       |
> -	     successive loads                   +-------+       |       |
> +	                               |        | X->9  |------>|       |
> +	                               |        +-------+       |       |
> +	  Makes sure all effects --->   \   ddddddddddddddddd   |       |
> +	  prior to the store of C        \      +-------+       |       |
> +	  are perceptible to              ----->| B->2  |------>|       |
> +	  subsequent loads                      +-------+       |       |
>  	                                        :       :       +-------+
>  
>  
> @@ -699,73 +713,239 @@ following sequence of events:
>  
>  	CPU 1			CPU 2
>  	=======================	=======================
> +		{ A = 0, B = 9 }
>  	STORE A=1
> -	STORE B=2
> -	STORE C=3
>  	<write barrier>
> -	STORE D=4
> -	STORE E=5
> -				LOAD A
> +	STORE B=2
>  				LOAD B
> -				LOAD C
> -				LOAD D
> -				LOAD E
> +				LOAD A
>  
>  Without intervention, CPU 2 may then choose to perceive the events on CPU 1 in
>  some effectively random order, despite the write barrier issued by CPU 1:
>  
> -	+-------+       :      :
> -	|       |       +------+
> -	|       |------>| C=3  | }
> -	|       |  :    +------+ }
> -	|       |  :    | A=1  | }
> -	|       |  :    +------+ }
> -	| CPU 1 |  :    | B=2  | }---
> -	|       |       +------+ }   \
> -	|       |   wwwwwwwwwwwww}    \
> -	|       |       +------+ }     \          :       :       +-------+
> -	|       |  :    | E=5  | }      \         +-------+       |       |
> -	|       |  :    +------+ }       \      { | C->3  |------>|       |
> -	|       |------>| D=4  | }        \     { +-------+    :  |       |
> -	|       |       +------+           \    { | E->5  |    :  |       |
> -	+-------+       :      :            \   { +-------+    :  |       |
> -	                           Transfer  -->{ | A->1  |    :  | CPU 2 |
> -	                          from CPU 1    { +-------+    :  |       |
> -	                           to CPU 2     { | D->4  |    :  |       |
> -	                                        { +-------+    :  |       |
> -	                                        { | B->2  |------>|       |
> -	                                          +-------+       |       |
> -	                                          :       :       +-------+
> -
> -
> -If, however, a read barrier were to be placed between the load of C and the
> -load of D on CPU 2, then the partial ordering imposed by CPU 1 will be
> -perceived correctly by CPU 2.
> +	+-------+       :      :                :       :
> +	|       |       +------+                +-------+
> +	|       |------>| A=1  |------      --->| A->0  |
> +	|       |       +------+      \         +-------+
> +	| CPU 1 |   wwwwwwwwwwwwwwww   \    --->| B->9  |
> +	|       |       +------+        |       +-------+
> +	|       |------>| B=2  |---     |       :       :
> +	|       |       +------+   \    |       :       :       +-------+
> +	+-------+       :      :    \   |       +-------+       |       |
> +	                             ---------->| B->2  |------>|       |
> +	                                |       +-------+       | CPU 2 |
> +	                                |       | A->0  |------>|       |
> +	                                |       +-------+       |       |
> +	                                |       :       :       +-------+
> +	                                 \      :       :
> +	                                  \     +-------+
> +	                                   ---->| A->1  |
> +	                                        +-------+
> +	                                        :       :
>  
> -	+-------+       :      :
> -	|       |       +------+
> -	|       |------>| C=3  | }
> -	|       |  :    +------+ }
> -	|       |  :    | A=1  | }---
> -	|       |  :    +------+ }   \
> -	| CPU 1 |  :    | B=2  | }    \
> -	|       |       +------+       \
> -	|       |   wwwwwwwwwwwwwwww    \
> -	|       |       +------+         \        :       :       +-------+
> -	|       |  :    | E=5  | }        \       +-------+       |       |
> -	|       |  :    +------+ }---      \    { | C->3  |------>|       |
> -	|       |------>| D=4  | }   \      \   { +-------+    :  |       |
> -	|       |       +------+      \      -->{ | B->2  |    :  |       |
> -	+-------+       :      :       \        { +-------+    :  |       |
> -	                                \       { | A->1  |    :  | CPU 2 |
> -	                                 \        +-------+       |       |
> -	   At this point the read ---->   \   rrrrrrrrrrrrrrrrr   |       |
> -	   barrier causes all effects      \      +-------+       |       |
> -	   prior to the storage of C        \   { | E->5  |    :  |       |
> -	   to be perceptible to CPU 2        -->{ +-------+    :  |       |
> -	                                        { | D->4  |------>|       |
> -	                                          +-------+       |       |
> -	                                          :       :       +-------+
> +
> +If, however, a read barrier were to be placed between the load of E and the
> +load of A on CPU 2:
> +
> +	CPU 1			CPU 2
> +	=======================	=======================
> +		{ A = 0, B = 9 }
> +	STORE A=1
> +	<write barrier>
> +	STORE B=2
> +				LOAD B
> +				<read barrier>
> +				LOAD A
> +
> +then the partial ordering imposed by CPU 1 will be perceived correctly by CPU
> +2:
> +
> +	+-------+       :      :                :       :
> +	|       |       +------+                +-------+
> +	|       |------>| A=1  |------      --->| A->0  |
> +	|       |       +------+      \         +-------+
> +	| CPU 1 |   wwwwwwwwwwwwwwww   \    --->| B->9  |
> +	|       |       +------+        |       +-------+
> +	|       |------>| B=2  |---     |       :       :
> +	|       |       +------+   \    |       :       :       +-------+
> +	+-------+       :      :    \   |       +-------+       |       |
> +	                             ---------->| B->2  |------>|       |
> +	                                |       +-------+       | CPU 2 |
> +	                                |       :       :       |       |
> +	                                |       :       :       |       |
> +	  At this point the read ---->   \  rrrrrrrrrrrrrrrrr   |       |
> +	  barrier causes all effects      \     +-------+       |       |
> +	  prior to the storage of B        ---->| A->1  |------>|       |
> +	  to be perceptible to CPU 2            +-------+       |       |
> +	                                        :       :       +-------+
> +
> +
> +To illustrate this more completely, consider what could happen if the code
> +contained a load of A either side of the read barrier:
> +
> +	CPU 1			CPU 2
> +	=======================	=======================
> +		{ A = 0, B = 9 }
> +	STORE A=1
> +	<write barrier>
> +	STORE B=2
> +				LOAD B
> +				LOAD A [first load of A]
> +				<read barrier>
> +				LOAD A [second load of A]
> +
> +Even though the two loads of A both occur after the load of B, they may both
> +come up with different values:
> +
> +	+-------+       :      :                :       :
> +	|       |       +------+                +-------+
> +	|       |------>| A=1  |------      --->| A->0  |
> +	|       |       +------+      \         +-------+
> +	| CPU 1 |   wwwwwwwwwwwwwwww   \    --->| B->9  |
> +	|       |       +------+        |       +-------+
> +	|       |------>| B=2  |---     |       :       :
> +	|       |       +------+   \    |       :       :       +-------+
> +	+-------+       :      :    \   |       +-------+       |       |
> +	                             ---------->| B->2  |------>|       |
> +	                                |       +-------+       | CPU 2 |
> +	                                |       :       :       |       |
> +	                                |       :       :       |       |
> +	                                |       +-------+       |       |
> +	                                |       | A->0  |------>| 1st   |
> +	                                |       +-------+       |       |
> +	  At this point the read ---->   \  rrrrrrrrrrrrrrrrr   |       |
> +	  barrier causes all effects      \     +-------+       |       |
> +	  prior to the storage of B        ---->| A->1  |------>| 2nd   |
> +	  to be perceptible to CPU 2            +-------+       |       |
> +	                                        :       :       +-------+
> +
> +
> +But it may be that the update to A from CPU 1 becomes perceptible to CPU 2
> +before the read barrier completes anyway:
> +
> +	+-------+       :      :                :       :
> +	|       |       +------+                +-------+
> +	|       |------>| A=1  |------      --->| A->0  |
> +	|       |       +------+      \         +-------+
> +	| CPU 1 |   wwwwwwwwwwwwwwww   \    --->| B->9  |
> +	|       |       +------+        |       +-------+
> +	|       |------>| B=2  |---     |       :       :
> +	|       |       +------+   \    |       :       :       +-------+
> +	+-------+       :      :    \   |       +-------+       |       |
> +	                             ---------->| B->2  |------>|       |
> +	                                |       +-------+       | CPU 2 |
> +	                                |       :       :       |       |
> +	                                 \      :       :       |       |
> +	                                  \     +-------+       |       |
> +	                                   ---->| A->1  |------>| 1st   |
> +	                                        +-------+       |       |
> +	                                    rrrrrrrrrrrrrrrrr   |       |
> +	                                        +-------+       |       |
> +	                                        | A->1  |------>| 2nd   |
> +	                                        +-------+       |       |
> +	                                        :       :       +-------+
> +
> +
> +The guarantee is that the second load will always come up with A == 1 if the
> +load of B came up with B == 2.  No such guarantee exists for the first load of
> +A; that may come up with either A == 0 or A == 1.
> +
> +
> +READ MEMORY BARRIERS VS LOAD SPECULATION
> +----------------------------------------
> +
> +Many CPUs speculate with loads: that is they see that they will need to load an
> +item from memory, and they find a time where they're not using the bus for any
> +other loads, and so do the load in advance - even though they haven't actually
> +got to that point in the instruction execution flow yet.  This permits the
> +actual load instruction to potentially complete immediately because the CPU
> +already has the value to hand.
> +
> +It may turn out that the CPU didn't actually need the value - perhaps because a
> +branch circumvented the load - in which case it can discard the value or just
> +cache it for later use.
> +
> +Consider:
> +
> +	CPU 1	   		CPU 2
> +	=======================	=======================
> +	 	   		LOAD B
> +	 	   		DIVIDE		} Divide instructions generally
> +	 	   		DIVIDE		} take a long time to perform
> +	 	   		LOAD A
> +
> +Which might appear as this:
> +
> +	                                        :       :       +-------+
> +	                                        +-------+       |       |
> +	                                    --->| B->2  |------>|       |
> +	                                        +-------+       | CPU 2 |
> +	                                        :       :DIVIDE |       |
> +	                                        +-------+       |       |
> +	The CPU being busy doing a --->     --->| A->0  |~~~~   |       |
> +	division speculates on the              +-------+   ~   |       |
> +	LOAD of A                               :       :   ~   |       |
> +	                                        :       :DIVIDE |       |
> +	                                        :       :   ~   |       |
> +	Once the divisions are complete -->     :       :   ~-->|       |
> +	the CPU can then perform the            :       :       |       |
> +	LOAD with immediate effect              :       :       +-------+
> +
> +
> +Placing a read barrier or a data dependency barrier just before the second
> +load:
> +
> +	CPU 1	   		CPU 2
> +	=======================	=======================
> +	 	   		LOAD B
> +	 	   		DIVIDE
> +	 	   		DIVIDE
> +				<read barrier>
> +	 	   		LOAD A
> +
> +will force any value speculatively obtained to be reconsidered to an extent
> +dependent on the type of barrier used.  If there was no change made to the
> +speculated memory location, then the speculated value will just be used:
> +
> +	                                        :       :       +-------+
> +	                                        +-------+       |       |
> +	                                    --->| B->2  |------>|       |
> +	                                        +-------+       | CPU 2 |
> +	                                        :       :DIVIDE |       |
> +	                                        +-------+       |       |
> +	The CPU being busy doing a --->     --->| A->0  |~~~~   |       |
> +	division speculates on the              +-------+   ~   |       |
> +	LOAD of A                               :       :   ~   |       |
> +	                                        :       :DIVIDE |       |
> +	                                        :       :   ~   |       |
> +	                                        :       :   ~   |       |
> +	                                    rrrrrrrrrrrrrrrr~   |       |
> +	                                        :       :   ~   |       |
> +	                                        :       :   ~-->|       |
> +	                                        :       :       |       |
> +	                                        :       :       +-------+
> +
> +
> +but if there was an update or an invalidation from another CPU pending, then
> +the speculation will be cancelled and the value reloaded:
> +
> +	                                        :       :       +-------+
> +	                                        +-------+       |       |
> +	                                    --->| B->2  |------>|       |
> +	                                        +-------+       | CPU 2 |
> +	                                        :       :DIVIDE |       |
> +	                                        +-------+       |       |
> +	The CPU being busy doing a --->     --->| A->0  |~~~~   |       |
> +	division speculates on the              +-------+   ~   |       |
> +	LOAD of A                               :       :   ~   |       |
> +	                                        :       :DIVIDE |       |
> +	                                        :       :   ~   |       |
> +	                                        :       :   ~   |       |
> +	                                    rrrrrrrrrrrrrrrrr   |       |
> +	                                        +-------+       |       |
> +	The speculation is discarded --->   --->| A->1  |------>|       |
> +	and an updated value is                 +-------+       |       |
> +	retrieved                               :       :       +-------+
>  
>  
>  ========================
> @@ -901,7 +1081,7 @@ IMPLICIT KERNEL MEMORY BARRIERS
>  ===============================
>  
>  Some of the other functions in the linux kernel imply memory barriers, amongst
> -which are locking, scheduling and memory allocation functions.
> +which are locking and scheduling functions.
>  
>  This specification is a _minimum_ guarantee; any particular architecture may
>  provide more substantial guarantees, but these may not be relied upon outside
> @@ -966,6 +1146,20 @@ equivalent to a full barrier, but a LOCK
>      barriers is that the effects instructions outside of a critical section may
>      seep into the inside of the critical section.
>  
> +A LOCK followed by an UNLOCK may not be assumed to be full memory barrier
> +because it is possible for an access preceding the LOCK to happen after the
> +LOCK, and an access following the UNLOCK to happen before the UNLOCK, and the
> +two accesses can themselves then cross:
> +
> +	*A = a;
> +	LOCK
> +	UNLOCK
> +	*B = b;
> +
> +may occur as:
> +
> +	LOCK, STORE *B, STORE *A, UNLOCK
> +
>  Locks and semaphores may not provide any guarantee of ordering on UP compiled
>  systems, and so cannot be counted on in such a situation to actually achieve
>  anything at all - especially with respect to I/O accesses - unless combined
> @@ -1016,8 +1210,6 @@ Other functions that imply barriers:
>  
>   (*) schedule() and similar imply full memory barriers.
>  
> - (*) Memory allocation and release functions imply full memory barriers.
> -
>  
>  =================================
>  INTER-CPU LOCKING BARRIER EFFECTS
