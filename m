Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWGQCpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWGQCpd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 22:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWGQCpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 22:45:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10468 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932243AbWGQCpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 22:45:32 -0400
Date: Mon, 17 Jul 2006 03:45:19 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>,
       dm-devel@redhat.com, Ingo Molnar <mingo@elte.hu>,
       Milan Broz <mbroz@redhat.com>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: lockdep warning when nesting dm devices
Message-ID: <20060717024519.GA26318@agk.surrey.redhat.com>
Mail-Followup-To: Peter Osterlund <petero2@telia.com>,
	linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjan@linux.intel.com>, dm-devel@redhat.com,
	Ingo Molnar <mingo@elte.hu>, Milan Broz <mbroz@redhat.com>,
	Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
References: <m34pxj6rsm.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m34pxj6rsm.fsf@telia.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2006 at 01:17:29PM +0200, Peter Osterlund wrote:
> # echo "0 10000 linear /dev/loop0 0" | /sbin/dmsetup create test
> # echo "0 10000 linear /dev/mapper/test 0" | /sbin/dmsetup create test2
 
> I get the following warning from the lockdep validator.
> =============================================
> [ INFO: possible recursive locking detected ]
> ---------------------------------------------

Well at first sight the message is simply pointing out something expected - it
only say "INFO" after all - viz. recursive use of
	down_read(&md->io_lock);
something tied up with the split_bio horridness which needs to go away some
day.  The lock prevents any attempt to suspend the device from happening
while a bio is in the process of being split into other bios.

Of course it's always helpful to review code from different perspectives
like this to look out for any gotchas and we ought to re-check the use
of this lock.

> Btw, is there a limit on how many dm devices can be chained? I guess
> there will be a kernel stack overflow if you try to chain together too
> many devices.

There's a patch in -mm which tackles that, but it needs some changes to dm
(which Milan Broz has begun working on) before it will behave correctly in all
cases.
 
Alasdair
-- 
agk@redhat.com
