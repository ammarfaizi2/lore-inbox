Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265547AbUALOdm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 09:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265550AbUALOdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 09:33:42 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:65157 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S265547AbUALOd0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 09:33:26 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [discuss] Re: kgdb for x86_64 2.6 kernels
Date: Mon, 12 Jan 2004 20:01:59 +0530
User-Agent: KMail/1.5
Cc: George Anzinger <george@mvista.com>, Andrew Morton <akpm@osdl.org>,
       jim.houston@comcast.net, discuss@x86-64.org, ak@suse.de,
       shivaram.upadhyayula@wipro.com, lkml <linux-kernel@vger.kernel.org>
References: <000e01c3d476$2ebe03a0$4008720a@shivram.wipro.com> <200401101611.53510.amitkale@emsyssoft.com> <20040110193049.GA252@elf.ucw.cz>
In-Reply-To: <20040110193049.GA252@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200401122001.29151.amitkale@emsyssoft.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Done. Thanks.

On Sunday 11 Jan 2004 1:00 am, Pavel Machek wrote:
> Hi!
>
> > Well said!
> >
> > I have released kgdb 2.0.1 for kernel 2.6.1:
> > http://kgdb.sourceforge.net/linux-2.6.1-kgdb-2.0.1.tar.bz2
> >
> > It doesn't contain any assert stuff. I have split it into multiple parts
> > to make a merge easier. Please let me know if you want me to further
> > split them or if you want something to be changed. The README file from
> > this tarball is pasted below.
> >
> > Here is two possible starting points:
> > 1. SMP stuff -> Replace my old smp and nmi handling code.
> > 2. Early boot -> Change 8250.patch to make configuration of serial port
> > either through config options or through command line.
> >
> > I'll attempt reading your patch and merging as much stuff as
> > possible.
>
> Fix round of changes:
>
> * kgdbeth_opt does not initialize ipaddrptr -> this could not have
> ever worked. [Okay, it still does not work].
>
> * Add some basic documentation
>
> * reply_arp can be static, AFAICS
>
> * getDebugChar() no longer exists, kill it from the docs, read_char()
> should be equivalent.
>
> * eth_PutDebugChar() seems to be no longer used. Kill it.
>
> Please apply,
> 									Pavel
>
>
> --- tmp/linux/drivers/net/kgdb_eth.c	2004-01-10 20:16:10.000000000 +0100
> +++ linux/drivers/net/kgdb_eth.c	2004-01-10 20:10:27.000000000 +0100
> @@ -72,8 +72,7 @@
>  read_char(void)
>  {
>  	/* intr routine has queued chars */
> -	if (atomic_read(&kgdb_buf_in_cnt) != 0)
> -	{
> +	if (atomic_read(&kgdb_buf_in_cnt) != 0) {
>  		int chr;
>
>  		chr = kgdb_buf[kgdb_buf_out_inx++] ;
> @@ -150,8 +149,6 @@
>  	kgdb_netdevice->hard_start_xmit(skb, kgdb_netdevice);
>  	kgdb_netdevice->xmit_lock_owner = -1;
>  	spin_unlock(&kgdb_netdevice->xmit_lock);
> -
> -	/* kfree_skb(skb); */
>  }
>
>  static void kgdbeth_flush(void)
> @@ -179,7 +176,7 @@
>
>  static struct sk_buff *send_skb = NULL;
>
> -void
> +static void
>  kgdb_eth_reply_arp(void)
>  {
>  	if (send_skb) {
> @@ -313,12 +310,12 @@
>   * Accept an skbuff from net_device layer and add the payload onto
>   * kgdb buffer
>   *
> - * When the kgdb stub routine getDebugChar() is called it draws characters
> + * When the kgdb stub routine read_char() is called it draws characters
>   * out of the buffer until it is empty and then reads directly from the
>   * serial port.
>   *
>   * We do not attempt to write chars from the interrupt routine since
> - * the stubs do all of that via putDebugChar() which writes one byte
> + * the stubs do all of that via write_char() which writes one byte
>   * after waiting for the interface to become ready.
>   *
>   * The debug stubs like to run with interrupts disabled since, after all,
> @@ -434,7 +431,7 @@
>  }
>
>  /*
> - * getDebugChar
> + * kgdbeth_read_char
>   *
>   * This is a GDB stub routine.  It waits for a character from the
>   * serial interface and then returns it.  If there is no serial
> @@ -455,42 +452,6 @@
>  	return chr;
>  }
>
> -#define ETH_QUEUE_SIZE 256
> -static char eth_queue[ETH_QUEUE_SIZE];
> -static int outgoing_queue;
> -
> -void
> -eth_flushDebugChar(void)
> -{
> -	if(outgoing_queue) {
> -		write_buffer(eth_queue, outgoing_queue);
> -
> -		outgoing_queue = 0;
> -	}
> -}
> -
> -static void
> -put_char_on_queue(int chr)
> -{
> -	eth_queue[outgoing_queue++] = chr;
> -	if(outgoing_queue == ETH_QUEUE_SIZE)
> -	{
> -		eth_flushDebugChar();
> -	}
> -}
> -
> -/*
> - * eth_putDebugChar
> - *
> - * This is a GDB stub routine.  It waits until the interface is ready
> - * to transmit a char and then sends it.
> - */
> -void
> -eth_putDebugChar(int chr)
> -{
> -	put_char_on_queue(chr); /* this routine will wait */
> -}
> -
>  static void kgdbeth_begin_session(void)
>  {
>  	kgdbeth_is_trapped = 1;
> @@ -546,7 +507,7 @@
>  static int __init kgdbeth_opt(char *str)
>  {
>  	char ipaddrstr[16];
> -	char *ipaddrptr;
> +	char *ipaddrptr = ipaddrstr;
>
>  	/* interfacenum */
>  	if (*str < '0' || *str > '9')
> --- /dev/null	2003-09-12 10:38:14.000000000 +0200
> +++ linux/Documentation/kgdb/kgdb_eth.txt	2004-01-10 19:53:37.000000000
> +0100 @@ -0,0 +1,10 @@
> +Some notes about kgdb over ethernet
> +
> + 2004 Pavel Machek <pavel@suse.cz>
> +
> +
> +kgdbeth=interfacenum,localmac,listenport,remoteip,remotemac
> +
> +Then
> +   % gdb ./vmlinux
> +   (gdb) target remote udp:HOSTNAME:6443

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

