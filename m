Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287946AbSANOUz>; Mon, 14 Jan 2002 09:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289175AbSANOUr>; Mon, 14 Jan 2002 09:20:47 -0500
Received: from iq.sch.bme.hu ([152.66.214.168]:39046 "EHLO iq.rulez.org")
	by vger.kernel.org with ESMTP id <S287946AbSANOUg>;
	Mon, 14 Jan 2002 09:20:36 -0500
Date: Mon, 14 Jan 2002 15:20:59 +0100 (CET)
From: Sasi Peter <sape@iq.rulez.org>
To: <linux-kernel@vger.kernel.org>
Subject: Erroneous output from /proc/net/dev
Message-ID: <Pine.LNX.4.33.0201141458480.2486-100000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All!

I just wanted to whomp a script up to be able to track the throughput of 
my network if (I am experimentimg w/ my fileserver).
I came up with these solution:
---->cuthere<----
#!/bin/bash

case $# in
  3)
    INTERFACE=$1
    INTERVAL=$2
    case $3 in
      B|b)
        DIVIDER='1'
        DIVTXT='Bytes/s'
        ;;
      K|k)
        DIVIDER='1024'
        DIVTXT='KBytes/s'
        ;;
      M|m)
        DIVIDER='1048576'
        DIVTXT='MBytes/s'
        ;;
      G|g)
        DIVIDER='1073741824'
        DIVTXT='GBytes/s'
        ;;
      *)
        DIVIDER='1024'
        DIVTXT='KBytes/s'
        ;;
    esac
    ;;
  2)
    INTERFACE=$1
    INTERVAL=$2
    DIVIDER='1024'
    DIVTXT='KBytes/s'
    ;;
  1)
    INTERFACE=$1
    INTERVAL='1'
    DIVIDER='1024'
    DIVTXT='KBytes/s'
    ;;
  *)
    INTERFACE='eth0'
    INTERVAL='1'
    DIVIDER='1024'
    DIVTXT='KBytes/s'
    ;;
esac

if [ "a$1" == "a" ]
then
  set 'eth0'
fi

