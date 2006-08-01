Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWHAUqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWHAUqu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 16:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWHAUqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 16:46:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16053 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750712AbWHAUqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 16:46:49 -0400
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: let md auto-detect 128+ raid members, fix potential race condition
References: <ork65veg2y.fsf@free.oliva.athome.lsd.ic.unicamp.br>
	<20060730124139.45861b47.akpm@osdl.org>
	<orac6qerr4.fsf@free.oliva.athome.lsd.ic.unicamp.br>
	<17613.16090.470524.736889@cse.unsw.edu.au>
	<ord5blcyg0.fsf@free.oliva.athome.lsd.ic.unicamp.br>
	<17614.44057.322945.156592@cse.unsw.edu.au>
	<orpsflrxmb.fsf@free.oliva.athome.lsd.ic.unicamp.br>
	<orac6p870v.fsf@free.oliva.athome.lsd.ic.unicamp.br>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat OS Tools Group
Date: Tue, 01 Aug 2006 17:46:38 -0300
In-Reply-To: <orac6p870v.fsf@free.oliva.athome.lsd.ic.unicamp.br> (Alexandre Oliva's message of "Tue, 01 Aug 2006 00:33:04 -0300")
Message-ID: <oru04wfakx.fsf@free.oliva.athome.lsd.ic.unicamp.br>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug  1, 2006, Alexandre Oliva <aoliva@redhat.com> wrote:

>> I'll give it a try some time tomorrow, since I won't turn on that
>> noisy box today any more; my daughter is already asleep :-)

> But then, I could use my own desktop to test it :-)

But then, I wouldn't be testing quite the same scenario.

My boot-required RAID devices were all raid 1, whereas the larger,
separate volume group was all raid 6.

Using the mkinitrd patch that I posted before, the result was that
mdadm did try to bring up all raid devices but, because the raid456
module was not loaded in initrd, the raid devices were left inactive.

Then, when rc.sysinit tried to bring them up with mdadm -A -s, that
did nothing to the inactive devices, since they didn't have to be
assembled.  Adding --run didn't help.

My current work-around is to add raid456 to initrd, but that's ugly.
Scanning /proc/mdstat for inactive devices in rc.sysinit and doing
mdadm --run on them is feasible, but it looks ugly and error-prone.

Would it be reasonable to change mdadm so as to, erhm, disassemble ;-)
the raid devices it tried to bring up but that, for whatever reason,
it couldn't activate?  (say, missing module, not enough members,
whatever)

-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
Secretary for FSF Latin America        http://www.fsfla.org/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
