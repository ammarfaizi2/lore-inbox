Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132547AbRDKKRT>; Wed, 11 Apr 2001 06:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132548AbRDKKRK>; Wed, 11 Apr 2001 06:17:10 -0400
Received: from elf.ihep.su ([194.190.161.106]:25873 "EHLO elf.ihep.su")
	by vger.kernel.org with ESMTP id <S132547AbRDKKQw>;
	Wed, 11 Apr 2001 06:16:52 -0400
Date: Wed, 11 Apr 2001 14:16:45 +0400
From: "Eugene B. Berdnikov" <berd@elf.ihep.su>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org, Dave Miller <davem@redhat.com>
Subject: Re: Bug report: tcp staled when send-q != 0, timers == 0.
Message-ID: <20010411141645.B12573@elf.ihep.su>
In-Reply-To: <20010409184338.B1396@elf.ihep.su> <200104101738.VAA21467@ms2.inr.ac.ru> <20010411011901.A2029@fay.elferno.lo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <20010411011901.A2029@fay.elferno.lo>; from Eugene B. Berdnikov on Wed, Apr 11, 2001 at 01:19:01AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello.

 I'd like to make additional comments to my previous message.

On Wed, Apr 11, 2001 at 01:19:01AM +0400, Eugene B. Berdnikov wrote:
>  The thing is that one machine (which run ssh client in my bug report)
>  do send ACKs when ssh is SIGSTOP'ed. The other one does not send ACKs,
>  but much more curious is that it does not send ACKs even when input
>  buffer is filled, and client IS NOT stopped! :))) Hence connection dies
>  due to retransmission timeout on the server side.
[...]
>  Both hosts are running 2.2.17 on K6 processors, compiled via egcs-1.1.2,
>  with minor differences in the kernel configuration.

 My observation of the "buggy" 2.2.17 was on the host, connected via
 modem and running ppp-2.4.0b2 with MTU=256. Today I got this kernel and
 modules, and run it on another machine with Cel-450 and 3c590B-TX
 ethernet card.  It also exhibits loss of ACKs. My study shows, that
 it depends upon MTU and keepalive flags:

   mtu 382 + keepalive yes -> loss
   mtu 382 + keepalive no  -> ok
   mtu 383 + any keepalive -> ok

 I tested several values of MTU over and below 382, and it seems me that
 value 382 is a boundary between normal and error behaviour.

 Then I have tested kernel 2.2.14-5.0 from the RedHat-6.2 distribution on
 the same machine (Cel-450 + 3c59x driver). It also shows loss of ACKs,
 but with another MTU boundary and independently of keepalive:

   mtu <= 420 + any keepalive  -> loss
   mtu >= 421 + any keepalive  -> ok

 At last, I tried several MTUs on 3d computer, running "right" 2.2.17, and
 could not find conditions, under which any loss of ACKs can be detected.

 So, the conclusion is that this loss depends upon kernel version,
 configuration options and MTU on the interface. I suspect this is
 another bug, accationaly found in discussion. :)

 I complete my statements with the illustration dump. Commands were like

 ifconfig ppp0 mtu 256
 ssh -o 'keepalive yes' 194.190.166.31 \
	'while true ; do cat /etc/passwd ; done' 2>&1 | less
 tcpdump -nl host 194.190.166.31

 [...]

 10:20:11.196983 > 172.16.42.57.1023 > 194.190.166.31.ssh: . 655:655(0) ack 30120 win 15708 <nop,nop,timestamp 8830012 121274899> (DF) [tos 0x10] 
 10:20:11.266845 < 194.190.166.31.ssh > 172.16.42.57.1023: P 30120:30324(204) ack 655 win 32616 <nop,nop,timestamp 121274900 8829912> (DF) [tos 0x10] 
 10:20:11.356837 < 194.190.166.31.ssh > 172.16.42.57.1023: P 30324:30528(204) ack 655 win 32616 <nop,nop,timestamp 121274900 8829912> (DF) [tos 0x10] 
 10:20:11.426832 < 194.190.166.31.ssh > 172.16.42.57.1023: P 30528:30732(204) ack 655 win 32616 <nop,nop,timestamp 121274902 8829919> (DF) [tos 0x10] 
 10:20:11.476844 < 194.190.166.31.ssh > 172.16.42.57.1023: P 30732:30936(204) ack 655 win 32616 <nop,nop,timestamp 121274902 8829919> (DF) [tos 0x10] 
 10:20:11.546843 < 194.190.166.31.ssh > 172.16.42.57.1023: P 30936:31140(204) ack 655 win 32616 <nop,nop,timestamp 121274962 8829928> (DF) [tos 0x10] 
 10:20:11.636840 < 194.190.166.31.ssh > 172.16.42.57.1023: P 31140:31344(204) ack 655 win 32616 <nop,nop,timestamp 121274962 8829928> (DF) [tos 0x10] 
 10:20:11.706843 < 194.190.166.31.ssh > 172.16.42.57.1023: P 31344:31548(204) ack 655 win 32616 <nop,nop,timestamp 121274963 8829935> (DF) [tos 0x10] 
 10:20:11.766854 < 194.190.166.31.ssh > 172.16.42.57.1023: P 31548:31752(204) ack 655 win 32616 <nop,nop,timestamp 121274963 8829935> (DF) [tos 0x10] 
 10:20:11.866832 < 194.190.166.31.ssh > 172.16.42.57.1023: P 31752:31956(204) ack 655 win 32616 <nop,nop,timestamp 121274964 8829939> (DF) [tos 0x10] 
 10:20:11.926839 < 194.190.166.31.ssh > 172.16.42.57.1023: P 31956:32160(204) ack 655 win 32616 <nop,nop,timestamp 121274964 8829939> (DF) [tos 0x10] 
 10:20:11.996837 < 194.190.166.31.ssh > 172.16.42.57.1023: P 32160:32364(204) ack 655 win 32616 <nop,nop,timestamp 121274984 8829949> (DF) [tos 0x10] 
 10:20:12.066835 < 194.190.166.31.ssh > 172.16.42.57.1023: P 32364:32568(204) ack 655 win 32616 <nop,nop,timestamp 121274984 8829949> (DF) [tos 0x10] 
 10:20:12.126850 < 194.190.166.31.ssh > 172.16.42.57.1023: P 32568:32772(204) ack 655 win 32616 <nop,nop,timestamp 121274985 8829956> (DF) [tos 0x10] 
 10:20:12.216832 < 194.190.166.31.ssh > 172.16.42.57.1023: P 32772:32976(204) ack 655 win 32616 <nop,nop,timestamp 121274985 8829956> (DF) [tos 0x10] 
 10:20:12.286854 < 194.190.166.31.ssh > 172.16.42.57.1023: P 32976:33180(204) ack 655 win 32616 <nop,nop,timestamp 121274986 8829962> (DF) [tos 0x10] 
 10:20:12.356846 < 194.190.166.31.ssh > 172.16.42.57.1023: P 33180:33384(204) ack 655 win 32616 <nop,nop,timestamp 121274986 8829962> (DF) [tos 0x10] 
 10:20:12.426838 < 194.190.166.31.ssh > 172.16.42.57.1023: P 33384:33588(204) ack 655 win 32616 <nop,nop,timestamp 121275007 8829969> (DF) [tos 0x10] 
 10:20:12.516835 < 194.190.166.31.ssh > 172.16.42.57.1023: P 33588:33792(204) ack 655 win 32616 <nop,nop,timestamp 121275007 8829969> (DF) [tos 0x10] 
 10:20:12.576830 < 194.190.166.31.ssh > 172.16.42.57.1023: P 33792:33996(204) ack 655 win 32616 <nop,nop,timestamp 121275008 8829976> (DF) [tos 0x10] 
 10:20:12.646843 < 194.190.166.31.ssh > 172.16.42.57.1023: P 33996:34200(204) ack 655 win 32616 <nop,nop,timestamp 121275008 8829976> (DF) [tos 0x10] 
 10:20:12.706842 < 194.190.166.31.ssh > 172.16.42.57.1023: P 34200:34404(204) ack 655 win 32616 <nop,nop,timestamp 121275009 8829982> (DF) [tos 0x10] 
 10:20:12.776850 < 194.190.166.31.ssh > 172.16.42.57.1023: P 34404:34608(204) ack 655 win 32616 <nop,nop,timestamp 121275009 8829982> (DF) [tos 0x10] 
 10:20:12.846842 < 194.190.166.31.ssh > 172.16.42.57.1023: P 34608:34812(204) ack 655 win 32616 <nop,nop,timestamp 121275029 8829990> (DF) [tos 0x10] 
 10:20:12.936834 < 194.190.166.31.ssh > 172.16.42.57.1023: P 34812:35016(204) ack 655 win 32616 <nop,nop,timestamp 121275030 8829999> (DF) [tos 0x10] 
 10:20:13.006840 < 194.190.166.31.ssh > 172.16.42.57.1023: P 35016:35220(204) ack 655 win 32616 <nop,nop,timestamp 121275031 8830006> (DF) [tos 0x10] 
 10:20:13.046850 < 194.190.166.31.ssh > 172.16.42.57.1023: P 35220:35424(204) ack 655 win 32616 <nop,nop,timestamp 121275032 8830012> (DF) [tos 0x10] 
 10:20:21.376855 < 194.190.166.31.ssh > 172.16.42.57.1023: P 30120:30324(204) ack 655 win 32616 <nop,nop,timestamp 121275972 8830012> (DF) [tos 0x10] 

 And from here 194.190.166.31 retransmits until timeout:

 10:20:40.146846 < 194.190.166.31.ssh > 172.16.42.57.1023: P 30120:30324(204) ack 655 win 32616 <nop,nop,timestamp 121277852 8830012> (DF) [tos 0x10] 
 10:21:17.746854 < 194.190.166.31.ssh > 172.16.42.57.1023: P 30120:30324(204) ack 655 win 32616 <nop,nop,timestamp 121281612 8830012> (DF) [tos 0x10] 
 10:22:32.956845 < 194.190.166.31.ssh > 172.16.42.57.1023: P 30120:30324(204) ack 655 win 32616 <nop,nop,timestamp 121289132 8830012> (DF) [tos 0x10] 
 10:24:32.966837 < 194.190.166.31.ssh > 172.16.42.57.1023: P 30120:30324(204) ack 655 win 32616 <nop,nop,timestamp 121301132 8830012> (DF) [tos 0x10] 
 10:26:32.986843 < 194.190.166.31.ssh > 172.16.42.57.1023: P 30120:30324(204) ack 655 win 32616 <nop,nop,timestamp 121313132 8830012> (DF) [tos 0x10] 
 10:28:32.966854 < 194.190.166.31.ssh > 172.16.42.57.1023: P 30120:30324(204) ack 655 win 32616 <nop,nop,timestamp 121325132 8830012> (DF) [tos 0x10] 
-- 
 Eugene Berdnikov
