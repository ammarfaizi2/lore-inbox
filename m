Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130471AbQLIBPV>; Fri, 8 Dec 2000 20:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132549AbQLIBPK>; Fri, 8 Dec 2000 20:15:10 -0500
Received: from web1.clubnet.net ([206.126.128.3]:62476 "EHLO web1.clubnet.net")
	by vger.kernel.org with ESMTP id <S132266AbQLIBPE>;
	Fri, 8 Dec 2000 20:15:04 -0500
Message-ID: <006501c06179$45d814e0$318d7ece@snowline.net>
From: "Eddy" <edmc@snowline.net>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: 2.2.16 and 2.2.17 nfsroot boot problem with D-Link DE-220PCT
Date: Fri, 8 Dec 2000 16:45:04 -0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0062_01C06136.371623E0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0062_01C06136.371623E0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This is a second posting, I just got back onto the kernel mailing list. =
The first was sent via dejanews. So If this looks familiar... It is. =
Ignore It.

Hi all, I seem to be having some problems configuring kernels 2.2.16 and =
2.2.17 to nfsroot boot. I have two machines at a friends house I am =
trying to link up. The server is an A-Bit BP6 433 celeron with a =
rtl-8139 10/100-tx pci board which is working fine. I am trying to hook =
up a 486-66 with an unknown motherboard type using interface chips =
DX6900A-1 and DX6900A-2 to the ISA bus trying to talk to a brand new =
D-link DE-220-PCT.=20

What I have done is comiled kernels 2.2.16-patched with USB and NTP-PPS =
and K-NSF and a newer 2.2.17 vanilla kernel. The 2.2.16-patched has been =
running fine for many months now. Windows-95 on the 486 runs the D-Link =
card ok. I can talk to the BP6 running samba great. I can take the =
D-Link card out of the 486 stuff it into the BP6 ISA bus. I can modprobe =
eth1 with the ne.o module and up comes the link to the 486. Windows can =
talk to samba great.

I think that I have just about every networking option compiled into the =
2.2.16 kernel except the experimental rarp module??? I've got kernel NFS =
patch from a while back for the 2.2.16 kernel.

I compile the kernel for 486. Strip down most of the stuff I wont need =
on the 486 and leave in the arp/rarp/bootp/dhcp nfs and root on nfs.

I do mknod /dev/nfs b 0 255 ...
I do rdev bzImage.216 /dev/nfs
I do mkdir /tftpboot/192.168.50.2
I do cd /tftpboot/192.168.50.2
I do tar -C /boot -cpsf - | tar -xpsf -  ... to ... tar -C /var -cpsf - =
| tar -xpsf -
I do mkdir /usr /lib /mp3 ... structures to come in shared via nfs
I do cd etc
vi fstab
//celeron:/tftpboot/192.168.50.2 /     nfs rsize=3D8192,wsize=3D8192 0 0
//celeron:/lib                   /lib  nfs rsize=3D8192,wsize=3D8192 0 0
//celeron:/usr                   /usr  nfs rsize=3D8192,wsize=3D8192 0 0
//celeron:/mp3                   /mp3  nfs rsize=3D8192,wsize=3D8192 0 0
/dev/hda1                        /cdrive vfat defaults 0 0
/cdrive/swapfile                 swap   swap  defaults 0 0
none                             /proc  proc  defaults 0 0
none                             /dev/pts pts defaults 0 0
...
wq

I cd /etc
vi exports
/tftpboot/192.168.50.2 486(rw,no_root_squash,no_all_squash)
/lib                   486(rw,no_root_squash,no_all_squash)
/usr                   486(rw,no_root_squash,no)all_squash)
...
a bunch of other stuff
wq
vi dhcpd.conf
shared-network 192.168.50.0;
  { allow bootp;
    server-name "celeron";
    server-identifier 192.168.50.1;
    subnet 192.168.50.0 netmask 255.255.255.0;
      { range 192.168.50.15 192.168.50.99;
        default-lease-time 600; max-lease-time 7200;
        option subnet-mask 255.255.255.0;
        option domain-name Sophie;
      }
    group
      { host 486
         { hardware 00:50:ba:05:7b:fb;
           fixed-address 192.168.50.2;
          }
       }
  }
