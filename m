Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbWJSJCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWJSJCm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 05:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbWJSJCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 05:02:41 -0400
Received: from av1.karneval.cz ([81.27.192.123]:46360 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S1030346AbWJSJCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 05:02:40 -0400
Message-ID: <45373F2F.90906@gmail.com>
Date: Thu, 19 Oct 2006 11:02:39 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: "Kilau, Scott" <Scott_Kilau@digi.com>
CC: Greg KH <greg@kroah.com>, Greg.Chandler@wellsfargo.com,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: kernel oops with extended serial stuff turned on...
References: <335DD0B75189FB428E5C32680089FB9F803FE8@mtk-sms-mail01.digi.com> <20061018230939.GA7713@kroah.com> <335DD0B75189FB428E5C32680089FB9FA473E9@mtk-sms-mail01.digi.com>
In-Reply-To: <335DD0B75189FB428E5C32680089FB9FA473E9@mtk-sms-mail01.digi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Alan Cox (who may be involved)
Cc: Andrew Morton (who forwarded me this message, thanks)

Kilau, Scott wrote:
> Hi Greg,
>  
>> What other driver is using the ttyM0 name?

drivers/char/mxser.c:   mxvar_sdriver->name = "ttyM";
drivers/char/isicom.c:  isicom_normal->name = "ttyM";

drivers/char/amiserial.c:       serial_driver->name = "ttyS";
drivers/char/serial167.c:    cy_serial_driver->name = "ttyS";
drivers/char/vme_scc.c: scc_driver->name = "ttyS";

drivers/char/istallion.c:static char    *stli_serialname = "ttyE";
drivers/char/stallion.c:        stl_serial->name = "ttyE";

drivers/char/vt.c:      console_driver->name = "tty";
drivers/char/viocons.c: viotty_driver->name = "tty";

Should we do something with these?

>> Any pointer to your driver's code so I can see if you are doing
>> something odd here?  Any reason it's just not in the main kernel tree so
>> I would have fixed it up at the time I did the other fixes?
> 
> Sorry,
> I probably shouldn't have brought my driver up,
> its just confusing things. =)
>  
> Greg C is not running any of my out-of-tree drivers,
> or even using one of our (Digi) boards.
>  
> I just saw his warning/error, and noticed it was the same as what I saw
> back when 2.6.18 was released, so I figured I would hop in and
> explain what I did to fix the problem in my driver...
>  
> (BTW, the error turns up a few times in a google of...
> "don't try to register things with the same name in the same directory."
> I wonder if all the "tty" ones are all related...)
>  
> In Greg C's case, he turned on *all* the serial options in "make config",
> because he wasn't sure which serial card he had...
>  
> Turns out that the driver/char/isicom.c driver claimed his board, and then
> tried to register the ttyM0 name, which apparently someone else
> in the kernel did already...
>  
> You have a good point tho, we probably should actually look at /dev/ttyM0
> on his system, and see who is actually claiming it already...

 From the other mail:
 > You need to change this line:
 >
 > isicom_normal->flags                    = TTY_DRIVER_REAL_RAW;
 >
 > To:
 >
 > isicom_normal->flags                    = TTY_DRIVER_REAL_RAW |
 > TTY_DRIVER_DYNAMIC_DEV;
 >
 > In the "drivers/char/isicom.c" file.

This is not a good idea, because the driver doesn't call tty_register_device at 
all. It fixes it, because it doesn't "reserve" the names and you can silently 
register the other driver, that might use it. This is wrong.

We have a few options:
- rewrite them to use TTY_DRIVER_DYNAMIC_DEV (I'm going to do this in isicom anyway)
- rename tty->names (will this something break? udev should cope with this, 
doesn't it?)
- any other solution?

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
