Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161645AbWAMDPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161645AbWAMDPm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161644AbWAMDPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:15:39 -0500
Received: from [203.2.177.25] ([203.2.177.25]:22808 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S1161640AbWAMDPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:15:30 -0500
Subject: Re: [PATCH 2/4 - 2.6.15]net: 32 bit (socket layer) ioctl emulation
	for 64 bit kernels
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Andi Kleen <ak@muc.de>,
       linux-kenel <linux-kernel@vger.kernel.org>,
       x25 maintainer <eis@baty.hanse.de>,
       "David S. Miller" <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>, SP <pereira.shaun@gmail.com>
In-Reply-To: <200601121924.02747.arnd@arndb.de>
References: <1137045732.5221.21.camel@spereira05.tusc.com.au>
	 <200601121924.02747.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 14:14:39 +1100
Message-Id: <1137122079.5589.34.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd
Thank you for reviewing that bit of code.  
I had a look at compat_sys_gettimeofday and sys32_gettimeofday codes.
They seem to work in a similar way, casting a pointer to the structure
from user space to a compat_timeval type.

But to make sure I have tested the routine by forcing the sk-
>sk_stamp.tv_sec value to 0 in the x25_module ( for testing purposes
only, as it is initialised to -1). Now when
I make a 32 bit userspace SIOCGSTAMP ioctl to the 64 bit kernel I should
get the current time back in user space. This seems to work, the ioctl
returns the system time (just after TEST6:)

So I have left the patch as is for now. However if necessary to use
the element-by-element __put_user routine as in put_tv32, then I can
make the change, just let me know.

Lastly, if anyone following this mail can help with adding this into the
next release, that would be really helpful. We are building a network
management application on linux for a telco and while they have 
the support of the SuSE's and Redhat's, any patches accepted by the
kernel community makes a difference, besides saving us from building
custom patches. (BTW, the application used to run on HP-UX, we are now
porting it to linux).

Many Thanks 
Shaun
------------------------------
ghostview:/home/spereira/x25_32/src/func_tests/server # uname -a
Linux ghostview 2.6.15-smp #9 SMP Fri Jan 13 12:43:27 EST 2006 x86_64
x86_64 x86_64 GNU/Linux
ghostview:/home/spereira/x25_32/src/func_tests/server # file server
server: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), for
GNU/Linux 2.2.5, dynamically linked (uses shared libs), not stripped
ghostview:/home/spereira/x25_32/src/func_tests/server # ./server
usage: server <local X.121 address> <interface name>
ghostview:/home/spereira/x25_32/src/func_tests/server # ./server
05052384500000 x25tap0
TEST1: create socket : passed
TEST2: bind socket : passed
TEST3: set subscription: passed
TEST4: set facilities: passed

**************
 Window size in = 2
 Window size out = 2
 Packet size in = 7
 Packet size out = 7
 Reverse flag = 00
 Throughput  = DD
**************
TEST5: set call user data on listen passed
cud[ 0 ] = 02
cud[ 1 ] = 03
TEST6: set matchlength on listen socket handle passed
The time stamp is Fri Jan 13 13:37:17 2006
TEST7: listen on socket: passed
 Waiting for X25 packets
-----------------------------------------------------------





On Thu, 2006-01-12 at 19:24 +0000, Arnd Bergmann wrote:
> On Thursday 12 January 2006 06:02, Shaun Pereira wrote:
> > +int compat_sock_get_timestamp(struct sock *sk, struct timeval __user
> > *userstamp)
> > +{
> > +       struct compat_timeval __user *ctv;
> > +       ctv = (struct compat_timeval __user*) userstamp;
> > +       if(!sock_flag(sk, SOCK_TIMESTAMP))
> > +               sock_enable_timestamp(sk);
> > +       if(sk->sk_stamp.tv_sec == -1)
> > +               return -ENOENT;
> > +       if(sk->sk_stamp.tv_sec == 0)
> > +               do_gettimeofday(&sk->sk_stamp);
> > +       return copy_to_user(ctv, &sk->sk_stamp, sizeof(struct
> > compat_timeval)) ?
> > +                       -EFAULT : 0;
> > +}
> 
> This looks wrong, you're not doing any conversion here.
> You cannot just copy sk_stamp to ctv, they are not compatible.
> See compat_sys_gettimeofday on how to copy a struct timeval
> correctly.
> 
> The other patches look good.
> 
> 	Arnd <><

