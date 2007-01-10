Return-Path: <linux-kernel-owner+w=401wt.eu-S932706AbXAJD35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbXAJD35 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 22:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbXAJD35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 22:29:57 -0500
Received: from ns1.suse.de ([195.135.220.2]:47862 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932706AbXAJD34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 22:29:56 -0500
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 10 Jan 2007 14:29:35 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17828.23967.419596.669927@notabene.brown>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH - RFC] allow setting vm_dirty below 1% for large memory
 machines
In-Reply-To: message from Andrew Morton on Tuesday January 9
References: <17827.22798.625018.673326@notabene.brown>
	<20070109021017.447b682d.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday January 9, akpm@osdl.org wrote:
> 
> Actually, ext3 doesn't work that way.  The atime update will go into the
> "running transaction", which is an instance of journal_t which is separate
> from the committing transaction.

Hmm... fair enough.  start_this_handle (which is called eventually
from ext3_dirty_inode) seems to wait for a few different things, and I
jumped to some conclusions.

> 
> But there are situations (ie; journal free-space exhaustion) where things
> can go synchronous.  They're more likely to occur during metadata storms
> though, and perhaps indicate an undersized journal.
> 
> But yeah, overall point agreed with.

Thanks.

> > So this patch removes the minimum of '5' and introduces a new tunable
> > 'vm.dirty_kb' which sets an upper limit in Kibibytes.
> 
> kibibytes?  We're feeding the kernel catfood now?

:-)

> > and journal commits).  The symptoms are:
> >   While generating constant write traffic on a machine with > 20Gig
> >   of RAM, performing assorted read-only operations can sometimes
> >   produces a pause of 10s of seconds.
> >   The pause can be removed by:
> >     - mounting noatime
> >     - mounting data=writeback
> >     - setting vm.dirty_kb to 1000 with this patch.
> 
> Could be IO scheduler borkage, could be ext3 borkage.  A well-timed sysrq-T
> will tell us, and is worth doing (please).
> 
> Does increasing the journal size help?

No, that was tried.

> 
> It would be better if we can avoid creating the second global variable.  Is
> it not possible to remove dirty_ratio?  Make everything work off
> vm_dirty_kb and do arithmetricks at the /proc/sys/vm/dirty_ratio interface?

Uhmmm... not sure what you are thinking.
I guess we could teach vm.dirty_ratio to take a floating point number
(but does sysctl understand that?) so we could set it to 0.01 or
similar, but that is missing the point in a way.  We don't really want
to set a small ratio.  We want to set a small maximum number.

It could make lots of sense to have two numbers.  A ratio that wins on
a small memory machine and a fixed number that wins on a large memory
machine.  Different trade offs are more significant in the different
cases.

> 
> We should perform the same conversion to dirty_background_ratio, I suspect.
> 

I didn't add a fixed limit for dirty_background_ratio as it seemed
reasonable to assume that (dirty_background_ratio / dirty_ratio) was a
meaningful value, and just multiplied the final 'dirty' figure by this
ration to get the 'background' figure.

> And these guys should be `long', not `int'.  Otherwise things will go
> pearshaped at 2 tabbybytes.

I don't think so.  You would need to have blindingly fast storage
before there would be any interest in vm_dirty_kb getting anything
close to t*bytes.  But I guess we can make it 'unsigned long' if it
helps.

Thanks,
NeilBrown
