Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129756AbRBVAg1>; Wed, 21 Feb 2001 19:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129785AbRBVAgS>; Wed, 21 Feb 2001 19:36:18 -0500
Received: from smtp.bellnexxia.net ([209.226.175.26]:5054 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129756AbRBVAgD>; Wed, 21 Feb 2001 19:36:03 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: [rfc] Near-constant time directory index for Ext2
To: linux-kernel@vger.kernel.org
Date: Wed, 21 Feb 2001 19:35:40 -0500
In-Reply-To: <E14VNAU-00014j-00@the-village.bc.nu> <20010221023515.6DF8E18C99@oscar.casa.dyndns.org> <971i36$180$1@penguin.transmeta.com>
Organization: me
User-Agent: KNode/0.4beta4
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <20010222003540.C51A518608@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> wrote:
>
> Ed Tomlinson  <tomlins@cam.org> wrote:
> >The default in reiserfs is now the R5 hash, but you are right that lots of
> > efforts went into finding this hash.  This includes testing various
> > hashes on real directory structures to see which one worked best.  R5
> > won.
>
> That's interesting.  The R5 hash is easily also the only one of the
> reiser hashes that might be useable for the generic VFS hashing.  It's
> not so different in spirit from the current one, and if you've done the
> work to test it, it's bound to be a lot better.

It was not me personally.   I just remembered the thread (from june 2000) on 
the reiserfs list...  I have summerized the results for you below.

For the program see: http://www.jedi.claranet.fr/hash_torture.tar.gz

Ed 

PS.  I am still seeing hangs with (2.4.2pre2 then I switched to ac7 or so and 
have had hangs with all pre and ac(s) tried and that is most of them)  ac20 
plus the latest reiserfs fixes has stayed up 8 hours so far - it can take two 
or three days  to trigger the hang though.  When it hangs it really dead,  a 
UPS connected via a serial port cannot shut it down.   pings to the box fail. 
A+SysRQ is dead, and the software watchdog does not trigger a reboot.  
ideas?

> (The current VFS name hash is probably _really_ stupid - I think it's
> still my original one, and nobody probably ever even tried to run it
> through any testing.  For example, I bet that using a shift factor of 4
> is really bad, because it evenly divides a byte, which together with the
> xor means that you can really easily generate trivial bad cases).
>
> What did you use for a test-case? Real-life directory contents? Did you
> do any worst-case analysis too?
>
>                Linus


some test results from june 2000 with Hans's summary first.
---------------------------------------------------------------
(reiserfs) Re: r5 hash
From: Hans Reiser <hans@reiser.to>
To: "Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>
Cc: Jedi/Sector One <j@4u.net>, Petru Paler <ppetru@coltronix.com>, 
"reiserfs@devlinux.com" <reiserfs@devlinux.com>, Yury Shevchuk 
<sizif@botik.ru>


Ok, based on this benchmark let's put rupasov5 in, and warn users who choose 
the
currently used rupasov1 hash that rupasov5 has obsoleted it.  Do this in both
3.6 and 3.5, and fix the the delimiting key check in 3.5 REISERFS_CHECK bug at
the same time.  Cut the patch, start testing, and see if you can release by
Monday.  Make rupasov5 the default.  sizif, review the documentation he 
creates
for users.

Jedi, if you disagree with the benchmarks let me know.  You might try
concatenating two filenames together instead of adding a digit to them, or
running find on a really large FS, to improve these tests.  Thanks for helping
us with analyzing the different hash methods available Jedi.

Hans

---------------------------------------------------------------
(reiserfs) Re: r5 hash
From: "Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>
To: Hans Reiser <hans@reiser.to>
Cc: Jedi/Sector One <j@4u.net>, Petru Paler <ppetru@coltronix.com>, 
"reiserfs@devlinux.com" <reiserfs@devlinux.com>, Yury Shevchuk 
<sizif@botik.ru>


Hans Reiser wrote:
> 
> What is the speed of the real filenames, not just the number of collisions.
> 



Ok, here is the results for real names :
# find / -type d -exec ls {} \; | sort | uniq > allfiles.txt

# wc -l allfiles.txt
161101 allfiles.txt

Collisions for 161 101 names:

tea_hash  : 784 total,  2 dangerous
jedi_hash2: 957 total,  2 dangerous 
r5_hash   :1191 total,  2 dangerous 
r7_hash   :8439 total, 18 dangerous


The speed for 161 101 real names :

create 161101 files of 10 bytes with names from allfiles.txt

# time create d1 allfiles.txt
# time cp d1 d2 -r
# time rm d1 -r

              create      copy        remove 
             --------------------------------
tea_hash   : 1m27.223s   5m43.069s  2m33.449s
jedi_hash2 : 1m26.062s   5m40.872s  2m32.795s
r5_hash    : 1m16.729s   4m14.967s  1m53.037s
r7_hash    : 1m10.665s   3m34.950s  1m39.756s


As you can see the results are differ, but not too much. :)
The situation changes dramatically if we will test 1 million files.

