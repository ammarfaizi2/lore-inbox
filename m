Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277358AbRJJSbz>; Wed, 10 Oct 2001 14:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277359AbRJJSbq>; Wed, 10 Oct 2001 14:31:46 -0400
Received: from quattro-eth.sventech.com ([205.252.89.20]:33299 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S277352AbRJJSbd>; Wed, 10 Oct 2001 14:31:33 -0400
Date: Wed, 10 Oct 2001 14:34:57 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB SMP race in 2.4.11
Message-ID: <20011010143457.D19707@sventech.com>
In-Reply-To: <20011010222223.A1223@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011010222223.A1223@linuxhacker.ru>; from green@linuxhacker.ru on Wed, Oct 10, 2001 at 10:22:23PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001, Oleg Drokin <green@linuxhacker.ru> wrote:
>    I have caught kernel oops that is related to SMP race on usb modules
>    deregistering.
>    2.4.10 was fine with the same setup.
>    USB core is compiled-in, hub driver is uhci (as module).
>    Here is the decoded oops:
> 
> Unable to handle kernel paging request at virtual address d890c138
> c018f709
> *pde = 01662067
> Oops: 0000
> CPU:    1
> EIP:    0010:[<c018f709>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010286
> eax: d890c12c   ebx: c1664800   ecx: c1661ef4   edx: d71cff60
> esi: 00000064   edi: c1661ef0   ebp: c1660000   esp: c1661ee0
> ds: 0018   es: 0018   ss: 0018
> Process khubd (pid: 10, stackpage=c1661000)
> Stack: d71cff60 c018f7fb d71cff60 c1661f00 00000001 c1661f08 c1661f08 00000000 
>        00000000 c1660000 c1661ef4 c1661ef4 c1664800 80000180 c160e720 c1661fbc 
>        c018f96f d71cff60 00000064 c1661f30 c1660000 c1661fbc c160e720 00000064 
> Call Trace: [<c018f7fb>] [<c018f96f>] [<c018fa04>] [<c0191dbc>] [<c0192b7b>] 
>    [<c0192d95>] [<c0105000>] [<c0105656>] [<c0192d50>] 
> Code: ff 50 0c 5a c3 89 f6 b8 ed ff ff ff c3 8d 76 00 8d bc 27 00 
> 
> >>EIP; c018f709 <usb_submit_urb+19/30>   <=====
> Trace; c018f7fb <usb_start_wait_urb+8b/1a0>
> Trace; c018f96f <usb_internal_control_msg+5f/70>
> Trace; c018fa04 <usb_control_msg+84/a0>
> Trace; c0191dbc <usb_get_port_status+3c/40>
> Trace; c0192b7b <usb_hub_events+eb/2c0>
> Trace; c0192d95 <usb_hub_thread+45/a0>
> Trace; c0105000 <_stext+0/0>
> Trace; c0105656 <kernel_thread+26/30>
> Trace; c0192d50 <usb_hub_thread+0/a0>
> Code;  c018f709 <usb_submit_urb+19/30>
> 00000000 <_EIP>:
> Code;  c018f709 <usb_submit_urb+19/30>   <=====
>    0:   ff 50 0c                  call   *0xc(%eax)   <=====
> Code;  c018f70c <usb_submit_urb+1c/30>
>    3:   5a                        pop    %edx
> Code;  c018f70d <usb_submit_urb+1d/30>
>    4:   c3                        ret    
> Code;  c018f70e <usb_submit_urb+1e/30>
>    5:   89 f6                     mov    %esi,%esi
> Code;  c018f710 <usb_submit_urb+20/30>
>    7:   b8 ed ff ff ff            mov    $0xffffffed,%eax
> Code;  c018f715 <usb_submit_urb+25/30>
>    c:   c3                        ret    
> Code;  c018f716 <usb_submit_urb+26/30>
>    d:   8d 76 00                  lea    0x0(%esi),%esi
> Code;  c018f719 <usb_submit_urb+29/30>
>   10:   8d bc 27 00 00 00 00      lea    0x0(%edi,1),%edi
> 
> It seems to die while dereferencing urb->dev->bus->op->submit_urb(urb),
> and urb->dev->bus->op pointer is bogus.
> Looking at the kernel messages, I have found that it dies at usb bus
> deregistering (when RedHat initscripts unload usb host controller driver
> for some reason).
> Here are the messages:
> 
> uhci.c: USB Universal Host Controller Interface driver v1.1
> uhci.c: USB UHCI at I/O 0xc400, IRQ 19
> usb.c: new USB bus registered, assigned bus number 1
> usb: raced timeout, pipe 0x80000000 status 0 time left 0
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> usb: raced timeout, pipe 0x80000100 status 0 time left 0
> hub.c: USB hub found
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> hub.c: 2 ports detected
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> usb: raced timeout, pipe 0x80000100 status 0 time left 0
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> usb: raced timeout, pipe 0x80000100 status 0 time left 0
> uhci.c: USB UHCI at I/O 0xc800, IRQ 19
> usb.c: new USB bus registered, assigned bus number 2
> usb: raced timeout, pipe 0x80000100 status 0 time left 0
> usb: raced timeout, pipe 0x80000100 status 0 time left 0
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> usb: raced timeout, pipe 0x80000000 status 0 time left 0
> usb: raced timeout, pipe 0x80000100 status 0 time left 0
> hub.c: USB new device connect on bus1/1, assigned device number 2
> usb.c: USB device 2 (vend/prod 0x49f/0x505a) is not claimed by any active driver.
> usb.c: registered new driver usbnet
> usb0: register usbnet 001/002, Linux Device
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> usb: raced timeout, pipe 0x80000100 status 0 time left 0
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> usb: raced timeout, pipe 0x80000100 status 0 time left 0
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> usb: raced timeout, pipe 0x80000100 status 0 time left 0
> hub.c: USB hub found
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> hub.c: 2 ports detected
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> usb: raced timeout, pipe 0x80000100 status 0 time left 0
> usb: raced timeout, pipe 0x80000180 status 0 time left 0
> usb: raced timeout, pipe 0x80000100 status 0 time left 0
> usb.c: USB disconnect on device 1
> usb.c: USB disconnect on device 2
> usb0: unregister usbnet 001/002, Linux Device
> usb.c: USB bus 1 deregistered
> usb.c: USB disconnect on device 1
> usb.c: USB bus 2 deregistered
> usb: raced timeout, pipe 0x80000100 status 0 time left 0
> Unable to handle kernel paging request at virtual address d890c138
> ...

Did you remove the uhci module?

This patch will fix the raced timeout messages, but you may have found a
reference counting bug as well.

JE

diff --minimal -Nru a/drivers/usb/uhci.c b/drivers/usb/uhci.c
--- a/drivers/usb/uhci.c	Wed Oct 10 07:32:38 2001
+++ b/drivers/usb/uhci.c	Wed Oct 10 07:32:38 2001
@@ -1594,9 +1594,7 @@
 	}
 
 	uhci_unlink_generic(uhci, urb);
-	uhci_destroy_urb_priv(urb);
-
-	usb_dec_dev_use(urb->dev);
+	uhci_call_completion(urb);
 
 	return ret;
 }
