Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752472AbWCQAzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbWCQAzP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 19:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752474AbWCQAzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 19:55:14 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:22917 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1752472AbWCQAzL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 19:55:11 -0500
Date: Thu, 16 Mar 2006 17:54:18 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
       Andrew Morton <akpm@osdl.org>, sct@redhat.com,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: ext3_ordered_writepage() questions
Message-ID: <20060317005418.GY30801@schatzie.adilger.int>
Mail-Followup-To: Badari Pulavarty <pbadari@us.ibm.com>,
	Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, sct@redhat.com,
	lkml <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20060308124726.GC4128@lst.de> <4410551D.5000303@us.ibm.com> <20060309153550.379516e1.akpm@osdl.org> <4410CA25.2090400@us.ibm.com> <20060316180904.GA29275@thunk.org> <1142533360.21442.153.camel@dyn9047017100.beaverton.ibm.com> <20060316210424.GD29275@thunk.org> <1142546275.21442.172.camel@dyn9047017100.beaverton.ibm.com> <20060316220545.GB18753@atrey.karlin.mff.cuni.cz> <1142552722.21442.180.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142552722.21442.180.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 16, 2006  15:45 -0800, Badari Pulavarty wrote:
> On Thu, 2006-03-16 at 23:05 +0100, Jan Kara wrote:
> >   The data buffers are not journaled. The buffers are just attached to the
> > transaction and when the transaction is committed, they are written
> > directly to their final location. This ensures the ordering but no data
> > goes via the log... I guess you should see empty transactions in the log
> > which are eventually commited when they become too old.
> 
> Yep. I wasn't expecting to see buffers in the transaction/log. I was
> expecting to see some "dummy" transaction - which these buffers are
> attached to provide ordering. (even though we are not doing metadata
> updates). In fact, I was expecting to see "ctime" update in the
> transaction.

The U. Wisconsin group that was doing journal-guided fast RAID resync
actually ended up putting dummy transactions into the logs for this
with the block numbers even if there were no metadata changes.

That way the journal could tell the MD RAID layer what blocks might
need resyncing instead of having to scan the whole block device for
inconsistencies.

That code hasn't been merged, or even posted anywhere yet AFAICS, though
I'd be very interested in seeing it.  It changes MD RAID recovery time
from O(device size) to O(journal size), and that is a huge deal when you
have an 8TB filesystem.

As for the ctime update, I'm not sure what happened to that, though
ext3 would currently only update the inode at most once a second.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

