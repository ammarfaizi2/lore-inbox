Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313688AbSDIBpD>; Mon, 8 Apr 2002 21:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313747AbSDIBpC>; Mon, 8 Apr 2002 21:45:02 -0400
Received: from paloma14.e0k.nbg-hannover.de ([62.181.130.14]:60041 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S313688AbSDIBpB>; Mon, 8 Apr 2002 21:45:01 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Jason Papadopoulos <jasonp@boo.net>
Subject: Re: [PATCH] page coloring for 2.4.18 kernel
Date: Tue, 9 Apr 2002 03:09:47 +0200
X-Mailer: KMail [version 1.4]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrea Arcange <andrea@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200204090237.29745.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jason,

I would gave page_coloring a go on my Athlon II (0.18µm, L1 128K, L2 512K) 
with 2.4.19-pre5-vm33-preempt+lock-break.

Little rejection in kernel/ksyms.c.rej.

***************
*** 559,561 ****

  EXPORT_SYMBOL(tasklist_lock);
  EXPORT_SYMBOL(pidhash);
--- 559,579 ----

  EXPORT_SYMBOL(tasklist_lock);
  EXPORT_SYMBOL(pidhash);
+
+ #ifdef CONFIG_PAGE_COLORING_MODULE
+ extern unsigned int page_miss_count;
+ extern unsigned int page_hit_count;
+ extern unsigned int page_alloc_count;
+ extern unsigned int page_colors;
+ extern struct list_head *page_color_table;
+ void page_color_start(void);
+ void page_color_stop(void);
+
+ EXPORT_SYMBOL_NOVERS(page_miss_count);
+ EXPORT_SYMBOL_NOVERS(page_hit_count);
+ EXPORT_SYMBOL_NOVERS(page_alloc_count);
+ EXPORT_SYMBOL_NOVERS(page_colors);
+ EXPORT_SYMBOL_NOVERS(page_color_table);
+ EXPORT_SYMBOL_NOVERS(page_color_start);
+ EXPORT_SYMBOL_NOVERS(page_color_stop);
+ #endif

No problem to add by hand but later on I get this:

mm/mm.o: In function `alloc_pages_by_color':
mm/mm.o(.text+0xb64a): undefined reference to `BAD_RANGE'
mm/mm.o(.text+0xb6e6): undefined reference to `BAD_RANGE'
mm/mm.o(.text+0xb760): undefined reference to `BAD_RANGE'
make: *** [vmlinux] Error 1

To solve this I have to move the definition of BAD_RANGE in mm/page_alloc.c 
somewhat more to the beginning of the file.

[-]
unsigned int rand_carry = 0x01234567;
unsigned int rand_seed = 0x89abcdef;

#define MULT 2131995753

/*
 * Temporary debugging check.
 */
#define BAD_RANGE(zone, page)						\
(									\
	(((page) - mem_map) >= ((zone)->zone_start_mapnr+(zone)->size))	\
	|| (((page) - mem_map) < (zone)->zone_start_mapnr)		\
	|| ((zone) != page_zone(page))					\
)
[-]

Apr  9 02:21:08 SunWave1 kernel: page_color: starting with 128 colors

After running "dbench 32" I get the below numbers:

/home/nuetzel> cat /proc/page_color
colors: 128
hits: 479219
misses: 7487
pages allocated: 479310
3 2 0 1 1 0 0 1 1 0 2 0 1 0 0 0 1 0 0 1 0 0 0 2 0 0 1 3 3 0 2 0 1 2 1 0 1 1 0 
0 0 2 1 1 1 0 0 1 1 1 0 0 2 0 2 1 4 3 1 1 1 1 1 2 0 2 2 2 0 0 3 1 1 1 0 1 2 2 
0 0 1 0 0 0 0 2 0 1 1 2 1 0 2 1 3 2 2 0 0 2 1 2 1 1 1 0 1 0 1 2 0 0 0 0 1 0 0 
1 3 1 0 0 4 2 0 1 1 3
0 4 1 1 2 1 0 1 1 1 2 0 4 0 2 3 1 2 0 2 1 1 1 1 0 2 2 1 2 5 2 2 3 2 3 0 2 2 0 
4 0 1 1 2 1 3 4 2 2 1 2 3 1 1 0 3 1 0 4 1 5 0 4 1
2 5 1 3 2 2 5 4 2 4 2 2 4 2 3 6 3 5 3 3 3 1 5 1 5 4 2 1 5 1 4 5
3 6 7 2 4 6 10 4 4 6 7 2 2 7 7 4
8 7 10 4 5 7 8 6
5 2 5 3
2 1
0
0
0
58 61 74 71 65 60 75 70 109 91 64 74 78 77 83 69 82 71 61 68 62 81 72 81 67 63 
83 94 98 74 53 78 77 75 90 74 77 87 92 88 96 86 72 101 79 77 71 74 56 73 88 
69 61 70 83 78 81 88 95 83 92 90 81 80 84 74 64 64 67 69 52 70 94 85 70 80 64 
84 84 87 50 65 64 68 60 66 56 70 74 79 78 76 68 72 77 78 91 86 75 77 84 85 88 
88 91 87 69 74 74 75 67 84 92 68 63 63 81 79 62 66 81 84 58 72 93 81 68 73
125 105 108 100 109 137 117 110 96 124 117 112 115 95 113 141 110 99 127 108 
120 117 113 120 125 101 129 106 116 113 101 133 112 130 102 102 119 122 123 
111 107 91 102 108 102 116 103 87 103 118 116 113 113 123 109 110 102 123 106 
123 104 126 112 129
127 141 139 154 155 150 152 137 151 132 140 156 159 149 140 135 109 139 144 
150 134 122 143 155 150 140 133 159 153 148 129 122
195 155 168 171 177 166 169 166 189 152 178 146 153 161 148 176
162 148 158 161 162 189 152 160
76 67 84 91
22 21
0
0
0

Thanks,
	Dieter


