Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSG2IwS>; Mon, 29 Jul 2002 04:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313638AbSG2IwS>; Mon, 29 Jul 2002 04:52:18 -0400
Received: from dsl-64-192-31-41.telocity.com ([64.192.31.41]:26496 "EHLO
	butterfly.hjsoft.com") by vger.kernel.org with ESMTP
	id <S313563AbSG2IwP>; Mon, 29 Jul 2002 04:52:15 -0400
From: glynis@butterfly.hjsoft.com
Date: Mon, 29 Jul 2002 04:50:33 -0400
To: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: linux 2.4.19-rc3, snat, and syslog-ng strangenesses
Message-ID: <20020729085033.GA3239@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

i've been working on stabilizing a dual athlon 1800 here, and
originally attributed my netfilter problems to smp, etc.  over the
weekend i've gather much more information that makes for an even more
bizarre story.

using snat, my box would throw an error:
Jul 29 00:12:31 butterfly kernel: LIST_DELETE: ip_conntrack_core.c:165
`&ct->tuplehash[IP_CT_DIR_REPLY]'(ddd3ee90) not in &ip_conntrack_hash
[hash_conntrack(&ct->tuplehash[IP_CT_DIR_REPLY].tuple)].

then /proc/net/ip_conntrack would start going nuts filling with
[UNREPLIED] connections, until cat just seemed to spew the same thing
over and over without eof, then deadlock.

sometimes i got an oops out of it most often blaming syslog-ng or
dnetc, and otherwise pinpointing it in ip_conntrack code.  these are
attached below.  i captured what i thought was pertinent info then
punched it back in to feed to ksymoops.  i hope it looks right.

using MASQUERADE instead of snat, it wouldn't exhibit any problems.

so after discussing the netfilter implications to death, i was
encouraged to widen my search, so i did.

i enabled snat, then started slowly eliminating programs and modules
from the running system.  i got it down to bind, syslog-ng, and my
netfilter modules pretty much.  it still would crash.  when i disabled
syslog-ng, the system stopped deadlocking/oopsing!

i brought back all my other services and the box would keep running!
when i added syslog-ng back in, rebooted, it would die within 10
minutes as usual.

then i disabled syslog-ng's remote udp log stream to another host, but
otherwise started syslog-ng for local logging, and the box still ran.

then i rearranged my /etc/rc2.d/ a bit to make sure my iptables rules
ran before syslog-ng started WITH it's udp stream to a remote host.
the box is still running.  so it seems if i start syslog-ng and it's
udp stream before setting up my firewall, it dies, but starting the
firewall before everything else, then starting syslog-ng works!

so what's causing this?  traffic through the firewall was relatively
light -- 2-3 hosts doing ntp checks for the most part.
does this offer any more info to the people who were trying to help me
debug earlier?=20

thank you for your time.

here are some references:
2 different decoded oopses:
---
ksymoops 2.4.5 on i686 2.4.19-rc3.  Options used
     -V (default)
     -k /var/log/ksymoops/20020729010116.ksyms (specified)
     -l /var/log/ksymoops/20020729010116.modules (specified)
     -o /lib/modules/2.4.19-rc3/ (default)
     -m /boot/System.map-2.4.19-rc3 (default)

Oops: 0
EIP: 0010:[<E0C023C5>]
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace: [<e0c02b76>] [<e0c130cf>] [<e0c1379b>] [<e0c16480>]
[<e0c037cd>]
Code: 39 4f 18 74 60 8d 47 08 89 45 f8 8b 47 08 8b 4d 08 31 db 31


>>EIP; e0c023c5 <[ip_conntrack]__ip_conntrack_find+155/1d0>   <=3D=3D=3D=3D=
=3D

Trace; e0c02b76 <[ip_conntrack]ip_conntrack_tuple_taken+a6/130>
Trace; e0c130cf <[iptable_nat]ip_nat_used_tuple+1f/30>
Trace; e0c1379b <[iptable_nat]get_unique_tuple+db/1e0>
Trace; e0c16480 <[iptable_nat]ip_nat_protocol_udp+0/40>
Trace; e0c037cd <[ip_conntrack]invert_tuplepr+1d/30>

Code;  e0c023c5 <[ip_conntrack]__ip_conntrack_find+155/1d0>
00000000 <_EIP>:
Code;  e0c023c5 <[ip_conntrack]__ip_conntrack_find+155/1d0>   <=3D=3D=3D=3D=
=3D
   0:   39 4f 18                  cmp    %ecx,0x18(%edi)   <=3D=3D=3D=3D=3D
Code;  e0c023c8 <[ip_conntrack]__ip_conntrack_find+158/1d0>
   3:   74 60                     je     65 <_EIP+0x65> e0c0242a <[ip_connt=
rack]__ip_conntrack_find+1ba/1d0>
Code;  e0c023ca <[ip_conntrack]__ip_conntrack_find+15a/1d0>
   5:   8d 47 08                  lea    0x8(%edi),%eax
Code;  e0c023cd <[ip_conntrack]__ip_conntrack_find+15d/1d0>
   8:   89 45 f8                  mov    %eax,0xfffffff8(%ebp)
Code;  e0c023d0 <[ip_conntrack]__ip_conntrack_find+160/1d0>
   b:   8b 47 08                  mov    0x8(%edi),%eax
Code;  e0c023d3 <[ip_conntrack]__ip_conntrack_find+163/1d0>
   e:   8b 4d 08                  mov    0x8(%ebp),%ecx
Code;  e0c023d6 <[ip_conntrack]__ip_conntrack_find+166/1d0>
  11:   31 db                     xor    %ebx,%ebx
Code;  e0c023d8 <[ip_conntrack]__ip_conntrack_find+168/1d0>
  13:   31 00                     xor    %eax,(%eax)

ksymoops 2.4.5 on i686 2.4.19-rc3.  Options used
     -V (default)
     -k /var/log/ksymoops/20020729040201.ksyms (specified)
     -l /var/log/ksymoops/20020729040201.modules (specified)
     -o /lib/modules/2.4.19-rc3/ (default)
     -m /boot/System.map-2.4.19-rc3 (default)

EIP: 0010:[<e0d9a3c5>]
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace: [<e0d9ab76>] [<e0dab0cf>] [<e0dab79b>] [<e0dae480>]
[<e0d9b7cd>] [<e0d0eec0>]
Code: 39 4f 18 74 60 8d 47 08 89 45 f8 8b 47 08 8b 4d 08 31 db 31


>>EIP; e0d9a3c5 <[ip_conntrack]__ip_conntrack_find+155/1d0>   <=3D=3D=3D=3D=
=3D

Trace; e0d9ab76 <[ip_conntrack]ip_conntrack_tuple_taken+a6/130>
Trace; e0dab0cf <[iptable_nat]ip_nat_used_tuple+1f/30>
Trace; e0dab79b <[iptable_nat]get_unique_tuple+db/1e0>
Trace; e0dae480 <[iptable_nat]ip_nat_protocol_udp+0/40>
Trace; e0d9b7cd <[ip_conntrack]invert_tuplepr+1d/30>
Trace; e0d0eec0 <[cpia_usb].bss.end+b5c79/130db9>

Code;  e0d9a3c5 <[ip_conntrack]__ip_conntrack_find+155/1d0>
00000000 <_EIP>:
Code;  e0d9a3c5 <[ip_conntrack]__ip_conntrack_find+155/1d0>   <=3D=3D=3D=3D=
=3D
   0:   39 4f 18                  cmp    %ecx,0x18(%edi)   <=3D=3D=3D=3D=3D
Code;  e0d9a3c8 <[ip_conntrack]__ip_conntrack_find+158/1d0>
   3:   74 60                     je     65 <_EIP+0x65> e0d9a42a <[ip_connt=
rack]__ip_conntrack_find+1ba/1d0>
Code;  e0d9a3ca <[ip_conntrack]__ip_conntrack_find+15a/1d0>
   5:   8d 47 08                  lea    0x8(%edi),%eax
Code;  e0d9a3cd <[ip_conntrack]__ip_conntrack_find+15d/1d0>
   8:   89 45 f8                  mov    %eax,0xfffffff8(%ebp)
Code;  e0d9a3d0 <[ip_conntrack]__ip_conntrack_find+160/1d0>
   b:   8b 47 08                  mov    0x8(%edi),%eax
Code;  e0d9a3d3 <[ip_conntrack]__ip_conntrack_find+163/1d0>
   e:   8b 4d 08                  mov    0x8(%ebp),%ecx
Code;  e0d9a3d6 <[ip_conntrack]__ip_conntrack_find+166/1d0>
  11:   31 db                     xor    %ebx,%ebx
Code;  e0d9a3d8 <[ip_conntrack]__ip_conntrack_find+168/1d0>
  13:   31 00                     xor    %eax,(%eax)
---

and my snat rules i have running now, but had lots of trouble with in
previous configurations:
---
	echo "1" > /proc/sys/net/ipv4/ip_forward
	iptables -t nat -A POSTROUTING -j SNAT --to 64.192.31.41
	iptables -t nat -A POSTROUTING -j SNAT --to 192.168.1.1
	iptables -t nat -A POSTROUTING -j SNAT --to 127.0.0.1

	iptables -A INPUT -p tcp -i eth0 --destination-port 515 --syn -j REJECT
	iptables -A INPUT -p tcp -i eth0 --destination-port 8082 --syn -j REJECT
	iptables -A INPUT -p tcp -i eth0 --destination-port 8083 --syn -j REJECT
	iptables -A INPUT -p tcp -i eth0 --destination-port 8007 --syn -j REJECT
	iptables -A INPUT -p tcp -i eth0 --destination-port 111 --syn -j REJECT
	iptables -A INPUT -p udp -i eth0 --destination-port 111 -j REJECT
	iptables -A INPUT -p tcp -i eth0 --destination-port 2049 --syn -j REJECT
	iptables -A INPUT -p udp -i eth0 --destination-port 2049 -j REJECT
---
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9RQHZCGPRljI8080RAjAoAJ9FfH44N9Bgnk2JYpYuFabRj2bu9QCaA2hb
YMQgCQB6dGqd10E65BJn8+Y=
=ZIxQ
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
