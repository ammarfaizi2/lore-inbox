Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266600AbTGFDPK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 23:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266601AbTGFDPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 23:15:10 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:23562 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S266600AbTGFDO7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 23:14:59 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Daniel Ritz <daniel.ritz@gmx.ch>, Dominik Brodowski <linux@brodo.de>
Subject: Re: yenta-socket oops with 2.5.73-mm3, 2.5.74, 2.5.74-mm1
Date: Sun, 6 Jul 2003 11:26:34 +0800
User-Agent: KMail/1.5.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-pcmcia" <linux-pcmcia@lists.infradead.org>
References: <200307060039.34263.daniel.ritz@gmx.ch>
In-Reply-To: <200307060039.34263.daniel.ritz@gmx.ch>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307061126.34635.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel and Dominik,

Now I got two patches to try, thank you.

I got the patch below (not yet tested) from Dominik. 

I will test this further on Monday. 

Regards
Michael

diff -ruN linux-original/drivers/pcmcia/cs.c linux/drivers/pcmcia/cs.c
--- linux-original/drivers/pcmcia/cs.c  2003-07-05 10:22:58.000000000 +0200
+++ linux/drivers/pcmcia/cs.c   2003-07-05 10:28:56.000000000 +0200
@@ -351,6 +351,10 @@
 
        wait_for_completion(&socket->thread_done);
        BUG_ON(!socket->thread);
+
+       /* ok, allow interrupts to be parsed */
+       socket->init_done = 1;
+
        pcmcia_parse_events(socket, SS_DETECT);
 
        return 0;
@@ -361,6 +365,8 @@
        struct pcmcia_socket *socket = class_get_devdata(class_dev);
        client_t *client;
 
