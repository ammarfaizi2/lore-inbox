Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262857AbVDATNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbVDATNY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 14:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbVDATNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 14:13:23 -0500
Received: from fire.osdl.org ([65.172.181.4]:46267 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262857AbVDATM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 14:12:57 -0500
Date: Fri, 1 Apr 2005 11:11:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       jlan@engr.sgi.com, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [1/1] CBUS: new very fast (for insert operations) message bus
 based on kenel connector.
Message-Id: <20050401111134.49a8af5f.akpm@osdl.org>
In-Reply-To: <1112361177.12969.23.camel@uganda>
References: <20050320112336.2b082e27@zanzibar.2ka.mipt.ru>
	<20050331162758.44aeaf44.akpm@osdl.org>
	<1112337814.9334.42.camel@uganda>
	<20050331232625.09057712.akpm@osdl.org>
	<1112341514.9334.103.camel@uganda>
	<20050331235927.6d104665.akpm@osdl.org>
	<1112345400.9334.157.camel@uganda>
	<20050401012547.68c26523.akpm@osdl.org>
	<1112350615.9334.194.camel@uganda>
	<20050401023004.2a83dbe5.akpm@osdl.org>
	<1112352955.9334.225.camel@uganda>
	<20050401032023.3d05d42f.akpm@osdl.org>
	<1112361177.12969.23.camel@uganda>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> Andrew, CBUS is not intended to be faster than connector itself, 
>  it is just not possible, since it calls connector's methods
>  with some preparation, which takes time.

Right - it's simply transferring work from one place to another.

>  CBUS was designed to provide very fast _insert_ operation.

I just don't see any point in doing this.  If the aggregate system load is
unchanged (possibly increased) then why is cbus desirable?

The only advantage I can see is that it permits irq-context messaging.

>  It is needed not only for fork() accounting, but for any
>  fast path, when we do not want to slow process down just to
>  send notification about it, instead we can create such a notification,
>  and deliver it later.

And when we deliver it later, we slow processes down!

>  Why do we defer all work from HW IRQ into BH context?

To enable more interrupts to come in while we're doing that work.

>  Because while we are in HW IRQ we can not perform other tasks,
>  so with connector and CBUS we have the same situation.

I agree that being able to send from irq context would be handy.  If we had
any code which wants to do that, and at present we do not.

But I fail to see any advantage in moving work out of fork() context, into
kthread context and incurring additional context switch overhead.  Apart
from conceivably better CPU cache utilisation.

The fact that deferred delivery can cause an arbitrarily large backlog and,
ultimately, deliberate message droppage or oom significantly impacts the
reliability of the whole scheme and means that well-designed code must use
synchronous delivery _anyway_.  The deferred delivery should only be used
from IRQ context for low-bandwidth delivery rates.

>  While we are sending a low priority event, we stops actuall work,
>  which is not acceptible in many situations.

Have you tested the average forking rate on a uniprocessor machine with
this patch?  If the forking continues for (say) one second, does the patch
provide any performance benefit?
