Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVBRRJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVBRRJw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 12:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVBRRJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 12:09:51 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:40844 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261404AbVBRRI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 12:08:29 -0500
Message-ID: <42161ED3.1050400@sgi.com>
Date: Fri, 18 Feb 2005 10:58:59 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andi Kleen <ak@muc.de>, Ray Bryant <raybry@austin.rr.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
 II
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de> <42114279.5070202@sgi.com> <20050215121404.GB25815@muc.de> <421241A2.8040407@sgi.com> <20050215214831.GC7345@wotan.suse.de> <4212C1A9.1050903@sgi.com> <20050217235437.GA31591@wotan.suse.de>
In-Reply-To: <20050217235437.GA31591@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an interface proposal that may be a middle ground and
should satisfy both small and large system requirements:

The system call interface would be:

page_migrate(pid, va_start, va_end, count, old_node_list, new_node_list);

(e. g. same as before, but please keep reading....):

The following restrictions of my original proposal would be
dropped:

(1)  va_start and va_end can span multiple vma's.  To migrate
      all pages in a process, va_start can be 0UL and va_end
      would be MAX_INT L.  (Equivalently, we could use va_start
      and length, in pages....)  We would expect the normal usage
      of this call on small systems to be va_start=0, va_end=MAX_INT.
      va_start and va_end would be required to be page aligned.

(2)  There is no requirement that the pid be suspended before
      the system call is issued.  Further requirements below
      are proposed to handle the allocation of new pages while
      the migrate system call is in progress.

(3)  Mempolicy data structures will be updated to reflect the
      new node locations before any pages are migrated.  That
      way, if the process allocates new pages before the migration
      process is completed, they will be allocated on the new
      nodes.

      (An alternative:  we could require the user to update
      the NUMA API data structures to reflect the new reality
      before the page_migrate() call is issued.  This is consistent
      with item (4).  If the user doesn't do this, then
      there is no guarentee that the page migration call will
      actually be able to migrate all pages.)

      If any memory policy is DEFAULT, then the pid will need to
      be migrated to a cpu associated with  one of the new_node_list
      nodes before the page_migrate() call.  This is so new
      allocations will happen in the new_node_list and the
      migration call won't miss those pages.  The system call
      will work correctly without this, it just can't guarentee
      that it will migrate all pages from the old_nodes.

(4)  If cpusets are in use, the new_node_list must represent
      valid nodes to allocate pages from for the cpuset that
      pid is currently a member of.  This implies that the
      pid is moved from its old cpuset to a new cpuset before
      the page_migrate() call is issued.  Any nodes not part
      of the new cpu set will cause the system call to return
      with -EINVAL.

(5)  If, during the migration process, a page is to be moved to
      node N, but the alloc_pages_node() call for node N fails, then the
      page will fall over to allocation on the "nearest" node
      in the new_node_list; if this node is full then fall over
      to the next nearest node, etc.  If none of the nodes has
      space, then the migration system call will fail.  (Hmmm...
      would we unmigrate the pages that had been migrated
      this far??  sounds messy.... also, not sure what one
      would do about error reporting here so that the caller
      could take some corrective action.)

(6)  The system call is reserved to root or a pid with
      capability CAP_PAGE_MIGRATE.

(7)  Mapped files with the extended attribute MIGRATE
      set to NONE are not migrated by the system call.
      Mapped files with the extended attribute MIGRATE
      set to LIB will be handled as follows:  r/o
      mappings will not be migrated.  r/w mappings will
      be migrated.  If no MIGRATE extended attribute is available,
      then the assumtion is that the MIGRATE extended
      attribute is not set.  (Files mapped from NFS
      would always be regarded as migrateable until
      NFS gets extended attributes.)

Note that nothing here requires parsing of /proc/pid/maps,
etc.  However, very large systems may use the system call
in special ways, e. g:

(1)  They may decide to suspend processes before migration.
(2)  They may decide to optimize the migration process by
      trying to migrate large shared objects only "once",
      in the sense that only one scan of a large shared
      object will be done.

Issues of complexity related to the above are reserved for
those systems who choose to use the system call in this way.

Please note, however that this is a performance optimization
that some systems MAY decide to do.  There is NO REQUIREMENT
that any user follow these steps from a correctness point of
view, the page_migrate() system call will still do the correct
thing.

Now, I know that is complicated and lot of verbage.  But this
would satisfy our requirements and I think it would satisfy
the concern that the page_migration() call was built just to
satisfy SGI requirements.

Comments, flames, suggestions, etc, as usual are all welcome.
-- 
-----------------------------------------------
Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
	 so I installed Linux.
-----------------------------------------------

