Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422843AbWCXKnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422843AbWCXKnI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 05:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422840AbWCXKnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 05:43:07 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:18885 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1422834AbWCXKnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 05:43:05 -0500
Date: Fri, 24 Mar 2006 11:34:47 +0100 (CET)
From: Jesper Dangaard Brouer <hawk@diku.dk>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel panic: Route cache, RCU, possibly FIB trie.
In-Reply-To: <44238DAC.2020402@cosmosbay.com>
Message-ID: <Pine.LNX.4.61.0603241051190.22635@ask.diku.dk>
References: <Pine.LNX.4.61.0603211113550.15500@ask.diku.dk>
 <20060321.023705.26111240.davem@davemloft.net> <Pine.LNX.4.61.0603211538280.28173@ask.diku.dk>
 <20060321.132514.24407022.davem@davemloft.net> <Pine.LNX.4.61.0603231536180.29788@ask.diku.dk>
 <Pine.LNX.4.61.0603231637360.29788@ask.diku.dk> <4422C9BC.3090400@cosmosbay.com>
 <Pine.LNX.4.61.0603232128400.3500@ask.diku.dk> <44238DAC.2020402@cosmosbay.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-511516320-576053567-1143194699=:22635"
Content-ID: <Pine.LNX.4.61.0603241105130.22635@ask.diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---511516320-576053567-1143194699=:22635
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.61.0603241105131.22635@ask.diku.dk>



On Fri, 24 Mar 2006, Eric Dumazet wrote:

> Jesper Dangaard Brouer a écrit :
>> 
>> On Thu, 23 Mar 2006, Eric Dumazet wrote:
>> 
>>> Jesper Dangaard Brouer a écrit :
>>> 
>> 
>> I have read the route.c code again, to see if I missed something. Are you 
>> trying to make the function "rt_check_expire" to do the cleanup?
>> 
>> I have tried your parameters, and it does not have the desired effect.
>> 
>
> I was just guessing, since you didnt give us your rtstat output.
>
> If you start to hit max_size then you have really a problem.
>
> And no, I was not trying to make the garbage collector starts. This cost way 
> too much cpu, the router drops packets.
>
> On my routers, I try to size the rt hash table appropriatly (boot param : 
> rhash_entries=1048575 for example), and keep the chains small, to avoid 
> spending too much cpu time (and too much memory cache lines touched) in 
> {soft}irq processing.
>
> But yes it uses some memory.

How much memory do your machine have?

What kernel version are you using?



> # rtstat -c10 -i1
> rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|
>  entries|  in_hit|in_slow_|in_slow_|in_no_ro|  in_brd|in_marti|in_marti| out_hit|out_slow|out_slow|gc_total|gc_ignor|gc_goal_|gc_dst_o|in_hlist|out_hlis|
>      tot|      mc|     ute|        |  an_dst|  an_src|    _tot|     _mc|        |      ed|    miss| verflow| _search|t_search|
>
> 1672276|   32062|    4688|       0|       0|       0|       0|       0|  2124|    2176|       0|       0|       0|       0|       0|   26020|    4385|
> 1671142|   31826|    4626|       0|       0|       0|       0|       0|  2055|    1906|       0|       0|       0|       0|       0|   25617|    4124|
> 1670424|   31473|    4702|       0|       0|       0|       0|       0|  2221|    2144|       0|       0|       0|       0|       0|   25348|    4340|
> 1670928|   31671|    7600|       0|       0|       0|       0|       0|  2037|    2152|       0|       0|       0|       0|       0|   30354|    4245|
> 1670444|   31704|    4818|       0|       0|       0|       0|       0|  2037|    1927|       0|       0|       0|       0|       0|   25424|    3871|
> 1670133|   31785|    4598|       0|       0|       0|       0|       0|  1988|    2184|       0|       0|       0|       0|       0|   24946|    4302|
> 1669990|   31544|    4700|       0|       0|       0|       0|       0|  2022|    2188|       0|       0|       0|       0|       0|   25092|    4357|
> 1669880|   31930|    4750|       0|       0|       0|       0|       0|  2054|    2002|       0|       0|       0|       0|       0|   25703|    4214|


You definitly have more entries than me!

After disabling equal cost multi path routing, the machine does not kernel 
panic, BUT it still dies because it runs out-of-memory!



An rtstat example (2.6.15.1):

  size   IN: hit     tot    mc no_rt bcast madst masrc  OUT: hit     tot     mc GC: tot ignored goal_miss ovrf HASH: in_search out_search
