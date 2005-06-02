Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVFBM63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVFBM63 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 08:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVFBM63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 08:58:29 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:23434 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261405AbVFBM6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 08:58:24 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: Moxa multi serial driver doesn't pass received chars up
Date: Thu, 2 Jun 2005 15:54:07 +0300
User-Agent: KMail/1.5.4
Cc: rmk+serial@arm.linux.org.uk, alan@redhat.com
References: <200506021220.47138.vda@ilport.com.ua>
In-Reply-To: <200506021220.47138.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506021554.07316.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 June 2005 12:20, Denis Vlasenko wrote:
> Hi,
> 
> I have to set up 8-port PCI multiport serial card.
> Everything seems okay except for receive side.
> 
> I added this to mxser.c: mxser_receive_chars()
> at the bottom:
> 
>         mxvar_log.rxcnt[info->port] += cnt;
>         info->mon_data.rxcnt += cnt;
>         info->mon_data.up_rxcnt += cnt;
>         spin_unlock_irqrestore(&info->slock, flags);
> 
> +if (verbose>1) {
> +int c = cnt;
> +unsigned char *p = tty->flip.char_buf;
> +printk("mxser_receive_chars:");
> +while(c--)
> +    printk(" %02x", *p++);
> +printk("\n");
> +}
> 
>         tty_flip_buffer_push(tty);
> }

No wonder... it directly stuffs chars into flip buffer,
but does _not_ update flip counter!

I am cooking a patch which will use

tty_insert_flip_char(tty, ch, flag);

instead...
--
vda

