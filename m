Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267766AbUHZHxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267766AbUHZHxp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 03:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267743AbUHZHxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 03:53:44 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:7417 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S267766AbUHZHxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 03:53:14 -0400
Message-ID: <02b701c48b41$b6b05100$f97d220a@linux.bs1.fc.nec.co.jp>
From: "Kaigai Kohei" <kaigai@ak.jp.nec.com>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>,
       "James Morris" <jmorris@redhat.com>
References: <Xine.LNX.4.44.0408161119160.4659-100000@dhcp83-76.boston.redhat.com> <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp> <1093014789.16585.186.camel@moss-spartans.epoch.ncsc.mil> <042b01c489ab$8a871ce0$f97d220a@linux.bs1.fc.nec.co.jp> <1093361844.1800.150.camel@moss-spartans.epoch.ncsc.mil> <024501c48a89$12d30b30$f97d220a@linux.bs1.fc.nec.co.jp> <1093449047.6743.186.camel@moss-spartans.epoch.ncsc.mil>
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
Date: Thu, 26 Aug 2004 16:53:02 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, thanks for your comments.

> A few other comments on the patch:
> 
> + new = kmalloc(sizeof(struct avc_node), GFP_ATOMIC);
> + if (!new)
> + return NULL;
> 
> Dynamically allocating the nodes at runtime (rather than pre-allocating
> them and then just reclaiming them as necessary as in the current AVC)
> worries me, as it introduces a new failure case for avc_has_perm. 
> Denying permission to a resource due to transient memory shortage is not
> good for robustness.  And changing the GFP_ATOMIC is not an option, as
> calling context may not allow blocking.  Hence, pre-allocation seems
> desirable, regardless of the locking scheme.

In my understanding, your worry about robustness is the execution path
when kmalloc() returns NULL.
The most significant point is there.
--[ in the original kernel-2.6.8.1 ]--
    :
  rc = avc_insert(ssid,tsid,tclass,&entry,aeref);
  if (rc) {
    spin_unlock_irqrestore(&avc_lock,flags);
    goto out;
  }
    :
--------------------------------------
In the original implementation, avc_insert() returns -ENOMEM when we can't
hold a avc_entry by avc_claim_node(), then avc_has_perm_noaudit() denies
the requested permition check by the reason an avc_node is not allocated.
(But avc_insert() always returns 0, because avc_insert() reclaim a avc_node
 under the spinlock when free_list is empty.)
However, allocating an avc_node and making the decision according to
the policy of SELinux should be separated in considering.

In my approach with RCU, avc_insert() can actually return NULL.
Currently, avc_has_perm_noaudit() returns -ENOMEM without the decision-making
like as the original implementation.
But we can make an decision according to the policy of SELinux by a suitable
recover processing.

My proposal is as follows:
- Normaly, decision-making is performed to the entry on AVC.
  These entries are allocated by kmalloc()
- When kmalloc() called by the extension of avc_insert() returns NULL,
  the decision-making is performed to the entry on stack variable,
  then the entry is not hold on AVC.

-- e.g. in avc_has_perm_noaudit() --------------
    :
  struct avc_entry local_ae, *ae;
    :
  node = avc_insert(....);
  if (!node) {
    SETUP_LOCAL_AE(&local_ae,&entry.avd);
    ae = &local_ae;
  } else {
    ae = &node->ae;
  }
  
  if (avd)
    memcpy(avd, &ae->avd, sizeof(*avd));
    :
------------------------------------------------
By this method, the decision-making is available irrespective of
the result of kmalloc(). Is it robustless?
The original implementation has too many lock contensitons in Big-SMP
environment. It is more positive to consider the method using RCU.

> In trying to merge the logic related to latest_notif, you've introduced
> a bug - latest_notif should only be increased, never decreased.  See the
> original logic from avc_control and avc_ss_reset prior to your patch. 
> Those functions update the latest notif based on a policy change event. 
> In the insert case, you are checking that the entry is not stale, i.e.
> has a smaller seqno than the latest notification due to an interleaving
> with a policy change event.

Ooooooops!
It is toooooo trivial BUG!
I'll fix them very soon.

> + if (node->ae.avd.allowed != (node->ae.avd.allowed|requested))
> + avc_update_node(AVC_CALLBACK_GRANT
> +                 ,requested,ssid,tsid,tclass);
>   }
> 
> The test seems unnecessary, as the function has already determined that
> not all of the requested permissions were granted, so you should be able
> to just unconditionally call avc_update_node here, and you only need to
> pass it the denied set that has already been computed, as any other
> permissions in requested were already allowed.

Indeed, it is right. I'll fix them soon.
avc_update_node() is in the section between rcu_read_lock() and rcu_read_unlock().

> - rc = -ENOENT;
>  out:
> - return rc;
> + return node;
> +}
> 
> Ah, I think the bug is here.

Oops!
I agree, and fix this soon.

Please wait for a patch, thanks.
--------
Kai Gai <kaigai@ak.jp.nec.com>
