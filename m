Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269731AbRHQGng>; Fri, 17 Aug 2001 02:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269735AbRHQGn1>; Fri, 17 Aug 2001 02:43:27 -0400
Received: from camus.xss.co.at ([194.152.162.19]:12048 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S269731AbRHQGnW>;
	Fri, 17 Aug 2001 02:43:22 -0400
Message-ID: <3B7CBCD0.CD209D84@xss.co.at>
Date: Fri, 17 Aug 2001 08:42:24 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S - *x Software + Systeme
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Pavel Machek <pavel@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Bulent Abali <abali@us.ibm.com>,
        "Dirk W. Steinberg" <dws@dirksteinberg.de>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Swapping for diskless nodes
In-Reply-To: <Pine.LNX.4.33L.0108162146120.5646-100000@imladris.rielhome.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Rik van Riel wrote:
> 
> On Thu, 16 Aug 2001, Pavel Machek wrote:
> 
> > I'd call that configuration error. If swap-over-nbd works in all but
> > such cases, its okay with me.
> 
> Agreed. I'm very interested in this case too, I guess we
> should start testing swap-over-nbd and trying to fix things
> as we encounter them...
> 
We do "testing" swap-over-nbd for some time now... :-))

In fact, all our workstations in our office are xS+S Diskless Clients, 
and about 50 Diskless Clients are running at several customer sites.

In order to make Pavel happy :-) we did some more stress testing
now, and here are the results:

We set up a quite old machine (ASUS P55T2P4 motherboard,
64MB RAM, AMD K6/200 CPU, Matrox Millenium II graphics card,
RTL8139 100MBit Ethernet) as Diskless Client with NBD Swap.

We installed our up-coming BLD-3.1 with Linux-2.2.19 kernel,
Etherboot+initrd, DevFS and NBD swap patches.

We started all kind of programs (KDE, Netscape, StarOffice,
Acrobat Reader, Emacs, X11 with several background images,
The Gimp and so on). To make memory more tight, we created
to ramdisks of 16MB each and filled them up (counting for 32MB
RAM used in buffers). The machine was slow, but still usable!
(Well, I wouldn't recommend to actually _use_ a system under
such load, but anyway... :-)

We let this configuration run for several hours, and it 
stayed very well alive. Swapping over NBD was _heavy_

We also started a ping -f from the server to the client
and let this run for about an hour. The client lost quite a few
packets, and interactive performance was really low (you
had to wait more than a minute for a switch between two
KDE desktops), but the system stayed alive!

Here are some figures from the system in this situation:

root@dws4:~ {138} $ date
Fri Aug 17 08:13:17 CEST 2001

root@dws4:~ {139} $ uname -a
Linux dws4 2.2.19 #1 Thu Aug 9 09:01:01 CEST 2001 i586 unknown

root@dws4:~ {140} $ uptime
  8:13am  up 15:04,  5 users,  load average: 4.84, 5.91, 6.54

root@dws4:~ {141} $ free
             total       used       free     shared    buffers    
cached
Mem:         63488      62088       1400      15396      32488     
10476
-/+ buffers/cache:      19124      44364
Swap:       204792     117520      87272 

root@dws4:~ {142} $ mount
/dev/root on / type nfs
(ro,v2,rsize=4096,wsize=4096,nolock,addr=192.168.163.2)
none on /dev type devfs (rw)
/dev/root.old on /initrd type romfs (ro)
proc on /proc type proc (rw)
/dev/rd/1 on /var type ext2 (rw)
server.demo.xss.co.at:/home on /home type nfs
(rw,v3,rsize=8192,wsize=8192,soft,addr=server.demo.xss.co.at)

root@dws4:~ {143} $ vmstat 1
   procs                      memory    swap          io    
system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs 
us  sy  id
 1  8  3 118092   1196  32488  11044 183  14    46     4  563   115 
59  37   5
 0 10  0 117984   1160  32488  10976 1120  16   280     4 24068   791 
18  73  10
 2 11  0 117860   1236  32488  10852 704   0   176     0 23064   495 
14  61  25
 0  9  1 117792    612  32488  11332 740  56   185    14 22500   657 
17  58  24
 2  8  0 117780   1572  32488  10364 480  60   120    15 22563   378 
11  63  27
 0  8  0 117860   1192  32488  10812 664 124   166    31 23140   651 
22  60  18
 1  7  0 117860   1432  32488  10620 532  16   133     5 22842   443  
8  66  26
 2  6  0 117800   1252  32488  10700 512   0   128     0 23410   820 
