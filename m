Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264857AbUGIOj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264857AbUGIOj3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 10:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbUGIOj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 10:39:29 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:49156 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264857AbUGIOjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 10:39:23 -0400
Subject: Re: gcc 3.5 compile fixes
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <m3r7rlpjd7.fsf@averell.firstfloor.org>
References: <m3r7rlpjd7.fsf@averell.firstfloor.org>
Content-Type: multipart/mixed; boundary="=-yfhHGP8g1m8ahlBbsiEF"
Date: Fri, 09 Jul 2004 16:39:07 +0200
Message-Id: <1089383948.1742.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.2 (1.5.9.2-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yfhHGP8g1m8ahlBbsiEF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I need the following patch to make recent -bk kernels compile against
gcc35.

On Fri, 2004-07-09 at 12:25 +0200, Andi Kleen wrote:
> I tried to compile 2.6.7-bk9 with a recent gcc 3.5 snapshot on i386
> and x86-64. It gave a lot of warnings and a lot of compile errors
> for make allyesconfig.
> 
> On x86-64 it miscompiled the kernel (due to kernel bugs); I will send
> fixes for that separately.
> 
> Most compile errors were about mixing extern and static declarations
> of the same symbol. I fixed this all except for the au88x0 driver
> in ALSA which had a too broken module setup (someone else will have 
> to tackle that)
> 
> I got one gcc internal compiler error while compiling the sunrpc 
> gss module. I filed an gcc bug for that. 
> 
> One problem was that it didn't always inline fix_to_virt() which
> resulted in undefined symbols. (gcc 3.4 and up doesn't set always 
> inline for normal inline). I fixed this by defining a new macro
> __always_inline in compiler.h and using that for fix_to_virt
> 
> Another issue (I think already fixed in -mm) was that memmove()
> needs to be moved out of line.
> 
> The result were a lot of patches for a lot of files. Instead
> of spamming l-k with them all I put them in 
> http://www.firstfloor.org/~andi/35/ 
> Andrew, please consider adding them to your tree.
> 
> The resulting i386 kernel booted on one machine; but failed to find
> the SCSI disks on another (didn't investigate what the problem 
> was on the later, some more work needed on that)  
> 
> -Andi
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=-yfhHGP8g1m8ahlBbsiEF
Content-Disposition: attachment; filename=gcc-35.patch
Content-Type: text/x-patch; name=gcc-35.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -uNr linux-2.6.7-mm7/arch/i386/kernel/cpu/mtrr/if.c linux-2.6.7-mm7-gcc35/arch/i386/kernel/cpu/mtrr/if.c
--- linux-2.6.7-mm7/arch/i386/kernel/cpu/mtrr/if.c	2004-06-16 07:19:02.000000000 +0200
+++ linux-2.6.7-mm7-gcc35/arch/i386/kernel/cpu/mtrr/if.c	2004-07-09 10:17:04.000000000 +0200
@@ -16,7 +16,7 @@
 
 #define FILE_FCOUNT(f) (((struct seq_file *)((f)->private_data))->private)
 
-static char *mtrr_strings[MTRR_NUM_TYPES] =
+char *mtrr_strings[MTRR_NUM_TYPES] =
 {
     "uncachable",               /* 0 */
     "write-combining",          /* 1 */
diff -uNr linux-2.6.7-mm7/drivers/pcmcia/ds.c linux-2.6.7-mm7-gcc35/drivers/pcmcia/ds.c
--- linux-2.6.7-mm7/drivers/pcmcia/ds.c	2004-07-09 10:55:33.000000000 +0200
+++ linux-2.6.7-mm7-gcc35/drivers/pcmcia/ds.c	2004-07-09 10:47:25.000000000 +0200
@@ -413,7 +413,7 @@
 EXPORT_SYMBOL(pcmcia_unregister_driver);
 
 #ifdef CONFIG_PROC_FS
-static struct proc_dir_entry *proc_pccard = NULL;
+struct proc_dir_entry *proc_pccard = NULL;
 
 static int proc_read_drivers_callback(struct device_driver *driver, void *d)
 {
diff -uNr linux-2.6.7-mm7/drivers/usb/class/usblp.c linux-2.6.7-mm7-gcc35/drivers/usb/class/usblp.c
--- linux-2.6.7-mm7/drivers/usb/class/usblp.c	2004-07-09 10:55:34.000000000 +0200
+++ linux-2.6.7-mm7-gcc35/drivers/usb/class/usblp.c	2004-07-09 10:51:48.000000000 +0200
@@ -1179,7 +1179,7 @@
 
 MODULE_DEVICE_TABLE (usb, usblp_ids);
 
-static struct usb_driver usblp_driver = {
+struct usb_driver usblp_driver = {
 	.owner =	THIS_MODULE,
 	.name =		"usblp",
 	.probe =	usblp_probe,
diff -uNr linux-2.6.7-mm7/net/ipv6/ip6_fib.c linux-2.6.7-mm7-gcc35/net/ipv6/ip6_fib.c
--- linux-2.6.7-mm7/net/ipv6/ip6_fib.c	2004-06-16 07:19:52.000000000 +0200
+++ linux-2.6.7-mm7-gcc35/net/ipv6/ip6_fib.c	2004-07-09 10:49:25.000000000 +0200
@@ -94,7 +94,7 @@
 
 static struct timer_list ip6_fib_timer = TIMER_INITIALIZER(fib6_run_gc, 0, 0);
 
-static struct fib6_walker_t fib6_walker_list = {
+struct fib6_walker_t fib6_walker_list = {
 	.prev	= &fib6_walker_list,
 	.next	= &fib6_walker_list, 
 };
diff -uNr linux-2.6.7-mm7/net/ipv6/xfrm6_state.c linux-2.6.7-mm7-gcc35/net/ipv6/xfrm6_state.c
--- linux-2.6.7-mm7/net/ipv6/xfrm6_state.c	2004-06-16 07:19:13.000000000 +0200
+++ linux-2.6.7-mm7-gcc35/net/ipv6/xfrm6_state.c	2004-07-09 10:50:23.000000000 +0200
@@ -119,7 +119,7 @@
 	return x0;
 }
 
-static struct xfrm_state_afinfo xfrm6_state_afinfo = {
+struct xfrm_state_afinfo xfrm6_state_afinfo = {
 	.family			= AF_INET6,
 	.lock			= RW_LOCK_UNLOCKED,
 	.init_tempsel		= __xfrm6_init_tempsel,
diff -uNr linux-2.6.7-mm7/scripts/kconfig/mconf.c linux-2.6.7-mm7-gcc35/scripts/kconfig/mconf.c
--- linux-2.6.7-mm7/scripts/kconfig/mconf.c	2004-06-16 07:19:02.000000000 +0200
+++ linux-2.6.7-mm7-gcc35/scripts/kconfig/mconf.c	2004-07-09 10:10:07.000000000 +0200
@@ -88,7 +88,7 @@
 static int indent;
 static struct termios ios_org;
 static int rows, cols;
-static struct menu *current_menu;
+struct menu *current_menu;
 static int child_count;
 static int do_resize;
 static int single_menu_mode;

--=-yfhHGP8g1m8ahlBbsiEF--

