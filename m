Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268098AbUHYQNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268098AbUHYQNT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 12:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268117AbUHYQNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 12:13:18 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:17093 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S268098AbUHYQNF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 12:13:05 -0400
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>
In-Reply-To: <1093449047.6743.186.camel@moss-spartans.epoch.ncsc.mil>
References: <Xine.LNX.4.44.0408161119160.4659-100000@dhcp83-76.boston.redhat.com>
	 <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp>
	 <1093014789.16585.186.camel@moss-spartans.epoch.ncsc.mil>
	 <042b01c489ab$8a871ce0$f97d220a@linux.bs1.fc.nec.co.jp>
	 <1093361844.1800.150.camel@moss-spartans.epoch.ncsc.mil>
	 <024501c48a89$12d30b30$f97d220a@linux.bs1.fc.nec.co.jp>
	 <1093449047.6743.186.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1093450284.6743.194.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 25 Aug 2004 12:11:24 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-25 at 11:50, Stephen Smalley wrote:
> I haven't tracked down the cause yet, but a kernel built with all three
> patches (list_replace_rcu, atomic_inc_return, and selinux.rcu take3) on
> x86 doesn't allow an enforcing boot; it begins auditing denials _before_
> the initial policy load (which should never happen, as
> security_compute_av allows everything until the policy is loaded), and
> prevents /sbin/init from loading the policy.

-int avc_lookup(u32 ssid, u32 tsid, u16 tclass,
-               u32 requested, struct avc_entry_ref *aeref)
+struct avc_node *avc_lookup(u32 ssid, u32 tsid, u16 tclass, u32 requested)
 {
 	struct avc_node *node;
-	int probes, rc = 0;
+	int probes;
 
 	avc_cache_stats_incr(AVC_CAV_LOOKUPS);
 	node = avc_search_node(ssid, tsid, tclass,&probes);
 
 	if (node && ((node->ae.avd.decided & requested) == requested)) {
 		avc_cache_stats_incr(AVC_CAV_HITS);
 		avc_cache_stats_add(AVC_CAV_PROBES,probes);
-		aeref->ae = &node->ae;
 		goto out;
 	}
 
 	avc_cache_stats_incr(AVC_CAV_MISSES);
-	rc = -ENOENT;
 out:
-	return rc;
+	return node;
+}

Ah, I think the bug is here.  avc_search_node() can return a node that
matches the (ssid,tsid,tclass) triple but doesn't include all of the
necessary decisions (the decided vector), but your avc_lookup() code
falls through nonetheless and returns it.  This happens normally during
initialization prior to policy load, where security_compute_av is only
adding decisions as they are requested.  Notice that the original code
set rc to ENOENT on that path; in your case, you need to reset node to
NULL.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