23  70   6
 0  6  0 117764   1608  32488  10376 548   0   137     1 22497   551 
25  66   9
 2  5  0 117816   1176  32488  10768 880  88   220    23 24694   538 
15  60  25

root@dws4:~ {144} $ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 6
model name      : AMD-K6tm w/ multimedia extensions
stepping        : 2
cpu MHz         : 200.459
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mmx
bogomips        : 399.76

root@dws4:~ {145} $ cat /proc/interrupts
           CPU0
  0:    5446658          XT-PIC  timer
  1:       3295          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:      60105          XT-PIC  serial
  8:          2          XT-PIC  rtc
 10:   52056240          XT-PIC  eth0
 13:          1          XT-PIC  fpu
NMI:          0 

root@dws4:~ {146} $ lspci
00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II]
(rev 03)
00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton
II] (rev 01)
00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE
[Natoma/Triton II]
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
00:0b.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W
[Millennium II]

root@dws4:~ {147} $ ps aux
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1064   60 ?        S    Aug16   0:01 init
[5]
root         2  0.0  0.0     0    0 ?        SW   Aug16   0:00
[kflushd]
root         3  0.0  0.0     0    0 ?        SW   Aug16   0:00
[kupdate]
root         4  0.8  0.0     0    0 ?        SW   Aug16   7:19
[kswapd]
root         5  0.0  0.0     0    0 ?        SW   Aug16   0:00
[kreclaimd]
root         6  0.0  0.0     0    0 ?        SW   Aug16   0:00
[keventd]
root        64  0.0  0.0     0    0 ?        SW   Aug16   0:00 [eth0]
root        70  0.5  0.0     0    0 ?        SW   Aug16   4:42
[rpciod]
daemon     163  0.0  0.0  1060    0 ?        SW   Aug16   0:00
[portmap]
root       165  0.0  0.0  1176    0 ?        SW   Aug16   0:00
[rpc.statd]
root       253  0.0  0.0  1496    0 ?        SW   Aug16   0:00
[devfsd]
root       316  0.0  0.0     0    0 ?        SW   Aug16   0:00 [lockd]
root       413  0.0  0.1  1468   68 ?        S    Aug16   0:01
/sbin/syslogd -p /var/log/log
root       420  0.0  0.0  1328    0 ?        SW   Aug16   0:00 [klogd]
root       465  0.0  0.1  1500   96 ?        S    Aug16   0:00
/usr/sbin/cron
root       555  0.0  0.0  1384    0 ?        SW   Aug16   0:00 [inetd]
root       592  0.0  0.2  1288  148 ?        S    Aug16   0:00
[ypbind]
root       596  0.0  0.2  1288  148 ?        S    Aug16   0:00
[ypbind]
root       597  0.0  0.2  1288  148 ?        S    Aug16   0:00
[ypbind]
root       599  0.0  0.2  1288  148 ?        S    Aug16   0:02
[ypbind]
root       606  0.0  0.0  1072    0 vc/3     SW   Aug16   0:00 [getty]
root       607  0.0  0.0  1072    0 vc/4     SW   Aug16   0:00 [getty]
root       674  0.7  0.0  1368    0 ?        SW   Aug16   7:08
[nbdswapc]
root       744  0.0  0.0  2176    0 ?        SW   Aug16   0:00 [login]
root       749  0.0  0.0  2200    0 vc/2     SW   Aug16   0:00 [sh]
root       786  0.0  0.0 12196    0 ?        SW   Aug16   0:00 [kdm]
root       787 31.9  5.6 42332 3588 ttyS1    D    Aug16 286:37
/usr/X11R6/bin/XFree86 -indirect dws4 :0 -depth 16 -dpi 75 vt12
root       881  0.0  0.0 13364    0 ?        SW   Aug16   0:00 [kdm]
demouser   898  0.0  0.0  1652    0 ?        SW   Aug16   0:00
[startkde]
demouser   926  0.0  0.0 13780    0 ?        SW   Aug16   0:03
[kdeinit]
demouser   928  0.0  0.0 14036    0 ?        SW   Aug16   0:01
[kdeinit]
demouser   930  0.0  0.6 13740  404 ?        S    Aug16   0:04
kdeinit: kded
demouser   938  0.0  0.0 13892    0 ?        SW   Aug16   0:00
[kdeinit]
demouser   950  0.0  0.0 13728    0 ?        SW   Aug16   0:00
[kdeinit]
demouser   952  0.0  0.0 13452    0 ?        SW   Aug16   0:05
[knotify]
demouser   953  0.0  0.0 10204    0 ?        SW   Aug16   0:04
[ksmserver]
demouser   954  0.3  1.6 15276 1032 ?        S    Aug16   3:33
kdeinit: kwin -session 11c0a8a369000098969662300000009350000
demouser   957  0.1  2.0 16852 1284 ?        S    Aug16   1:15
kdeinit: kdesktop
demouser   959  0.3  2.7 17212 1720 ?        S    Aug16   3:06
kdeinit: kicker
demouser   960  0.0  0.0 14232   24 ?        S    Aug16   0:00
kdeinit: kio_file file
/tmp/ksocket-demouser/klauncherPfMg8b.slave-socket
/tmp/ksocket-demouser/kdesktopsQAzbc.slave-soc
demouser   963  0.1  1.3 14788  856 ?        S    Aug16   1:20
kdeinit: klipper -icon klipper -miniicon klipper
demouser   965  0.0  0.0 14476    0 ?        SW   Aug16   0:01
[kdeinit]
demouser   967  0.0  0.0 14720    0 ?        SW   Aug16   0:02
[kdeinit]
demouser   968  0.0  0.0  1020    0 pts/0    SW   Aug16   0:00 [cat]
demouser   969  4.0  1.7  9624 1128 ?        S    Aug16  36:42 qps
demouser   971  0.0  0.0 15160    0 ?        SW   Aug16   0:05
[kdeinit]
demouser   972  0.0  0.0  2100    0 pts/1    SW   Aug16   0:00 [zsh]
root       991  0.0  0.0  1236   52 ?        S    Aug16   0:05
[in.telnetd]
root       992  0.0  0.0  2252    0 ?        SW   Aug16   0:00 [login]
root       993  0.0  0.0  2188    0 pts/2    SW   Aug16   0:00 [sh]
demouser  1002  0.6  3.3 121272 2140 pts/1   D    Aug16   5:30
/opt/StarOffice-5.2/program/soffice.bin
demouser  1019  0.0  3.3 121272 2140 pts/1   S    Aug16   0:00
/opt/StarOffice-5.2/program/soffice.bin
demouser  1020  0.0  3.3 121272 2140 pts/1   S    Aug16   0:00
/opt/StarOffice-5.2/program/soffice.bin
demouser  1021  0.0  3.3 121272 2140 pts/1   S    Aug16   0:00
/opt/StarOffice-5.2/program/soffice.bin
demouser  1022  0.0  3.3 121272 2140 pts/1   S    Aug16   0:03
/opt/StarOffice-5.2/program/soffice.bin
demouser  1024  0.0  3.3 121272 2140 pts/1   S    Aug16   0:10
/opt/StarOffice-5.2/program/soffice.bin
demouser  1025  0.0  3.3 121272 2140 pts/1   S    Aug16   0:01
/opt/StarOffice-5.2/program/soffice.bin
demouser  1026  0.0  3.3 121272 2140 pts/1   S    Aug16   0:00
/opt/StarOffice-5.2/program/soffice.bin
demouser  1027  0.0  3.3 121272 2140 pts/1   S    Aug16   0:00
/opt/StarOffice-5.2/program/soffice.bin
demouser  1028  0.0  3.3 121272 2148 pts/1   S    Aug16   0:00
/opt/StarOffice-5.2/program/soffice.bin
demouser  1029  0.0  3.3 121272 2148 pts/1   S    Aug16   0:00
/opt/StarOffice-5.2/program/soffice.bin
demouser  1031  0.0  3.3 121272 2148 pts/1   S    Aug16   0:00
/opt/StarOffice-5.2/program/soffice.bin
demouser  1035  0.4  3.3 23028 2104 ?        S    Aug16   4:05
kdeinit: konqueror --silent
demouser  1044  0.0  0.0 14636    0 ?        SW   Aug16   0:01
[kdeinit]
demouser  1048  0.0  0.0 10044   32 ?        S    Aug16   0:00 kdesud
demouser  1058  0.0  0.0 18264    0 ?        SW   Aug16   0:10
[kdeinit]
demouser  1059  0.0  0.0 18592    0 ?        SW   Aug16   0:09
[kdeinit]
demouser  1060  0.0  0.0 23604    0 ?        SW   Aug16   0:27
[netscape]
demouser  1061  0.0  0.0 16892    0 ?        SW   Aug16   0:00
[netscape]
demouser  1067  0.0  0.0  7356    0 ?        SW   Aug16   0:01 [emacs]
demouser  1069  0.0  1.1 12812  736 ?        S    Aug16   0:25 amor
demouser  1072  9.6  4.2 15768 2728 ?        D    Aug16  85:26
ksysguard
demouser  1073  5.2  0.5  1616  368 ?        S    Aug16  46:27
ksysguardd
demouser  1092  0.0  0.0 15392    0 ?        SW   Aug16   0:52
[konsole]
demouser  1094  0.0  0.0  2120    0 pts/3    SW   Aug16   0:00 [zsh]
demouser  1127  0.0  0.6 13656  388 pts/3    S    Aug16   0:18
/opt/Acrobat4/Reader/intellinux/bin/acroread
root      1144  0.2  0.0  1236   56 ?        S    Aug16   2:08
[in.telnetd]
root      1145  0.0  0.0  2252    0 ?        SW   Aug16   0:00 [login]
root      1146  0.0  0.0  2192    0 pts/4    SW   Aug16   0:00 [sh]
root      1165  6.7  0.7  2052  488 pts/4    S    Aug16  58:46 top
demouser  1167  4.7  1.7 15428 1104 ?        S    Aug16  38:19
kdeinit: konsole -ls -icon konsole -miniicon konsole -caption konsole
demouser  1168  0.0  0.0  2112    0 pts/5    SW   Aug16   0:00 [zsh]
demouser  1175 11.9  0.7  2052  488 pts/5    S    Aug16  95:01 top
root      1209  5.9  0.3  1072  216 pts/2    S    07:20   3:27 vmstat
1
demouser  1213  0.0  3.3 121272 2148 pts/1   S    07:25   0:00
/opt/StarOffice-5.2/program/soffice.bin
demouser  1214  0.0  3.3 121272 2148 pts/1   S    07:25   0:00
/opt/StarOffice-5.2/program/soffice.bin
root      1215  0.0  0.0  1236   60 ?        S    07:25   0:00
[in.telnetd]
demouser  1216  0.0  3.3 121272 2148 pts/1   S    07:25   0:00
/opt/StarOffice-5.2/program/soffice.bin
root      1217  0.0  0.0  2252    0 ?        SW   07:25   0:00 [login]
root      1218  0.0  0.6  2192  416 pts/6    S    07:26   0:01 -sh
demouser  1229  0.7  0.0 18564    0 ?        SW   07:35   0:18
[kdeinit]
demouser  1231  1.5  1.4 17640  920 ?        S    07:39   0:35
kdeinit: konqueror --silent
demouser  1234  1.3  0.3 17508  208 ?        S    07:42   0:28 gimp
/home/demouser/linux.jpg
demouser  1457  0.1  0.0  6196    0 ?        SW   07:54   0:02
[script-fu]
demouser  1463  0.1  0.0  3732    0 ?        SW   08:04   0:01 [gv]
demouser  1464  0.2  0.0  6128    0 ?        SW   08:05   0:01 [gs]
demouser  1475  0.3  0.1  2088  112 ?        RN   08:17   0:00
/opt/kde2/bin/kmatrix.kss -root
root      1476 15.8  1.7  2904 1104 pts/6    R    08:17   0:00 ps aux

