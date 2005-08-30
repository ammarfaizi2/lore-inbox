Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVH3DBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVH3DBl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 23:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVH3DBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 23:01:41 -0400
Received: from NS4.Sony.CO.JP ([137.153.0.44]:37860 "EHLO ns4.sony.co.jp")
	by vger.kernel.org with ESMTP id S932101AbVH3DBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 23:01:40 -0400
Message-ID: <4313CBEF.9020505@sm.sony.co.jp>
Date: Tue, 30 Aug 2005 12:01:03 +0900
From: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp
Subject: [RFC][FAT] diren scan profiling report
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



As I said in "[RFC] FAT dirent scan with hint"
	<43024977.7020101@sm.sony.co.jp>, we realized that FAT/VFAT has
poor performance with scanning directory entries.

Per discussions with Ogawa-san, VFAT maintainer, I took profiling data
to seek better solution. Here are results attached.

In short, I would say we need to reduce following factors.
	a) number of iterations inside fat_search_long()
	b) number of callings to uni16_to_x8()
	c) number of callings to fat__get_entry(), for short name scan.

In another E-mail, I'll send revised version patch which use hint
values to scan dirent. That patch would reduce number of iterations
inside fat_search_long() and fat_scan(). Those contributes reductions
above a)-c) factors.


RESULTS:


1-1) Top 10 function consuming time on long file name dir scan
(vfat_lookup) for 4095th LFN entry.

% kd -n 10 /tmp/lfn_kft-a.log
Function                            Count Time     Average  Local
----------------------------------- ----- -------- -------- --------
vfat_lookup                             1  1242285  1242285      705
vfat_find                               1  1241522  1241522      629
fat_search_long                         1  1240893  1240893   887490
uni16_to_x8                          4209   250222       59   249143
fat_get_entry                         765    69908       91     3306
fat__get_entry                        762    66602       87    50796
fat_shortname2uni                     593    33158       55    11393
fat_short2lower_uni                   414    21765       52    20860
fat_bmap                              202    13425       66      857
fat_bmap_cluster                      201    12568       62     1015

  *)To exclude profiling overhead, doesn't count functions < 50usec
  **) Remove "inline" from fat/dir.c to count up inline funcs.

1-2) Top 10 function consuming time on short file name dir scan
(fat_scan) for 4095th short file name entry.

% kd -n 10 /tmp/kft-a.log
Function                            Count Time     Average  Local
----------------------------------- ----- -------- -------- --------
fat_scan                                1   149743   149743    68069
fat_get_short_entry                   812    81512      100    11706
fat_get_entry                         765    69806       91     3252
fat__get_entry                        762    66554       87    50425
fat_bmap                              199    13181       66      838
fat_bmap_cluster                      198    12343       62     1055
fat_get_cluster                       194    11288       58     8481
fat_ent_read                           52     2807       53     2583
__getblk                               32     2339       73      326
__bread                                29     2145       73      598

  *)To exclude profiling overhead, doesn't count functions < 50usec
  **) Remove "inline" from fat/dir.c to count up inline funcs.


2-1) how to get result 1-1)

% ( cat <<__CONF
new
begin
        trigger start entry 0xc00cd904  # vfat_lookup
        trigger stop exit 0xc00cd904    # vfat_lookup
        filter mintime 50
        filter maxtime 0
        filter noints
        logentries      5000000
end

__CONF
)  > /proc/kft

% echo prime > /proc/kft

# mount vtat

% time stat 4095th-shortfilename-entry

real    0m1.351s
user    0m0.007s
sys     0m1.295s

# umount

# get data from /proc/kft_data


2-2) how to get result 1-2)


% ( cat <<__CONF
new
begin
        trigger start entry 0xc00c36dc # fat_scan
        trigger stop exit 0xc00c36dc # fat_scan
        filter mintime 50
        filter maxtime 0
        filter noints
        logentries      5000000
end
__CONF
)  > /proc/kft

% echo prime > /proc/kft

# mount msdos

% time stat 4095th-shortname-entry

real    0m0.216s
user    0m0.002s
sys     0m0.200s


# umount

# get data from /proc/kft_data


-- 
Hiroyuki Machida		machida@sm.sony.co.jp		
SSW Dept. HENC, Sony Corp.
