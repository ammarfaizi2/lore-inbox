Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291258AbSCMALh>; Tue, 12 Mar 2002 19:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291279AbSCMAL2>; Tue, 12 Mar 2002 19:11:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5642 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291272AbSCMALS>;
	Tue, 12 Mar 2002 19:11:18 -0500
Message-ID: <3C8E98B2.159FA546@zip.com.au>
Date: Tue, 12 Mar 2002 16:09:22 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: wli@holomorphy.com
CC: Andrea Arcangeli <andrea@suse.de>, wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
In-Reply-To: <20020312041958.C687@holomorphy.com> <20020312070645.X10413@dualathlon.random> <20020312112900.A14628@holomorphy.com> <20020312135605.P25226@dualathlon.random> <20020312141439.C14628@holomorphy.com> <20020312160430.W25226@dualathlon.random>,
		<20020312160430.W25226@dualathlon.random>; from andrea@suse.de on Tue, Mar 12, 2002 at 04:04:30PM +0100 <20020312233117.E14628@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wli@holomorphy.com wrote:
> 
> Also, these changes to the hashing scheme were not separated out
> from the rest of the VM patch, so the usual "break this up
> into a separate patch please" applies.

FYI, I am doing that at present.  It look like Andrea's 10_vm-30
patch will end up as twenty or thirty separate patches.  I won't
be testing every darn patch individually - I'll batch them up into
maybe four groups for testing and merging.

Andrea introduced some subtly changed buffer locking rules, and
this causes ext3 to deadlock under heavy load.  Until we sort
this out, I'm afraid that the -aa VM is not suitable for production
use with ext3.

ext2 is OK and I *assume* it's OK with reiserfs.  The problem occurs
when a filesystem performs:

	lock_buffer(dirty_bh);
	allocate_something(GFP_NOFS);

without having locked the buffer's page.  sync_page_buffers()
can perform a wait_on_buffer() against dirty_bh.  (I think.
I'm not quite up-to-speed with the new buffer state bits yet).


-
