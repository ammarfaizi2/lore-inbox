Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWCCPoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWCCPoj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 10:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWCCPoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 10:44:39 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:61917 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751108AbWCCPoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 10:44:38 -0500
Date: Fri, 3 Mar 2006 16:43:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
       Alexander Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 7/5] Optimise d_find_alias()
Message-ID: <20060303154312.GA11871@elte.hu>
References: <20060303034552.5fcedc49.akpm@osdl.org> <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com> <25676.1141385408@warthog.cambridge.redhat.com> <27600.1141390810@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27600.1141390810@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Howells <dhowells@redhat.com> wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> 
> > How can we get away without a barrier?
> 
> Is this what you're thinking of:
> 
> 	struct dentry * d_find_alias(struct inode *inode)
> 	{
> 		struct dentry *de = NULL;
> 
> 		smp_rmb();
> 		if (!list_empty(&inode->i_dentry)) {
> 			spin_lock(&dcache_lock);

no barrier is needed i think. This code just picks an alias, with no 
guarantee of any ordering wrt. add/removal ops from the alias list. In 
other words, d_find_alias() depends on external serialization - when 
used standalone it is fundamentally nondeterministic anyway.

it is true that the list_empty() might observe an intermediate state of 
the list [e.g. backlink not modified yet but forward link modified - or 
the other way around], but that's not a problem: it either returns true 
or false, both of which are correct results when the modification is 
underway in parallel on another CPU. When d_find_alias() returns 
non-NULL it will only do it by taking dcache_lock, so the correct use of 
the list is always guaranteed.

[ a barrier would have no useful effect here anyway - it only guarantees
  instruction ordering locally, and has no deterministic effect on the
  order of memory values being written from another CPU. A barrier makes
  sense when ordering of writes to two different memory values is
  deterministic - e.g. a flag and a resource pointer. But in the case of
  list_empty(), the order of modifications to the two pointers in the
  list is not guaranteed. ]

	Ingo