LINE=$(< /proc/net/dev)
set ${LINE##*eth0:}
CURRENTRX=$1 
CURRENTTX=$9

sleep $INTERVAL

while true
do 
  LASTTX=$CURRENTTX
  LASTRX=$CURRENTRX

  LINE=$(< /proc/net/dev)
  set ${LINE##*eth0:}
  CURRENTRX=$1 
  CURRENTTX=$9

#  check what it is doing
  date >&2
  echo "/proc/net/dev:--------------------" >&2
  echo $LINE >&2
  echo "extracted arithmetics by bc:------" >&2
  echo -n "(($CURRENTTX-$LASTTX)+($CURRENTRX-$LASTRX))/$DIVIDER/$INTERVAL=">&2
  echo "(($CURRENTTX-$LASTTX)+($CURRENTRX-$LASTRX))/$DIVIDER/$INTERVAL"|bc>&2

  echo "Sent to dc:-----------------------" >&2
  echo "3k$CURRENTTX $LASTTX-$CURRENTRX $LASTRX-+$DIVIDER/$INTERVAL/n[ $DIVTXT]pc"
  sleep $INTERVAL
done|dc
---->cuthere<----

The load of bash trickery is in so that I did not have to run a bunch of 
external commands at each sampling. STDOUT goes to dc, so that is 
also run only once. Actually succeeded to eleminate all but sleep(1) (any 
idea on how to eleminate that?).
In the output I sometimes saw a negative throughput, so the investigation 
began.
The extra echo lines went in to see the picture, exactly were things went 
wrong (I was suspecting a bash bug). Atually it is not.
As you can see from the output below, the number of bytes transmitted, as 
read from /proc/net/dev has a slip down, but next time it is can be read 
correctly again. I wonder which part of the kernel is responsible for 
this?

I am using 2.4.18-pre3, netcard is a Digital DE500.
Relevant lines from dmesg:
Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
PCI: Found IRQ 11 for device 00:0d.0
00:0d.0: PCI cache line size set incorrectly (0 bytes) by BIOS/FW, 
correcting to 32
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) 
block.
tulip0:  MII transceiver #5 config 1000 status 782f advertising 01e1.
eth0: Digital DS21140 Tulip rev 32 at 0xd907f000, 00:00:F8:02:5E:C3, IRQ 
11.
eth0: Setting full-duplex based on MII#5 link partner capability of 05e1.

>From this you can guess I have tried out all the new bells and whistles. 
Relevant bits from kernel's .config:
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_TULIP=m
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y

In your possible reply and/or discussion please CC me, as I am not on the 
list.

Sample output follows:
---->cuthere<----
Mon Jan 14 14:46:18 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746781315 215507 0 0 0 0 0 0 746781315 215507 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3233757829 17802963 1 0 0 0 0 0 3664927368 30186729 6 0 4 0 2 0
extracted arithmetics by bc:------
((3664927368-3435490572)+(3233757829-3228024110))/1024/60=3827
Sent to dc:-----------------------
3827.645 KBytes/s
Mon Jan 14 14:47:18 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746784213 215531 0 0 0 0 0 0 746784213 215531 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3239720464 17891120 1 0 0 0 0 0 3911916328 30355834 6 0 4 0 2 0
extracted arithmetics by bc:------
((3911916328-3664927368)+(3239720464-3233757829))/1024/60=4117
Sent to dc:-----------------------
4117.050 KBytes/s
Mon Jan 14 14:48:18 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746788501 215567 0 0 0 0 0 0 746788501 215567 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3245935334 17983962 1 0 0 0 0 0 4171558232 30533133 6 0 4 0 2 0
extracted arithmetics by bc:------
((4171558232-3911916328)+(3245935334-3239720464))/1024/60=4327
Sent to dc:-----------------------
4327.095 KBytes/s
Mon Jan 14 14:49:18 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746796132 215635 0 0 0 0 0 0 746796132 215635 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3252068081 18076601 1 0 0 0 0 0 144830187 30715399 6 0 4 0 2 0
extracted arithmetics by bc:------
((144830187-4171558232)+(3252068081-3245935334))/1024/60=-65439
Sent to dc:-----------------------
-65439.376 KBytes/s
Mon Jan 14 14:50:18 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746797592 215647 0 0 0 0 0 0 746797592 215647 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3258569462 18175464 1 0 0 0 0 0 424704705 30905618 6 0 4 0 2 0
extracted arithmetics by bc:------
((424704705-144830187)+(3258569462-3252068081))/1024/60=4661
Sent to dc:-----------------------
4661.066 KBytes/s
Mon Jan 14 14:51:18 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746797592 215647 0 0 0 0 0 0 746797592 215647 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3265886374 18286477 1 0 0 0 0 0 736470951 31117417 6 0 4 0 2 0
extracted arithmetics by bc:------
((736470951-424704705)+(3265886374-3258569462))/1024/60=5193
Sent to dc:-----------------------
5193.410 KBytes/s
Mon Jan 14 14:52:18 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746798512 215655 0 0 0 0 0 0 746798512 215655 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3272885312 18391427 1 0 0 0 0 0 1030175110 31317386 6 0 4 0 2 0
extracted arithmetics by bc:------
((1030175110-736470951)+(3272885312-3265886374))/1024/60=4894
Sent to dc:-----------------------
4894.256 KBytes/s
Mon Jan 14 14:53:18 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746800482 215671 0 0 0 0 0 0 746800482 215671 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3281076166 18500275 1 0 0 0 0 0 1332443731 31523754 6 0 4 0 2 0
extracted arithmetics by bc:------
((1332443731-1030175110)+(3281076166-3272885312))/1024/60=5053
Sent to dc:-----------------------
5053.051 KBytes/s
Mon Jan 14 14:54:18 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746809824 215755 0 0 0 0 0 0 746809824 215755 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3304163502 18617307 1 0 0 0 0 0 1625091478 31731837 6 0 4 0 2 0
extracted arithmetics by bc:------
((1625091478-1332443731)+(3304163502-3281076166))/1024/60=5138
Sent to dc:-----------------------
5138.917 KBytes/s
Mon Jan 14 14:55:18 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746812429 215777 0 0 0 0 0 0 746812429 215777 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3311254573 18723632 1 0 0 0 0 0 1932419183 31940702 6 0 4 0 2 0
extracted arithmetics by bc:------
((1932419183-1625091478)+(3311254573-3304163502))/1024/60=5117
Sent to dc:-----------------------
5117.493 KBytes/s
Mon Jan 14 14:56:18 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746815513 215799 0 0 0 0 0 0 746815513 215799 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3317701155 18821765 1 0 0 0 0 0 2215598364 32132487 6 0 4 0 2 0
extracted arithmetics by bc:------
((2215598364-1932419183)+(3317701155-3311254573))/1024/60=4713
Sent to dc:-----------------------
4713.960 KBytes/s
Mon Jan 14 14:57:18 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746817831 215819 0 0 0 0 0 0 746817831 215819 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3324322164 18922109 1 0 0 0 0 0 2505900480 32329283 6 0 4 0 2 0
extracted arithmetics by bc:------
((2505900480-2215598364)+(3324322164-3317701155))/1024/60=4832
Sent to dc:-----------------------
4832.733 KBytes/s
Mon Jan 14 14:58:18 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746820823 215839 0 0 0 0 0 0 746820823 215839 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3331618051 19032631 1 0 0 0 0 0 2821732243 32543345 6 0 4 0 2 0
extracted arithmetics by bc:------
((2821732243-2505900480)+(3331618051-3324322164))/1024/60=5259
Sent to dc:-----------------------
5259.239 KBytes/s
Mon Jan 14 14:59:18 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746823582 215863 0 0 0 0 0 0 746823582 215863 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3339262362 19149089 1 0 0 0 0 0 3155370988 32769404 6 0 4 0 2 0
extracted arithmetics by bc:------
((3155370988-2821732243)+(3339262362-3331618051))/1024/60=5554
Sent to dc:-----------------------
5554.737 KBytes/s
Mon Jan 14 15:00:19 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746824066 215867 0 0 0 0 0 0 746824066 215867 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3346773713 19263966 1 0 0 0 0 0 3482673897 32991218 6 0 4 0 2 0
extracted arithmetics by bc:------
((3482673897-3155370988)+(3346773713-3339262362))/1024/60=5449
Sent to dc:-----------------------
5449.450 KBytes/s
Mon Jan 14 15:01:19 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746827360 215895 0 0 0 0 0 0 746827360 215895 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3354840499 19387188 1 0 0 0 0 0 3834674770 33229953 6 0 4 0 2 0
extracted arithmetics by bc:------
((3834674770-3482673897)+(3354840499-3346773713))/1024/60=5860
Sent to dc:-----------------------
5860.476 KBytes/s
Mon Jan 14 15:02:19 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746827570 215897 0 0 0 0 0 0 746827570 215897 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3361659691 19490937 1 0 0 0 0 0 4134614353 33433461 6 0 4 0 2 0
extracted arithmetics by bc:------
((4134614353-3834674770)+(3361659691-3354840499))/1024/60=4992
Sent to dc:-----------------------
4992.818 KBytes/s
Mon Jan 14 15:03:19 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746828871 215909 0 0 0 0 0 0 746828871 215909 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3368395069 19592307 1 0 0 0 0 0 131770634 33632583 6 0 4 0 2 0
extracted arithmetics by bc:------
((131770634-4134614353)+(3368395069-3361659691))/1024/60=-65040
Sent to dc:-----------------------
-65040.825 KBytes/s
Mon Jan 14 15:04:19 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746835692 215969 0 0 0 0 0 0 746835692 215969 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3375596974 19685576 1 0 0 0 0 0 368174438 33801638 6 0 4 0 2 0
extracted arithmetics by bc:------
((368174438-131770634)+(3375596974-3368395069))/1024/60=3964
Sent to dc:-----------------------
3964.936 KBytes/s
Mon Jan 14 15:05:19 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746842023 216025 0 0 0 0 0 0 746842023 216025 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3382251503 19781988 1 0 0 0 0 0 631986834 33982543 6 0 4 0 2 0
extracted arithmetics by bc:------
((631986834-368174438)+(3382251503-3375596974))/1024/60=4402
Sent to dc:-----------------------
4402.130 KBytes/s
Mon Jan 14 15:06:19 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746845583 216055 0 0 0 0 0 0 746845583 216055 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3389085046 19884528 1 0 0 0 0 0 917808141 34176893 6 0 4 0 2 0
extracted arithmetics by bc:------
((917808141-631986834)+(3389085046-3382251503))/1024/60=4763
Sent to dc:-----------------------
4763.262 KBytes/s
Mon Jan 14 15:07:19 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746845793 216057 0 0 0 0 0 0 746845793 216057 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3395297632 19979133 1 0 0 0 0 0 1186478124 34359185 6 0 4 0 2 0
extracted arithmetics by bc:------
((1186478124-917808141)+(3395297632-3389085046))/1024/60=4474
Sent to dc:-----------------------
4474.000 KBytes/s
Mon Jan 14 15:08:19 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746849193 216087 0 0 0 0 0 0 746849193 216087 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3402276755 20079962 1 0 0 0 0 0 1453490324 34544968 6 0 4 0 2 0
extracted arithmetics by bc:------
((1453490324-1186478124)+(3402276755-3395297632))/1024/60=4459
Sent to dc:-----------------------
4459.494 KBytes/s
Mon Jan 14 15:09:19 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746864155 216205 0 0 0 0 0 0 746864155 216205 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3409030644 20182909 1 0 0 0 0 0 1744670606 34742472 6 0 4 0 2 0
extracted arithmetics by bc:------
((1744670606-1453490324)+(3409030644-3402276755))/1024/60=4849
Sent to dc:-----------------------
4849.188 KBytes/s
Mon Jan 14 15:10:19 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746869774 216253 0 0 0 0 0 0 746869774 216253 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3416223377 20292619 1 0 0 0 0 0 2056259316 34953212 6 0 4 0 2 0
extracted arithmetics by bc:------
((2056259316-1744670606)+(3416223377-3409030644))/1024/60=5188
Sent to dc:-----------------------
5188.500 KBytes/s
Mon Jan 14 15:11:19 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746871269 216265 0 0 0 0 0 0 746871269 216265 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3423538879 20398413 1 0 0 0 0 0 2346580580 35150421 6 0 4 0 2 0
extracted arithmetics by bc:------
((2346580580-2056259316)+(3423538879-3416223377))/1024/60=4844
Sent to dc:-----------------------
4844.348 KBytes/s
Mon Jan 14 15:12:19 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746873732 216285 0 0 0 0 0 0 746873732 216285 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3431185844 20509836 1 0 0 0 0 0 2654726241 35359113 6 0 4 0 2 0
extracted arithmetics by bc:------
((2654726241-2346580580)+(3431185844-3423538879))/1024/60=5139
Sent to dc:-----------------------
5139.853 KBytes/s
Mon Jan 14 15:13:19 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746874444 216291 0 0 0 0 0 0 746874444 216291 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3437787801 20608001 1 0 0 0 0 0 2930624875 35545977 6 0 4 0 2 0
extracted arithmetics by bc:------
((2930624875-2654726241)+(3437787801-3431185844))/1024/60=4597
Sent to dc:-----------------------
4597.991 KBytes/s
Mon Jan 14 15:14:19 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746876004 216303 0 0 0 0 0 0 746876004 216303 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3441748193 20663151 1 0 0 0 0 0 3080090859 35648025 6 0 4 0 2 0
extracted arithmetics by bc:------
((3080090859-2930624875)+(3441748193-3437787801))/1024/60=2497
Sent to dc:-----------------------
2497.174 KBytes/s
Mon Jan 14 15:15:19 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746880133 216335 0 0 0 0 0 0 746880133 216335 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3448746718 20750685 1 0 0 0 0 0 3282527875 35795757 6 0 4 0 2 0
extracted arithmetics by bc:------
((3282527875-3080090859)+(3448746718-3441748193))/1024/60=3408
Sent to dc:-----------------------
3408.781 KBytes/s
Mon Jan 14 15:16:19 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746881570 216347 0 0 0 0 0 0 746881570 216347 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3454992959 20843049 1 0 0 0 0 0 3531743110 35967002 6 0 4 0 2 0
extracted arithmetics by bc:------
((3531743110-3282527875)+(3454992959-3448746718))/1024/60=4157
Sent to dc:-----------------------
4157.901 KBytes/s
Mon Jan 14 15:17:19 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746882750 216357 0 0 0 0 0 0 746882750 216357 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3461313308 20937147 1 0 0 0 0 0 3788586405 36142310 6 0 4 0 2 0
extracted arithmetics by bc:------
((3788586405-3531743110)+(3461313308-3454992959))/1024/60=4283
Sent to dc:-----------------------
4283.262 KBytes/s
Mon Jan 14 15:18:19 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746882750 216357 0 0 0 0 0 0 746882750 216357 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3468800822 21047678 1 0 0 0 0 0 4094302824 36349972 6 0 4 0 2 0
extracted arithmetics by bc:------
((4094302824-3788586405)+(3468800822-3461313308))/1024/60=5097
Sent to dc:-----------------------
5097.720 KBytes/s
Mon Jan 14 15:19:19 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746883953 216367 0 0 0 0 0 0 746883953 216367 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3476200110 21155782 1 0 0 0 0 0 95869916 36552342 6 0 4 0 2 0
extracted arithmetics by bc:------
((95869916-4094302824)+(3476200110-3468800822))/1024/60=-64958
Sent to dc:-----------------------
-64958.229 KBytes/s
Mon Jan 14 15:20:19 CET 2002
/proc/net/dev:--------------------
Inter-| Receive | Transmit face |bytes packets errs drop fifo frame compressed multicast|bytes packets errs drop fifo colls carrier compressed lo:746884936 216375 0 0 0 0 0 0 746884936 216375 0 0 0 0 0 0 teql0: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 eth0:3482665049 21251441 1 0 0 0 0 0 361515008 36732499 6 0 4 0 2 0
extracted arithmetics by bc:------
((361515008-95869916)+(3482665049-3476200110))/1024/60=4428
Sent to dc:-----------------------
4428.874 KBytes/s
---->cuthere<----

Regards,

-- 
SaPE - Peter, Sasi - mailto:sape@sch.hu - http://sape.iq.rulez.org/

