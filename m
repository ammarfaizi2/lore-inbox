Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVBAN70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVBAN70 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 08:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVBAN70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 08:59:26 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:52950 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262020AbVBAN7R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 08:59:17 -0500
Date: Tue, 1 Feb 2005 14:52:37 +0100 (CET)
To: adobriyan@mail.ru
Subject: Re: [PATCH 2.6] I2C: New chip driver: sis5595
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <w2Am1HDp.1107265957.3006340.khali@localhost>
In-Reply-To: <200502011612.27220.adobriyan@mail.ru>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Aurelien Jarno" <aurelien@aurel32.net>, "Greg KH" <greg@kroah.com>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "LM Sensors" <sensors@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alexey,

> What about making sis5595_update_device() a simple jiffies-related wrapper
> around function that updates "struct sis5595" unconditionally. I'm not sure
> I plugged sis5595_do_update_client right, but you'll get the idea.

Yeah I get the idea, I think I had something similar in mind some times
ago but it failed to please me for the following reasons:

1* It forces a chip update (i.e. full register read) on driver load (or
more precisely on client detection). Since I2C/SMBus accesses are really
slow, it will result in a significant time penalty. As the read values
are only considered valid for 1.5 second (or equivalent duration for the
other drivers), this penalty brings statistically no benefit in return.

2* Each subsequent update (or attempt thereof) will conditionally require
an additional function call, which represents a small time penalty again
(much more than a comparison if I'm not mistaken).

We are only trying to avoid a conditional test and to get rid of a local
variable, and end up with a much slower init and an additional function
call later. The loss seems to overweight the gain, don't you think?

So I wouldn't go that way. To me, the only acceptable simplification is
the initialization of "last_updated" to something which ensures that
the first update attempt will succeed - providing we actually can do
that.

Now I wonder, this is certainly not the only drivers in the kernel which
need to do this, right? Didn't the other ones solve the issue already?
Would be worth taking a look.

Thanks,
--
Jean Delvare
