Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVBOQXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVBOQXO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 11:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVBOQWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 11:22:43 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:5521 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261782AbVBOQWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 11:22:03 -0500
Date: Tue, 15 Feb 2005 10:21:35 -0600
From: Robin Holt <holt@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: Robin Holt <holt@sgi.com>, haveblue@us.ibm.com, raybry@sgi.com,
       taka@valinux.co.jp, hugh@veritas.com, akpm@osdl.org,
       marcello@cyclades.com, raybry@austin.rr.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.11-rc2-mm2 7/7] mm: manual page migration -- sys_page_migrate
Message-ID: <20050215162135.GA22646@lnx-holt.americas.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <20050212032620.18524.15178.29731@tomahawk.engr.sgi.com> <1108242262.6154.39.camel@localhost> <20050214135221.GA20511@lnx-holt.americas.sgi.com> <1108407043.6154.49.camel@localhost> <20050214220148.GA11832@lnx-holt.americas.sgi.com> <20050215074906.01439d4e.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215074906.01439d4e.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 07:49:06AM -0800, Paul Jackson wrote:
> Robin wrote:
> > Then how do you handle overlapping nodes.  If I am doing a 5->4, 4->3,
> > 3->2, 2->1 shift ...
> 
> Then do the shifts in the other order, first 2->1, then 3->2, ...
> 
> So now you ask, what if you are doing a rotation?  Use a temporary
> node: 2->tmp, 3->2, ..., N->(N-1), tmp->N.

Consider the case where you are moving 248GB of data off of that node
onto a temporary.  You have just made that a double copy to save the
difficulty of passing in an array.  That seems like it is insane!

> 
> So now you ask, what if you are doing a rotation involving _all_
> nodes, and have nothing you can use as a temporary node?

Not necessarily all nodes for the rotation, but if you have no free nodes
in the system aside from the ones you are working with.  That will be the
typical case.  The batch scheduler will have control of all the nodes
except the nodes that are dedicated to I/O.  These will also likely
have less memory on them.  The batch scheduler may have any number
of jobs running in small cpusets.  At the time of the migration, the
system may only have the nodes from the old and new jobs to work with.
They you are stuck with a need for the arrays.

> 
> Argh I say ... would anyone really do that?  Or perhaps it makes
> sense to have the system call take a virtual address range (and
> hence a pid).  In which case, you can do one page at a time, if
> need be, and get any foolhardy migration possible.
> 
> Or perhaps some integration with Andi's mbind/mempolicy make sense.
> I'm not quite following Andi's comments on this, so I can't say
> one way or the other if this is good.

I think this is more closely related to cpusets, but that was not in when
Ray started working on his stuff.  The mem policy stuff does not handle
the immediate need to migrate (at least not that I see) and it does not
preserve node locality for already touched pages.  Assume we have a job
which has 16 processes which are doing work on 16 blocks of memory.
The code is designed to first touch the pages it will work with on
startup, redezvous with the other processes, and then start working.
During its run, it needs access to its block 97% of the time and needs
to read from the other blocks 3% of the time.

With a mem policy, after the "migration" it is a race to see who touches
the page first as for which node the memory is migrated to.  We need to
have a way to migrate the memory which preserves the placement information
the process has already given us.

Thanks,
Robin
