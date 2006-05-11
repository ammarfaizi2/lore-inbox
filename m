Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751790AbWEKOZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbWEKOZd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 10:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbWEKOZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 10:25:33 -0400
Received: from spirit.analogic.com ([204.178.40.4]:31244 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751790AbWEKOZc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 10:25:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 11 May 2006 14:25:30.0244 (UTC) FILETIME=[C1732440:01C67506]
Content-class: urn:content-classes:message
Subject: Linux poll() <sigh> again
Date: Thu, 11 May 2006 10:25:29 -0400
Message-ID: <Pine.LNX.4.61.0605111023030.3729@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux poll() <sigh> again
Thread-Index: AcZ1BsF66bRH4V0cRFe5Gz0PrVvoWQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

I'm trying to fix a long-standing bug which has a
work-around that has been working for a year or
so.

The bug relates to Linux implementation of poll()
on a connected socket. If poll() is set to detect
changes on a connected socket, with an infinite
timeout (-1), and the client disconnects, it returns
with a positive value (correct). The returned
events (revents member), shows only POLLIN bit
set. This, according to all known documentation
including man pages on the web, is supposed to
mean that there are data to be read. In fact,
there are no data and a read will return 0.

I have used the subsequent read() with a returned
value of zero, to indicate that the client disconnected
(as a work around). However, on recent versions of
Linux, this is not reliable and the read() may
wait forever instead of immediately returning.

So, it's time to fix poll. Will somebody please
have poll return POLLHUP when the client disconnects
a connected socket? I don't need to add any more
work arounds (like setting the socket to non-blocking
so a read will return even if poll() erroneously
reports that data are ready.

Here is relevent code:

             for(;;) {
                 mem->pfd.fd = fd;
                 mem->pfd.events = POLLIN|POLLERR|POLLHUP|POLLNVAL;
                 mem->pfd.revents = 0x00;
                 message("Calling poll\n");
                 if(poll(&mem->pfd, 0x01, -1) != 0x01)
                     break;
                 message("Poll returns okay with %08x\n", mem->pfd.revents);
                 if(mem->pfd.revents & (POLLHUP|POLLERR|POLLNVAL)) {
                     message("Poll says client hung up\n");
                     break;
                 }
                 if(mem->pfd.revents & POLLIN) {
                     message("Poll says data ready\n");
                     if((status = read(fd, mem->buf, BUF_LEN)) <=0 ) {
                         message("but read returns %d\n", status);
                         break;
                     }
                 }
             }
             message("Disconnected\n");

Here is what the code reports:

Script started on Thu 11 May 2006 10:18:34 AM EDT
[root@chaos servers]# ./control
Calling poll
Poll returns okay with 00000001
Poll says data ready
but read returns 0
Disconnected
Aborted via ^C
[root@chaos servers]# exit
Script done on Thu 11 May 2006 10:19:15 AM EDT

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.lymanschool.com
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
