Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbVKIRTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbVKIRTz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbVKIRTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:19:53 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:36763 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1030508AbVKIRTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:19:49 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17266.12228.657758.358807@gargle.gargle.HOWL>
Date: Wed, 9 Nov 2005 20:20:04 +0300
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       torvalds@osdl.org, Hirokazu Takahashi <taka@valinux.co.jp>,
       Magnus Damm <magnus.damm@gmail.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Paul Jackson <pj@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 6/8] Direct Migration V2: Avoid writeback / page_migrate()
 method
In-Reply-To: <Pine.LNX.4.62.0511090907260.3607@schroedinger.engr.sgi.com>
References: <20051108210246.31330.61756.sendpatchset@schroedinger.engr.sgi.com>
	<20051108210417.31330.72381.sendpatchset@schroedinger.engr.sgi.com>
	<17265.55057.438316.467289@gargle.gargle.HOWL>
	<Pine.LNX.4.62.0511090907260.3607@schroedinger.engr.sgi.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter writes:
 > On Wed, 9 Nov 2005, Nikita Danilov wrote:
 > 
 > >  > +#ifdef CONFIG_MIGRATION
 > >  > +extern int buffer_migrate_page(struct page *, struct page *);
 > >  > +#else
 > >  > +#define buffer_migrate_page(a,b) NULL
 > >  > +#endif
 > > 
 > > Depending on the CONFIG_MIGRATION, the type of buffer_migrate_page(a,b)
 > > expansion is either int or void *, which doesn't look right.
 > 
 > But its right. You need to think about buffer_migrate_page as a pointer to 
 > a function.

buffer_migrate_page is a pointer to function.

buffer_migrate_page(a, b) is a value of type int (or void *).

 > 
 > > Moreover below you have initializations
 > > 
 > >         .migrate_page		= buffer_migrate_page,
 > > 
 > > that wouldn't compile when CONFIG_MIGRATION is not defined (as macro
 > > requires two arguments).
 > 
 > NULL is a void * pointer which should work.

$ cat > macro.c
#define buffer_migrate_page(a,b) NULL

int (*migrate_page) (void *, void *) = buffer_migrate_page;
^D
$ cc macro.c
macro.c:3: error: `buffer_migrate_page' undeclared here (not in a function)

When CONFIG_MIGRATION is not defined, buffer_migrate_page is a macro,
taking _two_ arguments. Name of such macro cannot be used without
argument list.

Nikita.
