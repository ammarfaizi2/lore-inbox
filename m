Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTKNJTx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 04:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbTKNJTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 04:19:53 -0500
Received: from dwdmx2.dwd.de ([141.38.3.197]:49413 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S262228AbTKNJTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 04:19:48 -0500
Date: Fri, 14 Nov 2003 09:19:44 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problems with ipv4 multicast implementation in 2.4?
Message-Id: <Pine.LNX.4.44.0311140918160.20114-100000@praktifix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

We have about 25 systems that receive data via a pci DVB card from satellite.
The data is received through multiple muticast streams by some closed
source software. On all systems we notice that the free memory decreases
until in most cases the system are no longer reachable via network. They
then constantly print out: dst cache overflow. But I also have noticed that
some systems lock up hard, I assume this is because we just increase
the ip_dst_cache in /proc/sys/net/ipv4/route/max_size to some very
large value.

I also know that the German Telekom and Eumetsat have the same problems
and always have to reboot their systems. I also have reports from Austria
and expect many more systems in Europe are effected.

To get more information I have setup 3 systems with different kernels and
hardware and noticed that over the time ip_dst_cache and skbuff_head_cache
in /proc/slabinfo always increase. They never go down. Also one or more of
the of the size-x values always increase depending on the kernel and DVB
card being used. Here some more slabinfo details and hardware being used:

  System1 : PIII 450MHz, 256MB ram,  Kernel 2.4.23-pre9, pent@value DVB card
  System2 : PII  350MHz, 384MB ram,  Kernel 2.4.21, pent@value DVB card
  System3 : P4 2.4GHz with HT enabled, 1 GB ram (high mem enabled),
            Kernel 2.4.23-rc1 and libata patch, Nova-S DVB card

Now the slabinfo data every 24 hours:

System1:

   ip_dst_cache         647    672    160   27   28    1
   ip_dst_cache        7444   7464    160  311  311    1
   ip_dst_cache       14339  14352    160  598  598    1
   ip_dst_cache       21106  21120    160  880  880    1
   ip_dst_cache       28101  28104    160 1171 1171    1

   skbuff_head_cache    796   1008    160   41   42    1
   skbuff_head_cache   7588   7824    160  326  326    1
   skbuff_head_cache  14482  14688    160  612  612    1
   skbuff_head_cache  21258  21480    160  895  895    1
   skbuff_head_cache  28255  28416    160 1184 1184    1

   size-2048            685    968   2048  343  484    1
   size-2048           7483   7676   2048 3742 3838    1
   size-2048          14376  14398   2048 7188 7199    1
   size-2048          21146  21216   2048 10573 10608    1
   size-2048          28142  28292   2048 14071 14146    1

System2:

   ip_dst_cache           9     48    160    1    2    1
   ip_dst_cache        7437   7464    160  311  311    1
   ip_dst_cache       15161  15168    160  632  632    1
   ip_dst_cache       18831  18840    160  785  785    1

   skbuff_head_cache     14     24    160    1    1    1
   skbuff_head_cache  11482  12168    160  500  507    1
   skbuff_head_cache  23312  23904    160  996  996    1
   skbuff_head_cache  28900  29640    160 1235 1235    1

   size-128             611    660    128   21   22    1
   size-128           11987  12210    128  402  407    1
   size-128           23800  23970    128  798  799    1
   size-128           29445  29670    128  983  989    1


Slabinfo for every 12 hours and CONFIG_DEBUG_SLAB set:

System3:

   ip_dst_cache         576    576    160   24   24    1 :    576     576    24    0    0 :  252  126 :   1946     48   1426      0
   ip_dst_cache       17760  17760    160  740  740    1 :  17760   17760   740    0    0 :  252  126 :  46553   1480  29557      0
   ip_dst_cache       35376  35376    160 1474 1474    1 :  35376   36403  1474    0    0 :  252  126 :  94140   3014  60309      0
   ip_dst_cache       51624  51624    160 2151 2151    1 :  51624   53444  2151    0    0 :  252  126 : 138864   4431  89547      0

   skbuff_head_cache   1311   1311    168   57   57    1 :   1311   79557    57    0    0 :  252  126 :  82108    735  81114    621
   skbuff_head_cache  18492  18492    168  804  804    1 :  18492 3300792   804    0    0 :  252  126 : 3320868  27658 3303434  26050
   skbuff_head_cache  36133  36133    168 1571 1571    1 :  36133 6652585  1583   12    0 :  252  126 : 6684139  55715 6649977  52420
   skbuff_head_cache  52371  52371    168 2277 2277    1 :  52371 9913620  2294   17    0 :  252  126 : 9957116  82923 9907545  78097

   size-8192            540    540   8192  540  540    2 :    540    3196   540    0    0 :    0    0 :      0      0      0      0
   size-8192          17736  17738   8192 17736 17738    2 :  17738   23194 17738    0    0 :    0    0 :      0      0      0      0
   size-8192          35367  35367   8192 35367 35367    2 :  35367   43715 35374    7    0 :    0    0 :      0      0      0      0
   size-8192          51596  51598   8192 51596 51598    2 :  51598   62824 51611   13    0 :    0    0 :      0      0      0      0

   size-2048            452    512   2048  240  256    1 :    512   75002   256    0    0 :   60   30 : 140293   2995 140145   2485
   size-2048            454    514   2048  238  257    1 :    514 3029044   257    0    0 :   60   30 : 5130850 101465 5130703 100953
   size-2048            456    486   2048  241  243    1 :    530 6113873   593  350    0 :   60   30 : 10457205 204975 10457530 203655
   size-2048            454    484   2048  239  242    1 :    542 9104228  1042  800    0 :   60   30 : 15398297 305608 15399447 303014

   size-128            2016   2268    136   78   81    1 :   2268    9125    81    0    0 :  252  126 :  23644    195  22128     56
   size-128           19096  19096    136  682  682    1 :  19096   26457   682    0    0 :  252  126 : 131136   1401 113018     58
   size-128           36708  36708    136 1311 1311    1 :  36708   59707  1317    6    0 :  252  126 : 255889   2833 220918    144
   size-128           52920  52920    136 1890 1890    1 :  52920   81855  1911   21    0 :  252  126 : 370264   4135 319786    153

   size-64             7844   7844     72  148  148    1 :   7844    7931   148    0    0 :  252  126 :  15660    253   9102      0
   size-64            18497  18497     72  349  349    1 :  18497   18584   349    0    0 :  252  126 : 110763    655  93784      0
   size-64            24963  24963     72  471  471    1 :  24963   32458   471    0    0 :  252  126 : 209402   1008 186275      0
   size-64            34503  34503     72  651  651    1 :  34503   48900   651    0    0 :  252  126 : 305026   1613 272674      0

There is much more data available, the full slabinfo was taken every
hour for each system. Additionally with the help of Jörn Engel I managed
to setup System1 with gcov kernel patch and have all data available on
an hourly basis until the system has reached "dst cache overflow". I have
tried very hard to evaluate this data myself, but find that the linux
network code is way beyond my c programming knowledge.

Another thing noticed is that as the memory usage increases the systems
become slower, when you log in on them and work there.

Has anyone any suggestion of what else I can do to narrow down the problem?

What I am also not sure if it is correct to assume the bug in the ipv4
multicast implementation, or can it still be a driver problem? But I assume
two completely different drivers make this very unlikely.

Please, can someone help me to find the bug. I am willing to do any tests
or provide more information.

Thanks,
Holger

PS: Please cc me, since I am not on the list.

