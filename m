Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261336AbSIWUdl>; Mon, 23 Sep 2002 16:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261361AbSIWUdl>; Mon, 23 Sep 2002 16:33:41 -0400
Received: from dsl-213-023-022-250.arcor-ip.net ([213.23.22.250]:22710 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261336AbSIWUdi>;
	Mon, 23 Sep 2002 16:33:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Dave Olien <dmo@osdl.org>, axboe@suse.de
Subject: Re: DAC960 in 2.5.38, with new changes
Date: Mon, 23 Sep 2002 22:39:00 +0200
X-Mailer: KMail [version 1.3.2]
Cc: _deepfire@mail.ru, linux-kernel@vger.kernel.org
References: <20020923120400.A15452@acpi.pdx.osdl.net>
In-Reply-To: <20020923120400.A15452@acpi.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17tZyv-0003be-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 September 2002 21:04, Dave Olien wrote:
> Daniel, Jens
> 
> Thanks for the feedback.  Daniel, I've incorporated your patch into my
> driver changes, and moved to linux 2.5.38.
> 
> Included are changes to put the memory mailbox and completion status
> mailboxes into dma mapped pages...

Applied, booted, up and running.  I'll attempt to follow your work -
you are clearly way out in front of everybody in understanding this
driver.

Minor whitespace suggestion: don't worry too much about breaking up
lines to fit in 80 columns.  It's nice where it works, but where it
just makes more lines, don't bother.  We are going to go do spelling
patches to shorten a lot of those names anyway.

What test do you use to determine that some blocks are incorrectly
written?

> I made a decision to remove some behavior from the functions:
> 
> 	DAC960_V1_EnableMemoryMailboxInterface
> 	DAC960_FinalizeController
> 
> Following is a description of the behavior I have removed.
> 
> In the original code, for the  "LA" and "PG" controller types,
> the FinalizeController() function does NOT free the memory for the
> mailboxes for these controllers.  Instead, the Finalize function calls
> 
> 	DAC960_LA_SaveMemoryMailboxInfo
> 		or
> 	DAC960_PG_SaveMemoryMailboxInfo
> 
> to instruct the controller to remember its memory mailbox addresses.
> 
> The driver EnableMemoryMailboxInterface() function calls 
> 
> 	"DAC960_LA_RestoreMemoryMailboxInfo"
> 		or
> 	"DAC960_PG_RestoreMemoryMailboxInfo"
> 
> functions to retrieve the controller's stored memory mailbox pointers.
> 
> This behavior is "useful" only when the driver is unloaded, and then
> reloaded.  
> 
> I changed to code to just free the memory mailboxes during Finalize,
> and reallocate new ones when the driver is reloaded.
> I feel it is much better to release this resource when the driver
> isn't loaded.

I think you're right.  It's hard to imagine why it would be good to
optimize the module unload/reload case for DAC, and if there is a
correctness argument, I personally would rather find out about it the
hard way than never know it.

> In 2.5. the driver needs both DMA addresses (that would be the address
> stored in the controller), and the CPU address.  To preserve the old
> behavior in 2.5, the driver would need to save these CPU addresses
> somewhere.  Strictly speaking, we shouldn't be translating between
> the two address types.

Yes, it seems a waste of effort.

> I don't have specifications for these devices.
> I don't know if there is some real reason for the old behavior.
>
> I don't have either of these controller types available to test this change
> either.  So, if you can think of any reason I should preserve the original
> behavior, I'd appreciate the feedback.

Hopefully somebody with one of those will jump into the thread.  Where
in the mass of DAC init output do we look for the controller type?

-- 
Daniel
