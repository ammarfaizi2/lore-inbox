Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270334AbTGWOD4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 10:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270335AbTGWOD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 10:03:56 -0400
Received: from h80ad244e.async.vt.edu ([128.173.36.78]:17539 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270334AbTGWOCx (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 10:02:53 -0400
Message-Id: <200307231417.h6NEHoqj010244@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: jimis@gmx.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Feature proposal (scheduling related) 
In-Reply-To: Your message of "Wed, 23 Jul 2003 13:57:41 +0300."
             <3F1E6A25.5030308@gmx.net> 
From: Valdis.Kletnieks@vt.edu
References: <3F1E6A25.5030308@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-194208322P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 23 Jul 2003 10:17:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-194208322P
Content-Type: text/plain; charset=us-ascii

On Wed, 23 Jul 2003 13:57:41 +0300, jimis@gmx.net  said:
> 1)I 'm connected to the internet via dial-up, therefore I only have 40 kbits of 
> bandwidth available. What I want to do is listen to icecast radio via xmms (at
> 22 kbits), download the kernel sources with wget, and browse the web at the same
> time. Currently I think that this is *impossible* (correct me if I'm wrong) as
> the radio will be full of pauses and the browsing experience painfully slow.

Basically, you're stuck.  The biggest part of the problem is that although you
can certainly control the outbound packets, you have no real control over when
inbound packets arrive at the other end of your dial-up.  One person suggested
using QoS to help things along - but that needs to be implemented at the OTHER
end of the dial-up - which means unless your provider does QoS on the terminal
server, you're basically stuck.  Packets will probably just get queued up in
order of arrival.

And even if the packets do get prioritized so your xmms traffic "goes first",
that's still not going to be perfect, due to a phenomenon canned 'jitter',
which is a measure of how "bursty" the traffic is, and how much *variability*
there is.

Let's say you have xmms going, and a very slow wget.  The last 5 packets of
xmms traffic arrived when the modem was idle, and immediately start coming
across, so the jitter is near zero.  Now a 6th xmms packet arrives - but the
modem is 3 bytes into transmitting a 1500 byte wget packet.  Wham! that packet
gets to wait 300ms for its turn, and you just got 300ms of 'jitter'.  If the
xmms didn't have 300ms of sound already buffered, you're screwed and about to
have a drop-out.  QoS doesn't help here - the best it can do is guarantee that
you only have to wait for the currently transmitting packet and not for any
already-queued packets. (As an aside - TCP windowing will probably guarantee
that any given connection will only have 1 or 2 packets queued up - but if
you're going to run 5 concurrent data-transfer connections, that's still 5-10
packets. If you don't have QoS, any given packet *could* end up with several
seconds of latency here, and the exact order of arrival could make your jitter
anywhere from 0 to several seconds...

You *might* be able to improve the jitter characteristics by dropping the MTU
on the dialup connection from the 1500 byte range down to 576, but this has its
own problems. First, you're going to be sending 3x as many packets, so the
overhead of packet headers is going to triple, cutting into your effective
bandwidth.  Second, there are often issues with windowing, fragmented packets,
and PMTU Discovery when you do this.

> 2) Normally mozilla starts in 5 seconds after intense disk I/O to load all 
> needed libraries. If I run in the background a long disk intense process
> (like find / -name 'whatever' -xdev) loading mozilla could need 20 boring 
> seconds, or doing other simple tasks might be irritating slow. What I would like 
> to be able to do is (once again let's suppose nice has the --disk option to set 
> disk I/O priority):
> $ nice --disk 1 find / -name 'whatever' -xdev
> $ mozilla
> and load mozilla ,which has the default disk priority 0, fast. The scheduler 
> should give to mozilla most disk troughput when it needs it.

Again, here there be serious and nasty dragons.  The problem is that you have
to balance several competing issues:

1) Trying to maintain good overall disk throughput - if you keep pushing
Mozilla's disk requests *right now*, regardless of what the disk is doing, the
disk ends up spending a LOT of time just moving the heads back and forth.  Even
at 5ms a shot, seeks are *expensive*, so you often want to re-order the
requests to minimize the distance travelled.  Think of it as the difference
between planning your trip to the grocery store, the gas station, the post
office, and the bank to make it shortest, as opposed to going back home after
each one because there's something at home that needs doing Right Now...

2) There's a phenomenon called "starvation".  See that 'find' command in your
example?  If mozilla is disk-hungry enough, bad I/O scheduling can mean that
'find' command will sit there *forever*, tying up resources the whole time.
This can cause issues.  For instance - if you've flagged 'mozilla' as the
process that gets first shot at the disk, what do you do if you start paging to
the swap area, and some OTHER process has to read a page in?  What if that
"other process" is the X server or your window manager?  Think REALLY hard here
- just saying "I'll renice them too" is NOT the right answer.. .;)


--==_Exmh_-194208322P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/HpkOcC3lWbTT17ARAs13AKCzT58wqdOHAkDvpmxXgTNqV06KdQCfbHcI
u3NbSxFHbMcd2exJKphNPic=
=1fyJ
-----END PGP SIGNATURE-----

--==_Exmh_-194208322P--
