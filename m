Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269059AbUIHJhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269059AbUIHJhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 05:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269065AbUIHJhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 05:37:16 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:41958 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S269059AbUIHJhI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 05:37:08 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16702.53946.440328.258271@thebsh.namesys.com>
Date: Wed, 8 Sep 2004 13:36:58 +0400
To: paulmck@us.ibm.com
Cc: andrea@suse.de, shemminger@osdl.org, akpm@osdl.org, dipankar@in.ibm.com,
       rusty@au1.ibm.com, faith@redhat.com, riel@redhat.com, ak@suse.de,
       mjbligh@us.ibm.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][Patch] RCU documentation
In-Reply-To: <20040907232855.GA13513@us.ibm.com>
References: <20040907232855.GA13513@us.ibm.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney writes:
 > Hello!

Hello Paul,

[...]

 > 
 > +	static inline int audit_upd_rule(struct audit_rule *rule,
 > +					 struct list_head *list,
 > +					 __u32 newaction,
 > +					 __u32 newfield_count)
 > +	{
 > +		struct audit_entry  *e;
 > +		struct audit_newentry *ne;
 > +
 > +		list_for_each_entry(e, list, list) {
 > +			if (!audit_compare_rule(rule, &e->rule)) {
 > +				ne = kmalloc(sizeof(*entry), GFP_ATOMIC);
 > +				if (ne == NULL)
 > +					return _ENOMEM;

-ENOMEM;

 > +				audit_copy_rule(&ne->rule, &e->rule);
 > +				ne->rule.action = newaction;

[...]

 > +	static enum audit_state audit_filter_task(struct task_struct *tsk)
 > +	{
 > +		struct audit_entry *e;
 > +		enum audit_state   state;
 > +
 > +		rcu_read_lock();
 > +		list_for_each_entry_rcu(e, &audit_tsklist, list) {
 > +			if (audit_filter_rules(tsk, &e->rule, NULL, &state)) {
 > +				spin_lock(&e->lock);
 > +				if (e->deleted) {
 > +					spin_unlock(&e->lock);
 > +					rcu_read_unlock();
 > +					return AUDIT_BUILD_CONTEXT;

Shouldn't this be "continue", to work correctly in the face of mutators
similar to audit_upd_rule(), that at some point leave both old (marked
->deleted) and new versions on the list?

Also, RCU used instead of existential lock is so typical, that it
probably deserves dedicated example.

 > +				}

[...]

Nikita.