:wq
vi /etc/rc.d/init.d/rarp
... a bunch of junk
start =3D /sbin/rarp -s 192.168.50.2 00:50:ba:05:7b:fb
stop  =3D /sbin/rarp -d 192.168.50.2
status =3D /sbin/rarp -a
... a bunch more juck
:wq
vi /etc/rc.d/init.d/dhcpd
I add "eth0" to the "daemon dhcpd" start line.
:wq
cd /etc/rc.d
ln -s ../init.d/rarp rc5.d/S15rarp
ln -s ../init.d/rarp rc4.d/S15rarp
ln -s ../init.d/rarp rc3.d/s15rarp
ln -s ../init.d/dhcpd rc5.d/S65dhcpd
ln -s ../init.d/dhcpd rc4.d/S65dhcpd
ln -s ../init.d/dhcpd rc3.d/S65dhcpd

rarp -a reports 192.168.50.2 00:50:ba:05:7b:fb

tail /var/log/messages reports
"dhcpd sending and recieving on eth0 191.168.50.0... ready and waiting"

so know we do

cd /usr/src/linux/arch/i386/boot
ln -f bzImage-486.216 /tmp/
ln -f bzImage-486.217 /tmp/ ... after the rdev thingy

boot up windows on the 486.
open up the tmp samba share
copy bzImage* c:\

try
c:\loadlin.exe c:\bzImage-486.216 root=3D/dev/nfs ether=3D0,0,eth0
c:\loadlin.exe c:\bzImage-486.216 root=3D0:255 ether=3D0,0,eth0
c:\loadlin.exe c:\bzImage-486.216 root=3D/dev/nfs ip=3Dautoconf =
ether=3D0,0,eth0
c:\loadlin.exe c:\bzImage-486.216 root=3D/dev/nfs ip=3Dboth =
nfsroot=3D192.168.50.1:/tftpboot/192.168.50.2,rsize=3D8192,wsize=3D8192 =
ether=3D0,0,eth0
c:\loadlin.exe c:\bzImage-486.216 root=3D/dev/nfs nfsaddrs=3Dauto =
ether=3D0,0,eth0 ... "for compatibility reasons only"
c:\loadlin.exe c:\bzImage-486.216 root=3D/dev/nfs =
nfsaddrs=3D192.168.50.2:192.168.50.1::255.255.255.0:eth0:both ... "again =
only for compatibility reasons"
c:\loadlin.exe c:\bzImage-486.216 root=3D/dev/nfs =
ip=3Dsomething:something:something:something:something:something:Idon'tkn=
owhatelse nfsroot=3D192.168.50.1%s,rsize=3D8192,wsize=3D8192 =
nfsaddrs=3Dmyip:serv-ip:nogw:netmask:eth0 ether=3D9,0x280,eth0 =
lp=3D7,0x378 mem=3D8192k init=3D1
...
and every other combinations that I could possible try to think of after =
3 days of continuous awakining.
...
Ditto for bzImage.217
...
OK
The result is always the same on the 486. Both kernels.
First.. the kernel would boot up until it got to "hda". It would then =
hang after reporting some stuff about ide-something assuming 50Mhz and I =
you have to do is add another kernel parameter=3Dxx. So I tried =
10,15,20,25 all with the same results... Hang.
So recompiled the kernels and put back the old mfm/rll/ide disc suppot. =
The help said something about the old 486's having problems sometimes =
with the newer fancy module. And W-A-A-L-A-A-H-H I now see Donald =
Becker. ne.c:v1.10 9/23/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)
NE*000 ethercard probe at 0x280: 00:40:05:3f:20:d6 ... yes I know... =
It's just a backup card. I'll put the other one back when it starts =
working.
eth0: NE2000 found at 0x280, using IRQ 9.
_


and thats as far as I've gotten. So far.

Do any of the the kernel hacker type folks got any ideas what I can do =
next?

I Think I'll try the doing the debug thing but I've never done it yet =
and really don't know where to start. But I'm getting a little sleeply =
know so I think I'm going to just rest my head for a while.

Thanks in Advance
Eddy Cornu=20

