Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291477AbSCMBHP>; Tue, 12 Mar 2002 20:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291531AbSCMBHF>; Tue, 12 Mar 2002 20:07:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1553 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291477AbSCMBGx>;
	Tue, 12 Mar 2002 20:06:53 -0500
Date: Wed, 13 Mar 2002 01:06:52 +0000
From: wli@holomorphy.com
To: Andrew Morton <akpm@zip.com.au>
Cc: Andrea Arcangeli <andrea@suse.de>, wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020313010652.F14628@holomorphy.com>
Mail-Followup-To: wli@holomorphy.com, Andrew Morton <akpm@zip.com.au>,
	Andrea Arcangeli <andrea@suse.de>,
	wli@parcelfarce.linux.theplanet.co.uk,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
	phillips@bonn-fries.net
In-Reply-To: <20020312041958.C687@holomorphy.com> <20020312070645.X10413@dualathlon.random> <20020312112900.A14628@holomorphy.com> <20020312135605.P25226@dualathlon.random> <20020312141439.C14628@holomorphy.com> <20020312160430.W25226@dualathlon.random>, <20020312160430.W25226@dualathlon.random>; <20020312233117.E14628@holomorphy.com> <3C8E98B2.159FA546@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C8E98B2.159FA546@zip.com.au>; from akpm@zip.com.au on Tue, Mar 12, 2002 at 04:09:22PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wli@holomorphy.com wrote:
>> Also, these changes to the hashing scheme were not separated out
>> from the rest of the VM patch, so the usual "break this up
>> into a separate patch please" applies.

On Tue, Mar 12, 2002 at 04:09:22PM -0800, Andrew Morton wrote:
> FYI, I am doing that at present.  It look like Andrea's 10_vm-30
> patch will end up as twenty or thirty separate patches.  I won't
> be testing every darn patch individually - I'll batch them up into
> maybe four groups for testing and merging.

There are some okay parts to aa's hashing changes but we need to
work together to get the patch to perform those and drop the rest,
and also address some style issues. Some of the constants are
adjustable (though it's not clear how they should be adjusted) and the
wait_table_t ADT is fine. The hash function change is not and moving
the table from per-zone to per-node is questionable, as its effects are
not well-understood.

Perhaps understandably so, I'd like to take a hands-on role in
guiding this patch into a form suitable for the mainline kernel.


On Tue, Mar 12, 2002 at 04:09:22PM -0800, Andrew Morton wrote:
> Andrea introduced some subtly changed buffer locking rules, and
> this causes ext3 to deadlock under heavy load.  Until we sort
> this out, I'm afraid that the -aa VM is not suitable for production
> use with ext3.
> ext2 is OK and I *assume* it's OK with reiserfs.  The problem occurs
> when a filesystem performs:
> 	lock_buffer(dirty_bh);
> 	allocate_something(GFP_NOFS);
> without having locked the buffer's page.  sync_page_buffers()
> can perform a wait_on_buffer() against dirty_bh.  (I think.
> I'm not quite up-to-speed with the new buffer state bits yet).

This looks like a change of invariants that could generate a fair
amount of audit work. Ugh...


Cheers,
Bill
