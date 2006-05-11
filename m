Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbWEKGez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbWEKGez (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 02:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbWEKGey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 02:34:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:2963 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965153AbWEKGey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 02:34:54 -0400
Date: Wed, 10 May 2006 23:34:27 -0700
From: Paul Jackson <pj@sgi.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: akpm@osdl.org, bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/17] Infrastructure to mark exported symbols as
 unused-for-removal-soon
Message-Id: <20060510233427.4306422b.pj@sgi.com>
In-Reply-To: <1146581587.32045.41.camel@laptopd505.fenrus.org>
References: <1146581587.32045.41.camel@laptopd505.fenrus.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan wrote:
> This is patch one in a series of 17; to not overload lkml the other
> 16 will be mailed direct; people who want to see them all can see
> them at http://www.fenrus.org/unused

Well ... here's one case where your patch series is broken.

Argh - I almost missed this one.  My mailer is setup to tag all
incoming lkml email that mentions the magic word 'cpuset'.  But
it is not setup to catch indirect patches, needless to say.

One of your proposed changes (the only one I reviewed) removed the only
EXPORT_SYMBOL_GPL in kernel/cpuset.c.  That EXPORT is needed because
the routine in question is called from inlines which modules use.

I can't help but wonder how many more such cases your patches miss.

The details ...

Your patch includes this change:


+++++++++++++++++++++++ begin +++++++++++++++++++++++
Index: linux-2.6.17-rc3-mm1-unused/kernel/cpuset.c
===================================================================
--- linux-2.6.17-rc3-mm1-unused.orig/kernel/cpuset.c
+++ linux-2.6.17-rc3-mm1-unused/kernel/cpuset.c
@@ -2338,7 +2338,7 @@ int cpuset_mem_spread_node(void)
 	current->cpuset_mem_spread_rotor = node;
 	return node;
 }
-EXPORT_SYMBOL_GPL(cpuset_mem_spread_node);
+EXPORT_UNUSED_SYMBOL_GPL(cpuset_mem_spread_node); /* removal in 2.6.19 */
 
 /**
  * cpuset_excl_nodes_overlap - Do we overlap @p's mem_exclusive ancestors?
++++++++++++++++++++++++ end +++++++++++++++++++++++


Andrew added this EXPORT, with the following patch:


+++++++++++++++++++++++ begin +++++++++++++++++++++++
From: Andrew Morton <akpm@osdl.org>

It's called from inlines which modules use.

Cc: Paul Jackson <pj@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 kernel/cpuset.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN kernel/cpuset.c~cpuset-memory-spread-basic-implementation-fix kernel/cpuset.c
--- devel/kernel/cpuset.c~cpuset-memory-spread-basic-implementation-fix 2006-02-06 23:51:0
0.000000000 -0800
+++ devel-akpm/kernel/cpuset.c  2006-02-06 23:51:00.000000000 -0800
@@ -2220,6 +2220,7 @@ int cpuset_mem_spread_node(void)
        current->cpuset_mem_spread_rotor = node;
        return node;
 }
+EXPORT_SYMBOL_GPL(cpuset_mem_spread_node);

 /**
  * cpuset_excl_nodes_overlap - Do we overlap @p's mem_exclusive ancestors?
++++++++++++++++++++++++ end +++++++++++++++++++++++

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
