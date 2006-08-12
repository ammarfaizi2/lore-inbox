Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422648AbWHLTeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422648AbWHLTeN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 15:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422649AbWHLTeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 15:34:13 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:13731 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1422648AbWHLTeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 15:34:12 -0400
Message-ID: <44DE2A44.5070006@candelatech.com>
Date: Sat, 12 Aug 2006 12:21:40 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Network compatibility and performance
References: <Pine.LNX.4.61.0608101131530.4239@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0608101131530.4239@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> Hello,
> 
> Network throughput is seriously defective with linux-2.6.16.24
> if the length given to 'write()' is a large number.
> 
> Given this code on a connected socket........
> 
> //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
> //
> //  Copyright(c)  2005  Analogic Corporation    (rjohnson@analogic.com)
> //
> //  This program may be distributed under the GNU Public License
> //  version 2, as published by the Free Software Foundation, Inc.,
> //  59 Temple Place, Suite 330 Boston, MA, 02111.
> //
> //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
> 
> #include <stdio.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <stdint.h>
> #include <signal.h>
> #include <string.h>
> #include <stdarg.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <netinet/in.h>
> #include <netinet/tcp.h>
> #include <sys/poll.h>
> 
> #define BUF_LEN 0x1000
> #define FAIL -1
> 
> //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> //
> //   This sends a message that could exceed the size of the network buffers.
> //   It returns 0 if everything went okay, and FAIL if not.
> //
> int32_t sender(int32_t fd, void *buf, size_t len)
> {
>      int32_t ret_val;
>      uint8_t *cp;
>      cp = (uint8_t *) buf;
>      while(len) {
>          if((ret_val = write(fd, cp, MIN(len, BUF_LEN))) == FAIL) {
>              if(errno == EAGAIN)
>                  continue;
>              return ret_val;
>          }
>          len -= ret_val;
>          cp  += ret_val;
>      }
>      return 0;
> }
> 
> It used to work quite well with:
> 
>      while(len) {
>          if((ret_val = write(fd, cp, len)) == FAIL) {
>                  return ret_val;
>          }
>          len -= ret_val;
>          cp  += ret_val;
>      }
> 
> The network socket layer would return the amount of bytes
> actually sent and the code would walk its way up through the
> buffer. This was the expected behavior for many years.
> 
> Then after about Linux-2.6.8, I needed to do:
> 
>      while(len) {
>          if((ret_val = write(fd, cp, len)) == FAIL) {
>              if(errno == EAGAIN)
>                  continue;
>              return ret_val;
>          }
>          len -= ret_val;
>          cp  += ret_val;
>      }
> 
> This was because Linux would claim to run out of resources
> even though there was nothing else running on the system.
> 
> Now at Linux-2.6.16.24, the code needed to be further modified
> to:
>      while(len) {
>          if((ret_val = write(fd, cp, MIN(len, 0x1000))) == FAIL) {
>              if(errno == EAGAIN)
>                  continue;
>              return ret_val;
>          }
>          len -= ret_val;
>          cp  += ret_val;
>      }

In the case where you are getting EAGAIN, this is a busy-spin.  You 
might want to sleep in a select() or similar call as soon as you get
EAGAIN on this socket..or go off and do other work while the OS clears
out the send queue.

Also, from your description, this code should return 0 on success.  It
is returning 'ret_val' instead, which should be > 0.

I have no idea why you need to add the MIN() logic..and that seems like 
something that should not be required.

> ... or else it would spin <forever> returning 0 with no errno set.
> In all cases, these problems exist when 'len' is a large value, perhaps
> 0x01000000, much greater than Linux could ever find an available
> buffer for. Linux used to send what it could. Now it will just fail to
> send anything at all, returning 0 if it 'feels' like it doesn't want
> to bother. This is not good. With the hacked code, the data throughput
> is about 100,000 bytes per second on a dedicated link. The previous
> code ran 112,000 bytes per second. Once the 'errno' happens, the
> network stumbles to a measley 12,000 bytes per second. This
> breaks our applications.

Even 112kbps sucks on a decent network.  What is the speed of your 
network, what protocol are you using, if tcp, what is the latency
of your network?

Ben


