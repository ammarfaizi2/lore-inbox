Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266686AbTBYBrM>; Mon, 24 Feb 2003 20:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266702AbTBYBrL>; Mon, 24 Feb 2003 20:47:11 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:15404 "EHLO w-patman.des")
	by vger.kernel.org with ESMTP id <S266686AbTBYBrJ>;
	Mon, 24 Feb 2003 20:47:09 -0500
Date: Mon, 24 Feb 2003 17:47:31 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.62-mm2 slow file system writes across multiple disks
Message-ID: <20030224174731.A31454@beaverton.ibm.com>
References: <20030224120304.A29472@beaverton.ibm.com> <20030224135323.28bb2018.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030224135323.28bb2018.akpm@digeo.com>; from akpm@digeo.com on Mon, Feb 24, 2003 at 01:53:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 01:53:23PM -0800, Andrew Morton wrote:

> Could be that concurrent umount isn't a good way of getting scalable
> writeout; I can't say that I've ever looked...
> 
> Could you try putting a `sync' in there somewhere?
> 
> Or even better, throw away dd and use write-and-fsync from ext3 CVS.  Give it
> the -f flag to force an fsync against each file as it is closed.
> 
> http://www.zip.com.au/~akpm/linux/ext3/

Using fsync didn't seem to make any difference.

I moved to 2.5.62-mm3 [I had to drop back to qlogicisp for my boot disk,
and run the feral drver as a module in order to boot without hanging], and
ran write-and-fsync with -f, with and without -o (O_DIRECT).

What keeps pdflush running when get_request_wait sleeps? I thought there
was (past tense) some creation of multiple pdflushes to handle such cases.

Here are more details:

[patman@elm3b79 iostuff]$ cat /proc/cmdline 
BOOT_IMAGE=2562-mm3-1 ro root=801 BOOT_FILE=/boot/vmlinuz-2562-mm3 console=tty0 console=ttyS0,38400 notsc elevator=deadline

Write 10 100 mb files to 10 different disks, write-and-fsync with -f and -o:

[patman@elm3b79 iostuff]$ vmstat 1 10000
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 0  0  0      0 8070944  12756  21344    0    0     2   713  162    10  0  1 99
 0  0  0      0 8070944  12756  21344    0    0     0     0 1123     6  0  0 100
 0  0  0      0 8070944  12756  21344    0    0     0     0 1026     4  0  0 100
 0 10  0      0 8069840  12756  21344    0    0     0 39936 1149   194  1  4 95
 0 10  0      0 8069816  12772  21344    0    0     0 101500 1502   221  0  4 96
 0 10  0      0 8069816  12772  21344    0    0     0 83968 1200   167  0  4 96
 0 10  0      0 8069816  12772  21344    0    0     0 80896 1197   164  0  4 96
 0 10  0      0 8069816  12772  21344    0    0     0 83968 1192   169  0  4 96
 0 10  1      0 8069816  12776  21344    0    0     0 84996 1206   178  0  4 96
 0 10  0      0 8069816  12776  21344    0    0     0 82944 1191   167  0  4 96
 0 10  0      0 8069816  12776  21344    0    0     0 80896 1195   164  0  4 96
 0 10  0      0 8069816  12776  21344    0    0     0 83968 1196   170  0  4 96
 0 10  0      0 8069816  12776  21344    0    0     0 82944 1201   165  0  4 96
 0 10  1      0 8069808  12776  21344    0    0     0 86144 1195   173  0  4 95
 0 10  0      0 8069744  12776  21344    0    0     0 70896 1389   149  0  4 96
 0  2  0      0 8070320  12776  21344    0    0     0 52420 1183   218  0  2 97
 0  1  0      0 8070464  12776  21344    0    0     0 10244 1051    33  0  0 100
 0  0  0      0 8071016  12776  21344    0    0     0    36 1044    42  0  0 100
 0  0  1      0 8071016  12776  21344    0    0     0     4 1026     8  0  0 100


Total elapsed time of the 10 writers:

0.03user 1.83system 0:14.13elapsed 13%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1986major+3228minor)pagefaults 0swaps


Write 10 100 mb files to 10 different disks, write-and-fsync with -f (not
O_DIRECT):

[patman@elm3b79 iostuff]$ vmstat 1 10000
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 0  0  0      0 8070976  12920  21344    0    0     2   745  162    10  0  1 99
 0  0  0      0 8070976  12920  21344    0    0     0     0 1153     4  0  0 100
 0  0  0      0 8070912  12928  21344    0    0     0    28 1028    12  0  0 100
10  0  0      0 8054000  12928  37416    0    0     0     0 1063   114  0  5 95
10  0  0      0 7767944  12928 322948    0    0     0     0 1023    41  0 50 50
10  0  0      0 7482504  12928 604124    0    0     0     0 1025    31  0 50 50
 6  4  0      0 7222992  12928 858380    0    0     0 342668 1056    80  0 55 45
 0 10  1      0 7032160  12944 1045348    0    0     0 271940 1083   134  0 39 61
 0 10  1      0 7032048  12944 1045348    0    0     0 22040 1079    42  0  2 97
 0 10  1      0 7031832  12944 1045348    0    0     0 22544 1081    42  0  2 98
 0 10  1      0 7031800  12944 1045348    0    0     0  8120 1075    32  0  1 99
 0 10  1      0 7031800  12944 1045348    0    0     0     0 1073    92  0  1 99
 0 10  1      0 7031800  12944 1045348    0    0     0     0 1072    96  0  1 99
 0 10  1      0 7031800  12944 1045348    0    0     0     0 1071    88  0  1 99
 0 10  1      0 7031816  12944 1045348    0    0     0  3588 1078    98  0  1 99
 0 10  1      0 7031856  12944 1045348    0    0     0 18452 1093    96  0  2 98
 0  9  1      0 7031960  12944 1045348    0    0     0 11788 1075    58  0  2 98
 0  8  1      0 7032048  12944 1045348    0    0     0 36388 1082    55  0  2 97
 0  8  1      0 7032000  12944 1045348    0    0     0 25624 1085    40  0  2 98
 0  8  1      0 7031832  12944 1045348    0    0     0 25576 1098    42  0  2 98
 0  8  1      0 7031760  12944 1045348    0    0     0 22040 1084    58  0  2 98
 0  8  1      0 7031720  12944 1045348    0    0     0 23060 1084    60  0  2 98
 0  8  1      0 7031664  12944 1045348    0    0     0 10244 1089    60  0  1 98
 0  8  1      0 7031672  12944 1045348    0    0     0 18960 1095    70  0  2 98
 0  8  1      0 7031656  12944 1045348    0    0     0 40124 1135   108  0  2 97
 0  8  1      0 7031672  12944 1045348    0    0     0 37700 1136    92  0  3 97
 0  7  1      0 7031672  12944 1045348    0    0     0 22972 1140   113  0  3 97
 0  7  1      0 7031688  12944 1045348    0    0     0 17944 1144   163  0  3 97
 0  7  1      0 7031696  12944 1045348    0    0     0 23008 1152   183  0  2 97
 0  6  1      0 7031792  12944 1045348    0    0     0 18932 1146   177  0  3 97
 0  6  1      0 7031816  12944 1045348    0    0     0  1496 1133   176  0  2 98
 0  5  0      0 7032040  12944 1045348    0    0     0     0 1127    34  0  2 98
 0  4  0      0 7032312  12944 1045348    0    0     0    44 1131    31  0  1 99
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 0  3  0      0 7032688  12944 1045348    0    0     0     8 1098    26  0  1 99
 0  3  0      0 7033096  12944 1045348    0    0     0     0 1085    18  0  1 99
 0  1  0      0 7033808  12944 1045348    0    0     0     0 1066    24  0  1 99

Total elpased time:

0.04user 14.80system 0:33.35elapsed 44%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1986major+3228minor)pagefaults 0swaps

-- Patrick Mansfield