+       socket->init_done = 0;  /* block interrupts */
+
        if (socket->thread) {
                init_completion(&socket->thread_done);
                socket->thread = NULL;
@@ -870,6 +876,9 @@
 
 void pcmcia_parse_events(struct pcmcia_socket *s, u_int events)
 {
+       if (unlikely(&s->init_done == 0))
+               return;
+
        spin_lock(&s->thread_lock);
        s->thread_events |= events;
        spin_unlock(&s->thread_lock);
diff -ruN linux-original/include/pcmcia/ss.h linux/include/pcmcia/ss.h
--- linux-original/include/pcmcia/ss.h  2003-07-05 10:23:00.000000000 +0200
+++ linux/include/pcmcia/ss.h   2003-07-05 10:24:22.000000000 +0200
@@ -215,6 +215,7 @@
        wait_queue_head_t               thread_wait;
        spinlock_t                      thread_lock;    /* protects thread_events */
        unsigned int                    thread_events;
+       unsigned short                  init_done;      /* interrupts are parsed only if this is != 0 */
 
        /* pcmcia (16-bit) */
        struct pcmcia_bus_socket        *pcmcia;


On Sunday 06 July 2003 06:39, Daniel Ritz wrote:
> hello
>
> problem is that an interrupt arrives before socket->thread_wait is
> initialized so we crash in __wake_up_common. i think source of the
> interrupt is socket_init called before the initialization. but an interrupt
> can still arrive before...
>
> i think the whole init stuff should happen even before we do request_irq().
> i tried moving around pcmcia_register_socket() but then my card doesn't
> come up... maybe we should add something like pcmcia_alloc_socket() which
> does kmalloc() a socket struct and does all the important init stuff?
> russel?
>
> michael, can you try this one?
>
> rgds
> -daniel
>
>
> --- 1.50/drivers/pcmcia/cs.c	Mon Jun 30 22:22:30 2003
> +++ edited/cs.c	Sat Jul  5 23:58:07 2003
> @@ -338,13 +338,13 @@
>  	socket->erase_busy.next = socket->erase_busy.prev = &socket->erase_busy;
>  	INIT_LIST_HEAD(&socket->cis_cache);
>  	spin_lock_init(&socket->lock);
> -
> -	init_socket(socket);
> -
>  	init_completion(&socket->thread_done);
>  	init_waitqueue_head(&socket->thread_wait);
>  	init_MUTEX(&socket->skt_sem);
>  	spin_lock_init(&socket->thread_lock);
> +
> +	init_socket(socket);
> +
>  	ret = kernel_thread(pccardd, socket, CLONE_KERNEL);
>  	if (ret < 0)
>  		return ret;
>
> On Friday 04 July 2003 09:10, Michael Frank wrote:
> > modprobe yenta-socket produces oops below _only_ after cold boot and
> > _only_ when e100 loaded. No PCMCIA problems with this system with 2.4 and
> > 2.5 until recent PCMCIA rework.
> >
> > Reproduced behavior with 2.5.73-mm3, 2.5.74, 2.5.74-mm1
> >
> > 2.5.73-mm2 no oops but hangs about 1 in 10 at
> >  PCI: Enabling device 0:12.0 (0->2) (PCMCIA). e100 was loaded but not
> > tested wo e100
> >
> > Conditions:
> >  Cold-boot - no oops when warm-boot+load after successful load or when
> > unload+load e100 loaded
> >
> > Oops appears 1 in 4 loads and looks similar every time
> >
> > Setup:
> > ACPI core enabled, no usb
> >
> > $ lsmod
> > pcmcia_core
> > toshiba_acpi
> > e100
> >
> > $ lspci
> > 00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 01)
> > 00:00.1 RAM memory: Transmeta Corporation SDRAM controller
> > 00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
> > 00:04.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev
> > 13) 00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI
> > AC-Link Controller Audio Device (rev 01) 00:07.0 ISA bridge: ALi
> > Corporation M1533 PCI to ISA Bridge [Aladdin IV] 00:0e.0 Ethernet
> > controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08) 00:10.0 IDE
> > interface: ALi Corporation M5229 IDE (rev c3)
> > 00:11.0 Bridge: ALi Corporation M7101 PMU
> > 00:12.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to
> > Cardbus Bridge with ZV Support (rev 32) 00:14.0 USB Controller: ALi
> > Corporation USB 1.1 Controller (rev 03)
> >
> > No serial port, Oops taken from screen
> > unable to handle null pointer dereference at 0
> > oops: 0000 #1
> > EFLAGS 00010086
> > EIP is at __wake_up_common+0x13
> > eax ce09c9c0 ebx 286 ecx 1 edx 0
> > esi 1 edi 0 ebp ccc67dcc esp ccc67dc0
> > ds 7b es 7b ss 68
> > Process modprobe pid 1153 threadinfo ccc66000 task cd68e080
> > Stack: 286 4000001 0 ccc67de8 c011afa1 ce09c9c0 3 1
> >        0 ce09c800 ccc67df0 cf8a3ecf cccc67e04 cf87a7ea ce09c830 80
> >        cdffec00 ccc67e24 c010d0aa 5 ce09c800 ccc67e50 280 5
> > Call trace:
> > __wake_up+0x11
> > pcmcia_parse_events+0x23
> > yenta_interrupt+0x26
> > handle_IRQ_event+0x2a
> > do_IRQ+0x82
> > common_interrupt+0x18
> > setup_irq+0x9b
> > yenta_interrupt+0x0
> > request_irq+0x89
> > yenta_probe+0x137
> > yenta_interrupt+0x0
> > pci_device_probe_static+0x20
> > pci_device_probe+0x21
> > bus_match+0x38
> > driver_attach+0x3e
> > bus_add_driver+0x6e
> > driver_register+0x36
> > pci_register_driver+0x6a
> > yenta_socket_init+0xd
> > sys_init_module+0xe0
> > syscall_call+0x7
> > Code: 8b 3a 8b 45 08 83 c0 04 39 c2 74 23 8b 5a f4 8b 4d 14 51 8b
> >  <0> Fatal exception in interrupt
> > In interrupt handler - not syncing
> >
> > It is now running allright by starting pcmcia ahead of network.

-- 
Powered by linux-2.5.74-mm1. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp and ACPI S3
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt

