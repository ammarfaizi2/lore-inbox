Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269148AbUIHOq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269148AbUIHOq7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269150AbUIHOnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 10:43:43 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:34550 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S269111AbUIHOlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 10:41:51 -0400
Date: Wed, 8 Sep 2004 07:37:43 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: andrea@suse.de, shemminger@osdl.org, akpm@osdl.org, dipankar@in.ibm.com,
       rusty@au1.ibm.com, faith@redhat.com, riel@redhat.com, ak@suse.de,
       mjbligh@us.ibm.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][Patch] RCU documentation
Message-ID: <20040908143743.GB1240@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040907232855.GA13513@us.ibm.com> <16702.53946.440328.258271@thebsh.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16702.53946.440328.258271@thebsh.namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 01:36:58PM +0400, Nikita Danilov wrote:
> Paul E. McKenney writes:
>  > Hello!
> 
> Hello Paul,

Hello, Nikita!

> [...]
> 
>  > 
>  > +	static inline int audit_upd_rule(struct audit_rule *rule,
>  > +					 struct list_head *list,
>  > +					 __u32 newaction,
>  > +					 __u32 newfield_count)
>  > +	{
>  > +		struct audit_entry  *e;
>  > +		struct audit_newentry *ne;
>  > +
>  > +		list_for_each_entry(e, list, list) {
>  > +			if (!audit_compare_rule(rule, &e->rule)) {
>  > +				ne = kmalloc(sizeof(*entry), GFP_ATOMIC);
>  > +				if (ne == NULL)
>  > +					return _ENOMEM;
> 
> -ENOMEM;

Good catch!

>  > +				audit_copy_rule(&ne->rule, &e->rule);
>  > +				ne->rule.action = newaction;
> 
> [...]
> 
>  > +	static enum audit_state audit_filter_task(struct task_struct *tsk)
>  > +	{
>  > +		struct audit_entry *e;
>  > +		enum audit_state   state;
>  > +
>  > +		rcu_read_lock();
>  > +		list_for_each_entry_rcu(e, &audit_tsklist, list) {
>  > +			if (audit_filter_rules(tsk, &e->rule, NULL, &state)) {
>  > +				spin_lock(&e->lock);
>  > +				if (e->deleted) {
>  > +					spin_unlock(&e->lock);
>  > +					rcu_read_unlock();
>  > +					return AUDIT_BUILD_CONTEXT;
> 
> Shouldn't this be "continue", to work correctly in the face of mutators
> similar to audit_upd_rule(), that at some point leave both old (marked
> ->deleted) and new versions on the list?

Interesting point -- update-in-place combined with the ->deleted flag
does require some additional mechanism.  In some cases, the approach you
call out works (give or take the need for added memory barriers in order
to guarantee that the list_add_rcu() happends before the list_del_rcu()).
In other cases, such as in dcache, it is necessary to restart the search
from the beginning.

My thought would be to add some words saying that this example is
not cumulative with the _upd_ example.  I do need to keep the simple
deleted-flag example, since this is a common usage.

Thoughts?

> Also, RCU used instead of existential lock is so typical, that it
> probably deserves dedicated example.

Excellent point, will add this.  Any favorite example code?  ;-)

						Thanx, Paul

>  > +				}
> 
> [...]
> 
> Nikita.
> 