root@dws4:~ {148} $ ifconfig
eth0      Link encap:Ethernet  HWaddr 00:00:21:C6:CE:CE
          inet addr:192.168.163.104  Bcast:192.168.163.255 
Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:32988520 errors:2 dropped:0 overruns:0 frame:0
          TX packets:26332220 errors:2 dropped:8 overruns:0 carrier:2
          collisions:6493721 txqueuelen:100
          RX bytes:2465285636 (2351.0 Mb)  TX bytes:3498769136 (3336.6
Mb)
          Interrupt:10 Base address:0x8000
 
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:3924  Metric:1
          RX packets:24508915 errors:0 dropped:0 overruns:0 frame:0
          TX packets:24508915 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:1029721773 (982.0 Mb)  TX bytes:1029721773 (982.0
Mb) 

(Note: the diskless client was connected to a 100MBit HUB and 
flood-pinged, that's why there's a huge number of collisions)

Now I don't know what you would say, but I would call this
enough stable for real world use!

We have now updated our system for Linux 2.2.19. I'll try
to create clean nbd-swap-only patches for 2.2.19 over the
weekend (I hope I find some spare time). I'll announce them
on LKM as soon as they are ready.

I think, Linux with NBD swap is ready for production use.
We use it for more than a year now on our Diskless Clients.

If anyone want's to change Linux' swap mechanism for 2.5,
please keep in mind this application. It's very nice and
useful to have!

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
