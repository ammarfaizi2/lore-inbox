Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSIDRvh>; Wed, 4 Sep 2002 13:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSIDRvh>; Wed, 4 Sep 2002 13:51:37 -0400
Received: from zmamail05.zma.compaq.com ([161.114.64.105]:14600 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S313070AbSIDRv2> convert rfc822-to-8bit; Wed, 4 Sep 2002 13:51:28 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Problem on a kernel driver(SuSE, SMP)
Date: Wed, 4 Sep 2002 10:56:00 -0700
Message-ID: <8C18139EDEBC274AAD8F2671105F0E8E012704D7@cacexc02.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem on a kernel driver(SuSE, SMP)
Thread-Index: AcJUOiss3lYJ4C0XQ/KNhPBZX0Qo3gAAb2Uw
From: "Libershteyn, Vladimir" <vladimir.libershteyn@hp.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Sep 2002 17:56:00.0793 (UTC) FILETIME=[543E3890:01C2543C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Cristoph
Attached are two related functions,
I don't know if I can attach the files to the message,
but I can place them in a message body.
Please, let me know

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