The same test, but at the end of each name from allfiles.txt 
added numbers from 0 to 6 (1 127 707 files):
 
              create      copy        remove 
             --------------------------------
tea_hash   : 81m44.449s  
jedi_hash2 : 79m46.419s
r5_hash    : 15m56.037s
r7_hash    : 15m30.680s

Dual Celeron 500, 128 MB RAM, 8 GB scsi HDD
Reiserfs-3.5.21, Linux-2.2.15

Thanks,
Yura.
---------------------------------------------------------------
body { font-family: "helvetica" } p { font-size: 12pt } a { color: #0000ff; 
text-decoration: none; }(reiserfs) Torture results
From: Jedi/Sector One <j@4u.net>
To: reiserfs@devlinux.com


  Here are the results of the hash torture on a Celeron 300.
  Once again, you can substract 1 from the dangerous collisions numbers.
  Xuan, can you provide a test for the case Rupasov hash was designed
for ?
  Anyway, I don't really see why large directories should have similar
file names, rather that keywords.

  Best regards,
-- 
         Frank DENIS aka Jedi/Sector One aka DJ Chrysalis <j@4u.net>
                 -> Software : http://www.jedi.claranet.fr <-
      If Bill Gates had a dime for every time a Windows box crashed...
                  ...oh, wait a minute -- he already does.


********************** /usr/dict/words test **********************

Trying with   45402 words


-------------[Benchmarking tea hash]-------------

Collisions : 45
Dangerous :       1      ffff980
Timing :

real     0m0.145s
user     0m0.120s
sys      0m0.010s

-------------[Benchmarking rupasov hash]-------------

Collisions : 553
Dangerous :       1      ffffe00
Timing :

real     0m0.297s
user     0m0.260s
sys      0m0.020s

-------------[Benchmarking r5 hash]-------------

Collisions : 185
Dangerous :       1      ffae000
Timing :

real     0m0.124s
user     0m0.080s
sys      0m0.030s

-------------[Benchmarking r7 hash]-------------

Collisions : 2528
Dangerous :       1      fffd400
Timing :

real     0m0.121s
user     0m0.100s
sys      0m0.000s

-------------[Benchmarking jedi hash]-------------

Collisions : 54
Dangerous :       1      fff9780
Timing :

real     0m0.122s
user     0m0.100s
sys      0m0.010s

-------------[Benchmarking jedi2 hash]-------------

Collisions : 93
Dangerous :       1      fff9780
Timing :

real     0m0.122s
user     0m0.090s
sys      0m0.020s

-------------[Benchmarking lookup2 hash]-------------

Collisions : 63
Dangerous :       1      ffff480
Timing :

real     0m0.123s
user     0m0.100s
sys      0m0.000s

********************** Squid names test **********************

Trying with  458752 squid cache entries

-------------[Benchmarking tea hash]-------------

Collisions : 6237
Dangerous :       1      fffff80
Timing :

real     0m1.138s
user     0m1.090s
sys      0m0.030s

