Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281168AbRKOX4d>; Thu, 15 Nov 2001 18:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281181AbRKOX4W>; Thu, 15 Nov 2001 18:56:22 -0500
Received: from jalon.able.es ([212.97.163.2]:23029 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S281168AbRKOX4R>;
	Thu, 15 Nov 2001 18:56:17 -0500
Date: Fri, 16 Nov 2001 00:56:10 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: ext2/3 performace
Message-ID: <20011116005610.A7077@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

Well, I finally had the time to check ext2 and ext3 througput on my drives...
And as I was afraid, I was comparing apples and oranges. I have done the check
on a single disk, mounting and unmounting the disk to clear caches and so on.
The result is that ext3 reads the same amount of data int the same time.
So I still do not understand why cdrecord failed. Is there any utility to mesaure
sustained speed (and variance) ?

The script is like:

PART=/dev/sda5
MB=500

for fs in ext2 ext3
do
    echo "================================================================"
    echo "fs="$fs
    cd /
    umount /mnt/disk
    case $fs in
        ext2)
            mount -t $fs $PART /mnt/disk
            ;;
        ext3)
            mount -t $fs -o data=writeback $PART /mnt/disk
            ;;
    esac
    cd /mnt/disk
    echo "write:"
    rm -f foo
    time dd if=/dev/zero of=foo bs=1024k count=$MB
    echo "sync:"
    time sync
    echo "read:"
    time cat foo > /dev/null
    rm -f foo
    echo "================================================================"
done

sda is a IBM DDYS-T09170N (scsi3, U160), sdb is a IBM DCAS-34330W (scsi2, UW),
hanged on a 7890 (U2W), so bus speed for sda is 80Mb/s, and for sdb is 40Mb/s.
Kernel is 2.4.15-pre4.

Results are similar to this sample:

/dev/sda5 (ultra160 running at 80):
================================================================
fs=ext2
write:
500+0 records in
500+0 records out
0.00user 4.14system 0:15.76elapsed 26%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (120major+20minor)pagefaults 0swaps
sync:
0.00user 0.11system 0:10.15elapsed 1%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (95major+17minor)pagefaults 0swaps
read:
0.18user 3.45system 0:22.43elapsed 16%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (100major+19minor)pagefaults 0swaps
================================================================
================================================================
fs=ext3
write:
500+0 records in
500+0 records out
0.00user 8.34system 0:17.84elapsed 46%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (120major+20minor)pagefaults 0swaps
sync:
0.00user 0.12system 0:10.61elapsed 1%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (95major+17minor)pagefaults 0swaps
read:
0.19user 4.10system 0:22.44elapsed 19%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (100major+19minor)pagefaults 0swaps
================================================================

/dev/sdb1 (wide at 40):
================================================================
fs=ext2
write:
500+0 records in
500+0 records out
0.01user 4.20system 0:37.03elapsed 11%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (120major+20minor)pagefaults 0swaps
sync:
0.00user 0.07system 0:29.76elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (95major+17minor)pagefaults 0swaps
read:
0.21user 2.97system 1:05.17elapsed 4%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (100major+19minor)pagefaults 0swaps
================================================================
================================================================
fs=ext3
write:
500+0 records in
500+0 records out
0.01user 7.91system 0:41.96elapsed 18%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (120major+20minor)pagefaults 0swaps
sync:
0.00user 0.08system 0:28.87elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (95major+17minor)pagefaults 0swaps
read:
0.18user 4.43system 1:05.78elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (100major+19minor)pagefaults 0swaps
================================================================

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.15-pre4-beo-2 #1 SMP Thu Nov 15 13:02:43 CET 2001 i686
