Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVKUAsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVKUAsQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 19:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVKUAsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 19:48:16 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:2458 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S932147AbVKUAsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 19:48:16 -0500
Message-ID: <4381194A.3080609@shadowconnect.com>
Date: Mon, 21 Nov 2005 01:48:10 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: "David S. Miller" <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] I2O: SPARC fixes
References: <437E7ADB.5080200@shadowconnect.com> <20051118.172230.126076770.davem@davemloft.net> <1132371039.5238.14.camel@localhost.localdomain> <20051118.203707.129707514.davem@davemloft.net> <4380EDB1.1080308@shadowconnect.com> <20051120225256.GC27946@ftp.linux.org.uk> <20051120230714.GD27946@ftp.linux.org.uk> <20051120232158.GE27946@ftp.linux.org.uk>
In-Reply-To: <20051120232158.GE27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Al Viro wrote:
> On Sun, Nov 20, 2005 at 11:07:14PM +0000, Al Viro wrote:
>>	And here's another fun one:
>>                evt->size = size;
>>                evt->tcntxt = le32_to_cpu(msg->u.s.tcntxt);
>>                evt->event_indicator = le32_to_cpu(msg->body[0]);
>>                memcpy(&evt->tcntxt, &msg->u.s.tcntxt, size * 4);
>>in i2o_driver_dispatch().
> Gaaack...  Old code used to be
>                        evt = kmalloc(size * 4 + sizeof(*evt), GFP_ATOMIC);
>                        if (!evt)
>                                return -ENOMEM;
>                        memset(evt, 0, size * 4 + sizeof(*evt));
> 
>                        evt->size = size;
>                        memcpy_fromio(&evt->tcntxt, &msg->u.s.tcntxt,
>                                     (size + 2) * 4);
> Then it became
>                evt->size = size;
>                evt->tcntxt = readl(&msg->u.s.tcntxt);
>                evt->event_indicator = readl(&msg->body[0]);
>                memcpy_fromio(&evt->tcntxt, &msg->u.s.tcntxt, size * 4);
> See the problem with it?  The last copy should be from &msg->body[1] to
> evt->data.  As it is, we do not copy the last 8 bytes (which might or
> might not be a problem) *AND* we overwrite tcntxt and event_indicator

At the moment it's not a problem, because the event system is not used...

> with bus-endian values right after having host-endian ones carefully
> assigned to them.

Yep, you're right...  the memcpy_fromio is wrong... It should be:

memcpy_fromio(&evt->body[1], &msg->body[1], size * 4);

as you already mentioned...

Thanks for your help.


Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
