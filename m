Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314422AbSEUMmM>; Tue, 21 May 2002 08:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314442AbSEUMmL>; Tue, 21 May 2002 08:42:11 -0400
Received: from phoenix2.stts.com.sg ([202.95.121.178]:16659 "EHLO
	phoenix2.stts.com.sg") by vger.kernel.org with ESMTP
	id <S314422AbSEUMmK>; Tue, 21 May 2002 08:42:10 -0400
Message-ID: <4CE80268E133D6118A8800A0C9F4933A2649B7@VOYAGER_1>
From: Fung Chai <fungchai@stts.com.sg>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Asynchronous notification from device driver to more than one pro
	cess.
Date: Tue, 21 May 2002 20:43:00 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to implement asynchronous notification in a device driver.
I have 2 questions.

First question: where do I call kill_fasync()?

The driver, /usr/src/linux-2.4.7-10/drivers/acorn/char/mouse_ps2.c, calls
kill_fasync() within its psaux_interrupt(), which is the interrupt handler
registered via request_irq().

If I understand the concepts correctly, an interrupt handler runs at
interrupt
time and doesn't execute in the context of a process.  Therefore, when
psaux_interrupt() calls kill_fasync(), the process which is supposed to
receive a SIGIO may not be running.  Is this still OK (that is, to call
kill_fasync() within the interrupt handler)?  Will the kernel hang or crash?
Will the process receive the SIGIO?

Second question: can I send SIGIO to more than one process?

The hardware that I am working on can receive 3 types of interrupts.  My
interrupt handler can determine which type is received.  I would like to
provide some sort of ioctl mechanism to allow a process to specify that it
wishes to receive a SIGIO for a particular type.  This way, 2 or more
processes can open the same hardware unit and register an interest in a
certain type.  For example, process A could register for types 1 and 3 while
process B could register for type 2.  Or process A only ask for type 1 while
process B is only interested in type 2; no asynchronous notification will be
raised for type 3.

I am thinking of writing my interrupt handler as follows:

void
interrupt_handler (int irq, void* dev_id, struct pt_regs* regs)
{
        struct myDev* dev = dev_id;
        ....
        switch (type) {
        default:
                blah();
                break;
        case 1:
                if (dev->type1_fown)
                        send_sigio (dev->type1_fown, fd, band);
                break;
        case 2:
                if (dev->type2_fown)
                        send_sigio (dev->type2_fown, fd, band);
                break;
        case 3:
                if (dev->type3_fown)
                        send_sigio (dev->type3_fown, fd, band);
                break;
        }
        ...
}

The type?_fown will initially be set to NULL; each device has its own set of
these 3 pointers.  A process can use an ioctl() call, which will set the
appropriate type?_fown to contain the process's pid, etc.  The ioctl() will
return an error if another process has already registered for the same type
on the same hardware unit.

Am I doing this correctly?  It seems to me that F_SETOWN allows only one
process to be filp->f_owner.  I hope send_sigio() will remain stable.

Please reply to me directly (mailto:fungchai@stts.com.sg) as I am not
subscribed to the mailing list.

Thanks in advance.

Best regards,
Fung-Chai LIM
ST Training & Simulation Pte Ltd
24 Ang Mo Kio Street 65
Singapore 569061
Telephone: (65) 6413-1368
mailto:fungchai@stts.com.sg
