Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271033AbTHLSH0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 14:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271038AbTHLSH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 14:07:26 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:34791 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S271033AbTHLSHW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 14:07:22 -0400
Message-ID: <3F392CD5.3080400@free.fr>
Date: Tue, 12 Aug 2003 20:07:17 +0200
From: Florent Coste <coste.florent@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: fr
MIME-Version: 1.0
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re 2.6.0-test2-mm4 (pppd problem)
References: <3F2F0ED0.4060707@free.fr>	<20030804225737.007b6934.akpm@osdl.org>	<3F317097.4070401@free.fr> <20030806143251.6b84c749.akpm@osdl.org> <3F334304.9070502@free.fr>
In-Reply-To: <3F334304.9070502@free.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>
>> Florent Coste <coste.florent@free.fr> wrote:
>>  
>>
>>> - test2-mm2 :  pppd starts ok (i use & follow 2.5.x & 2.6-test 
>>> branch since ~2.5.40 .... 2.5.72-mm2 was ok for instance)
>>> - test2-mm3-1 : pppd does not start, kobject badness trace, full 
>>> traces in my last email and parts above :
>>>   
>>
>>
>> The `badness' thing is just telling us that netdevices aren't fully 
>> up to
>> speed with the kobject layer yet.  Don't worry about that.
>>
>> As for the ppp problem: don't know, sorry.  There was a small change 
>> in ppp
>> between those two kernel versions, so it would be useful if you could 
>> do a
>> `patch -R' of the below, see if that fixes mm3-1.  Thanks.
>
Andrew,

Sorry for the late reply :

I made the patch -R of ppp stuf against mm3-1 : same result as with the 
patch.

I thought making a  strace -f pppd of both a working kernel (test2-mm2) 
and the first non working
(test2-mm3-1) can be usefull, strace result files are available at 
http://coste.florent.free.fr

(pid of mm3 have been changed to match the ones of mm2 so that the diff 
is easy to read).

I also made the same test with test2-mm4 : same result as mm3-1. I'll 
test 2.6.0-test3(-mm1)  soon

Great Regards,

Florent

>>
>> diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
>> --- a/drivers/char/tty_io.c    Wed Aug  6 14:30:49 2003
>> +++ b/drivers/char/tty_io.c    Wed Aug  6 14:30:49 2003
>> @@ -611,6 +611,8 @@
>>         (tty->driver->stop)(tty);
>> }
>>
>> +EXPORT_SYMBOL(stop_tty);
>> +
>> void start_tty(struct tty_struct *tty)
>> {
>>     if (!tty->stopped || tty->flow_stopped)
>> @@ -628,6 +630,8 @@
>>         (tty->ldisc.write_wakeup)(tty);
>>     wake_up_interruptible(&tty->write_wait);
>> }
>> +
>> +EXPORT_SYMBOL(start_tty);
>>
>> static ssize_t tty_read(struct file * file, char * buf, size_t count, 
>>             loff_t *ppos)
>> diff -Nru a/drivers/net/ppp_async.c b/drivers/net/ppp_async.c
>> --- a/drivers/net/ppp_async.c    Wed Aug  6 14:30:49 2003
>> +++ b/drivers/net/ppp_async.c    Wed Aug  6 14:30:49 2003
>> @@ -891,6 +891,11 @@
>>             process_input_packet(ap);
>>         } else if (c == PPP_ESCAPE) {
>>             ap->state |= SC_ESCAPE;
>> +        } else if (I_IXON(ap->tty)) {
>> +            if (c == START_CHAR(ap->tty))
>> +                start_tty(ap->tty);
>> +            else if (c == STOP_CHAR(ap->tty))
>> +                stop_tty(ap->tty);
>>         }
>>         /* otherwise it's a char in the recv ACCM */
>>         ++n;
>>
>>
>>
>>  
>>
>
>
>
>


