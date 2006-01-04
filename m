Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWADEx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWADEx0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 23:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWADEx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 23:53:26 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:42920 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932385AbWADEx0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 23:53:26 -0500
Date: Wed, 4 Jan 2006 10:21:58 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, prasanna@in.ibm.com,
       anil.s.keshavamurthy@intel.com, davem@davemloft.net
Subject: Re: [-mm PATCH] kprobes: fix build break in 2.6.15-rc5-mm3
Message-ID: <20060104045158.GA26057@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20051220095432.GA5139@in.ibm.com> <20060103185508.53f65bf9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060103185508.53f65bf9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 06:55:08PM -0800, Andrew Morton wrote:
> Ananth N Mavinakayanahalli <ananth@in.ibm.com> wrote:
> >
> > The following patch (against 2.6.15-rc5-mm3) fixes a kprobes build
> >  break due to changes introduced in the kprobe locking in
> >  2.6.15-rc5-mm3. In addition, the patch reverts back the open-coding
> >  of kprobe_mutex.
> 

Andrew,

> Complaints:

Sorry for the goofups..

> a) Your changelog failed to describe what the build breakage was.  It helps.

The arch_remove_kprobe() prototype declaration in
include/asm-*/kprobes.h needs a forward declaration of "struct kprobe"
due to the order in which the kprobe.h files (include/linux/kprobe.h and
the arch specific ones) are included. Though other archs build fine,
the powerpc compiler throws out an error:

include/asm/kprobes.h:53: warning: its scope is only this definition or
declaration, which is probably not what you want
arch/powerpc/kernel/kprobes.c:84: error: conflicting types for
`arch_remove_kprobe'
include/asm/kprobes.h:53: error: previous declaration of
`arch_remove_kprobe'
make[1]: *** [arch/powerpc/kernel/kprobes.o] Error 1
make: *** [arch/powerpc/kernel] Error 2

> b) the changelog fails to describe _why_ we've reverted the locking

The patch that introduced kprobe_mutex instead of the spinlock had an
undesirable portion that passed a struct semaphore * as a parameter.
This obfuscates locking and will lead to hard to maintain code.

> c) The patch does multiple things.
> 
> See, what I would _like_ to do is to fold the fixes in this patch into the
> patches which are already in -mm.  That way, the patches which hit Linus's
> tree will be neater and won't introduce build breakage at any point.
> 
> And they won't add stuff and then immediately take it away again.  That's
> for git losers ;)
> 
> But the patch which you've sent doesn't have a hope of applying anywhere
> except at the end of the patches which I already have.

My understanding was that the preferred method is incremental patches over
the released -mm.
 
> The net result is that we'll hit Linus's tree with a bunch of patches, and
> then a followup patch which fixes those patches.  Which is a dumb way in
> which to present the permanent kernel record, given that we have an
> opportunity to get it right first time, no?

You are right. The patch in question fixes a build break and other issues
in the kprobe spinlock to mutex patch. And it is indeed better to redo the
patch with these fixes included. Does that sound reasonable?

> Here's the bottom line: please never ever ever ever ever ever do more than
> one thing in a single patch.  Ever.  Did I mention "ever"?  There are soooo
> many reasons for this....

Point taken :)

Ananth
