Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267771AbTGTTIq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 15:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267773AbTGTTIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 15:08:46 -0400
Received: from zork.zork.net ([64.81.246.102]:48864 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S267771AbTGTTIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 15:08:30 -0400
To: James Morris <jmorris@intercode.com.au>
Cc: netdev@oss.sgi.com, <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test1-mm1] TCP connections over ipsec hang after a few
 seconds
References: <Mutt.LNX.4.44.0307210116070.24197-100000@excalibur.intercode.com.au>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: James Morris <jmorris@intercode.com.au>,
 netdev@oss.sgi.com,  <linux-kernel@vger.kernel.org>
Date: Sun, 20 Jul 2003 20:23:16 +0100
In-Reply-To: <Mutt.LNX.4.44.0307210116070.24197-100000@excalibur.intercode.com.au> (James
 Morris's message of "Mon, 21 Jul 2003 01:21:24 +1000 (EST)")
Message-ID: <6uwued6lzv.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@intercode.com.au> writes:

> On Sun, 20 Jul 2003, Sean Neakums wrote:
>
>> I am seeing a lot of "pmtu discvovery on SA AH/03537192/c0a80003" type
>> messages (I forgot to check for them when on 100baseT; will recheck
>> that).  Are these indicative of such a problem?
>
> Yes.

I still get these messages running over 100baseT.

> With the 100baseT configuration, are the systems on the same segment?

I'm connecting the two machines with a crossed-over cable.

> It might help to provide tcpdumps from each end, ifconfig output for each 
> interface and setkey configuration (without the wlan bridging).

Below is the config info.  I'm running racoon.

I ended up with about forty megabytes of tcpdump output on each side
of the link before the hang occurred.  I've appended below the last
150 lines of each dump.  Four separate TCP connections were involved
in all, for a total of about 400MiB of data transferred.


--- First machine

eth0      Link encap:Ethernet  HWaddr xx:xx:xx:xx:xx:xx  
          inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:113024 errors:0 dropped:0 overruns:0 frame:0
          TX packets:361585 errors:0 dropped:0 overruns:0 carrier:0
          collisions:97 txqueuelen:100 
          RX bytes:8468832 (8.0 MiB)  TX bytes:531820915 (507.1 MiB)
          Interrupt:10 Base address:0xc400 Memory:dfffe000-dfffe038 

---

#!/usr/sbin/setkey -f
flush;
spdflush;

spdadd 192.168.0.1 192.168.0.3 any -P out ipsec esp/transport//require;
spdadd 192.168.0.3 192.168.0.1 any -P in ipsec esp/transport//require;

---

# $KAME: racoon.conf.in,v 1.18 2001/08/16 06:33:40 itojun Exp $

# "path" must be placed before it should be used.
# You can overwrite which you defined, but it should not use due to confusing.
path include "/etc/racoon" ;
#include "remote.conf" ;

# search this file for pre_shared_key with various ID key.
path pre_shared_key "/etc/racoon/psk.txt" ;

# racoon will look for certificate file in the directory,
# if the certificate/certificate request payload is received.
path certificate "/etc/cert" ;

# "log" specifies logging level.  It is followed by either "notify", "debug"
# or "debug2".
#log debug;

# "padding" defines some parameter of padding.  You should not touch these.
padding
{
	maximum_length 20;	# maximum padding length.
	randomize off;		# enable randomize length.
	strict_check off;	# enable strict check.
	exclusive_tail off;	# extract last one octet.
}

# if no listen directive is specified, racoon will listen to all
# available interface addresses.
listen
{
	#isakmp ::1 [7000];
	#isakmp 202.249.11.124 [500];
	#admin [7002];		# administrative's port by kmpstat.
	#strict_address; 	# required all addresses must be bound.
}

# Specification of default various timer.
timer
{
	# These value can be changed per remote node.
	counter 5;		# maximum trying count to send.
	interval 20 sec;	# maximum interval to resend.
	persend 1;		# the number of packets per a send.

	# timer for waiting to complete each phase.
	phase1 30 sec;
	phase2 15 sec;
}

remote anonymous
{
	exchange_mode aggressive,main;
	doi ipsec_doi;
	situation identity_only;

	my_identifier address;

	lifetime time 2 min;	# sec,min,hour
	initial_contact on;
	proposal_check obey;	# obey, strict or claim

	proposal {
		encryption_algorithm blowfish 448;
		hash_algorithm sha1;
		authentication_method pre_shared_key ;
		dh_group 2 ;
	}
}

sainfo anonymous
{
	pfs_group 1;
	lifetime time 2 min;
	encryption_algorithm blowfish 448;
	authentication_algorithm hmac_sha1;
	compression_algorithm deflate;
}

remote 192.168.0.3 {
	exchange_mode aggressive, main;
	my_identifier asn1dn;
	peers_identifier asn1dn;

	certificate_type x509 "tower.public" "tower.private";

	peers_certfile "craptop.public";
	proposal {
		encryption_algorithm blowfish 448;
		hash_algorithm sha1;
		authentication_method rsasig;
		dh_group 2;
	}
}

---

192.168.0.3 192.168.0.1 
	esp mode=transport spi=186578041(0x0b1ef479) reqid=0(0x00000000)
	E: blowfish-cbc  6047c0a9 b1244f40 37937606 2246d408 f3de362c 31f21b89 4cab6800 abde86ff
 b002ae5a 08681d2a d55c99fa ad2a626d d1f3a064 15f898d1
	A: hmac-sha1  a27c176b 40e0f619 c3a16111 72742867 acfc9b89
	seq=0x00000000 replay=4 flags=0x00000000 state=mature 
	created: Jul 20 20:05:25 2003	current: Jul 20 20:06:58 2003
	diff: 93(s)	hard: 120(s)	soft: 96(s)
	last:                     	hard: 0(s)	soft: 0(s)
	current: 0(bytes)	hard: 0(bytes)	soft: 0(bytes)
	allocated: 0	hard: 0	soft: 0
	sadb_seq=1 pid=2052 refcnt=0
192.168.0.1 192.168.0.3 
	esp mode=transport spi=55613933(0x035099ed) reqid=0(0x00000000)
	E: blowfish-cbc  d4ae888d 41f40471 9d51d800 bb52e89d a29e48ef 1f7e826f f16ac829 06e3fb74
 e8731ee8 579b4f04 01e7e8a6 8f4d5ff0 cb57b801 e6cf4036
	A: hmac-sha1  ca60673d bdab7f98 9b258c9e 6a6e6da3 8ff07b20
	seq=0x00000000 replay=4 flags=0x00000000 state=mature 
	created: Jul 20 20:05:25 2003	current: Jul 20 20:06:58 2003
	diff: 93(s)	hard: 120(s)	soft: 96(s)
	last: Jul 20 20:05:48 2003	hard: 0(s)	soft: 0(s)
	current: 3008(bytes)	hard: 0(bytes)	soft: 0(bytes)
	allocated: 2	hard: 0	soft: 0
	sadb_seq=0 pid=2052 refcnt=0

--- Second machine

eth0      Link encap:Ethernet  HWaddr xx:xx:xx:xx:xx:xx  
          inet addr:192.168.0.3  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:313871 errors:0 dropped:0 overruns:0 frame:0
          TX packets:83692 errors:0 dropped:0 overruns:0 carrier:1
          collisions:0 txqueuelen:100 
          RX bytes:471974158 (450.1 MiB)  TX bytes:7202706 (6.8 MiB)
          Interrupt:11 Base address:0xec80 

---

#!/usr/sbin/setkey -f
flush;
spdflush;

spdadd 192.168.0.3 192.168.0.1 any -P out ipsec esp/transport//require;
spdadd 192.168.0.1 192.168.0.3 any -P in ipsec esp/transport//require;

---

# $KAME: racoon.conf.in,v 1.18 2001/08/16 06:33:40 itojun Exp $

# "path" must be placed before it should be used.
# You can overwrite which you defined, but it should not use due to confusing.
path include "/etc/racoon" ;
#include "remote.conf" ;

# search this file for pre_shared_key with various ID key.
path pre_shared_key "/etc/racoon/psk.txt" ;

# racoon will look for certificate file in the directory,
# if the certificate/certificate request payload is received.
path certificate "/etc/cert" ;

# "log" specifies logging level.  It is followed by either "notify", "debug"
# or "debug2".
#log debug;

# "padding" defines some parameter of padding.  You should not touch these.
padding
{
	maximum_length 20;	# maximum padding length.
	randomize off;		# enable randomize length.
	strict_check off;	# enable strict check.
	exclusive_tail off;	# extract last one octet.
}

# if no listen directive is specified, racoon will listen to all
# available interface addresses.
listen
{
	#isakmp ::1 [7000];
	#isakmp 202.249.11.124 [500];
	#admin [7002];		# administrative's port by kmpstat.
	#strict_address; 	# required all addresses must be bound.
}

# Specification of default various timer.
timer
{
	# These value can be changed per remote node.
	counter 5;		# maximum trying count to send.
	interval 20 sec;	# maximum interval to resend.
	persend 1;		# the number of packets per a send.

	# timer for waiting to complete each phase.
	phase1 30 sec;
	phase2 15 sec;
}

remote anonymous
{
	exchange_mode aggressive,main;
	doi ipsec_doi;
	situation identity_only;

	my_identifier address;

	lifetime time 2 min;	# sec,min,hour
	initial_contact on;
	proposal_check obey;	# obey, strict or claim

	proposal {
		encryption_algorithm blowfish 448;
		hash_algorithm sha1;
		authentication_method pre_shared_key ;
		dh_group 2 ;
	}
}

sainfo anonymous
{
	pfs_group 1;
	lifetime time 2 min;
	encryption_algorithm blowfish 448;
	authentication_algorithm hmac_sha1;
	compression_algorithm deflate;
}

remote 192.168.0.1 {
	exchange_mode aggressive, main;
	my_identifier asn1dn;
	peers_identifier asn1dn;

	certificate_type x509 "craptop.public" "craptop.private";

	peers_certfile "tower.public";
	proposal {
		encryption_algorithm blowfish 448;
		hash_algorithm sha1;
		authentication_method rsasig;
		dh_group 2;
	}
}

---

192.168.0.3 192.168.0.1 
	esp mode=transport spi=186578041(0x0b1ef479) reqid=0(0x00000000)
	E: blowfish-cbc  6047c0a9 b1244f40 37937606 2246d408 f3de362c 31f21b89 4cab6800 abde86ff
 b002ae5a 08681d2a d55c99fa ad2a626d d1f3a064 15f898d1
	A: hmac-sha1  a27c176b 40e0f619 c3a16111 72742867 acfc9b89
	seq=0x00000000 replay=4 flags=0x00000000 state=mature 
	created: Jul 20 19:56:39 2003	current: Jul 20 19:57:55 2003
	diff: 76(s)	hard: 120(s)	soft: 96(s)
	last:                     	hard: 0(s)	soft: 0(s)
	current: 0(bytes)	hard: 0(bytes)	soft: 0(bytes)
	allocated: 0	hard: 0	soft: 0
	sadb_seq=1 pid=15668 refcnt=0
192.168.0.1 192.168.0.3 
	esp mode=transport spi=55613933(0x035099ed) reqid=0(0x00000000)
	E: blowfish-cbc  d4ae888d 41f40471 9d51d800 bb52e89d a29e48ef 1f7e826f f16ac829 06e3fb74
 e8731ee8 579b4f04 01e7e8a6 8f4d5ff0 cb57b801 e6cf4036
	A: hmac-sha1  ca60673d bdab7f98 9b258c9e 6a6e6da3 8ff07b20
	seq=0x00000000 replay=4 flags=0x00000000 state=mature 
	created: Jul 20 19:56:39 2003	current: Jul 20 19:57:55 2003
	diff: 76(s)	hard: 120(s)	soft: 96(s)
	last:                     	hard: 0(s)	soft: 0(s)
	current: 0(bytes)	hard: 0(bytes)	soft: 0(bytes)
	allocated: 0	hard: 0	soft: 0
	sadb_seq=0 pid=15668 refcnt=0

--- last 150 lines of tcpdump on 192.168.0.1

20:04:11.901017 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11315) (DF) (ttl 64, id 34196, len 72)
20:04:11.901132 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11316) (DF) (ttl 64, id 34197, len 72)
20:04:11.901201 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa18) (DF) (ttl 64, id 5447, len 1496)
20:04:11.901381 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa19) (DF) (ttl 64, id 5448, len 1496)
20:04:11.901534 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa1a) (DF) (ttl 64, id 5449, len 1496)
20:04:11.901684 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa1b) (DF) (ttl 64, id 5450, len 1496)
20:04:11.901257 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11317) (DF) (ttl 64, id 34198, len 72)
20:04:11.901863 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa1c) (DF) (ttl 64, id 5451, len 1496)
20:04:11.902013 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa1d) (DF) (ttl 64, id 5452, len 1496)
20:04:11.902162 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa1e) (DF) (ttl 64, id 5453, len 1496)
20:04:11.902312 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa1f) (DF) (ttl 64, id 5454, len 1496)
20:04:11.903145 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11318) (DF) (ttl 64, id 34199, len 72)
20:04:11.903327 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa20) (DF) (ttl 64, id 5455, len 1496)
20:04:11.903382 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11319) (DF) (ttl 64, id 34200, len 72)
20:04:11.903476 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa21) (DF) (ttl 64, id 5456, len 1496)
20:04:11.903641 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa22) (DF) (ttl 64, id 5457, len 1496)
20:04:11.903790 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa23) (DF) (ttl 64, id 5458, len 1496)
20:04:11.903940 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa24) (DF) (ttl 64, id 5459, len 1496)
20:04:11.904089 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa25) (DF) (ttl 64, id 5460, len 1496)
20:04:11.904237 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa26) (DF) (ttl 64, id 5461, len 1496)
20:04:11.904385 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa27) (DF) (ttl 64, id 5462, len 1496)
20:04:11.904567 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa28) (DF) (ttl 64, id 5463, len 1496)
20:04:11.905495 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1131a) (DF) (ttl 64, id 34201, len 72)
20:04:11.905680 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa29) (DF) (ttl 64, id 5464, len 1496)
20:04:11.905749 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1131b) (DF) (ttl 64, id 34202, len 72)
20:04:11.905835 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa2a) (DF) (ttl 64, id 5465, len 1496)
20:04:11.905990 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa2b) (DF) (ttl 64, id 5466, len 1496)
20:04:11.906130 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa2c) (DF) (ttl 64, id 5467, len 1496)
20:04:11.906269 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa2d) (DF) (ttl 64, id 5468, len 1496)
20:04:11.906408 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa2e) (DF) (ttl 64, id 5469, len 1496)
20:04:11.907958 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1131c) (DF) (ttl 64, id 34203, len 72)
20:04:11.908072 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1131d) (DF) (ttl 64, id 34204, len 72)
20:04:11.908212 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa2f) (DF) (ttl 64, id 5470, len 1496)
20:04:11.908198 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1131e) (DF) (ttl 64, id 34205, len 72)
20:04:11.908392 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa30) (DF) (ttl 64, id 5471, len 1496)
20:04:11.908547 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa31) (DF) (ttl 64, id 5472, len 1496)
20:04:11.908690 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa32) (DF) (ttl 64, id 5473, len 1496)
20:04:11.908863 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa33) (DF) (ttl 64, id 5474, len 1496)
20:04:11.909028 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa34) (DF) (ttl 64, id 5475, len 1496)
20:04:11.909180 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa35) (DF) (ttl 64, id 5476, len 1496)
20:04:11.909332 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa36) (DF) (ttl 64, id 5477, len 1496)
20:04:11.908353 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1131f) (DF) (ttl 64, id 34206, len 72)
20:04:11.909543 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa37) (DF) (ttl 64, id 5478, len 1496)
20:04:11.909691 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa38) (DF) (ttl 64, id 5479, len 1496)
20:04:11.909841 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa39) (DF) (ttl 64, id 5480, len 1496)
20:04:11.909992 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa3a) (DF) (ttl 64, id 5481, len 1496)
20:04:11.910141 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa3b) (DF) (ttl 64, id 5482, len 1496)
20:04:11.910294 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa3c) (DF) (ttl 64, id 5483, len 1496)
20:04:11.910442 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa3d) (DF) (ttl 64, id 5484, len 1496)
20:04:11.910592 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa3e) (DF) (ttl 64, id 5485, len 1496)
20:04:11.912595 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11320) (DF) (ttl 64, id 34207, len 72)
20:04:11.912746 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11321) (DF) (ttl 64, id 34208, len 72)
20:04:11.912782 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa3f) (DF) (ttl 64, id 5486, len 1496)
20:04:11.912933 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa40) (DF) (ttl 64, id 5487, len 1496)
20:04:11.913106 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa41) (DF) (ttl 64, id 5488, len 1496)
20:04:11.913257 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa42) (DF) (ttl 64, id 5489, len 1496)
20:04:11.913494 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11322) (DF) (ttl 64, id 34209, len 72)
20:04:11.913673 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa43) (DF) (ttl 64, id 5490, len 1496)
20:04:11.913820 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa44) (DF) (ttl 64, id 5491, len 1496)
20:04:11.913968 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa45) (DF) (ttl 64, id 5492, len 1496)
20:04:11.915429 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11323) (DF) (ttl 64, id 34210, len 72)
20:04:11.915535 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11324) (DF) (ttl 64, id 34211, len 72)
20:04:11.915623 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa46) (DF) (ttl 64, id 5493, len 1496)
20:04:11.915796 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa47) (DF) (ttl 64, id 5494, len 1496)
20:04:11.915948 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa48) (DF) (ttl 64, id 5495, len 1496)
20:04:11.916095 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa49) (DF) (ttl 64, id 5496, len 1496)
20:04:11.915719 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11325) (DF) (ttl 64, id 34212, len 72)
20:04:11.916301 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa4a) (DF) (ttl 64, id 5497, len 1496)
20:04:11.916459 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa4b) (DF) (ttl 64, id 5498, len 1496)
20:04:11.916616 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa4c) (DF) (ttl 64, id 5499, len 1496)
20:04:11.916775 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa4d) (DF) (ttl 64, id 5500, len 1496)
20:04:11.916933 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa4e) (DF) (ttl 64, id 5501, len 1496)
20:04:11.917943 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11326) (DF) (ttl 64, id 34213, len 72)
20:04:11.918118 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa4f) (DF) (ttl 64, id 5502, len 1496)
20:04:11.918274 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa50) (DF) (ttl 64, id 5503, len 1496)
20:04:11.918423 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa51) (DF) (ttl 64, id 5504, len 1496)
20:04:11.918573 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa52) (DF) (ttl 64, id 5505, len 1496)
20:04:11.918723 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa53) (DF) (ttl 64, id 5506, len 1496)
20:04:11.918215 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11327) (DF) (ttl 64, id 34214, len 72)
20:04:11.919551 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11328) (DF) (ttl 64, id 34215, len 72)
20:04:11.919723 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa54) (DF) (ttl 64, id 5507, len 1496)
20:04:11.919740 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11329) (DF) (ttl 64, id 34216, len 72)
20:04:11.919872 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa55) (DF) (ttl 64, id 5508, len 1496)
20:04:11.920026 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa56) (DF) (ttl 64, id 5509, len 1496)
20:04:11.920169 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa57) (DF) (ttl 64, id 5510, len 1496)
20:04:11.920322 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa58) (DF) (ttl 64, id 5511, len 1496)
20:04:11.920469 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa59) (DF) (ttl 64, id 5512, len 1496)
20:04:11.920479 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1132a) (DF) (ttl 64, id 34217, len 72)
20:04:11.920691 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa5a) (DF) (ttl 64, id 5513, len 1496)
20:04:11.920839 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa5b) (DF) (ttl 64, id 5514, len 1496)
20:04:11.920983 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa5c) (DF) (ttl 64, id 5515, len 1496)
20:04:11.922911 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1132b) (DF) (ttl 64, id 34218, len 72)
20:04:11.923041 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1132c) (DF) (ttl 64, id 34219, len 72)
20:04:11.923193 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1132d) (DF) (ttl 64, id 34220, len 72)
20:04:11.923369 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1132e) (DF) (ttl 64, id 34221, len 72)
20:04:11.924299 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1132f) (DF) (ttl 64, id 34222, len 72)
20:04:12.123058 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x1) (DF) (ttl 64, id 5516, len 1496)
20:04:12.123682 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x1) (DF) (ttl 64, id 34223, len 88)
20:04:12.123895 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x2) (DF) (ttl 64, id 5517, len 1496)
20:04:12.124044 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x3) (DF) (ttl 64, id 5518, len 1496)
20:04:12.124190 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x4) (DF) (ttl 64, id 5519, len 1496)
20:04:12.124375 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x2) (DF) (ttl 64, id 34224, len 72)
20:04:12.124607 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x5) (DF) (ttl 64, id 5520, len 1496)
20:04:12.124636 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x3) (DF) (ttl 64, id 34225, len 72)
20:04:12.124755 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x6) (DF) (ttl 64, id 5521, len 1496)
20:04:12.124897 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x4) (DF) (ttl 64, id 34226, len 72)
20:04:12.124929 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x7) (DF) (ttl 64, id 5522, len 1496)
20:04:12.125079 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x8) (DF) (ttl 64, id 5523, len 1496)
20:04:12.125190 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x5) (DF) (ttl 64, id 34227, len 72)
20:04:12.125250 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x9) (DF) (ttl 64, id 5524, len 1496)
20:04:12.125403 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0xa) (DF) (ttl 64, id 5525, len 1496)
20:04:12.125478 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x6) (DF) (ttl 64, id 34228, len 72)
20:04:12.125584 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0xb) (DF) (ttl 64, id 5526, len 1496)
20:04:12.125737 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0xc) (DF) (ttl 64, id 5527, len 1496)
20:04:12.125913 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0xd) (DF) (ttl 64, id 5528, len 1496)
20:04:12.126062 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0xe) (DF) (ttl 64, id 5529, len 1496)
20:04:12.125744 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x7) (DF) (ttl 64, id 34229, len 72)
20:04:12.126032 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x8) (DF) (ttl 64, id 34230, len 72)
20:04:12.126274 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0xf) (DF) (ttl 64, id 5530, len 1496)
20:04:12.126329 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x9) (DF) (ttl 64, id 34231, len 72)
20:04:12.126423 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x10) (DF) (ttl 64, id 5531, len 1496)
20:04:12.126584 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x11) (DF) (ttl 64, id 5532, len 1496)
20:04:12.126586 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0xa) (DF) (ttl 64, id 34232, len 72)
20:04:12.126740 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x12) (DF) (ttl 64, id 5533, len 1496)
20:04:12.126869 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0xb) (DF) (ttl 64, id 34233, len 72)
20:04:12.126909 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x13) (DF) (ttl 64, id 5534, len 1496)
20:04:12.127066 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x14) (DF) (ttl 64, id 5535, len 1496)
20:04:12.127227 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x15) (DF) (ttl 64, id 5536, len 1496)
20:04:12.127228 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0xc) (DF) (ttl 64, id 34234, len 72)
20:04:12.127388 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x16) (DF) (ttl 64, id 5537, len 1496)
20:04:12.127539 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0xd) (DF) (ttl 64, id 34235, len 72)
20:04:12.127548 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x17) (DF) (ttl 64, id 5538, len 1496)
20:04:12.127700 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x18) (DF) (ttl 64, id 5539, len 1496)
20:04:12.127848 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0xe) (DF) (ttl 64, id 34236, len 72)
20:04:12.127862 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x19) (DF) (ttl 64, id 5540, len 1496)
20:04:12.128010 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x1a) (DF) (ttl 64, id 5541, len 1496)
20:04:12.128155 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0xf) (DF) (ttl 64, id 34237, len 72)
20:04:12.128175 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x1b) (DF) (ttl 64, id 5542, len 1496)
20:04:12.128329 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x1c) (DF) (ttl 64, id 5543, len 1496)
20:04:12.128495 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x1d) (DF) (ttl 64, id 5544, len 1496)
20:04:12.128549 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x10) (DF) (ttl 64, id 34238, len 72)
20:04:12.128644 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x1e) (DF) (ttl 64, id 5545, len 1496)
20:04:12.128806 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x1f) (DF) (ttl 64, id 5546, len 1496)
20:04:12.128954 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x20) (DF) (ttl 64, id 5547, len 1496)
20:04:12.129108 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x21) (DF) (ttl 64, id 5548, len 1496)
20:04:12.133258 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x11) (DF) (ttl 64, id 34239, len 72)
20:04:12.133508 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x12) (DF) (ttl 64, id 34240, len 72)
20:04:29.971609 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x13) (DF) (ttl 64, id 34241, len 72)
20:04:30.179171 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x14) (DF) (ttl 64, id 34242, len 72)
20:04:30.595134 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x15) (DF) (ttl 64, id 34243, len 72)