------=_NextPart_000_0062_01C06136.371623E0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 5.50.4207.2601" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>This is a second posting, I just got =
back onto the=20
kernel mailing list. The first was sent via dejanews. So If this looks=20
familiar... It is. Ignore It.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Hi all, I seem to be having some =
problems=20
configuring kernels 2.2.16 and 2.2.17 to nfsroot boot. I have two =
machines at a=20
friends house I am trying to link up. The server is an A-Bit BP6 433 =
celeron=20
with a rtl-8139 10/100-tx pci board which is working fine. I am trying =
to hook=20
up a 486-66 with an unknown motherboard type using interface chips =
DX6900A-1 and=20
DX6900A-2 to the ISA bus trying to talk to a brand new D-link =
DE-220-PCT.=20
</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>What I have done is comiled kernels =
2.2.16-patched=20
with USB and NTP-PPS and K-NSF and a newer 2.2.17 vanilla kernel. The=20
2.2.16-patched has been running fine for many months now. Windows-95 on =
the 486=20
runs the D-Link card ok. I can talk to the BP6 running samba great. I =
can take=20
the D-Link card out of the 486 stuff it into the BP6 ISA bus. I can =
modprobe=20
eth1 with the ne.o module and up comes the link to the 486. Windows can =
talk to=20
samba great.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I think that I have just about every =
networking=20
option compiled into the 2.2.16 kernel except the experimental rarp =
module???=20
I've got kernel NFS patch from a while back for the 2.2.16 =
kernel.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I compile the kernel for 486. Strip =
down most of=20
the stuff I wont need on the 486 and leave in the arp/rarp/bootp/dhcp =
nfs and=20
root on nfs.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I do mknod /dev/nfs b 0 255 ...<BR>I do =
rdev=20
bzImage.216 /dev/nfs<BR>I do mkdir /tftpboot/192.168.50.2<BR>I do cd=20
/tftpboot/192.168.50.2<BR>I do tar -C /boot -cpsf - | tar -xpsf -&nbsp; =
... to=20
... tar -C /var -cpsf - | tar -xpsf -<BR>I do mkdir /usr /lib /mp3 ...=20
structures to come in shared via nfs<BR>I do cd etc<BR>vi=20
fstab<BR>//celeron:/tftpboot/192.168.50.2 /&nbsp;&nbsp;&nbsp;&nbsp; nfs=20
rsize=3D8192,wsize=3D8192 0=20
0<BR>//celeron:/lib&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/lib&nbsp; nfs rsize=3D8192,wsize=3D8192 0=20
0<BR>//celeron:/usr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/usr&nbsp; nfs rsize=3D8192,wsize=3D8192 0=20
0<BR>//celeron:/mp3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/mp3&nbsp; nfs rsize=3D8192,wsize=3D8192 0=20
0<BR>/dev/hda1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
/cdrive vfat defaults 0=20
0<BR>/cdrive/swapfile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
swap&nbsp;&nbsp; swap&nbsp; defaults 0=20
0<BR>none&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/proc&nbsp; proc&nbsp; defaults 0=20
0<BR>none&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/dev/pts pts defaults 0 0<BR>...<BR>wq</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I cd /etc<BR>vi =
exports<BR>/tftpboot/192.168.50.2=20
486(rw,no_root_squash,no_all_squash)<BR>/lib&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
486(rw,no_root_squash,no_all_squash)<BR>/usr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
486(rw,no_root_squash,no)all_squash)<BR>...<BR>a bunch of other=20
stuff<BR>wq<BR>vi dhcpd.conf<BR>shared-network 192.168.50.0;<BR>&nbsp; { =
allow=20
bootp;<BR>&nbsp;&nbsp;&nbsp; server-name =
"celeron";<BR>&nbsp;&nbsp;&nbsp;=20
server-identifier 192.168.50.1;<BR>&nbsp;&nbsp;&nbsp; subnet =
192.168.50.0=20
netmask 255.255.255.0;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { range =
192.168.50.15=20
192.168.50.99;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
default-lease-time=20
600; max-lease-time 7200;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
option=20
subnet-mask 255.255.255.0;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
option=20
domain-name Sophie;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>&nbsp;&nbsp;&nbsp;=20
group<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { host=20
486<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { hardware=20
00:50:ba:05:7b:fb;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;=20
fixed-address=20
192.168.50.2;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
}<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>&nbsp; }<BR>:wq<BR>vi=20
/etc/rc.d/init.d/rarp<BR>... a bunch of junk<BR>start =3D /sbin/rarp -s=20
192.168.50.2 00:50:ba:05:7b:fb<BR>stop&nbsp; =3D /sbin/rarp -d=20
192.168.50.2<BR>status =3D /sbin/rarp -a<BR>... a bunch more =
juck<BR>:wq<BR>vi=20
/etc/rc.d/init.d/dhcpd<BR>I add "eth0" to the "daemon dhcpd" start=20
line.<BR>:wq<BR>cd /etc/rc.d<BR>ln -s ../init.d/rarp rc5.d/S15rarp<BR>ln =
-s=20
../init.d/rarp rc4.d/S15rarp<BR>ln -s ../init.d/rarp rc3.d/s15rarp<BR>ln =
-s=20
../init.d/dhcpd rc5.d/S65dhcpd<BR>ln -s ../init.d/dhcpd =
rc4.d/S65dhcpd<BR>ln -s=20
../init.d/dhcpd rc3.d/S65dhcpd</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>rarp -a reports 192.168.50.2=20
00:50:ba:05:7b:fb</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>tail /var/log/messages =
reports<BR>"dhcpd sending=20
and recieving on eth0 191.168.50.0... ready and waiting"</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>so know we do</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>cd /usr/src/linux/arch/i386/boot<BR>ln =
-f=20
bzImage-486.216 /tmp/<BR>ln -f bzImage-486.217 /tmp/ ... after the rdev=20
thingy</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>boot up windows on the 486.<BR>open up =
the tmp=20
samba share<BR>copy bzImage* c:\</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>try<BR>c:\loadlin.exe =
c:\bzImage-486.216=20
root=3D/dev/nfs ether=3D0,0,eth0<BR>c:\loadlin.exe c:\bzImage-486.216 =
root=3D0:255=20
ether=3D0,0,eth0<BR>c:\loadlin.exe c:\bzImage-486.216 root=3D/dev/nfs =
ip=3Dautoconf=20
ether=3D0,0,eth0<BR>c:\loadlin.exe c:\bzImage-486.216 root=3D/dev/nfs =
ip=3Dboth=20
nfsroot=3D192.168.50.1:/tftpboot/192.168.50.2,rsize=3D8192,wsize=3D8192=20
ether=3D0,0,eth0<BR>c:\loadlin.exe c:\bzImage-486.216 root=3D/dev/nfs =
nfsaddrs=3Dauto=20
ether=3D0,0,eth0 ... "for compatibility reasons only"<BR>c:\loadlin.exe=20
c:\bzImage-486.216 root=3D/dev/nfs=20
nfsaddrs=3D192.168.50.2:192.168.50.1::255.255.255.0:eth0:both ... "again =
only for=20
compatibility reasons"<BR>c:\loadlin.exe c:\bzImage-486.216 =
root=3D/dev/nfs=20
ip=3Dsomething:something:something:something:something:something:Idon'tkn=
owhatelse=20
nfsroot=3D192.168.50.1%s,rsize=3D8192,wsize=3D8192=20
nfsaddrs=3Dmyip:serv-ip:nogw:netmask:eth0 ether=3D9,0x280,eth0 =
lp=3D7,0x378 mem=3D8192k=20
init=3D1<BR>...<BR>and every other combinations that I could possible =
try to think=20
of after 3 days of continuous awakining.<BR>...<BR>Ditto for=20
bzImage.217<BR>...<BR>OK<BR>The result is always the same on the 486. =
Both=20
kernels.<BR>First.. the kernel would boot up until it got to "hda". It =
would=20
then hang after reporting some stuff about ide-something assuming 50Mhz =
and I=20
you have to do is add another kernel parameter=3Dxx. So I tried =
10,15,20,25 all=20
with the same results... Hang.<BR>So recompiled the kernels and put back =
the old=20
mfm/rll/ide disc suppot. The help said something about the old 486's =
having=20
problems sometimes with the newer fancy module. And W-A-A-L-A-A-H-H I =
now see=20
Donald Becker. ne.c:v1.10 9/23/94 Donald Becker (<A=20
href=3D"mailto:becker@cesdis.gsfc.nasa.gov">becker@cesdis.gsfc.nasa.gov</=
A>)<BR>NE*000=20
ethercard probe at 0x280: 00:40:05:3f:20:d6 ... yes I know... It's just =
a backup=20
card. I'll put the other one back when it starts working.<BR>eth0: =
NE2000 found=20
at 0x280, using IRQ 9.<BR>_</FONT></DIV>
<DIV>&nbsp;</DIV><FONT face=3DArial size=3D2>
<DIV><BR>and thats as far as I've gotten. So far.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Do any of the the kernel hacker type folks got any ideas what I can =
do=20
next?</DIV>
<DIV>&nbsp;</DIV>
<DIV>I Think I'll try the doing the debug thing but I've never done it =
yet and=20
really don't know where to start. But I'm getting a little sleeply know =
so I=20
think I'm going to just rest my head for a while.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks in Advance<BR>Eddy Cornu </FONT></DIV></BODY></HTML>

------=_NextPart_000_0062_01C06136.371623E0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
