Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316421AbSEWPOv>; Thu, 23 May 2002 11:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316431AbSEWPOu>; Thu, 23 May 2002 11:14:50 -0400
Received: from mail11b.verio-web.com ([161.58.148.19]:48661 "HELO
	mail-fwd.verio-web.com") by vger.kernel.org with SMTP
	id <S316421AbSEWPOs>; Thu, 23 May 2002 11:14:48 -0400
Message-ID: <00b701c2026c$8bf0e8e0$320e10ac@irvine.hnc.com>
Reply-To: "Kirk" <kirk@scriptdoggie.com>
From: "Kirk" <kirk@scriptdoggie.com>
To: "Ambrish Verma" <averma@marantinetworks.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <003b01c201ca$fc5e5f60$3701a8c0@maranti.com>
Subject: Re: RE:ipfwadm
Date: Thu, 23 May 2002 08:14:33 -0700
Organization: ScriptDoggie Inc
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Loop-Detect: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Unfortunately this didn't work.  I'm sure it's something I'm doing wrong and
it's driving me nutty, the iptables man documentation is cryptic at best and
provides no examples (is there someplace I can go to view similar
examples?).  So here's what I have, maybe someone has time to clue me in:


Hardware Config:
--------------------
"the internet cloud"
        |
(eth1)  - 10.1.1.166/30
[LXS] - Linux 2.4.18
(eth0) - 192.168.0.1/24
        |
(eth1) - 192.168.0.22/24
[WNT] - Windoze NT 2000
--------------------

This was working with kernel 2.2.x and ipchains:
--------------------
# rc.firewall
/sbin/depmod -a
/sbin/modprobe ip_masq_ftp
echo "1" > /proc/sys/net/ipv4/ip_forward
ipchains -M -S 7200 10 60
ipchains -P forward DENY
ipchains -A forward -s 192.168.0.0/24 -j MASQ
--------------------

So I replaced it with:
--------------------
# rc.firewall
iptables -F
echo 1 > /proc/sys/net/ipv4/ip_forward
echo 1 > /proc/sys/net/ipv4/conf/eth0/proxy_arp
echo 1 > /proc/sys/net/ipv4/conf/eth1/proxy_arp
iptables -A FORWARD -i eth0 -o eth1 -s 192.168.0.22/24 -d 10.1.1.166/30 -v
iptables -A FORWARD -i eth1 -o eth0 -s 10.1.1.166/30 -d 192.168.0.22/24 -v
--------------------

And a call to iptables -L reveals:
--------------------
$ >sudo iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination
           all  --  192.168.0.0/24       bdsl.10.1.1.164.gte.net/30
           all  --  bdsl.10.1.1.164.gte.net/30  192.168.0.0/24

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination
$ >
--------------------

Now, everything else withing the local 192 network is working, samba and
all.  From WNT I can ping 192.168.0.1 and 10.1.1.166, and From LXS I can
ping 192.168.0.22.  I'm obviously no expert but it looks like it's missing
something related to the masqurading (nat perhaps?)

Frustrated,
Kirk




----- Original Message -----
From: "Ambrish Verma" <averma@marantinetworks.com>
To: "'Kirk'" <kirk@scriptdoggie.com>
Sent: Wednesday, May 22, 2002 12:58 PM
Subject: RE: RE:ipfwadm


> Certainly it can do this..
>
> For this you need to follow these steps:
> Here are some assumptions first:
>
> Eth0: 192.168.1.22 (local  net.) and eth1:10.1.1.25 (lets say it
> is your wan).
> IBM box (ipstore1_data) : 192.168.1.8 (Maranti net.) and
> 11.1.1.25 (to linux2)
> Linux2: 192.168.1.17 (Maranti net on eth1), 10.1.1.63 (to
> Stileto2 on eth0) and
>
> First check whether your kernel has iptables compiled or not, this you
> can test just by typing "iptables -L" on prompt, if it shows somw tables
> than fine but if shows some error message than you need to do this:
> [ . Login as a root.
> . Make xconfig and see if you have "packet netfiltering"
> included under "networking options". If it is not already
> included than you need to include it and also all the options
> under "netfilter configuration" should be included.
> . Now if you have made some change to configuration in
> earlier step, than you need to recompile the kernel (simple
> steps like make dep, make clean, make bzImage, make modules and
> make modules_install. Than you also need to update the image under
> /boot directory and don't forget to run /etc/lilo again else the
> new image will not be included in your boot menu.). Now reboot the
> system.
> ]
>
> if it was fine than just enable the ip forwarding, for this follow these
> steps:
> 1) $ echo 1 > /proc/sys/net/ipv4/ip_forward
> 2) In case you want your internal hosts to see outside and vice-versa
> also
>    $ echo 1 > /proc/sys/net/ipv4/conf/eth0/proxy_arp
>    $ echo 1 > /proc/sys/net/ipv4/conf/eth2/proxy_arp
>
> 3) $ iptables -A FORWARD -i eth0 -o eth1 -s 192.168.1.22/24 -d
> 10.1.1.25/24
>   and similar one if you want other way also.
>
> Once all this is done do "iptables -L" it will show you newly added
> rules.
>
> The case I explained above may require some changes in terms of ip
> address and netmask, please be careful about that.
>
>
> --
> Ambrish
> p.s.:  I can not post this message on newsgroup (as I do not have
> access), if you can post this whole thing there than it may be of help
> for others as well.
>
>
>
> -----Original Message-----
> From: Kirk [mailto:kirk@scriptdoggie.com]
> Sent: Wednesday, May 22, 2002 12:40 PM
> To: Ambrish Verma
> Subject: Re: RE:ipfwadm
>
> Does iptables have or allow IP Masqurading?  This is really what I'm
> trying
> to do as I have a network behind my linux server (acting as a router)
> and
> need to forward packets from 192.168.0.x to my WAN port on the same
> Linux
> server.  I had this working with ipchains until the upgrade to 2.4.18.
>
> Thanks,
> Kirk
>
> ----- Original Message -----
> From: "Ambrish Verma" <averma@marantinetworks.com>
> To: <kirk@scriptdoggie.com>
> Sent: Wednesday, May 22, 2002 12:18 PM
> Subject: RE:ipfwadm
>
>
> > In the new kernels ipchains is not included by default (probably if
> you
> > put
> > some effort you can include it.).
> > There is an alternate for ipchains is available called iptables, with
> > which
> > you should be able to do most of the things you expect from ipchains.
> >
> > --
> > Ambrish
> >
> >

