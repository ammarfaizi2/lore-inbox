Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262218AbRETUQT>; Sun, 20 May 2001 16:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262219AbRETUQL>; Sun, 20 May 2001 16:16:11 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:21509 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262218AbRETUQE>; Sun, 20 May 2001 16:16:04 -0400
Message-ID: <3B082672.63D1F44E@gmx.net>
Date: Sun, 20 May 2001 22:17:54 +0200
From: Jens Haerer <jens.haerer@gmx.net>
Organization: STZ Softwaretechnik
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: waitqueue problem on 2.4.3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hy to all !

I am experiencing big problems using wait queues in a device driver
(module)
on kernel 2.4.3-20mdk (gcc version 2.96). 
I dont know if this is the right place to ask for - but its my last hope...
The device driver i write is for a measuring device connected to parallel
port-
so i'm using the parport and parport_pc modules with exclusice access to
the
parallel port. Communication with the device works perfectly with one
exception - i cant use waitqueues - it doesnt matter in which was i try it
(i noticed there were changes to waitqueues in 2.4 kernels)...

the first approach using waitqueues looks like this :


hshppm.c: (the driver)

/* ... */ 
static DECLARE_WAIT_QUEUE_HEAD( hshppm_isr_digital_wq );

/* ... */
static int device_open( struct inode *inode, struct file *file )
{
	/* ... */ 
	init_waitqueue_head(&hshppm_isr_digital_wq);
	/* ... */
}

/* ... */
static ssize_t device_read( struct file *file,
                            char *buffer,    
                            size_t length,  
			    loff_t *offset)
{ 
	/* ... */
	interruptible_sleep_on( &hshppm_isr_digital_wq );
	/* ... */
}

/* ... */
/* the ISR for the INTs on the parallel port */
/* called from parport_generic_irq() */
void hshppm_isr( int irq, void *handle, struct pt_regs *regs )
{
	/* ... */
	wake_up_interruptible( &hshppm_isr_digital_wq )
	/* ... */
}

When I run this code and execute the read() from userland it does a
segfault
when the module executes the interruptible_sleep_on() - a kernel oops is
recorded in the
log:
May 20 21:01:40 ofen kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000003d
May 20 21:01:40 ofen kernel:  printing eip:
May 20 21:01:40 ofen kernel: c0111c4b
May 20 21:01:40 ofen kernel: pgd entry cae50000: 0000000000000000
May 20 21:01:40 ofen kernel: pmd entry cae50000: 0000000000000000
May 20 21:01:40 ofen kernel: ... pmd not present!
May 20 21:01:40 ofen kernel: Oops: 0000
May 20 21:01:40 ofen kernel: CPU:    0
May 20 21:01:40 ofen kernel: EIP:    0010:[sleep_on+35/88]
May 20 21:01:40 ofen kernel: EIP:    0010:[<c0111c4b>]
May 20 21:01:40 ofen kernel: EFLAGS: 00210086
May 20 21:01:40 ofen kernel: eax: cb53e000   ebx: 00200286   ecx:
00200246   edx: 00000039
May 20 21:01:40 ofen kernel: esi: ce071720   edi: 0804b225   ebp:
cb53ff5c   esp: cb53ff48
May 20 21:01:40 ofen kernel: ds: 0018   es: 0018   ss: 0018
May 20 21:01:40 ofen kernel: Process dev_test1 (pid: 1842,
stackpage=cb53f000)
May 20 21:01:40 ofen kernel: Stack: ffffffea 00000000 cb53e000 cb53e000
c0111554 cb53ff9c e8be7232 e8becaf8 
May 20 21:01:40 ofen kernel:        e8beb383 e8becadc d6fd4000 d5e75960
40016000 0000001a ffffffea d5e75960 
May 20 21:01:40 ofen kernel:        0000001a bfffeee8 ffffffea ce071720
00000001 bffff698 c012dca6 ce071720 
May 20 21:01:40 ofen kernel: Call Trace: [process_timeout+0/72]
[<e8be7232>] [<e8becaf8>] [<e8beb383>] [<e8becadc>] [sys_read+142/196]
[system_call+51/64] 
May 20 21:01:40 ofen kernel: Call Trace: [<c0111554>] [<e8be7232>]
[<e8becaf8>] [<e8beb383>] [<e8becadc>] [<c012dca6>] [<c0106f23>] 
May 20 21:01:40 ofen kernel: 
May 20 21:01:40 ofen kernel: Code: 8b 42 04 8d 4d f8 89 48 04 8d 4a 04 89
4d fc 89 45 f8 8d 4d 

