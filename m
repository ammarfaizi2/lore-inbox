Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262465AbREXWr4>; Thu, 24 May 2001 18:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262466AbREXWrq>; Thu, 24 May 2001 18:47:46 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38920 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262465AbREXWrc>; Thu, 24 May 2001 18:47:32 -0400
Subject: Re: [CHECKER] free bugs in 2.4.4 and 2.4.4-ac8
To: engler@csl.Stanford.EDU (Dawson Engler)
Date: Thu, 24 May 2001 23:44:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
In-Reply-To: <200105242104.OAA29654@csl.Stanford.EDU> from "Dawson Engler" at May 24, 2001 02:04:02 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1533qI-0005jT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [BUG] [fixed in 2.4.4]
> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/block/cciss.c:686:cciss_ioctl: ERROR:FREE:682:686: WARN: Use-after-free of "c"! set by 'cmd_free':682 [type=SECURITY]
>                 {
>                         /* Copy the data out of the buffer we created */
>                         if (copy_to_user(iocommand.buf, buff, iocommand.buf_size))
> 			{
>                         	kfree(buff);
> Start --->
> 				cmd_free(h, c, 0);

Missing return -EFAULT - fixed. (The one thing your analyser cant do is guess
history of bugs ;) - this is one that came with the updated driver. Im glad
you caught it as the update went on to Linus for 2.4.5pre


> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/usb/dc2xx.c:473:camera_disconnect: ERROR:FREE:466:473: WARN: Use-after-free of "camera"! set by 'kfree':466

Already fixed in ac15 but a real bug

> [BUG]  seems possible --- or is some precondition guarenteed?
> /u2/engler/mc/oses/linux/2.4.4-ac8/net/ipv6/udp.c:438:udpv6_recvmsg: ERROR:FREE:453:438: WARN: Use-after-free of "skb"! set by 'kfree_skb':453

Looks right. Left for DaveM

> ---------------------------------------------------------
> [BUG]  [BAD] Seems like a really really bad double free.
> /u2/engler/mc/oses/linux/2.4.4/drivers/i2o/i2o_pci.c:231:i2o_pci_install: ERROR:FREE:229:231: WARN: Use-after-free of "c"! set by 'i2o_delete_controller':229

Real bug - in -ac the bug is the same but the file moved

> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/isdn/isdn_ppp.c:822:isdn_ppp_init: ERROR:FREE:822:822: WARN: Use-after-free of "ippp_table"! set by 'kfree':822
>
Fixed in -ac and current 2.4.5pre already - real bug

> [BUG]
> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/atm/iphase.c:1323:rx_dle_intr: ERROR:FREE:1321:1323: WARN: Use-after-free of "skb"! set by 'dev_kfree_skb_any':1321

Real bug - fixed

> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/atm/iphase.c:1339:rx_dle_intr: ERROR:FREE:1337:1339: WARN: Use-after-free of "skb"! set by 'dev_kfree_skb_any':1337
>           length =  swap(trailer->length);

Real bug - fixed

> ---------------------------------------------------------
> [BUG]
> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/sound/cs4281/cs4281m.c:4468:cs4281_remove: ERROR:FREE:4466:4468: WARN: Use-after-free of "s"! set by 'kfree':4466

Real bug - fixed

> [BUG] Again assumes kfree sets memory to NULL.

Disagree with diagnosis
> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/wan/lapbether.c:116:lapbeth_check_devices: ERROR:FREE:113:116: WARN: Use-after-free of "lapbeth"! set by 'kfree':113
> 			if (&lapbeth->axdev == dev)

But the bug is real - fixed a missing else

> [BUG] bpq is freed, assigned to another variable (bpq_prev), then
> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/hamradio/bpqether.c:196:bpq_check_devices: ERROR:FREE:193:196: WARN: Use-after-free of "bpq"! set by 'kfree':193

Fixed - real bug (copy of lapbether bug)

> [BUG]
>
 /u2/engler/mc/oses/linux/2.4.4-ac8/net/wanrouter/wanmain.c:617:device_setup: ERROR:FREE:614:617: WARN: Use-after-free of "conf"! set by 'kfree':614

Real bug - fixed

> /u2/engler/mc/oses/linux/2.4.4-ac8/net/netrom/nr_dev.c:122:nr_rebuild_header: ERROR:FREE:117:122: WARN: Use-after-free of "skbn"! set by 'kfree_skb':117
> 		skb_set_owner_w(skbn, skb->sk);
> 

Real bug - fixed

> /u2/engler/mc/oses/linux/2.4.4-ac8/net/ax25/ax25_ip.c:163:ax25_rebuild_header: ERROR:FREE:157:163: WARN: Use-after-free of "skb"! set by 'kfree_skb':157
> 			}

Uggh - nasty - fixed.

> Error --->
> 		dbg(__FUNCTION__" - nonzero write bulk status received: %d", urb->status);

Fixed

> 		return;
> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/char/drm/gamma_dma.c:573:gamma_dma_send_buffers: ERROR:FREE:561:573: WARN: Use-after-free of "last_buf"! set by 'drm_free_buffer':561
> 		DRM_DEBUG("%d running\n", current->pid);

Left for the XFree folk

> [BUG]
> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/usb/dc2xx.c:332:camera_release: ERROR:FREE:330:332: WARN: Use-after-free of "camera"! set by 'kfree':330
>

Already fixed in ac15 - real bug
> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/char/rio/rio_linux.c:1036:rio_init_datastructures: ERROR:FREE:1031:1036: WARN: Use-after-free of "RIOHosts"! set by 'kfree':1031
>         kfree (p->RIOPortp[i]);
> 	rio_dprintk (RIO_DEBUG_INIT, "Not enough memory! %p %p %p %p %p\n", 
> Error --->
>         	       p, p->RIOHosts, p->RIOPortp, rio_termios, rio_termios);

Not a bug - you need to teach your code that printf has formats that print the
value of a pointer not dereference it

Thats pretty good - one false positive. 

