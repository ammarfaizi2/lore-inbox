Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269019AbTGJHDh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 03:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269025AbTGJHDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 03:03:37 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:24075 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S269019AbTGJHDQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 03:03:16 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.5.74-mm3 yenta-socket oops back
Date: Thu, 10 Jul 2003 15:09:03 +0800
User-Agent: KMail/1.5.2
Cc: rmk@arm.linux.org.uk, daniel.ritz@gmx.ch, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org
References: <200307060039.34263.daniel.ritz@gmx.ch> <200307101127.32590.mflt1@micrologica.com.hk> <20030709213010.1882a898.akpm@osdl.org>
In-Reply-To: <20030709213010.1882a898.akpm@osdl.org>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307101448.58180.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 July 2003 12:30, Andrew Morton wrote:
> Michael Frank <mflt1@micrologica.com.hk> wrote:
> > 2.5.74-mm3 yenta-socket oopsed on the first boot at the same spot.
> >
> > I have successfully used both patches below with -mm1.
> >
> > --- 1.50/drivers/pcmcia/cs.c    Mon Jun 30 22:22:30 2003
> > +++ edited/cs.c Sat Jul  5 23:58:07 2003
> > @@ -338,13 +338,13 @@
> >         socket->erase_busy.next = socket->erase_busy.prev =
> > &socket->erase_busy; INIT_LIST_HEAD(&socket->cis_cache);
> >         spin_lock_init(&socket->lock);
> > -
> > -       init_socket(socket);
> > -
> >         init_completion(&socket->thread_done);
> >         init_waitqueue_head(&socket->thread_wait);
> >         init_MUTEX(&socket->skt_sem);
> >         spin_lock_init(&socket->thread_lock);
> > +
> > +       init_socket(socket);
> > +
> >         ret = kernel_thread(pccardd, socket, CLONE_KERNEL);
> >         if (ret < 0)
> >                 return ret;
>
> This one is clearly correct.
>
> > and my patch (may apply with some offset, which I'm about to check
> > into bk anyway):
> >
> > --- linux/drivers/pcmcia/cs.c.old       Fri Jul  4 10:21:50 2003
> > +++ linux/drivers/pcmcia/cs.c   Sun Jul  6 23:04:10 2003
> > @@ -870,11 +870,13 @@
> >
> >  void pcmcia_parse_events(struct pcmcia_socket *s, u_int events)
> >  {
> > -       spin_lock(&s->thread_lock);
> > -       s->thread_events |= events;
> > -       spin_unlock(&s->thread_lock);
> > +       if (s->thread) {
> > +               spin_lock(&s->thread_lock);
> > +               s->thread_events |= events;
> > +               spin_unlock(&s->thread_lock);
> >
> > -       wake_up(&s->thread_wait);
> > +               wake_up(&s->thread_wait);
> > +       }
> >  } /* pcmcia_parse_events */
>
> This one may not be.  How did we get here with no thread to handle the
> event?  Do you have an oops trace on this one?
>

Is called from interrupt handler. Seems that events occur before the 
thread is created.

No serial port, Oops taken from screen 
unable to handle null pointer dereference at 0
oops: 0000 #1
EFLAGS 00010086
EIP is at __wake_up_common+0x13
eax ce09c9c0 ebx 286 ecx 1 edx 0
esi 1 edi 0 ebp ccc67dcc esp ccc67dc0
ds 7b es 7b ss 68
Process modprobe pid 1153 threadinfo ccc66000 task cd68e080
Stack: 286 4000001 0 ccc67de8 c011afa1 ce09c9c0 3 1 
       0 ce09c800 ccc67df0 cf8a3ecf cccc67e04 cf87a7ea ce09c830 80
       cdffec00 ccc67e24 c010d0aa 5 ce09c800 ccc67e50 280 5
Call trace:
__wake_up+0x11
pcmcia_parse_events+0x23
yenta_interrupt+0x26
handle_IRQ_event+0x2a
do_IRQ+0x82
common_interrupt+0x18
setup_irq+0x9b
yenta_interrupt+0x0
request_irq+0x89
yenta_probe+0x137
yenta_interrupt+0x0
pci_device_probe_static+0x20
pci_device_probe+0x21
bus_match+0x38
driver_attach+0x3e
bus_add_driver+0x6e
driver_register+0x36
pci_register_driver+0x6a
yenta_socket_init+0xd
sys_init_module+0xe0
syscall_call+0x7
Code: 8b 3a 8b 45 08 83 c0 04 39 c2 74 23 8b 5a f4 8b 4d 14 51 8b
 <0> Fatal exception in interrupt
In interrupt handler - not syncing


> Or just stick a
>
> 	if (!s->thread)
> 		dump_stack();
>
> in there as well.

Applied rmk's patch and the above to -mm3 and send the stack trace once obtained.

Regards
Michael 


-- 
Powered by linux-2.5.74-mm3. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp for 2.4/2.5 and ACPI S3 of 2.5 kernel 
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt
More info on swsusp: http://sourceforge.net/projects/swsusp/

