Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbTL3EJf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 23:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbTL3EJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 23:09:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40335 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264373AbTL3EJd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 23:09:33 -0500
Message-ID: <3FF0FA6A.8000904@pobox.com>
Date: Mon, 29 Dec 2003 23:09:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with dev_kfree_skb_any() in 2.6.0
References: <1072567054.4112.14.camel@gaston> <20031227170755.4990419b.davem@redhat.com>
In-Reply-To: <20031227170755.4990419b.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Sun, 28 Dec 2003 10:17:34 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> 
>>We should probably fix dev_kfree_skb_any() ? Still ugly imho though...
>>
>>-        if (in_irq())
>>+        if (in_irq() || irqs_disabled())
>>
> 
> 
> That's not the right fix, the sungem PM code path TX queue
> packet freeing should be instead done outside of IRQ spinlocks.


Not really...  pretty much _all_ TX queue packet freeing occurs inside 
an irq handler and inside the driver spinlock.  Further, we don't want 
to reinvent some sort of "queue skb for freeing" code in every driver.

Look at what a driver really wants from the net stack:

	if (you can free the skb now)
		free skb
	otherwise
		queue it to be freed later

The driver _shouldn't_ care about the conditions under which an skb can 
be freed.  That's entirely the net stack's domain (and should be)... 
heck, the net stack should even be free to change said conditions, 
without breaking or confusing drivers.

	Jeff



