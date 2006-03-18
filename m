Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932861AbWCRC5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932861AbWCRC5t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 21:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932860AbWCRC5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 21:57:49 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:41865 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932854AbWCRC5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 21:57:48 -0500
Date: Sat, 18 Mar 2006 08:27:43 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>,
       Andreas Dilger <adilger@clusterfs.com>, Jan Kara <jack@suse.cz>,
       "Theodore Ts'o" <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: ext3_ordered_writepage() questions
Message-ID: <20060318025743.GA20722@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20060316180904.GA29275@thunk.org> <1142533360.21442.153.camel@dyn9047017100.beaverton.ibm.com> <20060316210424.GD29275@thunk.org> <1142546275.21442.172.camel@dyn9047017100.beaverton.ibm.com> <20060316220545.GB18753@atrey.karlin.mff.cuni.cz> <1142552722.21442.180.camel@dyn9047017100.beaverton.ibm.com> <20060317005418.GY30801@schatzie.adilger.int> <1142615110.3641.8.camel@orbit.scot.redhat.com> <1142631141.15257.40.camel@dyn9047017100.beaverton.ibm.com> <1142634134.3641.56.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142634134.3641.56.camel@orbit.scot.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 05:22:13PM -0500, Stephen C. Tweedie wrote:
> Hi,
> 
> On Fri, 2006-03-17 at 13:32 -0800, Badari Pulavarty wrote:
> 
> > I have a patch which eliminates adding buffers to the journal, if
> > we are doing just re-write of the disk block. ...
> 
> >      2.6.16-rc6      2.6.16-rc6+patch
> > real  0m6.606s        0m3.705s 
> 
> OK, that's a really significant win!  What exactly was the test case for
> this, and does that performance edge persist for a longer-running test?
> 
> > In real world, does this ordering guarantee matter ? 
> 
> Not that I am aware of.  Even with the ordering guarantee, there is
> still no guarantee of the order in which the writes hit disk within that
> transaction, which makes it hard to depend on it.
> 
> I recall that some versions of fsync depended on ordered mode flushing
> dirty data on transaction commit, but I don't think the current
> ext3_sync_file() will have any problems there.  
> 
> Other than that, the only thing I can think of that had definite
> dependencies in this are was InterMezzo, and that's no longer in the
> tree.  Even then, I'm not 100% certain that InterMezzo had a dependency
> for overwrites (it was certainly strongly dependent on the ordering
> semantics for allocates.)

Besides we seem to have already broken the guarantee in async DIO
writes for the overwrite case.

Regards
Suparna

> 
> It is theoretically possible to write applications that depend on that
> ordering, but they would be necessarily non-portable anyway.  I think
> relaxing it is fine, especially for a 100% (wow) performance gain.
> 
> There is one other perspective to be aware of, though: the current
> behaviour means that by default ext3 generally starts flushing pending
> writeback data within 5 seconds of a write.  Without that, we may end up
> accumulating a lot more dirty data in memory, shifting the task of write
> throttling from the filesystem to the VM.  
> 
> That's not a problem per se, just a change of behaviour to keep in mind,
> as it could expose different corner cases in the performance of
> write-intensive workloads.
> 
> --Stephen
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

