Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267801AbTBUXcJ>; Fri, 21 Feb 2003 18:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267802AbTBUXcJ>; Fri, 21 Feb 2003 18:32:09 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:27329 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267801AbTBUXcI>; Fri, 21 Feb 2003 18:32:08 -0500
Date: Fri, 21 Feb 2003 15:48:14 -0800
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: lse-tech@lists.sf.et
cc: linux-kernel@vger.kernel.org
Subject: Minutes from Feb 21 LSE Call
Message-ID: <96700000.1045871294@w-hlinder>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	LSE Con Call Minutes from Feb21

Minutes compiled by Hanna Linder hannal@us.ibm.com, please post
corrections to lse-tech@lists.sf.net.

Object Based Reverse Mapping:
(Dave McCracken, Ben LaHaise, Rik van Riel, Martin Bligh, Gerrit Huizenga)

	Dave coded up an initial patch for partial object based rmap
which he sent to linux-mm yesterday. Rik pointed out there is a scalability 
problem with the full object based approach. However, a hybrid approach 
between regular rmap and object based may not be too radical for 
2.5/2.6 timeframe.
	Ben said none of the users have been complaining about 
performance with the existing rmap.  Martin disagreed and said Linus, 
Andrew Morton and himself have all agreed there is a problem.
One of the problems Martin is already hitting on high cpu machines with 
large memory is the space consumption by all the pte-chains filling up
memory and killing the machine. There is also a performance impact of 
maintaining the chains.
	Ben said they shouldnt be using fork and bash is the
main user of fork and should be changed to use clone instead.
Gerrit said bash is not used as much as Ben might think on 
these large systems running real world applications. 
	Ben said he doesnt see the large systems problems with
the users he talks to and doesnt agree the full object based rmap 
is needed.  Gerrit explained we have very complex workloads running on 
very large systems and we are already hitting the space consumption 
problem which is a blocker for running Linux on them.
	Ben said none of the distros are supporting these large 
systems right now. Martin said UL is already starting to support
them. Then it degraded into a distro discussion and Hanna asked
for them to bring it back to the technical side.
	In order to show the problem with object based rmap you have to 
add vm pressure to existing benchmarks to see what happens. Martin 
agreed to run multiple benchmarks on the same systems to simulate this.
Cliff White of the OSDL offered to help Martin with this.
	At the end Ben said the solution for now needs to be
a hybrid with existing rmap. Martin, Rik, and Dave all agreed with Ben. 
Then we all agreed to move on to other things. 

*ActionItem - someone needs to change bash to use clone instead of fork..

Scheduler Hang as discovered by restarting a large Web application
multiple times:
	Rick Lindlsey/ Hanna Linder

	We were seeing a hard hang after restarting a large web 
serving application 3-6 times on the 2.5.59 (and up) kernels 
(also seen as far back as 2.5.44).  It was mainly caused when two 
threads each have interrupts disabled and one is spinning on a lock that 
the other is holding. The one holding the lock has sent an IPI to all 
the other processes telling them to flush their TLB's. But the one 
witinging for the spinlock has interrupts turned off and does not recieve 
that IPI request. So they both sit there waiting for ever.

The final fix will be in kernel.org mainline kernel version 2.5.63. 
Here are the individual patches which should apply with fuzz to
older kernel versions:

http://linux.bkbits.net:8080/linux-2.5/cset@1.1005?nav=index.html
http://linux.bkbits.net:8080/linux-2.5/cset@1.1004?nav=index.html


Shared Memory Binding :
		Matt Dobson -
	Shared memory binding API (new). A way for an
application to bind shared memory to Nodes. Motivation
is for large databases support that want more control
over their shared memory.
	current allocation scheme is each process gets
a chunk of shared memory from the same node the process
is located on. instead of page faulting around to different
nodes dynamicaly this API will allow a process to specify
which node or set of nodes to bind the shared memory to.
	Work in progress.

Martin - gcc 2.95 vs 3.2.

Martin has done some testing which indicates that gcc 3.2 produces
slightly worse code for the kernel than 2.95 and takes a bit
longer to do so. gcc 3.2 -Os produces larger code than gcc 2.95 -O2.
On his machines -O2 was faster than -Os, but on a cpu wiht smaller 
caches the inverse may be true. More testing may be needed.