-------------[Benchmarking rupasov hash]-------------

Collisions : 377520
Dangerous :       1      e32700
Timing :

real     0m2.588s
user     0m2.550s
sys      0m0.020s

-------------[Benchmarking r5 hash]-------------

Collisions : 309991
Dangerous :       1      55406b80
Timing :

real     0m0.940s
user     0m0.880s
sys      0m0.040s

-------------[Benchmarking r7 hash]-------------

Collisions : 449006
Dangerous :       2      22b16580
Timing :

real     0m0.928s
user     0m0.840s
sys      0m0.070s

-------------[Benchmarking jedi hash]-------------

Collisions : 2771
Dangerous :       1      fffef80
Timing :

real     0m0.928s
user     0m0.860s
sys      0m0.050s

-------------[Benchmarking jedi2 hash]-------------

Collisions : 0
Dangerous :       1      ffff80
Timing :

real     0m0.879s
user     0m0.810s
sys      0m0.050s

-------------[Benchmarking lookup2 hash]-------------

Collisions : 6203
Dangerous :       1      fffdc00
Timing :

real     0m0.930s
user     0m0.840s
sys      0m0.080s

********************** Real names test **********************

Trying with   89830 files

-------------[Benchmarking tea hash]-------------

Collisions : 237
Dangerous :       1      fff5580
Timing :

real     0m0.276s
user     0m0.250s
sys      0m0.000s

-------------[Benchmarking rupasov hash]-------------

Collisions : 6288
Dangerous :       1      ffee080
Timing :

real     0m0.582s
user     0m0.560s
sys      0m0.010s

-------------[Benchmarking r5 hash]-------------

Collisions : 3920
Dangerous :       1      fff4600
Timing :

real     0m0.230s
user     0m0.190s
sys      0m0.020s

-------------[Benchmarking r7 hash]-------------

Collisions : 11801
Dangerous :       1      fff580
Timing :

real     0m0.225s
user     0m0.180s
sys      0m0.030s

-------------[Benchmarking jedi hash]-------------

Collisions : 269
Dangerous :       1      fff9f80
Timing :

real     0m0.226s
user     0m0.200s
sys      0m0.010s

-------------[Benchmarking jedi2 hash]-------------

Collisions : 415
Dangerous :       1      fff9f80
Timing :

real     0m0.225s
user     0m0.200s
sys      0m0.010s

-------------[Benchmarking lookup2 hash]-------------

Collisions : 223
Dangerous :       1      ffff480
Timing :

real     0m0.230s
user     0m0.210s
sys      0m0.000s

----------------------------------------------------------------------------------------

body { font-family: "helvetica" } p { font-size: 12pt } a { color: #0000ff; 
text-decoration: none; }(reiserfs) hash torture results
From: Petru Paler <ppetru@coltronix.com>
To: reiserfs@devlinux.com


