Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbTBBXym>; Sun, 2 Feb 2003 18:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265806AbTBBXyl>; Sun, 2 Feb 2003 18:54:41 -0500
Received: from netsonic.fi ([194.29.192.20]:36562 "EHLO nalle.netsonic.fi")
	by vger.kernel.org with ESMTP id <S265815AbTBBXyj>;
	Sun, 2 Feb 2003 18:54:39 -0500
Date: Mon, 3 Feb 2003 02:09:00 +0200 (EET)
From: Sampsa Ranta <sampsa@netsonic.fi>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG/2.4.x] Proc / sysctl bug
Message-ID: <Pine.LNX.4.33.0211301348280.24319-100000@nalle.netsonic.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

proc interface to sysctl is unable to handle acces to interfaces
parameters that are configured by when you have a lot of interfaces, only
"all" + "default" + 133 first interfaces or something like that are
accessible via /proc/sys/net/ipv4/conf/.

Via sysctl() syscall these seemed to work fine when I last checked. I
sometimies keep wondering why each kernel function including this is
accessible via two different interface. =)

Brief demo example on procfs sysctl interface with tunnels follows.

Altough if one loads for example ipv6 module after executing the script
below, the ipv6 module is not able to register to proc-filesystem.

I've tested this against RedHat kernel 2.4.18 and 2.4.20pre3.

---  tunnel.pl ---
#!/usr/bin/perl -w

$i = 1;

while($i < 200) {
  $cmd = "/sbin/ip tunnel add sit$i remote 192.168.1.$i local 192.168.1.2 dev eth0 mode ipip";
  print $cmd."\n";
  system($cmd);
  $cmd="/sbin/ip addr add 192.168.1.2/24 dev sit$i";
  print $cmd."\n";
  system($cmd);
  $cmd="/sbin/ip link set sit$i up";
  print $cmd."\n";
  system($cmd);
  $i++;
}

system#./tunnel.pl
...
system# /sbin/ip addr show dev sit199
202: sit199@eth0: <POINTOPOINT,NOARP,UP> mtu 1480 qdisc noqueue
    link/ipip 192.168.1.2 peer 192.168.1.199
    inet 192.168.1.2/24 scope global sit199
system#ls /proc/sys/net/ipv4/conf/
all      sit107  sit12   sit14  sit28  sit40  sit53  sit66  sit79  sit91
default  sit108  sit120  sit15  sit29  sit41  sit54  sit67  sit8   sit92
eth0     sit109  sit121  sit16  sit3   sit42  sit55  sit68  sit80  sit93
lo       sit11   sit122  sit17  sit30  sit43  sit56  sit69  sit81  sit94
sit0     sit110  sit123  sit18  sit31  sit44  sit57  sit7   sit82  sit95
sit1     sit111  sit124  sit19  sit32  sit45  sit58  sit70  sit83  sit96
sit10    sit112  sit125  sit20  sit33  sit46  sit59  sit71  sit84  sit97
sit100   sit113  sit126  sit21  sit34  sit47  sit6   sit72  sit85  sit98
sit101   sit114  sit127  sit22  sit35  sit48  sit60  sit73  sit86  sit99
sit102   sit115  sit128  sit23  sit36  sit49  sit61  sit74  sit87
sit103   sit116  sit129  sit24  sit37  sit5   sit62  sit75  sit88
sit104   sit117  sit13   sit25  sit38  sit50  sit63  sit76  sit89
sit105   sit118  sit130  sit26  sit39  sit51  sit64  sit77  sit9
sit106   sit119  sit131  sit27  sit4   sit52  sit65  sit78  sit90
system# ls /proc/sys/net/ipv4/conf/sit199
ls: /proc/sys/net/ipv4/conf/sit199: No such file or directory
system# ls /proc/sys/net/ipv4/conf/|wc -l
    135

Thanks,
 Sampsa Ranta



