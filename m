Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWIONly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWIONly (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWIONly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:41:54 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:52936 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751440AbWIONlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:41:53 -0400
Date: Fri, 15 Sep 2006 15:41:56 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Alignment of fields in struct dentry
Message-ID: <20060915134156.GA9404@wohnheim.fh-wedel.de>
References: <20060914093123.GA10431@wohnheim.fh-wedel.de> <20060914105029.GA1702@wohnheim.fh-wedel.de> <20060914183325.GU6441@schatzie.adilger.int> <20060914210235.GA10548@wohnheim.fh-wedel.de> <20060914215545.GC6441@schatzie.adilger.int> <20060915102736.GA767@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060915102736.GA767@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 September 2006 12:27:36 +0200, Jörn Engel wrote:
> 
> --- slab/include/linux/dcache.h~dentry_size	2006-09-14 22:19:51.000000000 +0200
> +++ slab/include/linux/dcache.h	2006-09-15 12:25:27.000000000 +0200
> @@ -77,7 +77,7 @@ full_name_hash(const unsigned char *name
>  
>  struct dcookie_struct;
>  
> -#define DNAME_INLINE_LEN_MIN 36
> +#define DNAME_INLINE_LEN_MIN 16
>  
>  struct dentry {
>  	atomic_t d_count;
> @@ -112,7 +112,10 @@ struct dentry {
>  #endif
>  	int d_mounted;
>  	unsigned char d_iname[DNAME_INLINE_LEN_MIN];	/* small names */
> -};
> +}__attribute__((aligned(64)));	/* make sure the dentry is 128/192 bytes
> +				   on 32/64 bit independently of config
> +				   options.  d_iname will vary in length
> +				   a bit. */
>  
>  /*
>   * dentry->d_lock spinlock nesting subclasses:

Here is the filename length distribution on my absolutely non-standard
system (thanks for the script, Arnd).  The spikes are:
37: ccache
38: git
44: ccache

Could it make sense to set DNAME_INLINE_LEN_MIN to 44 for hackers? :)

limerick:~# for i in `seq 100` ; do echo $i `find / | grep "/[^/]\{$i\}$" | wc -l` ; done 2>/dev/null
1 3182
2 9375
3 27751
4 45573
5 107506
6 160836
7 186526
8 218420
9 169198
10 166416
11 114927
12 106676
13 85750
14 57269
15 41845
16 32014
17 22970
18 17139
19 15323
20 10334
21 7935
22 6780
23 6806
24 4716
25 3965
26 3152
27 3331
28 3045
29 2486
30 2586
31 2068
32 1907
33 1568
34 1549
35 1232
36 4971
37 19504
38 66679
39 606
40 586
41 723
42 483
43 4484
44 19026
45 297
46 245
47 272
48 275
49 200
50 192
51 193
52 148
53 140
54 152
55 137
56 102
57 100
58 164
59 81
60 92
61 93
62 54
63 68
64 112
65 65
66 44
67 43
68 62
69 39
70 29
71 41
72 33
73 36
74 23
75 19
76 31
77 23
78 13
79 23
80 10
81 12
82 8
83 12
84 4
85 7
86 7
87 10
88 10
89 11
90 3
91 5
92 5
93 5
94 4
95 1
96 2
97 1
98 2
99 4
100 8


Jörn

-- 
It is better to die of hunger having lived without grief and fear,
than to live with a troubled spirit amid abundance.
-- Epictetus
