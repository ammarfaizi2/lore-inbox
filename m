Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSILIbM>; Thu, 12 Sep 2002 04:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSILIbM>; Thu, 12 Sep 2002 04:31:12 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:38638
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313898AbSILIbL>; Thu, 12 Sep 2002 04:31:11 -0400
Subject: Re: spinlocks and polling
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Soos Peter <sp@osb.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209120926230.3311-100000@sppc.intranet.osb.hu>
References: <Pine.LNX.4.44.0209120926230.3311-100000@sppc.intranet.osb.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 12 Sep 2002 09:36:38 +0100
Message-Id: <1031819798.2902.59.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-12 at 08:54, Soos Peter wrote:
> It is working but through spinlocks the interrupt sensible drives doesn't 
> works (e.g. ppp interface have 5-80% of packet loss) when the OMNIBOOK_POLL
> value is in the usable range. This is too high price for the volume 
> control buttons.
> 
> Does anybody idea to solve this problem?

If its very slow hardware then that might explain your problem. You
would be sitting with interrupts off for a very long time. What really
makes the difference to how you handle it is - if the irq is shared, and
how easy it is to block.

If it is not shared, or can be blocked fast then you end up with code
that basically says

	irq_handler
		block irq
		set work_to_do
		kick off a tasklet
	return

and take care in the tasklet to avoid blocking IRQ's during the actual
reads from the chip. You might do something like


	if(!test_and_set_bit(0, &chip_do_read))
	{
		add_read_to_queue();
		reenable_int
	}
	else
		set_bit(1, &chip_do_read);

and elsewhere where you touch that data or might lock against it do

	set_bit(0, &chip_do_read);
	/* Above maybe code that waits politely for that.. */
	blah
	blah
	/* Now clean up */
	if(test_bit(1, &chip_do_read))  /* Poll deferred */
	{
		clear_bit(1, &chip_do_read);
		add_read_to_queue();
		clear_bit(0, &chip_do_read);
		reeanable_int
	}
	else
		clear_bit(0, &chip_do_read);

or use xchg, or atomic_t counters



