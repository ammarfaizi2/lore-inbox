Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131365AbRAOXgu>; Mon, 15 Jan 2001 18:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130510AbRAOXgk>; Mon, 15 Jan 2001 18:36:40 -0500
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:61388 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S131541AbRAOXgJ>; Mon, 15 Jan 2001 18:36:09 -0500
Message-Id: <5.0.2.1.2.20010115152847.00a8a380@pop.we.mediaone.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 15 Jan 2001 15:36:26 -0800
To: linux-kernel@vger.kernel.org
From: Eric Taylor <et@rocketship.com>
Subject: tcp no-ack bug can-rpt, w/script incl (this bugs 4 u)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tcp developers: (Alan Cox: you probably could fix in a minute)

I've been told that this is THE PLACE to contact
linux kernel developers. Ok, I've got a repeatable
bug that I've reported elsewhere to no avail. Hope
this is the place:

Includes 2 perl scripts to reproduce it and info about what
I see not working with tcpdump traces.

(i'm not a subscriber - to reach me use my email address)

thnx
et



from my prior posts:


--------------------
Hi:

I have been trying to figure out
why linux tcp is failing to ack
properly in some situations.

I can easily reproduce this error
using 2 perl scripts. (see below) I
create a socket server in one
script, a client in another, start
sending, suspend the receiver and
wait 4 minutes. The socket will get
disconnected. It should not do
this, it should send an ack with a
window of 0, which it fails to do.
Both the client and the server can
be on the same system to easily see
the error.

To any developer who might be
listening - please help me find and
fix this problem.

Thanks
Eric


---- debugging info follows ------------------



If I run the client from a windows
system, linux behaves properly,
sending acks/window 0, and when I
unsuspend the receiver, all
re-starts up in a few seconds.

When going linux to linux, it fails
almost always. When it does fail, I
see the sender trying to send a
large block (1-2k bytes) and when
no ack comes back the sender goes
into it's retransmit loop waiting
1,2,4... seconds. I also see the
retransmit count going up with:
/proc/net/tcp

When it fails, the last ack sent
back shows a window size of more
than 15000. Here is a sample:

21:48:23.376528   lo > 127.0.0.1.5000 > 127.0.0.1.1052: . 1:1(0) ack 1255213 win 18158 <nop,nop,timestamp 21258536 21258536> (DF)
21:48:23.379304   lo > 127.0.0.1.1052 > 127.0.0.1.5000: P 1255213:1255256(43) ack 1 win 31072 <nop,nop,timestamp 21258536 21258536> (DF)
21:48:23.384049   lo > 127.0.0.1.1052 > 127.0.0.1.5000: P 1255256:1257234(1978) ack 1 win 31072 <nop,nop,timestamp 21258537 21258536

No further acks here. This last
send occurs until the retransmit
count is exhausted. Then the socket
is closed.

Once in a while, it does not fail,
when it works, I see the sender
(tcpdump trace) sending only a 1
byte record. And I see all the acks
with a window getting smaller until
it reaches zero. At that point, the
sender is probing by sending 1 byte
records.

Here is a sample where it does
work:

22:13:34.161580   lo > 127.0.0.1.5000 > 127.0.0.1.1053: . 1:1(0) ack 5444248 win 11616 <nop,nop,timestamp 21409615 21409615> (DF)
22:13:34.161979   lo > 127.0.0.1.5000 > 127.0.0.1.1053: . 1:1(0) ack 5451992 win 7744 <nop,nop,timestamp 21409615 21409615> (DF)
22:13:34.162322   lo > 127.0.0.1.5000 > 127.0.0.1.1053: . 1:1(0) ack 5459736 win 3872 <nop,nop,timestamp 21409615 21409615> (DF)
22:13:34.162553   lo > 127.0.0.1.5000 > 127.0.0.1.1053: . 1:1(0) ack 5463608 win 3872 <nop,nop,timestamp 21409615 21409615> (DF)
22:13:34.179785   lo > 127.0.0.1.5000 > 127.0.0.1.1053: . 1:1(0) ack 5467480 win 0 <nop,nop,timestamp 21409617 21409615> (DF)
22:13:34.379759   lo > 127.0.0.1.1053 > 127.0.0.1.5000: . 5467479:5467479(0) ack 1 win 31072 <nop,nop,timestamp 21409637 21409617> (DF)
22:13:34.379856   lo > 127.0.0.1.5000 > 127.0.0.1.1053: . 1:1(0) ack 5467480 win 0 <nop,nop,timestamp 21409637 21409615> (DF)
22:13:34.779762   lo > 127.0.0.1.1053 > 127.0.0.1.5000: . 5467479:5467479(0) ack 1 win 31072 <nop,nop,timestamp 21409677 21409637> (DF)
22:13:34.779852   lo > 127.0.0.1.5000 > 127.0.0.1.1053: . 1:1(0) ack 5467480 win 0 <nop,nop,timestamp 21409677 21409615> (DF)
22:13:35.579755   lo > 127.0.0.1.1053 > 127.0.0.1.5000: . 5467479:5467479(0) ack 1 win 31072 <nop,nop,timestamp 21409757 21409677> (DF)
22:13:35.579842   lo > 127.0.0.1.5000 > 127.0.0.1.1053: . 1:1(0) ack 5467480 win 0 <nop,nop,timestamp 21409757 21409615> (DF)

server resumed here.

22:18:33.572608   lo > 127.0.0.1.5000 > 127.0.0.1.1053: . 1:1(0) ack 5467480 win 3872 <nop,nop,timestamp 21439556 21409615> (DF)
22:18:33.572714   lo > 127.0.0.1.1053 > 127.0.0.1.5000: P 5467480:5471352(3872) ack 1 win 31072 <nop,nop,timestamp 21439556 21439556> (DF)
22:18:33.572910   lo > 127.0.0.1.5000 > 127.0.0.1.1053: . 1:1(0) ack 5471352 win 3872 <nop,nop,timestamp 21439556 21439556> (DF)
22:18:33.573007   lo > 127.0.0.1.1053 > 127.0.0.1.5000: P 5471352:5475224(3872) ack 1 win 31072 <nop,nop,timestamp 21439556 21439556

------------------------------------------------------



To reproduce: create the 2 perl
files, badclient.pl and
badserver.pl shown below.

>From two terminal windows:

>perl badserver.pl 5000
>perl badclient.pl

You will see for the server (hit control-z):

[1028]$ perl badserver.pl 5000
waiting for connection on port 5000
accept connection from 127.0.0.1, 1052
hello there /badclient.pl/   //   // 1
hello there /badclient.pl/   //   // 1001
hello there /badclient.pl/   //   // 2001
hello there /badclient.pl/   //   // 3001
---type control z ---
[1]+  Stopped                 perl badserver.pl 5000

You will see nothing for the client.

---badclient.pl----

use IO::Socket;

$client = IO::Socket::INET->new("localhost:5000") or die $@;
$a = shift;
$b = shift;
$i=1;
while(1) {
  print $client "hello there /$0/   /$a/   /$b/ $i\n";
  $i++;
}

close($client);


---badserver.pl---



use IO::Socket;
use Socket;
$port = shift or die "usage: perl server port_number\n";

$server = IO::Socket::INET->new(
		LocalPort =>$port,
		Type => SOCK_STREAM,
		Reuse    => 1,
		Listen    => 10,
		)
		or die "cannot create server : $@\n";
print "waiting for connection on port $port\n";			
while ($client = $server->accept()) {
    $other = getpeername($client) or die "cannot get peer $!\n";
    ($port,$iaddr) = unpack_sockaddr_in($other);
    $ip_addr = inet_ntoa($iaddr);
	print "accept connection from $ip_addr, $port\n";
    $i=0;
    while( $_ = <$client> ) {
        if($i%1000 == 0){print $_;}
	$i++;
    }
    print "done with this connection\n";
}			
			
close($server);
								

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
