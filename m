Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751652AbWHAUIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbWHAUIy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 16:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbWHAUIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 16:08:53 -0400
Received: from mail.tmr.com ([64.65.253.246]:50075 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1751652AbWHAUIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 16:08:53 -0400
Message-ID: <44CFB5A1.8080904@tmr.com>
Date: Tue, 01 Aug 2006 16:12:17 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: tickle NMI watchdog on serial output.
References: <20060801182529.GJ22240@redhat.com>
In-Reply-To: <20060801182529.GJ22240@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://newsvote.bbc.co.uk/mpapps/pagetools/print/news.bbc.co.uk/2/hi/health/5232150.stmDave 
Jones wrote:
> Serial is _slow_ sometimes. So slow, that the NMI watchdog kicks in.


> I initially did the patch below a year ago for the Fedora kernel, and have
> been keeping it up to date since.  I recently got the same thing happening
> on a vanilla kernel, so figured it was time to repost this.

Hopefully this will get picked up for mainline. In case of a real hung 
it should still trigger NMI in some reasonable time.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- linux-2.6/drivers/serial/8250.c~	2005-05-14 02:49:02.000000000 -0400
> +++ linux-2.6/drivers/serial/8250.c	2005-05-14 02:54:30.000000000 -0400
> @@ -2098,9 +2098,11 @@ static inline void wait_for_xmitr(struct
>  	/* Wait up to 1s for flow control if necessary */
>  	if (up->port.flags & UPF_CONS_FLOW) {
>  		tmout = 1000000;
> -		while (--tmout &&
> -		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
> +		while (!(serial_in(up, UART_MSR) & UART_MSR_CTS) && --tmout) {
>  			udelay(1);
> +			if ((tmout % 1000) == 0)
> +				touch_nmi_watchdog();
> +		}
>  	}
>  }
>  
> 


-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
