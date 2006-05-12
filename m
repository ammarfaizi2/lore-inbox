Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWELO5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWELO5S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 10:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWELO5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 10:57:17 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:18183 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932109AbWELO5Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 10:57:16 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 12 May 2006 14:57:15.0538 (UTC) FILETIME=[5B81AF20:01C675D4]
Content-class: urn:content-classes:message
Subject: Re: Linux poll() <sigh> again
Date: Fri, 12 May 2006 10:57:15 -0400
Message-ID: <Pine.LNX.4.61.0605121050060.9212@chaos.analogic.com>
In-Reply-To: <44649FAB.4080806@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux poll() <sigh> again
Thread-Index: AcZ11FuNHlkKuOW+SOS1RuyN7lui2Q==
References: <6bkl7-56Y-11@gated-at.bofh.it> <4463D1E4.5070605@shaw.ca> <Pine.LNX.4.61.0605120745050.8670@chaos.analogic.com> <44649C85.5000704@shaw.ca> <44649FAB.4080806@huawei.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "jimmy" <jimmyb@huawei.com>
Cc: "Robert Hancock" <hancockr@shaw.ca>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 May 2006, jimmy wrote:

> Robert Hancock wrote:
>> linux-os (Dick Johnson) wrote:
>>>> POLLHUP means "The device has been disconnected." This would obviously
>>>> be appropriate for a device such as a serial line or TTY, etc. but for a
>>>> socket it is less obvious that this return value is appropriate.
>>>>
>>>
>>> Hardly "less obvious". SunOs has returned POLLHUP as has other
>>> Unixes like Interactive, from which the software was ported. It
>>> went from Interactive, to SunOs, to Linux. Linux was the first
>>> OS that required the hack. This was reported several years ago
>>> and I was simply excoriated for having the audacity to report
>>> such a thing. So, I just implemented a hack. Now the hack is
>>> biting me. It's about time for poll() to return the correct
>>> stuff.
>>
>> The standard doesn't require that a close on a socket should report
>> POLLHUP. Thus this behavior may differ between UNIX implementations. If
>> your software is requiring a POLLHUP to indicate the socket is closed I
>> think it is being unnecessarily picky since read returning 0 universally
>> indicates that the connection has been closed. Such are the compromises
>> that are sometimes required to write portable software.

This is from the Linux man-page shipped with recent distributions


SOCKET(7)                  Linux Programmer‚EUR(tm)s Manual                 SOCKET(7)



        +--------------------------------------------------------------------+
        |                            I/O events                              |
        +-----------+-----------+--------------------------------------------+
        |Event      | Poll flag | Occurrence                                 |
        +-----------+-----------+--------------------------------------------+
        |Read       | POLLIN    | New data arrived.                          |
        +-----------+-----------+--------------------------------------------+
        |Read       | POLLIN    | A connection setup has been completed (for |
        |           |           | connection-oriented sockets)               |
        +-----------+-----------+--------------------------------------------+
        |Read       | POLLHUP   | A disconnection request has been initiated |
        |           |           | by the other end.                          |
        +-----------+-----------+--------------------------------------------+
        |Read       | POLLHUP   | A connection is broken (only  for  connec- |
        |           |           | tion-oriented protocols).  When the socket |
        |           |           | is written SIGPIPE is also sent.           |
        +-----------+-----------+--------------------------------------------+
        |Write      | POLLOUT   | Socket has enough send  buffer  space  for |
        |           |           | writing new data.                          |
        +-----------+-----------+--------------------------------------------+
        |Read/Write | POLLIN|   | An outgoing connect(2) finished.           |
        |           | POLLOUT   |                                            |
        +-----------+-----------+--------------------------------------------+
        |Read/Write | POLLERR   | An asynchronous error occurred.            |
        +-----------+-----------+--------------------------------------------+
        |Read/Write | POLLHUP   | The other end has shut down one direction. |
        +-----------+-----------+--------------------------------------------+
        |Exception  | POLLPRI   | Urgent data arrived.  SIGURG is sent then. |
        +-----------+-----------+--------------------------------------------+


If linux doesn't support POLLHUP, then it shouldn't be documented.
I got the same king of crap^M^M^M^Mresponse the last time I reported
this __very__ __obvious__ defect!  The information is available
in the kernel. It should certainly report it, just like other
operating systems do, including <shudder> wsock32.

>>
>>>
>>>>> I have used the subsequent read() with a returned
>>>>> value of zero, to indicate that the client disconnected
>>>>> (as a work around). However, on recent versions of
>>>>> Linux, this is not reliable and the read() may
>>>>> wait forever instead of immediately returning.
>>>> If you want nonblocking behavior, you should set the socket to
>>>> nonblocking. This is a bit strange though, unless the data was stolen by
>>>> another thread or something. Are you sure you've seen this?
>>>
>>> I don't use threads. The hang under the specified conditions was first
>>> observed on 2.6.16.4 (that I'm running on this system). The hack,
>>> previously
>>> used, i.e., the read of zero was used since 2.4.x with success except
>>> it's
>>> a hack and shouldn't be required. It was not ever required on SunOs from
>>> which the software was ported.
>>
>> This may be a bug somewhere.. however, once again if you don't want read
>> to block under any circumstances, set your sockets to non-blocking!
>>
> But that's another hack. AFAICS why ppl (mostly) use select/poll wud be
> to know if their send/recv/read/write would go thru rather than getting
> blocked!
>

Yes. You need to know if something has changed. This could mean
many things such as new data available or a disconnection. This
is a communications link for crysake, one needs to handle
communications events.

>
> -jb
> --
> Only two things are infinite, the universe and human stupidity, and I'm
> not sure about the former. - Albert Einstein
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.lymanschool.com
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
