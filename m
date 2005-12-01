Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbVLASdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbVLASdo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 13:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVLASdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 13:33:43 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:19624 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932397AbVLASdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 13:33:43 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH 2.6-git] MTD/SPI dataflash driver
Date: Thu, 1 Dec 2005 10:33:41 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
References: <20051201191109.40f2d04b.vwool@ru.mvista.com> <20051201191837.222fe0b3.vwool@ru.mvista.com>
In-Reply-To: <20051201191837.222fe0b3.vwool@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512011033.41627.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 December 2005 8:18 am, Vitaly Wool wrote:
 
> It took about fifteen minutes of mindwork to port the MTD dataflash driver
> posted by David Brownell 11/23 to our SPI core from David's,

Interesting and informative; +1!

Did you have a chance to test this?  There are some post-2.6.15-rc3-mm1
updates to this code, mostly to catch startup fauults better but also to
hotplug reasonably.  The glitches I saw may as easily be JFFS2 integration
issues for the DataFlash code as bitbang adapter problems.  (I think you
started more or less from what's in rc3-mm1.)


> reducing both 
> the size of the source code and the footprint of the object code.
> I'd also like to mention that now it looks significatnly easier to understand
> due to no more use of complicated SPI message structures. The number of variables
> used was also decreased

I think that's all the same issue.  Other than "spi_driver" replacing
"device_driver" (I'd like to see a patch doing that to rc3-mm1), the
main changes seem to be:

  - Move from original atomic requests like this

	{ write command, read response }

    over to two separate requests

	{ write command, and leave CS active }
	{ read response, and leave CS off }

 - Lower the per-request performance ceiling on this driver

      * original code could be implemented in a single DMA chain on
        at least two systems I happen to have handy ... one IRQ.

      * this version requires two separate chains, with an intervening
        task schedule.  (More than twice the cost.)

      * in your framework I still can't be _sure_ it never does memcpy
        for those buffers (the last version I looked at did so).  the
        original code just used normal DMA models, so it "obviously"
        doesn't risk memcpy.

 - Add fault handling problems ... probably an oversight, you call
   routines and don't check for fault reports.  Though I'm not clear
   how the faults between the two requests would be handled (in your
   framework) with any robustness... doing this right could easily
   cost all the codespace you've conserved.

 - I might agree with this being "easier to understand" code, though
   it's debatable.  (The device sees one transaction, why should the
   driver writer have to split it up into two?)  But that doesn't
   matter much:  filesystems are better with "faster to run" code.

 - Chipselect works differently in your code.  You're giving one
   driver control over all the devices sharing a controller, by
   blocking requests going to other devices until your driver yields
   the chipselect.  This seems like a bad idea even if you ignore
   how it produces priority inversions in your framework.  :)

So the way I see it, this is a good example of why my original I/O model
is better.  It provides _flexibility_ in the API so that some drivers
can be really smart, if they want to.  You haven't liked the consequence
of that though:  controller drivers being able to choose how they
represent and manage I/O queues, rather than doing that in your "core".

- Dave



