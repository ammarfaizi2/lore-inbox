Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272361AbRHYA3G>; Fri, 24 Aug 2001 20:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272362AbRHYA24>; Fri, 24 Aug 2001 20:28:56 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:37287 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S272361AbRHYA2i>;
	Fri, 24 Aug 2001 20:28:38 -0400
Date: Sat, 25 Aug 2001 02:28:52 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <20010825022852.P547@cerebro.laendle>
Mail-Followup-To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010824201125Z16096-32383+1213@humbolt.nl.linux.org> <Pine.LNX.4.33L.0108241713420.31410-100000@duckman.distro.conectiva> <20010825012338.B547@cerebro.laendle> <200108242344.f7ONi0h21270@mailg.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200108242344.f7ONi0h21270@mailg.telia.com>
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2001 at 01:39:35AM +0200, Roger Larsson <roger.larsson@skelleftea.mail.telia.com> wrote:
> Try to add only one - but one that surely reads from another file...

unless two clients request the same file (possible but very rare), no
thread will read from the same file (even if, at 800 clients this is a
rare occasion).

> In the example it looked like only one was waiting for data.
> Then you added 15 more => 16 waiting for data...

exactly. and when i add one more => 2 waiting for data. I admit I have no
idea what you are after ;) My problem is that I want much more speed out
of the elevator. read-ahead cannot help in the general case, as the numebr
of clients will not decrease, but increase, so at one point I simply will
have to live without any read-ahead to get any performance at all.

> But you should see the read ahead effect when going from 1 to 2 concurrently
> reading. You can actually see the effect when doing a diff with two files :-)

 1  1  1      0   3068  16780 210080   0   0  5492     0 4045  1809  43  37  20
 2  0  3      0   3060  16776 210096   0   0  6944     0 4151  1650  44  42  14
 2  1  1      0   3056  16796 210076   0   0  4072  2572 3875  1542  25  35  40
 1  1  1      0   3056  16796 210072   0   0  6460     0 3943  1801  36  37  27
 1  1  1      0   3064  16796 210072   0   0  6724     0 4134  1807  48  36  16
 2  1  1      0   3056  16796 210060   0   0  5868     0 4226  1894  55  34  12
 2  1  0      0   3056  16796 210056   0   0  7020     0 4229  1743  46  38  15
 1  1  0      0   3056  16872 209980   0   0  5220  2124 4260  1462  41  43  16
 2  1  2      0   3064  16868 209984   0   0  4608     0 3935  1647  44  48   8
 2  2  0      0   3060  16868 210000   0   0  5340     0 4178  1874  42  43  15
 2  1  2      0   3068  16840 210000   0   0  5724     0 4239  1803  59  40   1
# added one more thread
 3  1  4      0   3560  16808 210140   0   0  6616     0 4179  1550  50  36  14
 4  1  4      0   3056  16848 210576   0   0  5868  1384 4018  1653  41  37  22
 1  2  1      0   3056  16848 210708   0   0  4348   952 4048  1429  45  43  13
 3  2  0      0   3056  16848 210712   0   0  5968     0 4130  1740  44  42  14
 1  2  0      0   3056  16848 210700   0   0  5376     0 4251  1988  40  46  14
 1  2  2      0   3064  16836 210712   0   0  6704     0 4476  1701  41  40  18
 2  4  1      0   3056  16828 210724   0   0  5024   316 3919  1647  44  30  26
 1  2  1      0   3056  16828 210716   0   0  4124  1832 4048  1559  39  42  19

(as you can see, another process was running here). one more thread does
not change much (server throughput goes down to about 19mbit, but that
could be attributed to pure chance).

     0.000571 read(6, "\300\317\347\n", 4) = 4 <0.000272>
     0.000649 lseek(1368, 23993104, SEEK_SET) = 23993104 <0.000039>
     0.000354 read(1368, "\f\vv\247\25(\27\27\211B@\374\274{\360\n\22\201\361WvF"..., 65536) = 65536 <0.023478>
     0.024785 write(9, "\300\317\347\n", 4) = 4 <0.000282>
     0.000702 read(6, "\200\\\2\n", 4)  = 4 <0.000279>
     0.000697 lseek(1485, 33253196, SEEK_SET) = 33253196 <0.000040>
     0.007086 read(1485, "\276IY\315\213qM\16#\202 D\345\24\210>\205\231I(H\304 "..., 65536) = 65536 <0.051500>
     0.052311 write(9, "\200\\\2\n", 4) = 4 <0.000093>

anyway, my server would be happy without any read-ahead (socket +
userspace buffers already are readahead), but I certainly need the
head-movement-optimization from the elevator. And I don't see how I can
get this without issues many reads in parallel.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
