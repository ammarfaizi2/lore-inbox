Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVFTPwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVFTPwc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 11:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVFTPwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 11:52:31 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:62439 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261360AbVFTPwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 11:52:25 -0400
Date: Mon, 20 Jun 2005 21:31:26 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org
Cc: linux-kernel@vger.kernel.org, bcrl@kvack.org, wli@holomorphy.com,
       zab@zabbo.net, mason@suse.com
Subject: [PATCH 0/6] Integrate AIO with wait-bit based filtered wakeups
Message-ID: <20050620160126.GA5271@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050620120154.GA4810@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620120154.GA4810@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 05:31:54PM +0530, Suparna Bhattacharya wrote:
> Since AIO development is gaining momentum once again, ocfs2 and
> samba both appear to be using AIO, NFS needs async semaphores etc,
> there appears to be an increase in interest in straightening out some
> of the pending work in this area. So this seems like a good
> time to re-post some of those patches for discussion and decision.
> 
> Just to help sync up, here is an initial list based on the pieces
> that have been in progress with patches in existence (please feel free
> to add/update ones I missed or reflected inaccurately here):
> 
> (1) Updating AIO to use wait-bit based filtered wakeups (me/wli)
> 	Status: Updated to 2.6.12-rc6, needs review

Here is a little bit of background on the motivation behind this set of
patches to update AIO for filtered wakeups:

(a) Since the introduction of filtered wakeups support and 
    the wait_bit_queue infrastructure in mainline, it is no longer
    sufficient to just embed a wait queue entry in the kiocb
    for AIO operations involving filtered wakeups.
(b) Given that filesystem reads/writes use filtered wakeups underlying
    wait_on_page_bit, fixing this becomes a pre-req for buffered
    filesystem AIO.
(c) The wait_bit_queue infrastructure actually enables a cleaner
    implementation of filesystem AIO because it already provides
    for an action routine intended to allow both blocking and
    non-blocking or asynchronous behaviour.

As I was rewriting the patches to address this, there is one other
change I made to resolve one remaining ugliness in my earlier
patchsets - special casing of the form 
	if (wait == NULL) wait = &local_wait
to switch to a stack based wait queue entry if not passed a wait
queue entry associated with an iocb.

To avoid this, I have tried biting the bullet by including a default
wait bit queue entry in the task structure, to be used instead of
on-demand allocation of a wait bit queue entry on stack.

All in all, these changes have (hopefully) simplified the code,
as well as made it more up-to-date. Comments (including
better names etc as requested by Zach) are welcome !

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

