Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272231AbRIEQUv>; Wed, 5 Sep 2001 12:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272225AbRIEQUf>; Wed, 5 Sep 2001 12:20:35 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:55305 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S272220AbRIEQUS>; Wed, 5 Sep 2001 12:20:18 -0400
Date: Wed, 5 Sep 2001 18:20:33 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Wietse Venema <wietse@porcupine.org>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-net@vger.kernel.org
Subject: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <20010905182033.D3926@emma1.emma.line.org>
Mail-Followup-To: Wietse Venema <wietse@porcupine.org>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org
In-Reply-To: <20010905170037.A6473@emma1.emma.line.org> <20010905152738.C5912BC06D@spike.porcupine.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010905152738.C5912BC06D@spike.porcupine.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----

Dear network experts, dear lurkers,

Wietse Venema and I are wondering about different Linux 2.2/2.4 and
FreeBSD 4.4-RC behaviour when using ioctls to figure interface netmasks,
FreeBSD gets it right, Linux 2.4.9 and 2.4.9-ac7 get it wrong, and from
looking at the source, I think, Linux 2.2.19 gets it wrong as well.

Please Cc: replies back, I'm not on the -net list, and I'm not sure if
Wietse is on either list.

In either case, inet_addr_local, which Postfix uses to figure local
address/netmask pairs, does this:

1. obtain SIOCGIFCONF list
2. for each AF_INET entry in the list from (1.), do:
   2.1 pull out the address from ifr and store it away
   2.2 copy the whole request to an ifr_mask structure
   2.3 ioctl(somesocket, SIOCGIFNETMASK, ifr_mask)
   2.4 pull out the mask and store it away

Example:

FreeBSD 4.4-RC:

# ifconfig xl0 alias 192.168.1.1/28    # add alias
# ifconfig xl0                         # display, only relevant part quoted
xl0: flags=8843<UP,BROADCAST,RUNNING,SIMPLEX,MULTICAST> mtu 1500
        inet 192.168.0.4 netmask 0xffffff00 broadcast 192.168.0.255
        inet 192.168.1.1 netmask 0xfffffff0 broadcast 192.168.1.15
# ./inet_addr_local # what Postfix figures
192.168.0.4/255.255.255.0
192.168.1.1/255.255.255.240
127.0.0.1/255.0.0.0

- -> works.

Linux: 

# ip addr add 192.168.1.1/28 dev eth0  # add alias without label eth0:0
# ip addr show dev eth0                # 
2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:60:08:6f:8a:5e brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.1/24 brd 192.168.0.255 scope global eth0
    inet 192.168.1.1/28 scope global eth0
# ./inet_addr_local
127.0.0.1/255.0.0.0
192.168.0.1/255.255.255.0
192.168.1.1/255.255.255.0

- -> oops, 192.168.1.1 got wrong netmask.

Digging with gdb on either platform, the interface name is xl0 for all
addresses on FreeBSD (no :0 or something) and eth0 on Linux (no :0 or
something). There is no platform-dependent code in inet_addr_local.

Looking at FreeBSD's Kernel source, FreeBSD iterates over the addresses:
/usr/src/sys/netinet/in.c, function in_control, ll. 189ff in my version,
comparing against ifr_addr.

Looking at Linux' Kernel source, Linux 2.4.9 compares just the ifr_name,
/usr/src/linux/net/ipv4/devinet.c, function devinet_ioctl, ll.  463 ff.
in 2.4.9, so Linux always returns the mask for the first address, not
the mask for the requested address. This doesn't matter as long as
eth0:0-style aliases are configured with ifconfig, but it does matter as
soon as ip comes into play and both addresses are assigned to eth0
rather than eth0 and eth0:0.




I believe this would require fixing for compatibility reasons, in the
sense that the address is also compared to figure the interface, but I'm
out of time now and cannot try anything before tomorrow, I'd happily
test patches sent by then.

Would net/ipv4/devinet.c be the only place to fix or are there other
places that do also need fixing?


Non-Postfix guys: Here's how to build inet_addr_local:

1. fetch /mirrors/postfix-release/official/postfix-20010228-pl04.tar.gz
   from ftp.porcupine.org
2. unpack the sources, then do:
   make Makefiles ; cd src/util ; make inet_addr_local
3. add an IP alias to any network (eth in my case), but let it have a
   different netmask than the primary address of the net.

Thanks a lot in advance!

Cheers,

- -- 
Matthias Andree
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iQCVAwUBO5ZQgydEoB0mv1ypAQEzvAP+IMWRaKR+Bvzxbhd/fJCNR8oq//U06kP3
mg1KIoOKX3PBfNkxIZW4l+oTt9wxHAXHJUJ1W6w3T43xlBlcHi4Y70XNKqbyCFiB
n6l+q0JFHv+qV4pWxJCG1sz20nrwK/nUwf+5nxcGAdetPnPBXpndGtiX66nzNtka
NGO38uOvIuA=
=587q
-----END PGP SIGNATURE-----
