Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266102AbTIETym (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 15:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266101AbTIETym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 15:54:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59656 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266103AbTIETyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 15:54:40 -0400
Date: Fri, 5 Sep 2003 20:54:29 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Sven Dowideit <svenud@ozemail.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Tom Marshall <tommy@home.tig-grr.com>
Subject: Re: Problems with PCMCIA (Texas Instruments PCI1450)
Message-ID: <20030905205429.D14076@flint.arm.linux.org.uk>
Mail-Followup-To: Daniel Ritz <daniel.ritz@gmx.ch>,
	Sven Dowideit <svenud@ozemail.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Tom Marshall <tommy@home.tig-grr.com>
References: <200308270056.33190.daniel.ritz@gmx.ch> <200309052019.30051.daniel.ritz@gmx.ch> <20030905193811.C14076@flint.arm.linux.org.uk> <200309052140.27906.daniel.ritz@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200309052140.27906.daniel.ritz@gmx.ch>; from daniel.ritz@gmx.ch on Fri, Sep 05, 2003 at 09:40:27PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 09:40:27PM +0200, Daniel Ritz wrote:
> On Fri September 5 2003 20:38, Russell King wrote:
> > On Fri, Sep 05, 2003 at 08:19:28PM +0200, Daniel Ritz wrote:
> > > ok, now i can reproduce the problem on my ti1410 too. on boot detection
> > > works fine with an UP kernel and fails with an SMP kernel. thanx for the
> > > hint.
> > > 
> > > i go to look at the csets a bit and try to find out more....
> > > (i think i know which change...)
> > 
> > Care to provide a hint?
> 
> yes. just tested. patch below makes on boot detection with a SMP kernel
> working again (for me). which is nice, but i don't see why it is better
> that way...

Ok, now I need to hear from Sven (and others) to see if this patch fixes
their problems.  Also, are these other people running a SMP kernel as
well?

Meanwhile, I'm wondering if we have a timing problem here.  Can you check
whether adding a mdelay(1) just after the BUG_ON in the original code
fixes the problem?

> ===== cs.c 1.56 vs edited =====
> --- 1.56/drivers/pcmcia/cs.c	Sun Aug  3 14:48:43 2003
> +++ edited/cs.c	Fri Sep  5 21:42:09 2003
> @@ -316,7 +316,6 @@
>  
>  	wait_for_completion(&socket->thread_done);
>  	BUG_ON(!socket->thread);
> -	pcmcia_parse_events(socket, SS_DETECT);
>  
>  	return 0;
>  }
> @@ -1524,6 +1523,9 @@
>      if (client == NULL)
>  	return CS_OUT_OF_RESOURCE;
>  
> +    if (++s->real_clients == 1)
> +	pcmcia_parse_events(s, SS_DETECT);
> +    
>      *handle = client;
>      client->state &= ~CLIENT_UNBOUND;
>      client->Socket = s;
> 

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
