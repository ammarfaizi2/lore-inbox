Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287866AbSABQ2t>; Wed, 2 Jan 2002 11:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287868AbSABQ2h>; Wed, 2 Jan 2002 11:28:37 -0500
Received: from ep09.kernel.pl ([212.160.181.1]:6664 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S287866AbSABQ2R>;
	Wed, 2 Jan 2002 11:28:17 -0500
Date: Wed, 2 Jan 2002 17:28:06 +0100
From: Michal Moskal <malekith@pld.org.pl>
To: linux-kernel@vger.kernel.org
Subject: strange TCP stack behiviour with write()es in pieces
Message-ID: <20020102162806.GA29399@ep09.kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found something intresting (at least to me ;) in Linux TCP stack.
I don't know if it should be regarded a bug or not, or if it's known.
Anyway, this email is not meant to start flame of any kind (test results
are flamable material... ;)

So, it occurs in programs doing packet communication over TCP, when
peer waits for a packet to send an answer. If they send data with two
write() calls (for example to write packet header and packet data),
the performance dramaticly decrases (down to exactly 100 (2.2.19)
or 25 (2.4.[57]) packet exchanges per second on x86, from several
thousands. 100 seems to be related to HZ variable, see also AXP results,
where HZ is 10 times bigger).

Maybe example of code will tell more:

	struct header {
		int cmd;
		int len;
	};
	
	void send_packet(int cmd, void *data, int len)
	{
		struct header h = { cmd, len };

		write(fd, &h, sizeof(h));
		write(fd, data, len);
	}

is, let's say, 300 times slower then:

	void send_packet(int cmd, void *data, int len)
	{
		struct header h = { cmd, len };
		char tmp[BUFSIZE];

		memcpy(tmp, &h, sizeof(h));
		memcpy(tmp + sizeof(h), data, len);
		write(fd, tmp, len + sizeof(h));
	}

when running over loopback. Similar effects can be seen when running over
ethernet (the condition is, that next packet is requested only after
first one is recived).

I, personally, would expect the second version to be at most two times
slower (as there might be need to send two IP packets instead of one).
Also note, that as it is obvious that version with copying to buffer
on the stack should be faster, it is not so obvious if there is need to
malloc() buffer before sending (for example if there is no upper limit
on len).  However even if we need to malloc() buffer, second version is
still by orders of magnitude faster.

I don't know how many user space program does it impact. Probably not many,
as they often use buffering of some kind.

This is both true for 2.2 and 2.4, IPv4 and IPv6. One vs two writes doesn't
seem to make big a diffrence for unix domain sockets though.

I found it during work with client/server program that worked horribly
slow just becouse of this. (of course I fixed it, but that's not the point).

I tried to find it in kernel sources, but probably I didn't try hard enough ;)

I attach a test program and results of tests with few diffrent machines.

Test results follow. Please don't be suggested by diffrences between
2.2 and 2.4 as they might be results of kernel patches, also machines
other then roke were on heavy load. The only important thing, is that
two-writes-mode works at *constant* speed, indpenent of machine speed.

(to make things a bit sweeter I can tell that on fbsd 4.4 stable fragmented
writes go at 10 packets/sec, unfortunetly I don't have other machines to 
chceck right now ;)

Linux roke 2.4.7 #3 Wed Oct 3 22:22:24 CEST 2001 i686 pld
cpu MHz		: 840.426
model name	: AMD Duron(tm) Processor
IPv4
  25 packets/sec
  31833 packets/sec
IPv6
  25 packets/sec
  31634 packets/sec
UNIX
  66135 packets/sec
  77457 packets/sec


Linux roke 2.2.19 #6 Sun Sep 30 20:25:08 CEST 2001 i686 pld
cpu MHz		: 840.442
model name	: AMD Duron(tm) Processor
IPv4
  100 packets/sec
  34562 packets/sec
IPv6
  100 packets/sec
  38555 packets/sec
UNIX
  72355 packets/sec
  90586 packets/sec


Linux boniek 2.2.19 #2 Tue Mar 27 17:19:45 CEST 2001 alpha pld
IPv4
  1024 packets/sec
  23351 packets/sec
UNIX
  42219 packets/sec
  50643 packets/sec


# and more recent 2.4:

Linux kenny 2.4.16 #1 SMP Thu Dec 20 16:16:22 CET 2001 i686 pld
cpu MHz         : 699.331
cpu MHz         : 699.331
model name      : Pentium III (Cascades)
model name      : Pentium III (Cascades)
IPv4
  25 packets/sec
  16965 packets/sec
IPv6
  25 packets/sec
  14928 packets/sec
UNIX
  30111 packets/sec
  32143 packets/sec

sparc64/2.2.19 does similary as x86/2.2.19


-- 
: Michal ``,/\/\,       '' Moskal    | |            : GCS {C,UL}++++$
:          |    |alekith      @    |)|(| . org . pl : {E--, W, w-,M}-
:    Linux: We are dot in .ORG.    |                : {b,e>+}++ !tv h
: CurProj: ftp://ftp.pld.org.pl/people/malekith/ksi : PLD Team member

