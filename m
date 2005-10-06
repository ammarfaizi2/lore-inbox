Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbVJFSom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbVJFSom (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 14:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVJFSom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 14:44:42 -0400
Received: from fmr21.intel.com ([143.183.121.13]:62149 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751302AbVJFSol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 14:44:41 -0400
Date: Thu, 6 Oct 2005 11:44:28 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Junio C Hamano <junkio@cox.net>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: PIPE_BUFFERS - was Re: What to expect after 0.99.8
Message-ID: <20051006184428.GA6476@agluck-lia64.sc.intel.com>
References: <7v1x32l0gz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0510031606550.31407@g5.osdl.org> <20051004071210.GA18716@localdomain> <Pine.LNX.4.63.0510040321170.23242@iabervon.org> <pan.2005.10.04.14.18.59.102722@smurf.noris.de> <434296F1.5030006@zytor.com> <20051004154640.GC4682@kiste.smurf.noris.de> <4342AF4B.7020806@zytor.com> <7vu0fx9c1c.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0510041706330.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510041706330.31407@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 05:10:18PM -0700, Linus Torvalds wrote:
> Just for performance reasons, I ended up doing merging anyway, so in fact 
> regardless of how you write the current pipe buffer size is up to 16 
> pages.

s/git@vger.kernel.org/linux-kernel@vger.kernel.org/ in the Cc: list, this
isn't a GIT issue.

Should that:

#define PIPE_BUFFERS (16)

really be a function of PAGE_SIZE?  Many systems have a 4K page size
so they get 64K of buffering per pipe.  But ia64 defaults to 16K page
size, so pipes are suddenly 256K ... and with a 64K page size we
have 1MB per pipe.

So perhaps:

#define PIPE_BUFFERS (65536 / PAGE_SIZE)

But that would leave PIPE_BUFFERS as "1" on a 64K page size system, is
there any double-buffering benefit from having more than one page on the
pipe list?  If so, then something like:

#define PIPE_BUFFERS min(2, (65536 / PAGE_SIZE))

but then gcc is unhappy using the super-type safe "min" in the
places that use PIPE_BUFFERS ... so we'd end up with:

#define PIPE_BUFFERS ((65536 / PAGE_SIZE) > 1 ? (65536 / PAGE_SIZE) : 2)

-Tony
