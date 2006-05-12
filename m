Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWELPGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWELPGf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 11:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWELPGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:06:35 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.25]:49091 "EHLO smtp6.wanadoo.fr")
	by vger.kernel.org with ESMTP id S932116AbWELPGe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:06:34 -0400
X-ME-UUID: 20060512150632450.6DDBE1C0012F@mwinf0612.wanadoo.fr
Message-ID: <4464A46C.50101@cosmosbay.com>
Date: Fri, 12 May 2006 17:06:20 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: jimmy <jimmyb@huawei.com>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux poll() <sigh> again
References: <6bkl7-56Y-11@gated-at.bofh.it> <4463D1E4.5070605@shaw.ca> <Pine.LNX.4.61.0605120745050.8670@chaos.analogic.com> <44649C85.5000704@shaw.ca> <44649FAB.4080806@huawei.com> <Pine.LNX.4.61.0605121050060.9212@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0605121050060.9212@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) a écrit :
> On Fri, 12 May 2006, jimmy wrote:
>
>   
>> Robert Hancock wrote:
>>     
>>> linux-os (Dick Johnson) wrote:
>>>       
>>>>> POLLHUP means "The device has been disconnected." This would obviously
>>>>> be appropriate for a device such as a serial line or TTY, etc. but for a
>>>>> socket it is less obvious that this return value is appropriate.
>>>>>
>>>>>           
>>>> Hardly "less obvious". SunOs has returned POLLHUP as has other
>>>> Unixes like Interactive, from which the software was ported. It
>>>> went from Interactive, to SunOs, to Linux. Linux was the first
>>>> OS that required the hack. This was reported several years ago
>>>> and I was simply excoriated for having the audacity to report
>>>> such a thing. So, I just implemented a hack. Now the hack is
>>>> biting me. It's about time for poll() to return the correct
>>>> stuff.
>>>>         
>>> The standard doesn't require that a close on a socket should report
>>> POLLHUP. Thus this behavior may differ between UNIX implementations. If
>>> your software is requiring a POLLHUP to indicate the socket is closed I
>>> think it is being unnecessarily picky since read returning 0 universally
>>> indicates that the connection has been closed. Such are the compromises
>>> that are sometimes required to write portable software.
>>>       
>
> This is from the Linux man-page shipped with recent distributions
>
>
> SOCKET(7)                  Linux ProgrammerâEUR(tm)s Manual                 SOCKET(7)
>
>
>
>         +--------------------------------------------------------------------+
>         |                            I/O events                              |
>         +-----------+-----------+--------------------------------------------+
>         |Event      | Poll flag | Occurrence                                 |
>         +-----------+-----------+--------------------------------------------+
>         |Read       | POLLIN    | New data arrived.                          |
>         +-----------+-----------+--------------------------------------------+
>         |Read       | POLLIN    | A connection setup has been completed (for |
>         |           |           | connection-oriented sockets)               |
>         +-----------+-----------+--------------------------------------------+
>         |Read       | POLLHUP   | A disconnection request has been initiated |
>         |           |           | by the other end.                          |
>         +-----------+-----------+--------------------------------------------+
>         |Read       | POLLHUP   | A connection is broken (only  for  connec- |
>         |           |           | tion-oriented protocols).  When the socket |
>         |           |           | is written SIGPIPE is also sent.           |
>         +-----------+-----------+--------------------------------------------+
>         |Write      | POLLOUT   | Socket has enough send  buffer  space  for |
>         |           |           | writing new data.                          |
>         +-----------+-----------+--------------------------------------------+
>         |Read/Write | POLLIN|   | An outgoing connect(2) finished.           |
>         |           | POLLOUT   |                                            |
>         +-----------+-----------+--------------------------------------------+
>         |Read/Write | POLLERR   | An asynchronous error occurred.            |
>         +-----------+-----------+--------------------------------------------+
>         |Read/Write | POLLHUP   | The other end has shut down one direction. |
>         +-----------+-----------+--------------------------------------------+
>         |Exception  | POLLPRI   | Urgent data arrived.  SIGURG is sent then. |
>         +-----------+-----------+--------------------------------------------+
>
>
> If linux doesn't support POLLHUP, then it shouldn't be documented.
> I got the same king of crap^M^M^M^Mresponse the last time I reported
> this __very__ __obvious__ defect!  The information is available
> in the kernel. It should certainly report it, just like other
> operating systems do, including <shudder> wsock32.
>   
Hi Dick

On socket disconnection, POLLIN set in poll()->revents and recv() 
returning 0 is the only portable and reliable method.

This is well explained in Stevens book (The absolute reference imho). It 
was writen well before Linus wrote a single line of C code.

If you dont have this book (that would be a shame !!! )

Please refer to 
http://www.opengroup.org/onlinepubs/000095399/functions/poll.html

POLLHUP

    The device has been disconnected. This event and POLLOUT are
    mutually-exclusive; a stream can never be writable if a hangup has
    occurred. However, this event and POLLIN, POLLRDNORM, POLLRDBAND, or
    POLLPRI are not mutually-exclusive. This flag is only valid in the
    /revents/ bitmask; it shall be ignored in the /events/ member.

So you should not set POLLHUP in the  mem->pfd.events member, since 
POLLHUP is non maskable.

Also you might find this interesting : 
http://www.greenend.org.uk/rjk/2001/06/poll.html

More over this comment found in the linux kernel (file net/ipv4/tcp.c) 
is quite good :

        /*
         * POLLHUP is certainly not done right. But poll() doesn't
         * have a notion of HUP in just one direction, and for a
         * socket the read side is more interesting.
         *
         * Some poll() documentation says that POLLHUP is incompatible
         * with the POLLOUT/POLLWR flags, so somebody should check this
         * all. But careful, it tends to be safer to return too many
         * bits than too few, and you can easily break real applications
         * if you don't tell them that something has hung up!
         *
         * Check-me.
         *
         * Check number 1. POLLHUP is _UNMASKABLE_ event (see UNIX98 and
         * our fs/select.c). It means that after we received EOF,
         * poll always returns immediately, making impossible poll() on 
write()
         * in state CLOSE_WAIT. One solution is evident --- to set POLLHUP
         * if and only if shutdown has been made in both directions.
         * Actually, it is interesting to look how Solaris and DUX
         * solve this dilemma. I would prefer, if PULLHUP were maskable,
         * then we could set it on SND_SHUTDOWN. BTW examples given
         * in Stevens' books assume exactly this behaviour, it explains
         * why PULLHUP is incompatible with POLLOUT.    --ANK
         *
         * NOTE. Check for TCP_CLOSE is added. The goal is to prevent
         * blocking on fresh not-connected or disconnected socket. --ANK
         */
        if (sk->sk_shutdown == SHUTDOWN_MASK || sk->sk_state == TCP_CLOSE)
                mask |= POLLHUP;


So basically a POLLHUP could be stick in revent if POLLOUT was not given 
in event, but it would be of litle interest...

Eric



