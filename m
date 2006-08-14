Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWHNLa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWHNLa0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 07:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbWHNLaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 07:30:25 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:64782 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751146AbWHNLaY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 07:30:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 14 Aug 2006 11:30:21.0948 (UTC) FILETIME=[0742ABC0:01C6BF95]
Content-class: urn:content-classes:message
Subject: Re: Network compatibility and performance
Date: Mon, 14 Aug 2006 07:30:16 -0400
Message-ID: <Pine.LNX.4.61.0608140714170.20677@chaos.analogic.com>
In-Reply-To: <44DE2A44.5070006@candelatech.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Network compatibility and performance
thread-index: Aca/lQdJfivbCpj2QUO5WQ21/vE5zQ==
References: <Pine.LNX.4.61.0608101131530.4239@chaos.analogic.com> <44DE2A44.5070006@candelatech.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ben Greear" <greearb@candelatech.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 12 Aug 2006, Ben Greear wrote:

> linux-os (Dick Johnson) wrote:
>> Hello,
>>
>> Network throughput is seriously defective with linux-2.6.16.24
>> if the length given to 'write()' is a large number.
>>
>> Given this code on a connected socket........
>>
>> //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
>> //
>> //  Copyright(c)  2005  Analogic Corporation    (rjohnson@analogic.com)
>> //
>> //  This program may be distributed under the GNU Public License
>> //  version 2, as published by the Free Software Foundation, Inc.,
>> //  59 Temple Place, Suite 330 Boston, MA, 02111.
>> //
>> //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
>>
>> #include <stdio.h>
>> #include <unistd.h>
>> #include <stdlib.h>
>> #include <stdint.h>
>> #include <signal.h>
>> #include <string.h>
>> #include <stdarg.h>
>> #include <errno.h>
>> #include <fcntl.h>
>> #include <netinet/in.h>
>> #include <netinet/tcp.h>
>> #include <sys/poll.h>
>>
>> #define BUF_LEN 0x1000
>> #define FAIL -1
>>
>> //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
>> //
>> //   This sends a message that could exceed the size of the network buffers.
>> //   It returns 0 if everything went okay, and FAIL if not.
>> //
>> int32_t sender(int32_t fd, void *buf, size_t len)
>> {
>>      int32_t ret_val;
>>      uint8_t *cp;
>>      cp = (uint8_t *) buf;
>>      while(len) {
>>          if((ret_val = write(fd, cp, MIN(len, BUF_LEN))) == FAIL) {
>>              if(errno == EAGAIN)
>>                  continue;
>>              return ret_val;
>>          }
>>          len -= ret_val;
>>          cp  += ret_val;
>>      }
>>      return 0;
>> }
>>
>> It used to work quite well with:
>>
>>      while(len) {
>>          if((ret_val = write(fd, cp, len)) == FAIL) {
>>                  return ret_val;
>>          }
>>          len -= ret_val;
>>          cp  += ret_val;
>>      }
>>
>> The network socket layer would return the amount of bytes
>> actually sent and the code would walk its way up through the
>> buffer. This was the expected behavior for many years.
>>
>> Then after about Linux-2.6.8, I needed to do:
>>
>>      while(len) {
>>          if((ret_val = write(fd, cp, len)) == FAIL) {
>>              if(errno == EAGAIN)
>>                  continue;
>>              return ret_val;
>>          }
>>          len -= ret_val;
>>          cp  += ret_val;
>>      }
>>
>> This was because Linux would claim to run out of resources
>> even though there was nothing else running on the system.
>>
>> Now at Linux-2.6.16.24, the code needed to be further modified
>> to:
>>      while(len) {
>>          if((ret_val = write(fd, cp, MIN(len, 0x1000))) == FAIL) {
>>              if(errno == EAGAIN)
>>                  continue;
>>              return ret_val;
>>          }
>>          len -= ret_val;
>>          cp  += ret_val;
>>      }
>
> In the case where you are getting EAGAIN, this is a busy-spin.  You
> might want to sleep in a select() or similar call as soon as you get
> EAGAIN on this socket..or go off and do other work while the OS clears
> out the send queue.
>
> Also, from your description, this code should return 0 on success.  It
> is returning 'ret_val' instead, which should be > 0.

No it will return FAIL (-1) or an error and 0 (the bottom of the procedure)
if the whole things went. It is mandatory that the whole thing goes
so this procedure should handle any intermediate actions.

Upon your advice, I may try to add select() although, on a write it
seems to be putting in user-space something that used to be handled
quite well in the kernel. I don't think the user should really care
about the kernel internals, whether or not the kernel happens to have
a buffer available.

>
> I have no idea why you need to add the MIN() logic..and that seems like
> something that should not be required.
>

It seems that some code 'thinks' that a large buffer of data is
an error and won't even try to send some anymore.


>> ... or else it would spin <forever> returning 0 with no errno set.
>> In all cases, these problems exist when 'len' is a large value, perhaps
>> 0x01000000, much greater than Linux could ever find an available
>> buffer for. Linux used to send what it could. Now it will just fail to
>> send anything at all, returning 0 if it 'feels' like it doesn't want
>> to bother. This is not good. With the hacked code, the data throughput
>> is about 100,000 bytes per second on a dedicated link. The previous
>> code ran 112,000 bytes per second. Once the 'errno' happens, the
>> network stumbles to a measley 12,000 bytes per second. This
>> breaks our applications.
>
> Even 112kbps sucks on a decent network.  What is the speed of your
> network, what protocol are you using, if tcp, what is the latency
> of your network?
>

The network is a single wire about 8 feet long, connecting Intel gigibit
links on two identical computers (crossover cable). This link is TCP.
For high-speed data, I use UDP and I get a higher throughput because
there is no handshake. Thew latency is the latency of Linux. BTW, it's
only a gigaBIT link, you can divide that by 8 for gigabytes. I don't
know the actual bit-rate on the wires, if we assume 1GHz, the byte-rate
is only 125,000 bytes per second. Being able to use 89.6 percent of
that isn't bad at all.


> Ben
>
>
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
