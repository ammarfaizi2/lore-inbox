Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266627AbUHYJ5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266627AbUHYJ5A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 05:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUHYJzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 05:55:53 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:1514 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S266366AbUHYJzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 05:55:19 -0400
Message-ID: <024b01c48a89$26765b60$f97d220a@linux.bs1.fc.nec.co.jp>
From: "Kaigai Kohei" <kaigai@ak.jp.nec.com>
To: <paulmck@us.ibm.com>
Cc: "Stephen Smalley" <sds@epoch.ncsc.mil>,
       "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>,
       "James Morris" <jmorris@redhat.com>
References: <Xine.LNX.4.44.0408161119160.4659-100000@dhcp83-76.boston.redhat.com> <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp> <1093014789.16585.186.camel@moss-spartans.epoch.ncsc.mil> <042b01c489ab$8a871ce0$f97d220a@linux.bs1.fc.nec.co.jp> <20040824230245.GA1243@us.ibm.com>
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
Date: Wed, 25 Aug 2004 18:51:53 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul, thanks for your comments.

> > I modified the following points:
> > - We hold the lock for hash backet when avc_insert() and avc_ss_reset() are
> >   called for safety.
> > - list_for_each_rcu() and list_entry() are replaced by list_for_entry().
> 
> One subtlety here...
> 
> The traversals that are protected by rcu_read_lock() (rather than an
> update-side spinlock) need to be list_for_each_entry_rcu() rather than
> list_for_each_entry().  The "_rcu()" is required in order to work
> reliably on Alpha, and has the added benefit of calling out exactly
> which traversals are RCU-protected.
> 
> Update-side code remains list_for_each_entry().

It was a simple misconception.
I fixed them in the take3-patch.

> > - avc_node_dual structure which contains two avc_node objects is defined. 
> >   It allows to do avc_update_node() without kmalloc() or any locks.
> 
> What happens when you have two consecutive updates to the same object?
> Don't you have to defer the second update until a grace period has
> elapsed since the first update in order to avoid confusing readers that
> are still accessing the original version?

I didn't imagine such a situation. Indeed, such thing may happen.

> One way to do this would be to set a "don't-touch-me" bit that is
> cleared by an RCU callback.  An update to an element with the
> "don't-touch-me" bit set would block until the bit clears.  There
> are probably better ways...

I think we can't apply this approach for the implementation
of avc_update_node(), because execution context isn't permitted to block.

I changed my opinion and implementation of avc_update_node().
If kmalloc() returns NULL in avc_update_node(), it returns -ENOMEM.

But this effect of changing the prototype is limited, because only
avc_has_perm_noaudit() and avc_update_cache() call avc_update_node().

Even if avc_update_node() return -ENOMEM to avc_has_perm_noaudit(),
avc_has_perm_noaudit() can ignore it, because the purpose is only
to control the audit-log floods.
This adverse effect is only that audit-logs are printed twice.

Nobody calls avc_update_cache(), which is only defined.

Some other trivial fixes are as follows:
- All list_for_each_entry() were replaced by list_for_each_entry_rcu().
- All spin_lock()/spin_unlock() were replaced by spin_lock_irqsave()
  /spin_unlock_restore().
- In avc_node_insert(), if an entry with the same ssid/tsid/tclass as new
  one exists, the older entry is replaced by the new one.

Thank you for the opinion as a specialist of RCU!
--------
Kai Gai <kaigai@ak.jp.nec.com>

