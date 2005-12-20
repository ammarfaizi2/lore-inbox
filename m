Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbVLTMa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbVLTMa3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 07:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbVLTMa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 07:30:29 -0500
Received: from [147.27.14.5] ([147.27.14.5]:9186 "HELO softnet.tuc.gr")
	by vger.kernel.org with SMTP id S1750974AbVLTMa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 07:30:28 -0500
Message-ID: <33642.147.27.7.175.1135081821.squirrel@147.27.7.175>
Date: Tue, 20 Dec 2005 14:30:21 +0200 (EET)
Subject: Re: selfmade serial driver problem with chipset other than VIA
From: gxatzipavlis@softnet.tuc.gr
To: linux-os@analogic.com
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3-RC1
X-Mailer: SquirrelMail/1.4.3-RC1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os@analogic.com wrote:
> The 8250 and clones generate an interrupt when the TX buffer becomes
> empty as well as when the RX buffer contains data. Becoming empty
> implies that it must have had something in it. Therefore, you need
> to put the first byte from a buffer into the TX buffer without
> using interrupts after which your ISR will be able to take over.
>
> A de facto standard way of doing this is to make a tx_send() routine
> that can be called from both from the ISR and from the driver
> write() routine. After user-mode data are written to a buffer,
> the driver write() routine executes tx_send(). This will start
> the ball rolling. The tx_send() code is written to handle the
> buffer pointer(s) and to do nothing if there are no more data
> available.

i have such a routine called writer_bottomhalf. Is my bh function.

DECLARE_TASKLET(writer_tasklet,writer_bottomhalf,(unsigned
long)&status);

in write() function:

static ssize_t eib_write(struct file *file, const char *buf, size_t
count, loff_t *offset){

	//adding header, checksum and ending character to the user data

	tasklet_schedule(&writer_bottomhalf);
	return bytes_read_from_user_space;
}


in writer_bottomhalf() function:

static void writer_bottomhalf(unsigned long data){

	if(bytes_send==writer_length){

	    //init timer to check for acks

	}
	else{

	    outb(writer[bytes_send], eib_io+UART_TX); //eib_io=0x03f8
	    printk(KERN_INFO"sending %x\n",writer[bytes_send]);

       }
}

in ISR function:

static void interrupt_handler(int irq, void *dev_id, struct pt_regs
*regs){

	//do stuff for other interrupts

	if ( inb(  eib_io + UART_LSR ) & ( UART_LSR_THRE) ){

		bytes_send++;
		tasklet_schedule(&writer_bottomhalf);

	}
}

so i call my bh function from my write() and from my ISR routines.
is their any difference if this routine is a bh or a plain routine as
long as they execute the same code?

paulkf@microgate.com wrote:
> If the Line Control Register (LCR) Divisor Latch Access Bit (DLAB)
> is set, then offsets 0 and 1 access the divisor latch instead
> of the transmit holding register (THR) and interrupt enable register >
> (IER).
>
> You do not state if you initialize that bit to zero.
> If that bit is set, that could prevent the THR empty
> interrupt you expect.

in the init_module function i do:

outb( UART_LCR_DLAB | UART_LCR_WLEN8 | UART_LCR_PARITY | UART_LCR_EPAR ,
eib_io + UART_LCR );      //dlab =1  serial init for 8E1


outb(0X06,eib_io+UART_DLL);  //speed set to 19200
outb(0X00,eib_io+UART_DLM);

outb(inb( eib_io + UART_LCR ) & ~UART_LCR_DLAB,eib_io+UART_LCR);	//unset
dlab

outb( UART_IER_RLSI | UART_IER_RDI | UART_IER_THRI , eib_io
+UART_IER);     //enabling interrupts

i am an unexperienced programmer and my code is awful and buggy but i
can't understand why is working only in my computer and not to any other
x86 machine...? that's why i suspect the chipset manufacturer (maybe the
have the serial address port in another address and not in 0x03f8 or
smth like this)


