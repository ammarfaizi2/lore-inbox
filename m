Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268082AbUILSAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268082AbUILSAQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 14:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268237AbUILSAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 14:00:15 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:26892 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S268082AbUILSAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 14:00:00 -0400
Date: Sun, 12 Sep 2004 19:59:46 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Wolfpaw - Dale Corse <admin@wolfpaw.net>
Cc: peter@mysql.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial of Service Attack
Message-ID: <20040912175946.GA3491@alpha.home.local>
References: <029201c498d8$dff156f0$0300a8c0@s> <001c01c498df$8d2cd0f0$0200a8c0@wolf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001c01c498df$8d2cd0f0$0200a8c0@wolf>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dale,

I've tried your code right here.
The "attacker" was 10.0.3.1, and the victim 10.0.3.2.

I could successfully generate 1 CLOSE_WAIT on the victim with your program.
It was on port 23 and attached to inetd as fd #3. So I killed inetd, the
connection was then freed, and restarted it.

I changed the code slightly to be able to pass IP/ports as arguments.
On the victim, I straced inetd (pid 1013), and captured all TCP traffic
on port 23.

attacker> ./tcpnclose2 10.0.3.2 22 10.0.3.2 23

I stopped it when it was shouting at me :
socket failed.Connecting to 10.0.3.2:22 (FD: -1)...  FAILED: UNKNOWN ERROR.
socket failed.Connecting to 10.0.3.2:23 (FD: -1)...  FAILED: UNKNOWN ERROR.

Then, on the victim :

victim> sudo netstat -atnp|grep -v LISTEN
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name   
tcp        1      0 10.0.3.2:23             10.0.3.1:34058          CLOSE_WAIT  1013/inetd          

victim> tcpdump -Svnr capture-victim.cap tcp port 34058
reading from file capture-victim.cap, link-type EN10MB (Ethernet)
19:05:10.360728 IP (tos 0x0, ttl  64, id 8168, offset 0, flags [DF], length: 48) 10.0.3.1.34058 > 10.0.3.2.23: S [tcp sum ok] 2882867180:2882867180(0) win 15920 <mss 7960,nop,nop,sackOK>
19:05:10.360764 IP (tos 0x0, ttl  64, id 0, offset 0, flags [DF], length: 48) 10.0.3.2.23 > 10.0.3.1.34058: S [tcp sum ok] 2614211278:2614211278(0) ack 2882867181 win 5840 <mss 1460,nop,nop,sackOK>
19:05:10.360863 IP (tos 0x0, ttl  64, id 8169, offset 0, flags [DF], length: 40) 10.0.3.1.34058 > 10.0.3.2.23: . [tcp sum ok] ack 2614211279 win 15920
19:06:17.668670 IP (tos 0x0, ttl  64, id 8170, offset 0, flags [DF], length: 40) 10.0.3.1.34058 > 10.0.3.2.23: F [tcp sum ok] 2882867181:2882867181(0) ack 2614211279 win 15920
19:06:17.671102 IP (tos 0x0, ttl  64, id 11127, offset 0, flags [DF], length: 40) 10.0.3.2.23 > 10.0.3.1.34058: . [tcp sum ok] ack 2882867182 win 5840

==> We see that the victim (10.0.3.2) did not send the FIN in return.

Now let's take a closer look at inetd :

victim> cat /proc/net/tcp 
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
  16: 0203000A:0017 0103000A:850A 08 00000000:00000001 00:00000000 00000000     0        0 6420 1 d5dac400 1500 20 0 2 -1                            

==> The socket (state 8 = CLOSE_WAIT) is bound to inode 6420.

victim> sudo ls -l /proc/1013/fd/|grep 6420
lrwx------    1 root     root           64 Sep 12 19:28 3 -> socket:[6420]

==> Again, it's FD #3.

I restarted strace on inetd, and noticed that fd#3 was not in the select fd
list anymore (remember one of the two cases I spoke about a few hours ago ?) :
victim> strace -p 1013
select(22, [4 5 6 7 8 9 11 12 13 14 15 16 17 18 19 20 21], NULL, NULL, NULL <unfinished ...>

Then, I took a look at the strace capture (184 MB !), to which I inserted line
numbers for better readability :

1:1013  accept(10, 0, NULL)               = 3
2:1013  fcntl64(10, F_SETFL, O_RDONLY)    = 0
3:1013  rt_sigprocmask(SIG_BLOCK, [HUP ALRM CHLD], NULL, 8) = 0
4:1013  fork()                            = 1108
5:1013  rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
6:1013  close(3)                          = 0

This was the last but one connection assigned to fd #3. As you see, it's
finally closed. But a few lines later :

7:1013  select(22, [4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21], NULL, NULL, NULL) = 1 (in [10])
8:1013  fcntl64(10, F_SETFL, O_RDONLY|O_NONBLOCK) = 0
9:1013  accept(10, 0, NULL)               = 3
10:1013  fcntl64(10, F_SETFL, O_RDONLY)    = 0
11:1013  rt_sigprocmask(SIG_BLOCK, [HUP ALRM CHLD], NULL, 8) = 0
12:1013  gettimeofday({1095008773, 685550}, NULL) = 0

The FD gets re-used, but is never scanned anymore, so never closed either :

35:1013  select(22, [4 5 6 7 8 9 11 12 13 14 15 16 17 18 19 20 21], NULL, NULL, NULL <unfinished ...>

Conclusion :
============

The problem is within inetd. In my case it could be because it was a bit
old (1999), but since you have it too, it might indicate an old bug. The
fact that it affects mysql too does not prove that the problem is in the
kernel, and I suspect that for whatever reason, there are some race
conditions in these two programs if the connection is either reused or
closed very quickly.

To demonstrate this, I've run your program against my reverse-proxy,
haproxy, which I fortunately happen to know better than these other
programs. I could not manage to get even a CLOSE_WAIT session after
several attempts.  All connections are closed normally, and as you'll
see with this extract from strace, the polled file-descriptors are
active once you kill the attacker :

(...)
close(593)                              = 0
select(684, [3 5 603 604 605 606 607 608 609 610 611 612 613 614 615 616 617
618 619 620 621 622 623 624 625 626 627 628 629 630 631 632 633 634 635 636
637 638 639 640 641 642 643 644 645 646 647 648 649 650 651 652 653 654 655
656 657 658 659 660 661 662 663 664 665 666 667 668 669 670 671 672 673 674
675 676 677 678 679 680 681 682 683], NULL, NULL, {4, 835000}) = 81 (in [603
604 605 606 607 608 609 610 611 612 613 614 615 616 617 618 619 620 621 622
623 624 625 626 627 628 629 630 631 632 633 634 635 636 637 638 639 640 641
642 643 644 645 646 647 648 649 650 651 652 653 654 655 656 657 658 659 660
661 662 663 664 665 666 667 668 669 670 671 672 673 674 675 676 677 678 679
680 681 682 683], left {4, 836000})
gettimeofday({1095011266, 506966}, NULL) = 0
recv(603, "", 4096, 0x4000)             = 0
recv(604, "", 4096, 0x4000)             = 0
recv(605, "", 4096, 0x4000)             = 0
(...)
close(605)                              = 0
close(604)                              = 0
close(603)                              = 0
select(6, [3 5], NULL, NULL, NULL <unfinished ...>

So I believe you'll have to dig into some programs because at least you found
a vulnerability in both inetd and mysql :-)

Regards,
Willy