Machine: AMD Athlon/650MHz, 128Mb RAM, Quantum Fireball lct15 IDE hdd
(UDMA/66 but that doesn't matter). Kernel 2.4.0-test1-ac10.

The results are interesting, but more interesting would be to see how fast
reiserfs actually is with each of these hashes.

Script output:

********************** /usr/dict/words test **********************

Trying with   45402 words


-------------[Benchmarking tea hash]-------------

Collisions : 45
Dangerous :       1      ffff980
Timing :
0.00user 0.01system 0:00.08elapsed 11%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (83major+13minor)pagefaults 0swaps

-------------[Benchmarking rupasov hash]-------------

Collisions : 553
Dangerous :       1      ffffe00
Timing :
0.00user 0.00system 0:00.18elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (83major+13minor)pagefaults 0swaps

-------------[Benchmarking r5 hash]-------------

Collisions : 185
Dangerous :       1      ffae000
Timing :
0.00user 0.00system 0:00.08elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (83major+13minor)pagefaults 0swaps

-------------[Benchmarking r7 hash]-------------

Collisions : 2528
Dangerous :       1      fffd400
Timing :
0.00user 0.01system 0:00.07elapsed 12%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (83major+13minor)pagefaults 0swaps

-------------[Benchmarking jedi hash]-------------

Collisions : 54
Dangerous :       1      fff9780
Timing :
0.00user 0.00system 0:00.08elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (83major+13minor)pagefaults 0swaps

-------------[Benchmarking jedi2 hash]-------------

Collisions : 93
Dangerous :       1      fff9780
Timing :
0.00user 0.00system 0:00.07elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (83major+13minor)pagefaults 0swaps

-------------[Benchmarking lookup2 hash]-------------

Collisions : 63
Dangerous :       1      ffff480
Timing :
0.00user 0.00system 0:00.07elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (83major+13minor)pagefaults 0swaps

********************** Squid names test **********************

Trying with  262144 squid cache entries

-------------[Benchmarking tea hash]-------------

Collisions : 2019
Dangerous :       1      ffff880
Timing :
0.00user 0.01system 0:00.47elapsed 2%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (83major+13minor)pagefaults 0swaps

-------------[Benchmarking rupasov hash]-------------

Collisions : 210912
Dangerous :       1      a88f00
Timing :
0.00user 0.02system 0:01.03elapsed 1%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (83major+13minor)pagefaults 0swaps

-------------[Benchmarking r5 hash]-------------

Collisions : 171912
Dangerous :       1      54ca7680
Timing :
0.00user 0.03system 0:00.41elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (83major+13minor)pagefaults 0swaps

-------------[Benchmarking r7 hash]-------------

Collisions : 256171
Dangerous :       6      22aa0600
Timing :
0.00user 0.03system 0:00.41elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (83major+13minor)pagefaults 0swaps

-------------[Benchmarking jedi hash]-------------

Collisions : 589
Dangerous :       1      fffda00
Timing :
0.00user 0.02system 0:00.42elapsed 4%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (83major+13minor)pagefaults 0swaps

-------------[Benchmarking jedi2 hash]-------------

Collisions : 0
Dangerous :       1      ffff80
Timing :
0.00user 0.00system 0:00.40elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (83major+13minor)pagefaults 0swaps

-------------[Benchmarking lookup2 hash]-------------

Collisions : 2041
Dangerous :       1      fffdc00
Timing :
0.00user 0.01system 0:00.40elapsed 2%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (83major+13minor)pagefaults 0swaps

********************** Real names test **********************

find: /proc/31112/fd/4: No such file or directory
Trying with   94836 files

-------------[Benchmarking tea hash]-------------

Collisions : 235
Dangerous :       1      fff5e80
Timing :
0.00user 0.00system 0:00.20elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (83major+13minor)pagefaults 0swaps

-------------[Benchmarking rupasov hash]-------------

Collisions : 2016
Dangerous :       1      fffab80
Timing :
0.01user 0.00system 0:00.46elapsed 2%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (83major+13minor)pagefaults 0swaps

-------------[Benchmarking r5 hash]-------------

Collisions : 495
Dangerous :       1      fff8780
Timing :
0.00user 0.00system 0:00.17elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (83major+13minor)pagefaults 0swaps

-------------[Benchmarking r7 hash]-------------

Collisions : 8162
Dangerous :       1      fff580
Timing :
0.00user 0.02system 0:00.17elapsed 11%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (83major+13minor)pagefaults 0swaps

-------------[Benchmarking jedi hash]-------------

Collisions : 331
Dangerous :       1      ffe400
Timing :
0.00user 0.00system 0:00.17elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (83major+13minor)pagefaults 0swaps

-------------[Benchmarking jedi2 hash]-------------

Collisions : 341
Dangerous :       1      ffe400
Timing :
0.00user 0.00system 0:00.17elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (83major+13minor)pagefaults 0swaps

-------------[Benchmarking lookup2 hash]-------------

Collisions : 298
Dangerous :       1      fffb700
Timing :
0.00user 0.00system 0:00.17elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (83major+13minor)pagefaults 0swaps

-Petru

