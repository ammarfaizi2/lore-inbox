Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752122AbWCOAyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbWCOAyx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 19:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbWCOAyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 19:54:53 -0500
Received: from ozlabs.org ([203.10.76.45]:26547 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751248AbWCOAyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 19:54:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17431.26069.168489.609677@cargo.ozlabs.ibm.com>
Date: Wed, 15 Mar 2006 11:54:45 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Howells <dhowells@redhat.com>
Cc: ebiederm@xmission.com (Eric W. Biederman), akpm@osdl.org,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, mingo@redhat.com, alan@redhat.com,
       linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #4] 
In-Reply-To: <2301.1142380768@warthog.cambridge.redhat.com>
References: <17431.14867.211423.851470@cargo.ozlabs.ibm.com>
	<m1veujy47r.fsf@ebiederm.dsl.xmission.com>
	<16835.1141936162@warthog.cambridge.redhat.com>
	<32068.1142371612@warthog.cambridge.redhat.com>
	<2301.1142380768@warthog.cambridge.redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells writes:

> Paul Mackerras <paulus@samba.org> wrote:
> 
> > No, that's not the problem.  The problem is that you can get q == &b
> > and d == 1, believe it or not.  That is, you can see the new value of
> > the pointer but the old value of the thing pointed to.
> 
> But that doesn't make any sense!

It certainly violates the principle of least surprise. :)

Apparently this can occur on some Alpha machines that have a
partitioned cache.  Although CPU 1 sends out the updates to b and p in
the right order because of the smp_wmb(), it's possible that b and p
are present in CPU 2's cache, one in each half of the cache.  If there
are a lot of updates coming in for the half containing b, but the half
containing p is quiet, it is possible for CPU 2 to see a new value of
p but an old value of b, unless you put an rmb instruction between the
two loads from memory.

I haven't heard of this being an issue on any other architecture.  On
PowerPC it can't happen because the architecture specifies that a data
dependency creates an implicit read barrier.

Paul.
