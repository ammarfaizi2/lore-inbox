Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271319AbTGWVAY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 17:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271323AbTGWVAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 17:00:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6151 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S271319AbTGWVAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 17:00:23 -0400
Date: Wed, 23 Jul 2003 22:15:25 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Lawrence <dgl@integrinautics.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: compact flash IDE hot-swap summary please
Message-ID: <20030723221525.A3397@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Dave Lawrence <dgl@integrinautics.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3F1ECFDD.D561D861@integrinautics.com> <1058984303.5515.105.camel@dhcp22.swansea.linux.org.uk> <20030723204954.A439@flint.arm.linux.org.uk> <1058991230.5515.126.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1058991230.5515.126.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Jul 23, 2003 at 09:13:51PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 09:13:51PM +0100, Alan Cox wrote:
> Everyone I know is using the PCMCIA interface stuff for that. Now that 
> can support the unplugging but the ide-cs code is still not doing the
> right things in this case (and the core could be a little more careful).
> The ide_unregister can fail - you are supposed to call it again later if
> it does - ide_cs doesnt

Ok, I see a couple of problems here.

Firstly, how does ide_cs in 2.6.0-test1 know that ide_unregister has
failed?  In my copy of 2.6.0-test1, it doesn't return any values.

Secondly, 2.4.21 seems to fail with value '1' for two cases:
 - the ide interface wasn't found to be present
 - the drive is in use
 - the shutdown fails

In the first case, we just want to forget all about the interface - we
don't want to retry at some time in the future.  In the second case,
well, the device has physically gone, so any outstanding requests are
not going to complete.  Hopefully an in-progress request should time
out, but we shouldn't try to start a new request.

Thirdly, we don't change the iops on unregister.  Some hardware returns
random garbage to reads from the PCMCIA space when there isn't a card
present.

So, in short, I think that IDE unplug is broken in the core IDE driver
and needs significant work in _both_ 2.4 and 2.6 before we can think
about getting PCMCIA-based IDE cards to work sufficiently well.  Yes,
ide-cs.c may need some work, but ide.c also requires work.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

