Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268057AbUHYPxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268057AbUHYPxy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 11:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268043AbUHYPxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 11:53:54 -0400
Received: from [144.51.25.10] ([144.51.25.10]:40898 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S268057AbUHYPwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 11:52:40 -0400
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>
In-Reply-To: <024501c48a89$12d30b30$f97d220a@linux.bs1.fc.nec.co.jp>
References: <Xine.LNX.4.44.0408161119160.4659-100000@dhcp83-76.boston.redhat.com>
	 <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp>
	 <1093014789.16585.186.camel@moss-spartans.epoch.ncsc.mil>
	 <042b01c489ab$8a871ce0$f97d220a@linux.bs1.fc.nec.co.jp>
	 <1093361844.1800.150.camel@moss-spartans.epoch.ncsc.mil>
	 <024501c48a89$12d30b30$f97d220a@linux.bs1.fc.nec.co.jp>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1093449047.6743.186.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 25 Aug 2004 11:50:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-25 at 05:51, Kaigai Kohei wrote:
> The attached take3-patch is modified as follows:
> - avc_node_dual was eliminated by Paul E.McKenny's suggestion.
>   avc_update_node() calls kmalloc() and may return -ENOMEM.
>   (But, I think this effect is so limited.)
> - All list_for_each_entry() were replaced by list_for_each_entry_rcu().
> - All spin_lock()/spin_unlock() were replaced by spin_lock_irqsave()
>   /spin_unlock_restore().
> - In avc_node_insert(), if an entry with the same ssid/tsid/tclass as new
>   one exists, the older entry is replaced by the new one.
> 
> Thanks. I want to make it the last edition hopefully. :)

I haven't tracked down the cause yet, but a kernel built with all three
patches (list_replace_rcu, atomic_inc_return, and selinux.rcu take3) on
x86 doesn't allow an enforcing boot; it begins auditing denials _before_
the initial policy load (which should never happen, as
security_compute_av allows everything until the policy is loaded), and
prevents /sbin/init from loading the policy.

A few other comments on the patch:

+	new = kmalloc(sizeof(struct avc_node), GFP_ATOMIC);
+	if (!new)
+		return NULL;

Dynamically allocating the nodes at runtime (rather than pre-allocating
them and then just reclaiming them as necessary as in the current AVC)
worries me, as it introduces a new failure case for avc_has_perm. 
Denying permission to a resource due to transient memory shortage is not
good for robustness.  And changing the GFP_ATOMIC is not an option, as
calling context may not allow blocking.  Hence, pre-allocation seems
desirable, regardless of the locking scheme.

+static int avc_latest_notif_update(int seqno, int is_insert)
+{
+	int ret = 0;
+	static spinlock_t notif_lock = SPIN_LOCK_UNLOCKED;
+	unsigned long flag;
+
+	spin_lock_irqsave(&notif_lock, flag);
+	if (seqno < avc_cache.latest_notif) {
+		if (is_insert) {
+			printk(KERN_WARNING "avc:  seqno %d < latest_notif %d\n",
+			       seqno, avc_cache.latest_notif);
+			ret = -EAGAIN;
+		} else {
+			avc_cache.latest_notif = seqno;
+		}
+	}
+	spin_unlock_irqrestore(&notif_lock, flag);
+	return ret;
 }

In trying to merge the logic related to latest_notif, you've introduced
a bug - latest_notif should only be increased, never decreased.  See the
original logic from avc_control and avc_ss_reset prior to your patch. 
Those functions update the latest notif based on a policy change event. 
In the insert case, you are checking that the entry is not stale, i.e.
has a smaller seqno than the latest notification due to an interleaving
with a policy change event.
 
+			if (node->ae.avd.allowed != (node->ae.avd.allowed|requested))
+				avc_update_node(AVC_CALLBACK_GRANT
+				                ,requested,ssid,tsid,tclass);
 		}

The test seems unnecessary, as the function has already determined that
not all of the requested permissions were granted, so you should be able
to just unconditionally call avc_update_node here, and you only need to
pass it the denied set that has already been computed, as any other
permissions in requested were already allowed.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

