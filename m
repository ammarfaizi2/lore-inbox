Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267866AbUIPJEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267866AbUIPJEk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 05:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267869AbUIPJEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 05:04:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22279 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267866AbUIPJE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 05:04:26 -0400
Date: Thu, 16 Sep 2004 10:04:19 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Albert Cahalan <albert@users.sf.net>, Jakub Jelinek <jakub@redhat.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@muc.de
Subject: Re: get_current is __pure__, maybe __const__ even
Message-ID: <20040916100419.A31029@flint.arm.linux.org.uk>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	Jakub Jelinek <jakub@redhat.com>,
	Albert Cahalan <albert@users.sourceforge.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@muc.de
References: <1095288600.1174.5968.camel@cube> <20040915231518.GB31909@devserv.devel.redhat.com> <20040915232956.GE9106@holomorphy.com> <1095300619.2191.6392.camel@cube> <20040916023604.GH9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040916023604.GH9106@holomorphy.com>; from wli@holomorphy.com on Wed, Sep 15, 2004 at 07:36:04PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 07:36:04PM -0700, William Lee Irwin III wrote:
> On Wed, Sep 15, 2004 at 07:15:18PM -0400, Jakub Jelinek wrote:
> >>> current will certainly change in schedule (),
> 
> On Wed, Sep 15, 2004 at 10:10:20PM -0400, Albert Cahalan wrote:
> > Not really!
> 
> Yes it does. The interior of schedule() is C and must be compiled also.
> 
> 
> At some point in the past, I wrote:
> >> Why would barrier() not suffice?
> 
> On Wed, Sep 15, 2004 at 10:10:20PM -0400, Albert Cahalan wrote:
> > I don't think even barrier() is needed.
> > Suppose gcc were to cache the value of
> > current over a schedule. Who cares? It'll
> > be the same after schedule() as it was
> > before.
> 
> Not over a call to schedule(). In the midst of schedule().

Actually, I find myself agreeing with Albert here.  Consider the
following points:

- "current_thread()" depends on the kernel stack pointer.

- the kernel stack pointer is changed when we switch threads.
- the rest of the register set is changed when we switch threads.

Therefore, if we have current_thread() cached in a register, and we
away from thread A to thread B, and back to A, has the cached copy
become invalid for thread A ?  No.

Now look at the same thing from thread B's perspective.  Has anything
changed because thread A has run?  No.

IOW, think from a tasks point of view.  It gets into the scheduler,
and switch_to() is just a normal function which just happens to sleep
for some time.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
