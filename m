Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWILHrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWILHrq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 03:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWILHrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 03:47:46 -0400
Received: from maggie.spheresystems.co.uk ([82.71.70.17]:5764 "EHLO
	maggie.spheresystems.co.uk") by vger.kernel.org with ESMTP
	id S964967AbWILHrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 03:47:45 -0400
From: Andrew Bird <ajb@spheresystems.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Spinlock debugging
Date: Tue, 12 Sep 2006 08:47:39 +0100
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200609111632.27484.ajb@spheresystems.co.uk> <200609111738.21818.ajb@spheresystems.co.uk> <1157995492.23085.191.camel@localhost.localdomain>
In-Reply-To: <1157995492.23085.191.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609120847.39655.ajb@spheresystems.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan
	thanks that did the trick. 
One further question, on the later kernels 2.6.17+, I don't have low_latency 
set. Can I still guarantee that after calling tty_flip_buffer_push() I have 
made space in the tty for my buffer? For example, is this legal? 

// in interrupt handler

   if(tty_buffer_request_room(tty, size) < size) {

      spin_unlock(&dc->lock);
      spin_unlock(&port->lock);

      tty_flip_buffer_push(tty);

      spin_lock(&port->lock);
      spin_lock(&dc->lock);

  }
  tty_insert_flip_string(tty, buf, size);
   
Thanks


Andrew

On Monday 11 September 2006 18:24, Alan Cox wrote:
> Ar Llu, 2006-09-11 am 17:38 +0100, ysgrifennodd Andrew Bird:
> > Alan
> > 	Yes, I have low_latency set for kernels lower than 2.6.17. I'm currently
> > testing using 2.6.15. When you mention 'write method for flow control' do
> > you mean for software XON/XOFF etc?
>
> Yes
>
> Basically in low_latency the following is valid
>
>
> 	driver receives bytes
> 		flush_to_ldisc
> 			ldisc calls driver write methods
>
>
> That means if you have a shared lock for read/write you want to drop it
> after you've bashed the hardware and before you flush_to_ldisc. Remember
> the IRQ handler is not re-entrant so another IRQ of the same number
> won't cause further I/O and out of order receives.
>
> Alan
