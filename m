Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVBVGjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVBVGjL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 01:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVBVGjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 01:39:10 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:19661 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262219AbVBVGhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 01:37:55 -0500
Message-ID: <421AD3E6.8060307@sgi.com>
Date: Tue, 22 Feb 2005 00:40:38 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Paul Jackson <pj@sgi.com>, ak@muc.de, raybry@austin.rr.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
 II
References: <20050215214831.GC7345@wotan.suse.de> <4212C1A9.1050903@sgi.com> <20050217235437.GA31591@wotan.suse.de> <4215A992.80400@sgi.com> <20050218130232.GB13953@wotan.suse.de> <42168FF0.30700@sgi.com> <20050220214922.GA14486@wotan.suse.de> <20050220143023.3d64252b.pj@sgi.com> <20050220223510.GB14486@wotan.suse.de> <42199EE8.9090101@sgi.com> <20050221121010.GC17667@wotan.suse.de>
In-Reply-To: <20050221121010.GC17667@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

I went back and did some digging on one the issues that has dropped
off the list here: the case where the set of old nodes and new
nodes overlap in some way.  No one could provide me with a specific
example, but the thread was that "This did happen in certain scenarios".

Part of these scenarios involved situations where a particular job
had to have access to a certain node, because that certain node was
attached to a graphics device, for example.  Here is one such
scenario:

Let's suppose that nodes 0-1 of a 64 CPU system have graphics
pipes.  To keep it simple, we will assume that there are 2 cpus
per node like an Altox. Let's suppose that jobs arrive as follows:

(1)  32 processor, non-graphics job arrives and gets assigned
      cpus 96-127 (nodes 48-63)

(2)  A second 32 processor, non-graphics job arrives and is
      assigned cpus 64-95 (nodes 32-47)

(3)  A 64 processor non-graphics job arrives and gets assigned
      cpus 0-63.

(bear with me, please)....

(4)  The job on nodes 64-95 terminates.  A new 28 processor
      job arrives and is assigned cpus 68-95.

(5)  A 4 cpu graphics job comes in and we want to assign it to
      cpus 0-3 (nodes 0-1) and it has a very high priority, so
      we want to migrate the 64 CPU job.  The only place left
      to migrate it is from cpus 0-63 to cpus 4-67.

(Note that we can't just migrate nodes 0-1 to nodes 32-33, because
for all we know, the program depends on the fact that nodes 0-1
are physically close to [have low latency access to] nodes 2-3.
So moving 0-1 to 32-33 would be a non-topological preserving
migration.)

Now if we are using a system call of the form

     migrate_pages(pid, count, old_node_list, new_node_list);

then we really can't have old_node_list and new_node_list overlap,
unless this is the only process that we are migrating or there is
no shared memory among the pid's.  (Neither is very likely for
our workload mix.  :-)  ).

The reason that this doesn't work is the following:  It works
fine for the first pid.  The shared segment gets moved to the
new_node_list.  But when we call migrate_pages() for the 2nd
pid, we will remigrate the pages that ended up on the nodes
that are in the intersection of the sets of members of the
two lists.  (The scanning code has no way to recognize that
the pages have been migrated.  It finds pages that are on one
of the old nodes, and migrates them again.)  This gets repeated
for each subsequent call.  Not pretty.  What happens in this
particular case if you do the trivial thing and try:

old_nodes=0 1 2 ... 31
new_nodes=2 3 4 ... 33

Then after 16 process have been migrated, all of the shared memory
pages of the job are on nodes 32 and 33. (I've assume the shared
memory is shared among all of the processes of the job.)

Now you COULD do multiple migrations to make this work.
In this case, you could do 16 migrations:

step    old_nodes   new_nodes
   1       30 31      32 33
   2       28 29      30 31
   3       26 27      28 29
  ...
   16      0   1       2  3

During each step, you would have to call migrate_pages() 64 times,
since there are 64 processes involved.  (You can't migrate
any more nodes in each step without creating a situation where
pages will be physically migrated twice.)  Once again, we are
starting to veer close to O(N**2) behavior here, and we want
to stay away from that.

OK, so what is the alternative?  Well, if we had a va_start and
va_end (or a va_start and length) we could move the shared object
once using a call of the form

    migrate_pages(pid, va_start, va_end, count, old_node_list,
	new_node_list);

with old_node_list = 0 1 2 ... 31
      new_node_list = 2 3 4 ... 33

for one of the pid's in the job.

(This is particularly important if the shared region is large.)

Next we could go and move the non-shared memory in each process
using similar calls, repeated one or more times in each process.

Yes, this is ugly, and yes this requires us to parse /proc/pid/maps.
Life is like that sometimes.

Now, I admit that this example is somewhat contrived, and it shows
worst case behavior.  But this is not an implausible scenario.  And
it shows the difficulties of trying to use a system call of the
form:

    migrate_pages(pid, count, old_node_list, new_node_list)

in those cases where the old_node_list and the new_node_list are not
disjoint.  Furthermore, it shows how we could end up in a situation
where the old_node_list and the new_node_lists overlap.

Jack Steiner pointed out this kind of example to me, and this kind
of example did arise in IRIX, so we believe that it will arise on
Altix and we don't know of a good way around these problems other
than the system call form that includes the va_start and va_end.
-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------
