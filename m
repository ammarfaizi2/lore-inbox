Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263801AbTIHXtZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 19:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbTIHXtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 19:49:25 -0400
Received: from bm-2a.paradise.net.nz ([202.0.58.21]:27280 "EHLO
	linda-2.paradise.net.nz") by vger.kernel.org with ESMTP
	id S263801AbTIHXtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 19:49:20 -0400
Date: Tue, 09 Sep 2003 11:49:17 +1200 (NZST)
From: Richard Procter <rnp@paradise.net.nz>
Subject: Re: [PATCH] Fix SMP support on 3c527 net driver, take 2
In-reply-to: <3F5CDF74.7010406@terra.com.br>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.21.0309091029230.252-100000@ps2.local>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Sep 2003, Felipe W Damasio wrote:

> 	Richard, did you test the driver with this last patch?

Hey Felipe, 

I've had a good look over your revised patch, and it looks fine to me. I
didn't manage to get an MCA kernel booting to test it, but I'm not sure if
it would have added a lot, especially as I don't have an SMP MCA machine.

That said, over the weekend I realised that the need to unroll wait_event
was a consequence of using the same queue to perform two quite distinct
functions: serialising the issuing of commands, and waiting for the card
to complete command execution. This forces us to use a private variable to
indicate which situation has occured. That's ok on UP, but requires us to
jump through hoops to use it safely on SMP with spinlocks. 

I've rewritten things using completions (== semaphores?), and it's both
cleaner and (unexpectedly) smaller (see example below). I'm in the process
of convincing myself it all works; should have something out there by the
end of the week.

If there's a merge deadline coming up, please feel free to submit the
patch, otherwise I'd like to hold off for a couple of days and see where
we stand then.

best, 
Richard. 

Object size of the function below: 
  -- original sti/cli driver: 238 bytes. 
  -- with spinlocks + inlined wait_event unrolling: 1833 bytes (770% of original)
  -- using completions: 190 bytes (80% of original, but with
     three completions structs per card instead of a lock + wait_queue_head)

static int mc32_command(struct net_device *dev, u16 cmd, void *data, int len)
{
	struct mc32_local *lp = (struct mc32_local *)dev->priv;
	int ioaddr = dev->base_addr;
	int ret = 0;
	
	/* (Initially complete) */ 

	wait_for_completion(&lp->current_command); 
	
	/*
	 *     My Turn 
	 */

	lp->exec_nonblocking=0; 
	lp->exec_box->mbox=0;
	lp->exec_box->mbox=cmd;
	memcpy((void *)lp->exec_box->data, data, len);
	barrier();	/* the memcpy forgot the volatile so be sure */

	while(!(inb(ioaddr+HOST_STATUS)&HOST_STATUS_CRR));
	outb(1<<6, ioaddr+HOST_CMD);		

	wait_for_completion(&lp->execution); 
	
	if(lp->exec_box->mbox&(1<<13))
	  ret = -1;

	/* ** on SMP, we could starve the mc_reload wait as 
	 * other threads waiting for completion could block the reload.
	 * a problem? solutions? 
	 */ 

	complete(&lp->current_command); 
	
	/*
	 *	A multicast set got blocked - try it now
	 */
		
	if(lp->mc_reload_wait)
	{
		mc32_reset_multicast_list(dev);
	}

	return ret;
}




