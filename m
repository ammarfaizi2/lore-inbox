Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269628AbRHAD47>; Tue, 31 Jul 2001 23:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269629AbRHAD4t>; Tue, 31 Jul 2001 23:56:49 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:9997 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269628AbRHAD4h>; Tue, 31 Jul 2001 23:56:37 -0400
Date: Tue, 31 Jul 2001 23:26:59 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrew Tridgell <tridge@valinux.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8preX VM problems
In-Reply-To: <20010801030520.9C33C421D@lists.samba.org>
Message-ID: <Pine.LNX.4.21.0107312326080.8866-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Andrew,

Can you reproduce the problem with 2.4.7 ? 


On Tue, 31 Jul 2001, Andrew Tridgell wrote:

> I've been testing the 2.4.8preX kernels on machines with fairly large
> amounts of memory (greater than 1G) and have found them to have
> disasterously bad performance through the buffer cache. If the machine
> has 900M or less then it performs well, but above that the performance
> drops through the floor (by about a factor of 600).
> 
> To see the effect use this:
> 
> ftp://ftp.samba.org/pub/unpacked/junkcode/readfiles.c
> 
> and this:
> 
> ftp://ftp.samba.org/pub/unpacked/junkcode/trd/
> 
> then do this:
> 
> insmod dummy_disk.o dummy_size=80000000
> mknod /dev/ddisk b 241 0
> readfile /dev/ddisk
> 
> "dummy_disk" is a dummy disk device (in this case iits 80G). All IOs
> to the device succeed, but don't actually do anything. This makes it
> easy to test very large disks on a small machine, and also eliminates
> interactions with particular block devices. It also allows you to
> unload the disk, which means you can easily start again with a clear
> buffer cache. You can see exactly the same effect with a real device
> if you would prefer not to load the dummy disk driver.
> 
> You will see that the speed is good for the first 800M then drops off
> dramatically after that. Meanwhile, kswapd and kreclaimd go mad
> chewing lots of cpu.
> 
> If you boot the machine with "mem=900M" then the problem goes away,
> with the performance staying high. If you boot with 950M or above
> then the throughput plummets once you have read more than 800M.
> 
> Here is a sample run with 2.4.8pre3:
> 
> [root@fraud trd]# ~/readfiles /dev/ddisk 
> 211 MB    211.754 MB/sec
> 404 MB    192.866 MB/sec
> 579 MB    175.188 MB/sec
> 742 MB    163.017 MB/sec
> 794 MB    49.5844 MB/sec
> 795 MB    0.971527 MB/sec
> 796 MB    0.94948 MB/sec
> 797 MB    1.35205 MB/sec
> 799 MB    1.30931 MB/sec
> 800 MB    1.16104 MB/sec
> 801 MB    1.30607 MB/sec
> 803 MB    1.67914 MB/sec
> 804 MB    1.1175 MB/sec
> 805 MB    0.645805 MB/sec
> 806 MB    0.749738 MB/sec
> 806 MB    0.555384 MB/sec
> 807 MB    0.330456 MB/sec
> 807 MB    0.320096 MB/sec
> 807 MB    0.320502 MB/sec
> 808 MB    0.33026 MB/sec
> 
> and on a real disk:
> 
> [root@fraud trd]# ~/readfiles /dev/rd/c0d1p2 
> 37 MB    37.5002 MB/sec
> 76 MB    38.8103 MB/sec
> 115 MB    38.8753 MB/sec
> 153 MB    37.6465 MB/sec
> 191 MB    38.223 MB/sec
> 229 MB    38.276 MB/sec
> 267 MB    38.3151 MB/sec
> 305 MB    37.3374 MB/sec
> 343 MB    37.6915 MB/sec
> 380 MB    37.7198 MB/sec
> 418 MB    37.5222 MB/sec
> 455 MB    37.1729 MB/sec
> 492 MB    37.2008 MB/sec
> 529 MB    36.2474 MB/sec
> 565 MB    36.7173 MB/sec
> 602 MB    36.6197 MB/sec
> 639 MB    36.5568 MB/sec
> 675 MB    36.4935 MB/sec
> 711 MB    36.1575 MB/sec
> 747 MB    36.0858 MB/sec
> 784 MB    36.1972 MB/sec
> 799 MB    15.1778 MB/sec
> 803 MB    4.11846 MB/sec
> 804 MB    1.33881 MB/sec
> 805 MB    0.927079 MB/sec
> 806 MB    0.790508 MB/sec
> 807 MB    0.679455 MB/sec
> 807 MB    0.316194 MB/sec
> 808 MB    0.305104 MB/sec
> 808 MB    0.317431 MB/sec
> 
> Interestingly, the 800M barrier is the same no matter how much memory
> is in the machine (ie. its the same barrier for a machine with 2G as
> 1G).
> 
> So, anyone have any ideas? 
> 
> I was prompted to do these tests when I saw kswapd and kreclaimd going
> mad in large SPECsfs runs on a machine with 2G of memory. I suspect
> that what is happening is that the meta data throughput plummets
> during the runs when the buffer cache reaches 800M in size. SPECsfs is
> very meta-data intensive. Typical runs will create millions of files.
> 
> Cheers, Tridge
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