377172      9431     153     0     0     2     0     0       119       5      0     159     157         0    0            1683         17
377350      9244     171     0     0     1     0     0       129       3      0     172     170         0    0            1741         20
377490      9822     143     0     0     2     0     0       101       6      0     149     147         0    0            1864         26
377657      9582     149     0     0     1     0     0       106       4      0     153     151         0    0            2192         23
377787      9105     136     0     0     1     0     0       106       6      0     141     139         0    0            1881         21
377930      9216     149     0     0     2     0     0       114       5      0     154     152         0    0            2033         19
377891      9157     159     0     0     4     0     0       117       6      0     165     163         0    0            2117         28
378126      9052     185     0     0     1     0     0       128       6      0     191     189         0    0            1908         24
378313      8862     185     0     0     2     0     0       152       5      0     189     187         0    0            1987         43
378504      8771     194     0     0     2     0     0       111       4      0     197     195         0    0            1904         20
378735      9069     219     0     0     4     0     0       153       4      0     223     221         0    0            1973         33
378948      8836     217     0     0     0     0     0       145       6      0     222     220         0    0            1807         18
379139      8952     190     0     0     5     0     0       120       5      0     195     193         0    0            1840         25


The strange thing is the kernel 2.4.26 rtstat output on the same machine, 
which does not grow out of proportions...

Kernel 2.4.26 output.
(Showing where the cache is periodically flushed)

  size   IN: hit     tot    mc no_rt bcast madst masrc  OUT: hit     tot     mc GC: tot ignored goal_miss ovrf HASH: in_search out_search
28556      8705     180     0     0     1     0     0       155       2      0     182     180         0    0           26229        514
28742      8630     184     0     0     2     0     0        92       6      0     191     189         0    0           24708        330
25955      8530     203     0     0     2     0     0        73       3      0     206     204         0    0           23575        237
26143      9015     228     0     0     2     0     0        93       2      0     230     228         0    0           23017        292
26345      9012     196     0     0     1     0     0       160       4      0     199     197         0    0           23527        560
26546      8535     216     0     0     0     0     0        65       3      0     216     214         0    0           24245        206
26715      8415     170     0     0     0     0     0        66       2      0     171     169         0    0           23079        203
26894      8376     180     0     0     0     0     0        77       5      0     185     183         0    0           22002        245
27073      8407     173     0     0     1     0     0        69       2      0     175     173         0    0           23926        228
27224      8590     160     0     0     2     0     0        68       3      0     163     161         0    0           24457        211
27381      8304     153     0     0     2     0     0        79       6      0     159     157         0    0           23955        313
27555      7993     174     0     0     1     0     0        52       2      0     176     174         0    0           22940        209
27766      8710     215     0     0     0     0     0        44       4      0     220     218         0    0           25631        174
27958      8073     192     0     0     1     0     0        46       3      0     195     193         0    0           24186        178
28082      7877     138     0     0     0     0     0        53       2      0     140     138         0    0           23524        205
28171      7519      91     0     0     1     0     0        47       4      0      95      93         0    0           22122        209
28254      7953      81     0     0     0     0     0        38       4      0      85      83         0    0           22011        175
28353      8062     103     0     0     1     0     0        53       3      0     107     105         0    0           22077        220
28450      8129      89     0     0     1     0     0        41       5      0      94      92         0    0           23018        154
28578      7767     129     0     0     0     0     0        53       3      0     132     130         0    0           21775        198
  size   IN: hit     tot    mc no_rt bcast madst masrc  OUT: hit     tot     mc GC: tot ignored goal_miss ovrf HASH: in_search out_search
28684      8291     112     0     0     0     0     0        58       5      0     117     115         0    0           22819        229
28774      8426      93     0     0     0     0     0        56       2      0      95      93         0    0           23719        213
28851      7632      85     0     0     0     0     0        51       3      0      88      86         0    0           21774        172
   485      7766     282     0     0     1     0     0        42      11      0      84      82         0    0           21271        161
  1385      7572     443     0     0     1     0     0        32      14      0       0       0         0    0             824          7
  1840      7538     232     1     0     1     0     0        38      12      0       0       0         0    0            1222          9
  2283      7429     216     0     0     2     0     0        60      10      0       0       0         0    0            1358         15
  2646      7209     172     0     0     1     0     0        43       8      0       0       0         0    0            1406         16
  2950      7934     146     0     0     0     0     0        55       5      0       0       0         0    0            1777         16
  3273      7784     156     0     0     2     0     0        43       5      0       0       0         0    0            2158         18
  3603      7159     158     0     0     0     0     0        48       6      0       0       0         0    0            2418         31
  3892      7398     140     0     0     0     0     0        49       4      0       0       0         0    0            2665         36
  4142      7847     158     0     0     1     0     0        46       5      0       0       0         0    0            2936         23
  4389      7789     116     0     0     0     0     0        43       9      0       0       0         0    0            3216         28
  4702      8082     151     0     0     0     0     0        30       5      0       0       0         0    0            3333         23
  4953      8011     120     0     0     0     0     0        42       5      0       0       0         0    0            3548         39



Hilsen
   Jesper Brouer

--
-------------------------------------------------------------------
Cand. scient datalog
Dept. of Computer Science, University of Copenhagen
-------------------------------------------------------------------
---511516320-576053567-1143194699=:22635--
