Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbULIWEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbULIWEh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 17:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbULIWEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 17:04:36 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:6842 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261642AbULIWCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 17:02:42 -0500
Date: Thu, 9 Dec 2004 14:02:37 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Hugh Dickins <hugh@veritas.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: page fault scalability patch V12: rss tasklist vs sloppy rss
In-Reply-To: <Pine.LNX.4.44.0412091830580.17648-300000@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0412091348130.7478@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0412091830580.17648-300000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2004, Hugh Dickins wrote:

> How do the scalability figures compare if you omit patch 7/7 i.e. revert
> the per-task rss complications you added in for Linus?  I remain a fan
> of sloppy rss, which you earlier showed to be accurate enough (I'd say),
> though I guess should be checked on other architectures than your ia64.
> I can't see the point of all that added ugliness for numbers which don't
> need to be precise - but perhaps there's no way of rearranging fields,
> and the point at which mm->(anon_)rss is updated (near up of mmap_sem?),
> to avoid destructive cacheline bounce.  What I'm asking is, do you have
> numbers to support 7/7?  Perhaps it's the fact you showed up to 512 cpus
> this time, but only up to 32 with sloppy rss?  The ratios do look better
> with the latest, but the numbers are altogether lower so we don't know.

Here is a full set of numbers for sloppy and tasklist. The sloppy version
is 2.6.9-rc2-bk14 with the prefault patch also applied and the tasklist
version is 2.6.9-rc2-bk12 w/o prefault (you can get the numbers of
2.6.9-rc2-bk12 w prefault in the post titled "anticipatory prefaulting
in the page fault handler")). Even with this handicap
tasklist is still slightly better! I would expect tasklist to increase in
importance for combination patches which increase the fault rate even
more. The tasklist is likely to be unavoidable once I get the prezeroing
patch debugged and integrated which should at least give us a peak pulse
performance for page faults > 5 mio faults /sec.

I was not also able to get the high numbers of > 3 mio faults with atomic
rss + prefaulting but was able to get that with tasklist + prefault. The
atomic version shares the locality problems with the sloppy approach.

sloppy (2.6.10-bk14-rss-sloppy-prefault):
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  1  10    1    0.040s      6.505s   6.054s100117.616 100072.760
  1  10    2    0.041s      7.394s   4.005s 88138.739 161535.358
  1  10    4    0.049s      7.863s   2.049s 82819.743 262839.190
  1  10    8    0.093s      8.657s   1.077s 74889.898 369606.184
  1  10   16    0.621s     13.278s   1.076s 47150.165 371506.561
  1  10   32    3.154s     35.337s   2.029s 17025.784 285469.956
  1  10   64   11.602s     77.548s   2.086s  7351.089 228908.831
  1  10  128   41.999s    217.106s   4.030s  2529.316 152087.458
  1  10  256   40.482s    106.627s   3.022s  4454.885 203363.548
  1  10  512   63.673s     61.361s   3.040s  5241.403 192528.941
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  4  10    1    0.176s     41.276s  41.045s 63238.628  63237.008
  4  10    2    0.154s     31.074s  16.095s 83943.753 154606.489
  4  10    4    0.193s     31.886s   9.096s 81715.471 263190.941
  4  10    8    0.210s     33.577s   6.061s 77584.707 396402.083
  4  10   16    0.473s     52.997s   6.036s 49025.701 411640.587
  4  10   32    3.331s    142.296s   7.093s 18000.934 330197.326
  4  10   64   10.820s    318.485s   8.088s  7960.503 295042.520
  4  10  128   56.012s    928.004s  12.037s  2664.019 211812.600
  4  10  256   46.197s    464.579s   7.026s  5132.263 360940.189
  4  10  512   57.396s    225.876s   4.081s  9254.125 544185.485
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
 16  10    1    0.948s    221.167s 222.009s 47208.624  47212.786
 16  10    2    0.824s    205.021s 110.022s 50939.876  95134.456
 16  10    4    0.689s    168.670s  53.055s 61914.226 195802.740
 16  10    8    0.683s    137.278s  27.034s 76004.706 383471.968
 16  10   16    0.969s    216.288s  24.031s 48264.109 431329.422
 16  10   32    3.932s    587.987s  30.002s 17714.820 349219.905
 16  10   64   13.542s   1253.834s  32.051s  8273.588 322528.516
 16  10  128   54.197s   3161.896s  38.064s  3260.403 271357.849
 16  10  256   57.610s   1668.913s  21.038s  6073.335 490410.386
 16  10  512   36.721s    833.691s  11.069s 12046.872 896970.623
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
 32  10    1    2.080s    470.722s 472.075s 44355.728  44360.409
 32  10    2    1.836s    456.343s 242.088s 45771.267  86344.100
 32  10    4    1.671s    432.569s 131.065s 48294.609 159291.360
 32  10    8    1.457s    354.825s  71.027s 58862.070 294242.410
 32  10   16    1.660s    431.057s  48.038s 48464.636 433466.055
 32  10   32    3.639s   1190.388s  59.040s 17563.676 353012.708
 32  10   64   14.623s   2490.393s  63.040s  8371.808 330750.309
 32  10  128   68.481s   6415.265s  76.053s  3234.476 274023.655
 32  10  256   63.428s   3216.337s  39.044s  6394.212 531665.931
 32  10  512   50.693s   1644.307s  21.035s 12372.572 982183.559
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
 64  10    1    4.457s   1021.948s1026.030s 40863.994  40868.119
 64  10    2    3.929s    994.825s 525.030s 41995.308  79844.658
 64  10    4    3.661s    931.523s 269.014s 44849.990 155838.443
 64  10    8    3.355s    858.565s 153.098s 48662.260 272381.402
 64  10   16    3.130s    904.485s 101.090s 46212.285 411581.778
 64  10   32    5.007s   2366.494s 116.079s 17686.275 359107.203
 64  10   64   17.472s   5195.222s 126.012s  8046.325 332545.646
 64  10  128   65.249s  12515.845s 147.053s  3333.815 284290.928
 64  10  256   61.328s   6706.566s  78.061s  6197.354 533523.711
 64  10  512   60.656s   3201.068s  39.095s 12859.162 1049637.054
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
128  10    8    7.481s   1875.297s 318.049s 44554.389 263386.340
128  10   16    7.128s   2048.919s 230.060s 40799.672 363757.736
128  10   32    9.584s   4758.868s 241.094s 17591.883 346711.571
128  10   64   17.955s  10135.674s 249.025s  8261.684 336547.279
128  10  128   66.939s  25006.914s 287.019s  3345.560 292086.404
128  10  256   62.454s  12892.242s 149.035s  6475.341 561653.696
128  10  512   59.082s   6456.965s  77.002s 12873.768 1089026.647
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
256  10    8   17.201s   4672.781s 860.094s 35772.446 194870.225
256  10   16   16.641s   5071.433s 588.076s 32973.603 284954.772
256  10   32   17.745s   9193.335s 478.005s 18214.166 350950.045
256  10   64   25.474s  20440.137s 510.037s  8197.759 328725.189
256  10  128   65.451s  50015.195s 572.044s  3350.040 293079.914
256  10  256   61.296s  25191.675s 290.084s  6643.660 576852.282
256  10  512   58.911s  12589.530s 149.012s 13264.255 1125015.367

tasklist (2.6.10-rc2-bk12-rss-tasklist):

 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  1   3    1    0.045s      2.042s   2.009s 94121.837  94039.902
  1   3    2    0.053s      2.217s   1.022s 86554.869 160093.661
  1   3    4    0.036s      2.325s   0.074s 83261.622 265213.249
  1   3    8    0.065s      2.507s   0.053s 76404.784 370587.422
  1   3   16    0.168s      4.727s   0.057s 40152.877 341385.368
  1   3   32    0.829s     11.408s   0.070s 16066.277 280690.973
  1   3   64    4.324s     25.591s   0.093s  6571.995 209956.473
  1   3  128   19.370s     81.568s   1.055s  1947.799 126774.712
  1   3  256   13.042s     46.608s   1.009s  3295.950 179708.774
  1   3  512   19.410s     28.085s   0.092s  4139.454 211823.959
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  4   3    1    0.161s     12.698s  12.086s 61156.292  61149.853
  4   3    2    0.152s     10.469s   5.073s 74037.518 137039.041
  4   3    4    0.179s      9.401s   2.098s 82081.949 263750.289
  4   3    8    0.156s     10.194s   1.098s 75979.430 395361.526
  4   3   16    0.407s     18.084s   2.010s 42527.778 373673.111
  4   3   32    0.824s     44.316s   2.031s 17421.815 339975.566
  4   3   64    4.706s     96.587s   2.066s  7763.856 295588.217
  4   3  128   17.453s    259.672s   3.053s  2837.813 222395.530
  4   3  256   17.090s    136.816s   2.017s  5109.777 361440.098
  4   3  512   13.466s     78.242s   1.043s  8575.295 548859.306
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
 16   3    1    0.678s     61.548s  62.023s 50551.998  50544.748
 16   3    2    0.691s     63.381s  34.027s 49095.790  91791.474
 16   3    4    0.663s     52.083s  16.086s 59639.041 186542.124
 16   3    8    0.585s     43.339s   9.031s 71614.583 337721.897
 16   3   16    0.744s     75.174s   8.003s 41435.328 391278.035
 16   3   32    1.713s    171.942s   8.086s 18114.674 354760.887
 16   3   64    4.720s    366.803s   9.055s  8467.079 329273.168
 16   3  128   22.637s    849.059s  10.093s  3608.741 287572.764
 16   3  256   15.849s    472.565s   6.009s  6440.683 515916.601
 16   3  512   15.479s    245.305s   3.046s 12062.521 909147.611
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
 32   3    1    1.451s    140.151s 141.060s 44430.367  44428.115
 32   3    2    1.399s    136.349s  73.041s 45673.303  85699.793
 32   3    4    1.321s    129.760s  39.027s 47996.303 160197.217
 32   3    8    1.279s    100.648s  20.039s 61724.641 308454.557
 32   3   16    1.414s    153.975s  15.090s 40488.236 395681.716
 32   3   32    2.534s    337.021s  17.016s 18528.487 366445.400
 32   3   64    4.271s    709.872s  18.057s  8809.787 338656.440
 32   3  128   18.734s   1805.094s  21.084s  3449.586 288005.644
 32   3  256   14.698s    963.787s  11.078s  6429.787 534077.540
 32   3  512   15.299s    453.990s   5.098s 13406.321 1050416.414
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
 64   3    1    3.018s    301.014s 304.004s 41386.617  41384.901
 64   3    2    2.941s    296.780s 157.005s 41981.967  80116.179
 64   3    4    2.810s    280.803s  82.047s 44366.266 152575.551
 64   3    8    2.763s    268.745s  48.099s 46344.377 256813.576
 64   3   16    2.764s    332.029s  34.030s 37584.030 366744.317
 64   3   32    3.337s    704.321s  34.074s 17781.025 362195.710
 64   3   64    7.395s   1475.497s  36.078s  8485.379 342026.888
 64   3  128   22.227s   3188.934s  40.044s  3918.492 311115.971
 64   3  256   18.004s   1834.246s  21.093s  6793.308 573753.797
 64   3  512   19.367s    861.324s  10.099s 14287.531 1144168.224

 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
128   3    4    5.857s    626.055s 189.010s 39824.798 133076.331
128   3    8    5.837s    592.587s 107.080s 42053.423 233443.791
128   3   16    5.852s    666.252s  71.008s 37443.301 354011.649
128   3   32    6.305s   1365.184s  69.075s 18349.259 360755.364
128   3   64    8.450s   2914.730s  72.046s  8609.057 347288.474
128   3  128   21.188s   6719.590s  79.078s  3733.370 315402.750
128   3  256   18.263s   3672.379s  43.049s  6818.817 578587.427
128   3  512   17.625s   1901.969s  22.082s 13109.967 1102629.479

128   3  256   24.035s   3392.117s  40.074s  7366.714 617628.607
128   3  512   17.000s   1820.242s  21.072s 13697.601 1158632.106

 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
256   3    4   11.976s   1660.924s 514.023s 30086.443  97877.018
256   3    8   11.618s   1301.448s 223.063s 38331.361 225057.902
256   3   16   11.696s   1409.158s 148.074s 35423.488 338379.838
256   3   32   12.678s   2668.417s 140.042s 18772.788 358421.926
256   3   64   15.933s   5833.804s 145.068s  8604.085 345487.685
256   3  128   32.640s  13437.080s 159.079s  3736.651 314981.569
256   3  256   23.875s   6835.241s  81.007s  7337.919 620777.397
256   3  512   17.566s   3392.148s  41.003s 14761.249 1226507.319

256   3  256   21.314s   6648.629s  79.085s  7546.038 630270.726
256   3  512   15.994s   3400.378s  40.087s 14732.481 1231399.906
