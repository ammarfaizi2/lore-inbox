Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSIDRtb>; Wed, 4 Sep 2002 13:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSIDRtb>; Wed, 4 Sep 2002 13:49:31 -0400
Received: from zmamail03.zma.compaq.com ([161.114.64.103]:31250 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S313060AbSIDRtY> convert rfc822-to-8bit; Wed, 4 Sep 2002 13:49:24 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Problem on a kernel driver(SuSE, SMP)
Date: Wed, 4 Sep 2002 10:53:56 -0700
Message-ID: <8C18139EDEBC274AAD8F2671105F0E8E121766@cacexc02.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem on a kernel driver(SuSE, SMP)
Thread-Index: AcJUOH7nIQq5eq6fTCO8wKjLYhUhkgAAMTdQ
From: "Libershteyn, Vladimir" <vladimir.libershteyn@hp.com>
To: <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Sep 2002 17:53:57.0174 (UTC) FILETIME=[0A8F7560:01C2543C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> You are not too specific, which makes it hard to understand what may
> be going wrong so I'll assume that you probably did a bad thing.

I think I gave all the specific information

> 
> (1)  You cannot sleep in an interrupt, which means you can't use
> down_*() and friends inside an ISR.

I DO NOT sleep in ISR, the up*() routine is inside the ISR, dut not down*()
This is a standard use of the mechanism

> 
> (2)  Wait queues should work fine from the 'user-side' of a driver,
> but again, you cannot ever sleep in an interrupt service routine.
> Look in ../linux/drivers/* for examples of code that works.
> 

Again there is NO sleep in ISR, and I know that queues should work fine, 
but they don't, that why I have a problem, but problem only on
SMP machine.

> (3)  You can't use any wait-queue or sleep on a semaphore while
> holding a spin-lock or while the interrupts are disabled. You can
> manage your own lock against re-entry in your procedure, but you
> can't allow two tasks to try the same semaphore at (nearly) the
> same time or you can dead-lock.

I DO NOT hold any spinlocks, while use down_interruptible

> 
> 
> (4)	The fact that 'down' hangs means that there is nothing
> that the CPU can do. This is direct evidence that you have the
> interrupts disabled when down executes.

To be more specific, here is a code:
----------------------------------------------------
function when thread go to sleep, if data not ready 
---------------------------------------------------
/
// Get the response back
//
static int axl_get_response(axl_interconnect *buf, int device)
{
    int enumerator, len;
	unsigned long flags;
	axl_info_t *a;
	
#ifdef AXL300_DEBUG
    printk("<1> get_response\n");
#endif
	
	a = axl[device];

	//
	// sanity check
	//
	if (!buf || !buf->CommBuffer ||
	    (buf->Enumerator >= MAX_LOGICAL_DEV) || (buf->Enumerator < 0) ||
	    (buf->DataContext1 != a->ld_unique[buf->Enumerator]))
	{
	    return -EINVAL;
	}

	//
	// extract input data
	//
	enumerator = buf->Enumerator % MAX_LOGICAL_DEV;
 
	//
	// sleep until data is ready
	//
	down_interruptible(&a->sem[enumerator]);
	

	//
	// data is here
	//
	spin_lock_irqsave(&a->lock, flags);
	
    len = axl_copy_buffer(buf->Enumerator, buf->CommBuffer, device);

	spin_unlock_irqrestore(&a->lock, flags);

    //
    // return length in bytes 
    //
    buf->Length = len;
		
	//
	// raise data ready flag
	//
	a->data_ready[enumerator] = 1;


#ifdef AXL300_DEBUG
  	printk("<1> get_response_exit\n");
#endif

	return 0;
}

----------------------------------------------------
function when thread wakes up 
---------------------------------------------------
//
// Interrupt Service Routine.  
//
static void axl_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
	axl_info_t *a = dev_id;
	int istat;
	unsigned long flags;
	volatile unsigned long *board_address;
	__u32 length, enumerator;

#ifdef AXL300_DEBUG
	printk("<1> axl_interrupt enter.\n");
	printk("<1> device - %x.\n", a->ctlr);
#endif

	//
	// check if it's Colusa interrupt
	//
	istat = atql5032_check_interrupt(a->ctlr);
	if (istat)
	{

#ifdef AXL300_DEBUG
	    printk("<1> INTS-31 has not been asserted.\n");	
#endif
	    goto axl_isr_exit;
	}

#ifdef AXL300_DEBUG
	printk("<1> interrupt received.\n");
	printk("<1> device - %x.\n", a->ctlr);
#endif

	//
	// Clear an int
	//
	atql5032_clear_interrupt(a->ctlr);

	//
	// create a board FIFO length count address
	//
	board_address = ((unsigned long *)((unsigned char *)a->vaddr + OutputQueueFilled));
	length = *board_address;
		
	if (length <= 4)
	{
	    number_reqs++;
#ifdef NEW_CODE_DEBUG
	    printk("<1> bad FIFO length: %x.\n", length);		
#endif
	    goto axl_isr_exit;
	}
	
	//
	// create a board FIFO address
	//
	board_address = ((unsigned long *)((unsigned char *)a->vaddr + OutputQueueData));

	//
	// read the length of the message from the card
	// do the sanity check, length should be > 2 ans < 256
	//	
	length = *board_address;
		
	if ((length <= 2) || ((length & 0x0fffffff) > MAXIMUM_COMMAND_LENGTH_WORDS))
	{
	
#ifdef NEW_CODE_DEBUG
	    printk("<1> bad length: %x.\n", (length & 0x0fffffff));		
#endif
	
	    goto axl_isr_exit;
	}

#ifdef AXL300_DEBUG
	printk("<1> got length: %x.\n", length);		
#endif
	
	//
	// read the enumerator from the message from the card
	// do the sanity check, enumerator should be < MAX_LOGICAL_DEV
	//	
	enumerator = *board_address;		
	if (enumerator > MAX_LOGICAL_DEV)
	{
	
#ifdef NEW_CODE_DEBUG
	    printk("<1> bad enumerator in ISR: %x.\n", enumerator);		
#endif
	
	    goto axl_isr_exit;
	}

#ifdef AXL300_DEBUG
	printk("<1> got enumerator in ISR: %x.\n", enumerator);		
#endif

	//
	// save data to be passed to application
	//
	a->length[enumerator] = length;

	//
	// Wake up the LD that interrupted us and setup "data ready" flag
	//
	up(&a->sem[enumerator]);

axl_isr_exit:
	//
	// Clear an int
	//
	atql5032_clear_interrupt(a->ctlr);
}