--- last 150 lines of tcpdump on 192.168.0.3

19:55:25.903800 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa15) (DF) (ttl 64, id 5444, len 1496)
19:55:25.903944 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa16) (DF) (ttl 64, id 5445, len 1496)
19:55:25.904102 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa17) (DF) (ttl 64, id 5446, len 1496)
19:55:25.905078 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11315) (DF) (ttl 64, id 34196, len 72)
19:55:25.905196 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11316) (DF) (ttl 64, id 34197, len 72)
19:55:25.905321 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11317) (DF) (ttl 64, id 34198, len 72)
19:55:25.905463 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa18) (DF) (ttl 64, id 5447, len 1496)
19:55:25.905646 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa19) (DF) (ttl 64, id 5448, len 1496)
19:55:25.905798 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa1a) (DF) (ttl 64, id 5449, len 1496)
19:55:25.905948 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa1b) (DF) (ttl 64, id 5450, len 1496)
19:55:25.906126 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa1c) (DF) (ttl 64, id 5451, len 1496)
19:55:25.906276 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa1d) (DF) (ttl 64, id 5452, len 1496)
19:55:25.906425 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa1e) (DF) (ttl 64, id 5453, len 1496)
19:55:25.906575 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa1f) (DF) (ttl 64, id 5454, len 1496)
19:55:25.907210 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11318) (DF) (ttl 64, id 34199, len 72)
19:55:25.907445 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11319) (DF) (ttl 64, id 34200, len 72)
19:55:25.907589 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa20) (DF) (ttl 64, id 5455, len 1496)
19:55:25.907739 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa21) (DF) (ttl 64, id 5456, len 1496)
19:55:25.907902 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa22) (DF) (ttl 64, id 5457, len 1496)
19:55:25.908050 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa23) (DF) (ttl 64, id 5458, len 1496)
19:55:25.908201 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa24) (DF) (ttl 64, id 5459, len 1496)
19:55:25.908350 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa25) (DF) (ttl 64, id 5460, len 1496)
19:55:25.908497 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa26) (DF) (ttl 64, id 5461, len 1496)
19:55:25.908646 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa27) (DF) (ttl 64, id 5462, len 1496)
19:55:25.908831 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa28) (DF) (ttl 64, id 5463, len 1496)
19:55:25.909557 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1131a) (DF) (ttl 64, id 34201, len 72)
19:55:25.909806 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1131b) (DF) (ttl 64, id 34202, len 72)
19:55:25.909942 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa29) (DF) (ttl 64, id 5464, len 1496)
19:55:25.910106 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa2a) (DF) (ttl 64, id 5465, len 1496)
19:55:25.910249 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa2b) (DF) (ttl 64, id 5466, len 1496)
19:55:25.910389 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa2c) (DF) (ttl 64, id 5467, len 1496)
19:55:25.910529 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa2d) (DF) (ttl 64, id 5468, len 1496)
19:55:25.910668 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa2e) (DF) (ttl 64, id 5469, len 1496)
19:55:25.912017 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1131c) (DF) (ttl 64, id 34203, len 72)
19:55:25.912132 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1131d) (DF) (ttl 64, id 34204, len 72)
19:55:25.912259 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1131e) (DF) (ttl 64, id 34205, len 72)
19:55:25.912415 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1131f) (DF) (ttl 64, id 34206, len 72)
19:55:25.912474 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa2f) (DF) (ttl 64, id 5470, len 1496)
19:55:25.912651 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa30) (DF) (ttl 64, id 5471, len 1496)
19:55:25.912806 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa31) (DF) (ttl 64, id 5472, len 1496)
19:55:25.912949 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa32) (DF) (ttl 64, id 5473, len 1496)
19:55:25.913124 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa33) (DF) (ttl 64, id 5474, len 1496)
19:55:25.913290 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa34) (DF) (ttl 64, id 5475, len 1496)
19:55:25.913442 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa35) (DF) (ttl 64, id 5476, len 1496)
19:55:25.913594 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa36) (DF) (ttl 64, id 5477, len 1496)
19:55:25.913807 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa37) (DF) (ttl 64, id 5478, len 1496)
19:55:25.913954 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa38) (DF) (ttl 64, id 5479, len 1496)
19:55:25.914117 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa39) (DF) (ttl 64, id 5480, len 1496)
19:55:25.914260 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa3a) (DF) (ttl 64, id 5481, len 1496)
19:55:25.914406 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa3b) (DF) (ttl 64, id 5482, len 1496)
19:55:25.914558 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa3c) (DF) (ttl 64, id 5483, len 1496)
19:55:25.914711 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa3d) (DF) (ttl 64, id 5484, len 1496)
19:55:25.914860 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa3e) (DF) (ttl 64, id 5485, len 1496)
19:55:25.916653 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11320) (DF) (ttl 64, id 34207, len 72)
19:55:25.916807 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11321) (DF) (ttl 64, id 34208, len 72)
19:55:25.917046 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa3f) (DF) (ttl 64, id 5486, len 1496)
19:55:25.917196 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa40) (DF) (ttl 64, id 5487, len 1496)
19:55:25.917561 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11322) (DF) (ttl 64, id 34209, len 72)
19:55:25.917371 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa41) (DF) (ttl 64, id 5488, len 1496)
19:55:25.917517 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa42) (DF) (ttl 64, id 5489, len 1496)
19:55:25.917936 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa43) (DF) (ttl 64, id 5490, len 1496)
19:55:25.918095 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa44) (DF) (ttl 64, id 5491, len 1496)
19:55:25.918230 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa45) (DF) (ttl 64, id 5492, len 1496)
19:55:25.919488 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11323) (DF) (ttl 64, id 34210, len 72)
19:55:25.919595 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11324) (DF) (ttl 64, id 34211, len 72)
19:55:25.919778 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11325) (DF) (ttl 64, id 34212, len 72)
19:55:25.919887 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa46) (DF) (ttl 64, id 5493, len 1496)
19:55:25.920059 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa47) (DF) (ttl 64, id 5494, len 1496)
19:55:25.920206 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa48) (DF) (ttl 64, id 5495, len 1496)
19:55:25.920353 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa49) (DF) (ttl 64, id 5496, len 1496)
19:55:25.920576 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa4a) (DF) (ttl 64, id 5497, len 1496)
19:55:25.920725 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa4b) (DF) (ttl 64, id 5498, len 1496)
19:55:25.920880 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa4c) (DF) (ttl 64, id 5499, len 1496)
19:55:25.921037 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa4d) (DF) (ttl 64, id 5500, len 1496)
19:55:25.921195 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa4e) (DF) (ttl 64, id 5501, len 1496)
19:55:25.922003 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11326) (DF) (ttl 64, id 34213, len 72)
19:55:25.922276 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11327) (DF) (ttl 64, id 34214, len 72)
19:55:25.922380 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa4f) (DF) (ttl 64, id 5502, len 1496)
19:55:25.922536 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa50) (DF) (ttl 64, id 5503, len 1496)
19:55:25.922724 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa51) (DF) (ttl 64, id 5504, len 1496)
19:55:25.922837 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa52) (DF) (ttl 64, id 5505, len 1496)
19:55:25.922989 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa53) (DF) (ttl 64, id 5506, len 1496)
19:55:25.923612 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11328) (DF) (ttl 64, id 34215, len 72)
19:55:25.923798 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x11329) (DF) (ttl 64, id 34216, len 72)
19:55:25.923989 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa54) (DF) (ttl 64, id 5507, len 1496)
19:55:25.924131 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa55) (DF) (ttl 64, id 5508, len 1496)
19:55:25.924539 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1132a) (DF) (ttl 64, id 34217, len 72)
19:55:25.924287 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa56) (DF) (ttl 64, id 5509, len 1496)
19:55:25.924431 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa57) (DF) (ttl 64, id 5510, len 1496)
19:55:25.924574 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa58) (DF) (ttl 64, id 5511, len 1496)
19:55:25.924732 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa59) (DF) (ttl 64, id 5512, len 1496)
19:55:25.924953 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa5a) (DF) (ttl 64, id 5513, len 1496)
19:55:25.925107 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa5b) (DF) (ttl 64, id 5514, len 1496)
19:55:25.925243 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c1e03ec,seq=0x3fa5c) (DF) (ttl 64, id 5515, len 1496)
19:55:25.926969 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1132b) (DF) (ttl 64, id 34218, len 72)
19:55:25.927101 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1132c) (DF) (ttl 64, id 34219, len 72)
19:55:25.927255 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1132d) (DF) (ttl 64, id 34220, len 72)
19:55:25.927431 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1132e) (DF) (ttl 64, id 34221, len 72)
19:55:25.928358 192.168.0.3 > 192.168.0.1: ESP(spi=0x06e9543a,seq=0x1132f) (DF) (ttl 64, id 34222, len 72)
19:55:26.127301 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x1) (DF) (ttl 64, id 5516, len 1496)
19:55:26.127706 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x1) (DF) (ttl 64, id 34223, len 88)
19:55:26.128128 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x2) (DF) (ttl 64, id 5517, len 1496)
19:55:26.128401 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x2) (DF) (ttl 64, id 34224, len 72)
19:55:26.128276 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x3) (DF) (ttl 64, id 5518, len 1496)
19:55:26.128657 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x3) (DF) (ttl 64, id 34225, len 72)
19:55:26.128423 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x4) (DF) (ttl 64, id 5519, len 1496)
19:55:26.128925 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x4) (DF) (ttl 64, id 34226, len 72)
19:55:26.128844 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x5) (DF) (ttl 64, id 5520, len 1496)
19:55:26.129219 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x5) (DF) (ttl 64, id 34227, len 72)
19:55:26.128982 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x6) (DF) (ttl 64, id 5521, len 1496)
19:55:26.129507 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x6) (DF) (ttl 64, id 34228, len 72)
19:55:26.129157 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x7) (DF) (ttl 64, id 5522, len 1496)
19:55:26.129772 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x7) (DF) (ttl 64, id 34229, len 72)
19:55:26.129304 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x8) (DF) (ttl 64, id 5523, len 1496)
19:55:26.130060 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x8) (DF) (ttl 64, id 34230, len 72)
19:55:26.129477 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x9) (DF) (ttl 64, id 5524, len 1496)
19:55:26.130349 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x9) (DF) (ttl 64, id 34231, len 72)
19:55:26.129629 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0xa) (DF) (ttl 64, id 5525, len 1496)
19:55:26.130615 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0xa) (DF) (ttl 64, id 34232, len 72)
19:55:26.129807 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0xb) (DF) (ttl 64, id 5526, len 1496)
19:55:26.130898 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0xb) (DF) (ttl 64, id 34233, len 72)
19:55:26.129963 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0xc) (DF) (ttl 64, id 5527, len 1496)
19:55:26.131256 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0xc) (DF) (ttl 64, id 34234, len 72)
19:55:26.130140 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0xd) (DF) (ttl 64, id 5528, len 1496)
19:55:26.131570 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0xd) (DF) (ttl 64, id 34235, len 72)
19:55:26.130288 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0xe) (DF) (ttl 64, id 5529, len 1496)
19:55:26.131875 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0xe) (DF) (ttl 64, id 34236, len 72)
19:55:26.130503 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0xf) (DF) (ttl 64, id 5530, len 1496)
19:55:26.132186 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0xf) (DF) (ttl 64, id 34237, len 72)
19:55:26.130648 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x10) (DF) (ttl 64, id 5531, len 1496)
19:55:26.132578 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x10) (DF) (ttl 64, id 34238, len 72)
19:55:26.130815 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x11) (DF) (ttl 64, id 5532, len 1496)
19:55:26.130969 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x12) (DF) (ttl 64, id 5533, len 1496)
19:55:26.131137 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x13) (DF) (ttl 64, id 5534, len 1496)
19:55:26.131292 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x14) (DF) (ttl 64, id 5535, len 1496)
19:55:26.131452 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x15) (DF) (ttl 64, id 5536, len 1496)
19:55:26.131624 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x16) (DF) (ttl 64, id 5537, len 1496)
19:55:26.131780 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x17) (DF) (ttl 64, id 5538, len 1496)
19:55:26.131935 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x18) (DF) (ttl 64, id 5539, len 1496)
19:55:26.132089 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x19) (DF) (ttl 64, id 5540, len 1496)
19:55:26.132241 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x1a) (DF) (ttl 64, id 5541, len 1496)
19:55:26.132429 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x1b) (DF) (ttl 64, id 5542, len 1496)
19:55:26.132562 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x1c) (DF) (ttl 64, id 5543, len 1496)
19:55:26.132727 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x1d) (DF) (ttl 64, id 5544, len 1496)
19:55:26.132878 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x1e) (DF) (ttl 64, id 5545, len 1496)
19:55:26.133034 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x1f) (DF) (ttl 64, id 5546, len 1496)
19:55:26.133183 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x20) (DF) (ttl 64, id 5547, len 1496)
19:55:26.133336 192.168.0.1 > 192.168.0.3: ESP(spi=0x0c59bc9d,seq=0x21) (DF) (ttl 64, id 5548, len 1496)
19:55:26.137285 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x11) (DF) (ttl 64, id 34239, len 72)
19:55:26.137532 192.168.0.3 > 192.168.0.1: ESP(spi=0x039c0c62,seq=0x12) (DF) (ttl 64, id 34240, len 72)

