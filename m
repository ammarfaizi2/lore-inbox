Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266631AbUHXH3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266631AbUHXH3x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 03:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266661AbUHXH2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 03:28:36 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:55993 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S266631AbUHXH1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 03:27:55 -0400
Message-ID: <043201c489ab$c16fd080$f97d220a@linux.bs1.fc.nec.co.jp>
From: "Kaigai Kohei" <kaigai@ak.jp.nec.com>
To: <paulmck@us.ibm.com>
Cc: "James Morris" <jmorris@redhat.com>,
       "Stephen Smalley" <sds@epoch.ncsc.mil>,
       "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>
References: <Xine.LNX.4.44.0408161119160.4659-100000@dhcp83-76.boston.redhat.com> <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp> <20040820201914.GA1244@us.ibm.com>
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
Date: Tue, 24 Aug 2004 16:27:05 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul, Thanks for your comments.

> A few comments interspersed for the larger patch (look for empty lines).
> I am missing why some of the list insertions and deletions are SMP safe.

Sorry, some of them were my bug.

> > + if (spin_trylock(&avc_cache.slots_lock[hvalue])) {
> > + list_for_each_rcu(pos, &avc_cache.slots[hvalue]) {
> 
> Since we are holding the lock, the list cannot change, and the _rcu()
> is not needed.  Right?

No, only insert/update/delete paths must hold the lock.
The _rcu suffix is necessary since read-only path does not hold the lock.
(It was my bug the inserting path did not hold the lock.)

> > + node = list_entry(pos, struct avc_node, list);
> 
> Why not just do:
> 
> list_for_each_entry(pos, &avc_cache.slots[hvalue], list) {
> 
> rather than having the separate list_entry().

Your suggestion is better. I fixed it.

> > + if (org) {
> > + if (!new) {
> 
> If we run out of memory, we silently delete the node that we were
> wanting to update?  Is this really what you want?
> 
> OK, OK, given that the "C" in "AVC" stands for "cache", I guess that
> deleting the element does indeed make sense...

Indeed, I thought it is pretty rough, and fixed avc_insert().
Now, kmalloc() is unecessary in avc_insert().
Therefore, the updating always succeeds.
(But pretty more memory is required.)

> > + switch (event) {
> > + case AVC_CALLBACK_GRANT:
> > + new->ae.avd.allowed |= perms;
> 
> This is a 32-bit field, and is protected by a lock.  Therefore, only
> one update should be happening at a time.  This field is 32-bit aligned
> (right?), and so the write that does the update will appear atomic to
> readers.  Only one of the the updates happens in a given call.

Is it about "new->ae.avd.allowed |= perms;" ?
No others can refer the 'new', since the 'new' is the duplicated entry
of the 'org'. It is safe irrespective of the lock held or unheld.

In addition, the problem which had its roots in avc_insert()
was solved by the take2 patch.

> o There is some bizarre CPU out there that does not do
> atomic 32-bit writes (but this would break all sorts of
> stuff).
> 
> o Consecutive changes might give a slow reader the incorrect
> impression that permissions are wide open.  One way to take
> care of this would be to force a grace period between each
> change.  One way to do this would be to set a bit indicating
> an update, and have the call_rcu() clear it.  When getting
> ready to update, if the bit is still set, block until the
> bit is cleared.  This would guarantee that a given reader
> would see at most one update.
> 
> But this would require considerable code restructuring, since
> this code is still under an rcu_read_lock().  But putting
> forward the thought anyway in case it is helpful.
> 
> If updates are -really- rare, a simple way to make this happen
> would be to protect the updates with a sema_t, and just do
> an unconditional synchronize_kernel() just before releasing
> the sema_t.
> 
> Since the current code permits readers to see changes to
> several different nodes, a single synchronize_kernel() should
> suffice.

> > + list_del_rcu(&node->list);
> 
> I don't see what prevents multiple list_del_rcu()s from executing in
> parallel, mangling the list.  Is there some higher-level lock?
> If so, why do we need RCU protecting the list?

I agree, and fixed it.

> > + rcu_read_lock();
> > + node = avc_insert(ssid,tsid,tclass,&entry);
> 
> I don't see what prevents two copies of avc_insert from running in parallel.
> Seems like this would trash the lists.  Or, if there is a higher-level lock
> that I am missing, why do we need RCU protecting the lists?

I agree, and fixed it.

Thanks.
--------
Kai Gai <kaigai@ak.jp.nec.com>

