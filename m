Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751854AbWCVAFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbWCVAFs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 19:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbWCVAFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 19:05:48 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:5044 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751851AbWCVAFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 19:05:47 -0500
Date: Wed, 22 Mar 2006 09:05:14 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: y-goto@jp.fujitsu.com, akpm@osdl.org, tony.luck@intel.com, ak@suse.de,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH: 002/017]Memory hotplug for new nodes v.4.(change name
 old add_memory() to arch_add_memory())
Message-Id: <20060322090514.6d6826fc.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1142964013.10906.158.camel@localhost.localdomain>
References: <20060317162757.C63B.Y-GOTO@jp.fujitsu.com>
	<1142615538.10906.67.camel@localhost.localdomain>
	<20060318102653.57c6a2af.kamezawa.hiroyu@jp.fujitsu.com>
	<1142964013.10906.158.camel@localhost.localdomain>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2006 10:00:12 -0800
Dave Hansen <haveblue@us.ibm.com> wrote:

> On Sat, 2006-03-18 at 10:26 +0900, KAMEZAWA Hiroyuki wrote:
> > If *determine node* function is moved to arch specific parts,
> > memory hot add need more and more codes to determine  paddr -> nid in arch
> > specific codes. Then, we have to add new paddr->nid function even if new nid is
> > passed by firmware. We *lose* useful information of nid from firmware if 
> > add_memory() has just 2 args, (start, end).  
> 
> What I'm saying is that I'd like add_memory() to be just that, for
> adding memory.
> 
> At some point in the process, you need to export the NUMA node layout to
> the rest of the system, to say which pages go in which node.  I'm just
> saying that you should do that _before_ add_memory().
> 

To do so, we have to maintain new pfn_to_nid() function.
We have to maintain a new table/list and have to consider name of it :).
And, add_memory() has to check whether a node which belongs exists ot not, again.
I don't want these kind of things. 

With current kernel, we have to add new *pgdat* to node when adding a new node.
(If we don't, the kernel goes panic()) And we have to allocate a pgdat/zones 
in a local node in future. So adding a node before adding memory is not good. 
(current code uses kmalloc() just for reducing complexity.)

> add_memory() should support adding memory to more than one node.  If any
> hypervisor or hardware happens to have memory added in one contiguous
> chunk, it can not simply call add_memory().  _That_ firmware would be
> forced to do the NUMA parsing and figure out how many times to call
> add_memory().  
I don't think the firmware adds memory of multiple nodes at once.
It's crazy.

> 
> Let me reiterate: the process of telling the system which pages are in
> which node should be separate from telling the system that there *are*
> currently pages there now.

Considering "cpu only node', "check and add new node" function can be separated,
like add_memory_less_node().(But pgdat/zone etc.. will be allocated in out of node.)

Bye.
-- Kame

