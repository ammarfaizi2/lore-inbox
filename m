Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTDQU1F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 16:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbTDQU1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 16:27:05 -0400
Received: from opersys.com ([64.40.108.71]:8965 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262423AbTDQU1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 16:27:03 -0400
Message-ID: <3E9F0FD5.595B000B@opersys.com>
Date: Thu, 17 Apr 2003 16:34:29 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
CC: "'Martin Hicks'" <mort@wildopensource.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>, "'hpa@zytor.com'" <hpa@zytor.com>,
       "'pavel@ucw.cz'" <pavel@ucw.cz>,
       "'jes@wildopensource.com'" <jes@wildopensource.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'wildos@sgi.com'" <wildos@sgi.com>,
       "'Tom Zanussi'" <zanussi@us.ibm.com>
Subject: Re: [patch] printk subsystems
References: <A46BBDB345A7D5118EC90002A5072C780C26308A@orsmsx116.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Perez-Gonzalez, Inaky" wrote:
> But you don't need to provide buffers, because normally the data
> is already in the kernel, so why need to copy it to another buffer
> for delivery?

There is no copying going on. As with kue, you have to have a
packaged structure somewhere to send to the recipient. As per
your code:
+       _m4 = kmalloc (sizeof (*_m4), GFP_KERNEL);
+       memcpy (_m4, &m4, sizeof (m4));
+       _m4->kue.flags = KUE_KFREE;
+       kue_send_event (&_m4->kue);

_m4 and m4 are placeholders that must exist before being queued,
there's just no way around that. With relayfs you would do:
relay_write(channel_id, &m4, , time_delta_offset);

When the channel buffer is mmap'ed in the user-process' address space,
all that is needed is a write() with a pointer to the buffer for it
to go to storage. There is zero-copying going on here.

Plus, kue uses lists with next & prev pointers. That simply won't
scale if you have a buffer filling at the rate of 10,000 events/s.
Also, at that rate, you simply can't wait on the reader to read
events one-by-one until you can reuse the structure where you
stored the data to be read. The data has to be secured in the buffer
at the return of the logging function (relay_write() in the case of
relayfs) and the reader has to read events by the thousand every
time.

> This is where I think relayfs is doing too much, and that is the
> reason why I implemented the kue stuff. It is very lightweight
> and does almost the same [of course, it is not bidirectional, but
> still nobody asked for that].

relayfs is there to solve the data transfer problems for the most
demanding of applications. Sending a few messages here and there
isn't really a problem. Sending messages/events/what-you-want-to-call-it
by the thousand every second, while using as little locking as possible
(lockless-logging is implemented in the case of relayfs' buffer handling
routines), and providing per-cpu buffering requires a different beast.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