i did the init_waitqueue_head() in device_open() when the device is openend
from userland - so this
should not happen...
i tested the above also with the init_waitqueue_head() omitted in
device_open() - cause the
kernel api changes documented in
http://www.atnf.csiro.au/~rgooch/linux/docs/porting-to-2.4.html
say i doesnt need it.

The second approach i tested look like this:

hshppm.c: (the driver)

/* ... */ 
static DECLARE_WAIT_QUEUE_HEAD( hshppm_isr_digital_wq );

/* ... */
static int device_open( struct inode *inode, struct file *file )
{
	/* ... */ 
	init_waitqueue_head(&hshppm_isr_digital_wq);
	/* ... */
}

/* ... */
static ssize_t device_read( struct file *file,
                            char *buffer,    
                            size_t length,  
			    loff_t *offset)
{ 
	/* ... */
	unsigned long flags;
	DECLARE_WAITQUEUE (wait, current);

	wq_write_lock_irqsave(&(hshppm_isr_digital_wq.lock), flags);
	wait.flags = 0;
	__add_wait_queue(&hshppm_isr_digital_wq, &wait);
	wq_write_unlock_irqrestore(&(hshppm_isr_digital_wq.lock), flags);

    	current->state = TASK_INTERRUPTIBLE;
        schedule();
	current->state = TASK_RUNNING;
	    
	wq_write_lock_irqsave(&(hshppm_isr_digital_wq.lock), flags);
	__remove_wait_queue(&hshppm_isr_digital_wq, &wait);
	wq_write_unlock_irqrestore(&(hshppm_isr_digital_wq.lock), flags);
	/* ... */
}

/* ... */
/* the ISR for the INTs on the parallel port */
/* called from parport_generic_irq() */
void hshppm_isr( int irq, void *handle, struct pt_regs *regs )
{
	/* ... */
	wake_up_interruptible( &hshppm_isr_digital_wq )
	/* ... */
}


Now wonder ! This time the code in device_read() executes - the process
calling
read() goes to sleep ...
But if an interrupt arrives in hshppm_isr() and the wake_up_interruptible()
is executed
the kernel freezes :(.

I also tested the old way of using waitqueues - just:
struct wait_queue *my_wait_queue;
wake_up_interruptible( &my_wait_queue );
interruptible_sleep_on( &my_wait_queue );

This gave me the same segfault as of my first approach at execution of
interruptible_sleep_on() ...

What am i doing wrong ? I have absolutly no idea why other modules
also containg waitqueue access are running without problems on my system
and the module i compiled is permanently crashing the kernel...
other modules running:
NVdriver              630032  12  (autoclean)
emu10k1                44384   0 
soundcore               3504   4  [emu10k1]
nfs                    73632   5  (autoclean)
lockd                  48720   1  (autoclean) [nfs]
sunrpc                 59232   1  (autoclean) [nfs lockd]
af_packet              11280   1  (autoclean)
8139too                11696   1  (autoclean)
keybdev                 1632   0  (unused)
usbkbd                  2912   0  (unused)
input                   3232   0  [keybdev usbkbd]
usb-uhci               20672   0  (unused)
usbcore                47248   1  [usbkbd usb-uhci]
ide-scsi                7568   0 
supermount             32496   6  (autoclean)
reiserfs              165760   3 
sd_mod                 11048   0  (unused)
scsi_mod               86036   2  [ide-scsi sd_mod]


I would be very glad if someone can tell me what i do wrong...


--
Jens Haerer
jens.haerer@gmx.net
