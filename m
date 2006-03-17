Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWCQAog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWCQAog (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 19:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752464AbWCQAof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 19:44:35 -0500
Received: from thunk.org ([69.25.196.29]:10121 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751335AbWCQAoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 19:44:34 -0500
Date: Thu, 16 Mar 2006 19:44:29 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@osdl.org>, sct@redhat.com,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: ext3_ordered_writepage() questions
Message-ID: <20060317004429.GG29275@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Badari Pulavarty <pbadari@us.ibm.com>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@osdl.org>, sct@redhat.com,
	lkml <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20060308124726.GC4128@lst.de> <4410551D.5000303@us.ibm.com> <20060309153550.379516e1.akpm@osdl.org> <4410CA25.2090400@us.ibm.com> <20060316180904.GA29275@thunk.org> <1142533360.21442.153.camel@dyn9047017100.beaverton.ibm.com> <20060316210424.GD29275@thunk.org> <1142546275.21442.172.camel@dyn9047017100.beaverton.ibm.com> <20060316220545.GB18753@atrey.karlin.mff.cuni.cz> <1142552722.21442.180.camel@dyn9047017100.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142552722.21442.180.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 03:45:21PM -0800, Badari Pulavarty wrote:
> Yep. I wasn't expecting to see buffers in the transaction/log. I was
> expecting to see some "dummy" transaction - which these buffers are
> attached to provide ordering. (even though we are not doing metadata
> updates). In fact, I was expecting to see "ctime" update in the
> transaction.

What you're missing is that journal_start() and journal_stop() don't
create a transaction.  They delimit an operation, yes, but multiple
operations are grouped together to form a transaction.  Transactions
are only closed when after the commit_internal or if the journal runs
out of space.  So you're not going to see a dummy transaction which
the buffers are attached to; instead, all of the various operations
happening within commit_interval are grouped into a single transaction.

This is all explained in Stephen's paper; see page #4 in:

http://ftp.kernel.org/pub/linux/kernel/people/sct/ext3/journal-design.ps.gz

						- Ted
