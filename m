Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTIISMI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 14:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbTIISMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 14:12:08 -0400
Received: from unthought.net ([212.97.129.24]:51336 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S264272AbTIISME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 14:12:04 -0400
Date: Tue, 9 Sep 2003 20:11:32 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Chris Meadors <clubneon@hereintown.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Panic when finishing raidreconf on 2.4.0-test4 with preempt
Message-ID: <20030909181131.GB9079@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Chris Meadors <clubneon@hereintown.net>, linux-kernel@vger.kernel.org
References: <1062883950.1341.26.camel@clubneon.clubneon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1062883950.1341.26.camel@clubneon.clubneon.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 06, 2003 at 05:32:30PM -0400, Chris Meadors wrote:
> I've done this twice now, I'd prefer not to do it again, but can upon
> request, if you really need the oops output.
> 
> Running raidreconf to expand a 4 disk array to 5, seems to work
> correctly until the very end.  I'm guessing it is as the RAID super
> block is being written.  A preempt error is triggered and the kernel
> panics.  Upon reboot the MD driver doesn't think the 5th disk is valid
> for consideration in the array and skips over it.  Leaving a very
> corrupted file system.

raidreconf does no "funny business" with the kernel, so I think this
points to either:
*) a bug which mkraid can trigger as well
*) an API change combined with missing error handling, which raidreconf
   now triggers (by calling the old API)
*) a more general kernel bug - there is a *massive* VM load when
   raidreconf does its magic, perhaps calling mkraid after beating
   the VM half way to death can trigger the same error?

raidreconf, upon complete reconfiguration, will set up the new
superblock for you array, mark it as "unclean", and add the disks one by
one.  Once all disks are added, the kernel should start calculating
parity information (because raidreconf does not do this during the
conversion, and hence marks the newly set up array as unclean in order
to have the kernel do this dirty work).

There should be nothing special about this, compared to normal mkraid
and raidhotadd usage - except raidreconf is probably a lot more likely
to trigger races.

Ah, fingerpointing  ;)

(/me sits back, confident that his code is perfect and the kernel alone
 is to blame)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
