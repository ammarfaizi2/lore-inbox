Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264421AbTK0DW3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 22:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264431AbTK0DW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 22:22:29 -0500
Received: from moof.zeroth.org ([203.117.131.35]:33288 "EHLO moof.zeroth.org")
	by vger.kernel.org with ESMTP id S264421AbTK0DVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 22:21:51 -0500
Message-ID: <3FC56DB2.2060704@metaparadigm.com>
Date: Thu, 27 Nov 2003 11:21:22 +0800
From: Jamie Clark <jclark@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>, Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: 2.4.23pre6aa3 - possible ext3 deadlock
References: <3FA713B9.3040405@metaparadigm.com> <20031104102816.GB2984@x30.random> <3FA79308.3070300@metaparadigm.com>
In-Reply-To: <3FA79308.3070300@metaparadigm.com>
Content-Type: multipart/mixed;
 boundary="------------040305040207040801090600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040305040207040801090600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Followup to last test with 2.4.23pre6aa3. same config as before (ext3 
/ql2300 / bonnie++) I forgot to mention that I have quotas enabled on 
the partition under test.

There have been a few 2.4 / quota / ext3 deadlock-type  mails on the 
list recently so I'm sot sure if this is related. I can see an atime 
update in the call trace of one of the bonnies but no dquot_ calls 
anywhere.  I haven't applied Jan's patch as it came out before I could 
reliably reproduce this problem.

In the meantime I'll restart testing with noatime - which is how I'd 
usually mount such a fs anyhow.

The box seems to deadlock after 3-6 days of filesystem exercise. I have 
repeated this 3 times. The last run was 6 days and and then I see all 
disk I/O has ceased. The system remains pingable and sshd connects at 
the TCP layer but nothing happens after that. The root filesystem is 
ext3 but is a completely separate device (motherboard scsi) to the 
filesystems running bonnie (external FC RAID). It seems that all 
filesystem activity ceases.

I have run the alt-sysrq-t ouput through ksymoops and attached.  Hope 
this is useful to someone who knows.

-jamie

Jamie Clark wrote:

> I made the quick fix (disabling rq_mergeable) and started the load test.
> Will let it run for a week or so.
>
> Thanks for the help!
> -Jamie
>
> Andrea Arcangeli wrote:
>
>> On Tue, Nov 04, 2003 at 10:49:29AM +0800, Jamie Clark wrote:
>>
>>> Hi,
>>>
>>> Consistent oops with 2.4.23pre6aa3 after 3-4 hours running bonnie on 
>>> ext3 fs through qla2300 HBA. (w SMP, HIGHMEM) The test machine was 
>>> completely wedged so I ended up transcribing the oops from the vga 
>>> console. No typos I think.
>>>
>> I need to release an update that has a chance to fix it. Jens identified
>> problem in his last_merge scsi patch so I will back it out.
>>
>> you can try to backout it by yourself in the meantime, it's called
>> \*elevator-merge-fast-path\* . or you can disable it with this patch:
>

--------------040305040207040801090600
Content-Type: text/plain;
 name="ksymoops.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops.out"

ksymoops 2.4.5 on i686 2.4.23-pre6aa3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23-pre6aa3/ (default)
     -m /boot/System.map (specified)

init          R F7907F14     0     1      0 12973               (NOTLB)
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace:         [<c01228b8>] (28) [<c012281c>] (12) [<c0151f0c>] (40) [<c0151bdc>] (20) [<c015238a>] (40) [<c0149454>] (44) [<c0107143>] (60)
migration_CPU S C1C1E000     0     2      1             3       (L-TLB)
Call Trace:         [<c011768f>] (16) [<c0117568>] (36) [<c01056d0>] (12)
migration_CPU S F790E346     0     3      1             4     2 (L-TLB)
Call Trace:         [<c011768f>] (16) [<c0117568>] (36) [<c01056d0>] (12) 
keventd       R 00000000     0     4      1             5     3 (L-TLB)
Call Trace:         [<c0127045>] (64) [<c01056d0>] (12)
ksoftirqd_CPU S F7908000     0     5      1             6     4 (L-TLB)
Call Trace:         [<c011e96f>] (20) [<c01056d0>] (12)
ksoftirqd_CPU S C1C1E000     0     6      1             7     5 (L-TLB)
Call Trace:         [<c011e96f>] (20) [<c01056d0>] (12)
kswapd        R C1C1C000  5332     7      1             8     6 (L-TLB)
Call Trace:         [<c0137ca9>] (36) [<c01056d0>] (12)
bdflush       S 00000286     0     8      1             9     7 (L-TLB)
Call Trace:         [<c0116351>] (36) [<c01459e3>] (16) [<c01056d0>] (12)
kupdated      R C1C19FB0  5224     9      1            10     8 (L-TLB)
Call Trace:         [<c01228b8>] (28) [<c012281c>] (12) [<c0145aaa>] (36) [<c01056d0>] (12)
ahc_dv_0      S F75C3F3C    12    10      1            11     9 (L-TLB)
Call Trace:         [<c0105e67>] (40) [<c0105f4b>] (12) [<c01dc79e>] (24) [<c01056d0>] (12)
ahc_dv_1      S F7524D1C  6188    11      1            12    10 (L-TLB)
Call Trace:         [<c0105e67>] (40) [<c0105f4b>] (12) [<c01dc79e>] (24) [<c01056d0>] (12)
scsi_eh_0     S C1C3BFDC  3304    12      1            13    11 (L-TLB)
Call Trace:         [<c0105e67>] (40) [<c0105f4b>] (12) [<c01d0d48>] (56) [<c01056d0>] (12)
scsi_eh_1     S C1C39FDC  6176    13      1            14    12 (L-TLB)
Call Trace:         [<c0105e67>] (40) [<c0105f4b>] (12) [<c01d0d48>] (56) [<c01056d0>] (12)
kjournald     R 00000286     0    14      1            57    13 (L-TLB)
Call Trace:         [<c0116351>] (36) [<c017de49>] (36) [<c017dca0>] (12) [<c01056d0>] (12)
qla2300_dpc2  S C2665FDC  2384    57      1            58    14 (L-TLB)
Call Trace:         [<c0105e67>] (40) [<c0105f4b>] (12) [<c2797943>] (120) [<c01056d0>] (12)
scsi_eh_2     S C2663FDC  2384    58      1            61    57 (L-TLB)
Call Trace:         [<c0105e67>] (40) [<c0105f4b>] (12) [<c01d0d48>] (56) [<c01056d0>] (12)
khubd         S 00000001  2384    61      1            99    58 (L-TLB)
Call Trace:         [<c26048bb>] (28) [<c260ddac>] (04) [<c260ddac>] (08) [<c01056d0>] (12)
kjournald     R 00000286  2384    99      1           100    61 (L-TLB)
Call Trace:         [<c0116351>] (36) [<c017de49>] (36) [<c017dca0>] (12) [<c01056d0>] (12)
kjournald     S 00000286    52   100      1           137    99 (L-TLB)
Call Trace:         [<c0116351>] (36) [<c017de49>] (36) [<c017dca0>] (12) [<c01056d0>] (12)
portmap       S 7FFFFFFF     0   137      1           208   100 (NOTLB)
Call Trace:         [<c012283c>] (24) [<c015267a>] (16) [<c01526b0>] (32) [<c0152884>] (64) [<c0151bdc>] (20) [<c0107143>] (60)
syslogd       R 7FFFFFFF     0   208      1           211   137 (NOTLB)
Call Trace:         [<c012283c>] (12) [<c01fe467>] (28) [<c0151f0c>] (40) [<c0151bdc>] (20) [<c015238a>] (84) [<c0107143>] (60)
klogd         R F7AA6000    52   211      1           219   208 (NOTLB)
Call Trace:         [<c01198bc>] (52) [<c016af45>] (16) [<c0140be7>] (36) [<c0107143>] (60)
rpc.statd     S 7FFFFFFF     0   219      1           225   211 (NOTLB)
Call Trace:         [<c012283c>] (12) [<c01fe467>] (28) [<c0151f0c>] (40) [<c0151bdc>] (20) [<c015238a>] (84) [<c0107143>] (60)
gpm           S F7A4BF14    52   225      1           230   219 (NOTLB)
Call Trace:         [<c01228b8>] (28) [<c012281c>] (12) [<c0151f0c>] (40) [<c0151bdc>] (20) [<c015238a>] (84) [<c0107143>] (60)
inetd         S 7FFFFFFF     0   230      1           249   225 (NOTLB)
Call Trace:         [<c012283c>] (12) [<c01fe467>] (28) [<c0151f0c>] (40) [<c0151bdc>] (20) [<c015238a>] (84) [<c0107143>] (60)
nfsd          R C23EBF54     0   241      1           253   242 (L-TLB)
Call Trace:         [<c01228b8>] (28) [<c012281c>] (12) [<c3228e99>] (72) [<f7a9029c>] (44) [<f7a9a520>] (12) [<c01056d0>] (12)
nfsd          R C23C9F54     0   242      1           241   243 (L-TLB)
Call Trace:         [<c01228b8>] (28) [<c012281c>] (12) [<c3228e99>] (72) [<f7a9029c>] (56) [<c01056d0>] (12)
nfsd          R C23A9F54    52   243      1           242   244 (L-TLB)
Call Trace:         [<c01228b8>] (28) [<c012281c>] (12) [<c3228e99>] (72) [<f7a9029c>] (56) [<c01056d0>] (12)
nfsd          R C238FF54     0   244      1           243   245 (L-TLB)
Call Trace:         [<c01228b8>] (28) [<c012281c>] (12) [<c3228e99>] (72) [<f7a9029c>] (56) [<c01056d0>] (12)
nfsd          R C236FF54    52   245      1           244   246 (L-TLB)
Call Trace:         [<c01228b8>] (28) [<c012281c>] (12) [<c3228e99>] (72) [<f7a9029c>] (56) [<c01056d0>] (12)
nfsd          R C234DF54     0   246      1           245   247 (L-TLB)
Call Trace:         [<c01228b8>] (28) [<c012281c>] (12) [<c3228e99>] (72) [<f7a9029c>] (56) [<c01056d0>] (12)
nfsd          R C232DF54    52   247      1           246   248 (L-TLB)
Call Trace:         [<c01228b8>] (28) [<c012281c>] (12) [<c3228e99>] (72) [<f7a9029c>] (56) [<c01056d0>] (12)
nfsd          R C2313F54    52   248      1           247   249 (L-TLB)
Call Trace:         [<c01228b8>] (28) [<c012281c>] (12) [<c3228e99>] (72) [<f7a9029c>] (48) [<f7a9a520>] (08) [<c01056d0>] (12)
lockd         S 7FFFFFFF  2384   249      1   250     248   230 (L-TLB)
Call Trace:         [<c012283c>] (20) [<c3225244>] (20) [<c3228e99>] (72) [<f7ab1cb3>] (36) [<c01056d0>] (12)
rpciod        S 00000001    52   250    249                     (L-TLB)
Call Trace:         [<c3225410>] (12) [<c322f74c>] (12) [<c322f74c>] (12) [<c322f744>] (04) [<c322f744>] (08) [<c01056d0>] (04) [<c322f74c>] (08)
rpc.mountd    S 7FFFFFFF    52   253      1           259   241 (NOTLB)
Call Trace:         [<c012283c>] (24) [<c015267a>] (16) [<c01526b0>] (32) [<c0152884>] (64) [<c0151bdc>] (20) [<c0107143>] (60)
sshd          S 7FFFFFFF    52   259      1 18848     263   253 (NOTLB)
Call Trace:         [<c012283c>] (12) [<c01fe467>] (28) [<c0151f0c>] (40) [<c0151bdc>] (20) [<c015238a>] (84) [<c0107143>] (60)
xfs           R C2287F14     0   263      1           268   259 (NOTLB)
Call Trace:         [<c01228b8>] (28) [<c012281c>] (12) [<c0151f0c>] (40) [<c0151bdc>] (20) [<c015238a>] (44) [<c011dd7d>] (40) [<c0107143>] (60)
atd           R F7A31F60    52   268      1           271   263 (NOTLB)
Call Trace:         [<c01228b8>] (28) [<c012281c>] (12) [<c01229ec>] (68) [<c0107143>] (60)
cron          R C2281F60     0   271      1 19062     275   268 (NOTLB)
Call Trace:         [<c01228b8>] (28) [<c012281c>] (12) [<c01229ec>] (68) [<c0107143>] (60)
apache        R C227DF14    52   275      1 18141     281   271 (NOTLB)
Call Trace:         [<c01228b8>] (28) [<c012281c>] (12) [<c0151f0c>] (40) [<c0151bdc>] (20) [<c015238a>] (84) [<c0107143>] (60)
getty         S 7FFFFFFF  5028   281      1           282   275 (NOTLB)
Call Trace:         [<c012283c>] (36) [<c0196084>] (04) [<c01960cf>] (88) [<c0191c3a>] (32) [<c0140be7>] (36) [<c0107143>] (60)
getty         S 7FFFFFFF     0   282      1           283   281 (NOTLB)
Call Trace:         [<c012283c>] (36) [<c0196084>] (04) [<c01960cf>] (88) [<c0191c3a>] (32) [<c0140be7>] (36) [<c0107143>] (60)
getty         S 7FFFFFFF     0   283      1           284   282 (NOTLB)
Call Trace:         [<c012283c>] (36) [<c0196084>] (04) [<c01960cf>] (88) [<c0191c3a>] (32) [<c0140be7>] (36) [<c0107143>] (60)
getty         S 7FFFFFFF    52   284      1           285   283 (NOTLB)
Call Trace:         [<c012283c>] (36) [<c0196084>] (04) [<c01960cf>] (88) [<c0191c3a>] (32) [<c0140be7>] (36) [<c0107143>] (60)
getty         S 7FFFFFFF    52   285      1           286   284 (NOTLB)
Call Trace:         [<c012283c>] (36) [<c0196084>] (04) [<c01960cf>] (88) [<c0191c3a>] (32) [<c0140be7>] (36) [<c0107143>] (60)
getty         S 7FFFFFFF    52   286      1           884   285 (NOTLB)
Call Trace:         [<c012283c>] (36) [<c0196084>] (04) [<c01960cf>] (88) [<c0191c3a>] (32) [<c0140be7>] (36) [<c0107143>] (60)
kjournald     D F7A9D294  4796   884      1           895   286 (L-TLB)
Call Trace:         [<c0105da8>] (36) [<c0105f40>] (16) [<c017c0b4>] (244) [<c0115f53>] (08) [<c0115f5f>] (76) [<c017de26>] (40) [<c017dca0>] (12) [<c01056d0>] (12)
screen        S 7FFFFFFF  2384   895      1   896     902   884 (NOTLB)
Call Trace:         [<c012283c>] (40) [<c0151f0c>] (40) [<c0151bdc>] (20) [<c015238a>] (84) [<c0107143>] (60)
rlbench.sh    S 00000000     0   896    895   898               (NOTLB)
Call Trace:         [<c011d6d6>] (60) [<c0107143>] (60)
rlbench       R C93DFF60  2384   897    896           898       (NOTLB)
Call Trace:         [<c01228b8>] (28) [<c012281c>] (12) [<c01229ec>] (68) [<c0107143>] (60)
tee           S C936E000  4888   898    896                 897 (NOTLB)
Call Trace:         [<c014afeb>] (60) [<c014b0c4>] (36) [<c0140be7>] (36) [<c0107143>] (60)
screen        S 7FFFFFFF  5524   902      1   903     907   895 (NOTLB)
Call Trace:         [<c012283c>] (40) [<c0151f0c>] (40) [<c0151bdc>] (20) [<c015238a>] (84) [<c0107143>] (60)
bash          S 00000000  2384   903    902  9385               (NOTLB)
Call Trace:         [<c011d6d6>] (60) [<c0107143>] (60)
screen        S 7FFFFFFF     0   907      1   908    9945   902 (NOTLB)
Call Trace:         [<c012283c>] (40) [<c0151f0c>] (40) [<c0151bdc>] (20) [<c015238a>] (84) [<c0107143>] (60)
bash          S 00000000     0   908    907  9387               (NOTLB)
Call Trace:         [<c011d6d6>] (60) [<c0107143>] (60)
bonnie++      D F7A9D294     0  9385    903  9400               (NOTLB)
Call Trace:         [<c0105da8>] (36) [<c0105f40>] (16) [<c017adfa>] (24) [<c0178ffd>] (24) [<c0173d48>] (24) [<c0156cbe>] (20) [<c01584aa>] (12) [<c012e882>] (52) [<c012ec64>] (16) [<c012eac0>] (24) [<c016f007>] (36) [<c0140be7>] (36) [<c0107143>] (60)
bonnie++      R C17FE560     0  9387    908  9394               (NOTLB)
bonnie++      R D7933F30     0  9394   9387                     (NOTLB)
Call Trace:         [<c01228b8>] (28) [<c012281c>] (12) [<c01526b0>] (32) [<c0152884>] (64) [<c0151bdc>] (20) [<c0107143>] (60)
bonnie++      R E157FF30     0  9400   9385                     (NOTLB)
Call Trace:         [<c01228b8>] (28) [<c012281c>] (12) [<c01526b0>] (32) [<c0152884>] (64) [<c0151bdc>] (20) [<c0107143>] (60)
screen        S 7FFFFFFF     0  9945      1  9946   12973   907 (NOTLB)
Call Trace:         [<c012283c>] (40) [<c0151f0c>] (40) [<c0151bdc>] (20) [<c015238a>] (84) [<c0107143>] (60)
bash          S 00000000     0  9946   9945  9947               (NOTLB)
Call Trace:         [<c011d6d6>] (60) [<c0107143>] (60)
bonnie++      D F7A9D294     0  9947   9946  9963               (NOTLB)
Call Trace:         [<c0105da8>] (36) [<c0105f40>] (16) [<c017adfa>] (24) [<c0178ffd>] (24) [<c0173d48>] (24) [<c0156cbe>] (20) [<c01584aa>] (12) [<c012e882>] (52) [<c012ec64>] (16) [<c012eac0>] (60) [<c0140be7>] (36) [<c0107143>] (60)
bonnie++      R DF49FF30     0  9963   9947                     (NOTLB)
Call Trace:         [<c01228b8>] (28) [<c012281c>] (12) [<c01526b0>] (32) [<c0152884>] (64) [<c0151bdc>] (20) [<c0107143>] (60)
lpd           S 7FFFFFFF     0 12973      1                9945 (NOTLB)
Call Trace:         [<c012283c>] (12) [<c01fe467>] (28) [<c0151f0c>] (40) [<c0151bdc>] (20) [<c015238a>] (44) [<c01ff657>] (40) [<c0107143>] (60)
apache        S 7FFFFFFF    52 18137    275         18138       (NOTLB)
Call Trace:         [<c012283c>] (40) [<c021f5ed>] (68) [<c021f77a>] (32) [<c0239a44>] (36) [<c01fec56>] (52) [<c0113d58>] (36) [<c012c729>] (52) [<c0124543>] (28) [<c01ff66c>] (44) [<c0107143>] (60)
apache        S 7FFFFFFF    52 18138    275         18139 18137 (NOTLB)
Call Trace:         [<c012283c>] (40) [<c021f5ed>] (68) [<c021f77a>] (32) [<c0239a44>] (36) [<c01fec56>] (52) [<c0113d58>] (36) [<c012c729>] (52) [<c0124543>] (28) [<c01ff66c>] (44) [<c0107143>] (60)
apache        S 7FFFFFFF    52 18139    275         18140 18138 (NOTLB)
Call Trace:         [<c012283c>] (40) [<c021f5ed>] (68) [<c021f77a>] (32) [<c0239a44>] (36) [<c01fec56>] (52) [<c0113d58>] (36) [<c012c729>] (52) [<c0124543>] (28) [<c01ff66c>] (44) [<c0107143>] (60)
apache        S 7FFFFFFF    52 18140    275         18141 18139 (NOTLB)
Call Trace:         [<c012283c>] (40) [<c021f5ed>] (68) [<c021f77a>] (32) [<c0239a44>] (36) [<c01fec56>] (52) [<c0113d58>] (36) [<c012c729>] (52) [<c0124543>] (28) [<c01ff66c>] (44) [<c0107143>] (60)
apache        S 7FFFFFFF    52 18141    275               18140 (NOTLB)
Call Trace:         [<c012283c>] (40) [<c021f5ed>] (68) [<c021f77a>] (32) [<c0239a44>] (36) [<c01fec56>] (52) [<c0113d58>] (36) [<c012c729>] (52) [<c0124543>] (28) [<c01ff66c>] (44) [<c0107143>] (60)
sshd          R 7FFFFFFF     0 18848    259 18850               (NOTLB)
Call Trace:         [<c012283c>] (40) [<c0151f0c>] (40) [<c0151bdc>] (20) [<c015238a>] (84) [<c0107143>] (60)
bash          S 7FFFFFFF     0 18850  18848                     (NOTLB)
Call Trace:         [<c012283c>] (36) [<c0196084>] (04) [<c01960cf>] (88) [<c0191c3a>] (32) [<c0140be7>] (36) [<c0107143>] (60)
cron          S E291A000     0 19062    271 19063               (NOTLB)
Call Trace:         [<c014afeb>] (60) [<c014b0c4>] (36) [<c0140be7>] (36) [<c0107143>] (60)
sh            S 00000000     0 19063  19062 19064               (NOTLB)
Call Trace:         [<c011d6d6>] (60) [<c0107143>] (60)
run-parts     S 7FFFFFFF     0 19064  19063 19091               (NOTLB)
Call Trace:         [<c012283c>] (40) [<c0151f0c>] (40) [<c0151bdc>] (20) [<c015238a>] (84) [<c0107143>] (60)
find          S 00000000     0 19091  19064 19092               (NOTLB)
Call Trace:         [<c011d6d6>] (60) [<c0107143>] (60)
updatedb      S 00000000     0 19092  19091 19109               (NOTLB)
Call Trace:         [<c011d6d6>] (60) [<c0107143>] (60)
updatedb      S 00000000     0 19106  19092 19107   19108       (NOTLB)
Call Trace:         [<c011d6d6>] (60) [<c0107143>] (60)
find          R F735CAC0  2384 19107  19106                     (NOTLB)
Call Trace:         [<c0141e75>] (40) [<c01715e2>] (20) [<c016eca6>] (84) [<c01493d4>] (52) [<c01510f4>] (12) [<c01516e0>] (24) [<c015182e>] (08) [<c01516e0>] (32) [<c015087b>] (24) [<c0107143>] (60)
sort          R current      0 19108  19092         19109 19106 (NOTLB)
frcode        S E20EA000    16 19109  19092               19108 (NOTLB)
Call Trace:         [<c014afeb>] (60) [<c014b0c4>] (36) [<c0140be7>] (36) [<c0107143>] (60)
Warning (Oops_read): Code line not seen, dumping what data is available

Proc;  init

>>EIP; f7907f14 <END_OF_CODE+17ce15/????>   <=====

Trace; c01228b8 <schedule_timeout+90/b0>
Trace; c012281c <process_timeout+0/c>
Trace; c0151f0c <do_select+1c8/204>
Trace; c0151bdc <__pollwait+0/c0>
Trace; c015238a <sys_select+41a/5fc>
Trace; c0149454 <sys_stat64+64/70>
Trace; c0107143 <system_call+33/38>
Proc;  migration_CPU

>>EIP; c1c1e000 <_end+187f58c/1dad58c>   <=====

Trace; c011768f <migration_thread+127/340>
Trace; c0117568 <migration_thread+0/340>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  migration_CPU

>>EIP; f790e346 <END_OF_CODE+183247/????>   <=====

Trace; c011768f <migration_thread+127/340>
Trace; c0117568 <migration_thread+0/340>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  keventd

>>EIP; 00000000 Before first symbol

Trace; c0127045 <context_thread+115/1cc>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  ksoftirqd_CPU

>>EIP; f7908000 <END_OF_CODE+17cf01/????>   <=====

Trace; c011e96f <ksoftirqd+93/c8>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  ksoftirqd_CPU

>>EIP; c1c1e000 <_end+187f58c/1dad58c>   <=====

Trace; c011e96f <ksoftirqd+93/c8>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  kswapd

>>EIP; c1c1c000 <_end+187d58c/1dad58c>   <=====

Trace; c0137ca9 <kswapd+75/ae>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  bdflush

>>EIP; 00000286 Before first symbol   <=====

Trace; c0116351 <interruptible_sleep_on+51/80>
Trace; c01459e3 <bdflush+cb/d0>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  kupdated

>>EIP; c1c19fb0 <_end+187b53c/1dad58c>   <=====

Trace; c01228b8 <schedule_timeout+90/b0>
Trace; c012281c <process_timeout+0/c>
Trace; c0145aaa <kupdate+c2/188>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  ahc_dv_0

>>EIP; f75c3f3c <[sunrpc].bss.end+34273429/343f34ed>   <=====

Trace; c0105e67 <__down_interruptible+5f/e4>
Trace; c0105f4b <__down_failed_interruptible+7/c>
Trace; c01dc79e <.text.lock.aic7xxx_osm+bb/21d>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  ahc_dv_1

>>EIP; f7524d1c <[sunrpc].bss.end+341d4209/343f34ed>   <=====

Trace; c0105e67 <__down_interruptible+5f/e4>
Trace; c0105f4b <__down_failed_interruptible+7/c>
Trace; c01dc79e <.text.lock.aic7xxx_osm+bb/21d>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  scsi_eh_0

>>EIP; c1c3bfdc <_end+189d568/1dad58c>   <=====

Trace; c0105e67 <__down_interruptible+5f/e4>
Trace; c0105f4b <__down_failed_interruptible+7/c>
Trace; c01d0d48 <.text.lock.scsi_error+dd/f5>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  scsi_eh_1

>>EIP; c1c39fdc <_end+189b568/1dad58c>   <=====

Trace; c0105e67 <__down_interruptible+5f/e4>
Trace; c0105f4b <__down_failed_interruptible+7/c>
Trace; c01d0d48 <.text.lock.scsi_error+dd/f5>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  kjournald

>>EIP; 00000286 Before first symbol   <=====

Trace; c0116351 <interruptible_sleep_on+51/80>
Trace; c017de49 <kjournald+199/250>
Trace; c017dca0 <commit_timeout+0/c>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  qla2300_dpc2

>>EIP; c2665fdc <[mii].rodata.end+2dc7dd/bf7801>   <=====

Trace; c0105e67 <__down_interruptible+5f/e4>
Trace; c0105f4b <__down_failed_interruptible+7/c>
Trace; c2797943 <[mii].rodata.end+40e144/bf7801>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  scsi_eh_2

>>EIP; c2663fdc <[mii].rodata.end+2da7dd/bf7801>   <=====

Trace; c0105e67 <__down_interruptible+5f/e4>
Trace; c0105f4b <__down_failed_interruptible+7/c>
Trace; c01d0d48 <.text.lock.scsi_error+dd/f5>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  khubd

>>EIP; 00000001 Before first symbol   <=====

Trace; c26048bb <[mii].rodata.end+27b0bc/bf7801>
Trace; c260ddac <[mii].rodata.end+2845ad/bf7801>
Trace; c260ddac <[mii].rodata.end+2845ad/bf7801>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  kjournald

>>EIP; 00000286 Before first symbol   <=====

Trace; c0116351 <interruptible_sleep_on+51/80>
Trace; c017de49 <kjournald+199/250>
Trace; c017dca0 <commit_timeout+0/c>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  kjournald

>>EIP; 00000286 Before first symbol   <=====

Trace; c0116351 <interruptible_sleep_on+51/80>
Trace; c017de49 <kjournald+199/250>
Trace; c017dca0 <commit_timeout+0/c>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  portmap

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c015267a <do_poll+86/dc>
Trace; c01526b0 <do_poll+bc/dc>
Trace; c0152884 <sys_poll+1b4/2a3>
Trace; c0151bdc <__pollwait+0/c0>
Trace; c0107143 <system_call+33/38>
Proc;  syslogd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c01fe467 <sock_poll+23/28>
Trace; c0151f0c <do_select+1c8/204>
Trace; c0151bdc <__pollwait+0/c0>
Trace; c015238a <sys_select+41a/5fc>
Trace; c0107143 <system_call+33/38>
Proc;  klogd

>>EIP; f7aa6000 <END_OF_CODE+31af01/????>   <=====

Trace; c01198bc <do_syslog+ec/3e4>
Trace; c016af45 <kmsg_read+11/18>
Trace; c0140be7 <sys_read+8f/100>
Trace; c0107143 <system_call+33/38>
Proc;  rpc.statd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c01fe467 <sock_poll+23/28>
Trace; c0151f0c <do_select+1c8/204>
Trace; c0151bdc <__pollwait+0/c0>
Trace; c015238a <sys_select+41a/5fc>
Trace; c0107143 <system_call+33/38>
Proc;  gpm

>>EIP; f7a4bf14 <END_OF_CODE+2c0e15/????>   <=====

Trace; c01228b8 <schedule_timeout+90/b0>
Trace; c012281c <process_timeout+0/c>
Trace; c0151f0c <do_select+1c8/204>
Trace; c0151bdc <__pollwait+0/c0>
Trace; c015238a <sys_select+41a/5fc>
Trace; c0107143 <system_call+33/38>
Proc;  inetd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c01fe467 <sock_poll+23/28>
Trace; c0151f0c <do_select+1c8/204>
Trace; c0151bdc <__pollwait+0/c0>
Trace; c015238a <sys_select+41a/5fc>
Trace; c0107143 <system_call+33/38>
Proc;  nfsd

>>EIP; c23ebf54 <[mii].rodata.end+62755/bf7801>   <=====

Trace; c01228b8 <schedule_timeout+90/b0>
Trace; c012281c <process_timeout+0/c>
Trace; c3228e99 <[iptable_filter].data.end+2a779a/3be901>
Trace; f7a9029c <END_OF_CODE+30519d/????>
Trace; f7a9a520 <END_OF_CODE+30f421/????>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  nfsd

>>EIP; c23c9f54 <[mii].rodata.end+40755/bf7801>   <=====

Trace; c01228b8 <schedule_timeout+90/b0>
Trace; c012281c <process_timeout+0/c>
Trace; c3228e99 <[iptable_filter].data.end+2a779a/3be901>
Trace; f7a9029c <END_OF_CODE+30519d/????>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  nfsd

>>EIP; c23a9f54 <[mii].rodata.end+20755/bf7801>   <=====

Trace; c01228b8 <schedule_timeout+90/b0>
Trace; c012281c <process_timeout+0/c>
Trace; c3228e99 <[iptable_filter].data.end+2a779a/3be901>
Trace; f7a9029c <END_OF_CODE+30519d/????>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  nfsd

>>EIP; c238ff54 <[mii].rodata.end+6755/bf7801>   <=====

Trace; c01228b8 <schedule_timeout+90/b0>
Trace; c012281c <process_timeout+0/c>
Trace; c3228e99 <[iptable_filter].data.end+2a779a/3be901>
Trace; f7a9029c <END_OF_CODE+30519d/????>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  nfsd

>>EIP; c236ff54 <[qla2300].bss.end+39655/41701>   <=====

Trace; c01228b8 <schedule_timeout+90/b0>
Trace; c012281c <process_timeout+0/c>
Trace; c3228e99 <[iptable_filter].data.end+2a779a/3be901>
Trace; f7a9029c <END_OF_CODE+30519d/????>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  nfsd

>>EIP; c234df54 <[qla2300].bss.end+17655/41701>   <=====

Trace; c01228b8 <schedule_timeout+90/b0>
Trace; c012281c <process_timeout+0/c>
Trace; c3228e99 <[iptable_filter].data.end+2a779a/3be901>
Trace; f7a9029c <END_OF_CODE+30519d/????>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  nfsd

>>EIP; c232df54 <[qla2300]fw2300tp_code01+126e4/1804e>   <=====

Trace; c01228b8 <schedule_timeout+90/b0>
Trace; c012281c <process_timeout+0/c>
Trace; c3228e99 <[iptable_filter].data.end+2a779a/3be901>
Trace; f7a9029c <END_OF_CODE+30519d/????>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  nfsd

>>EIP; c2313f54 <[qla2300]qla2x00_cfg_build_path_tree+1dc/2a4>   <=====

Trace; c01228b8 <schedule_timeout+90/b0>
Trace; c012281c <process_timeout+0/c>
Trace; c3228e99 <[iptable_filter].data.end+2a779a/3be901>
Trace; f7a9029c <END_OF_CODE+30519d/????>
Trace; f7a9a520 <END_OF_CODE+30f421/????>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  lockd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c3225244 <[iptable_filter].data.end+2a3b45/3be901>
Trace; c3228e99 <[iptable_filter].data.end+2a779a/3be901>
Trace; f7ab1cb3 <END_OF_CODE+326bb4/????>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  rpciod

>>EIP; 00000001 Before first symbol   <=====

Trace; c3225410 <[iptable_filter].data.end+2a3d11/3be901>
Trace; c322f74c <[iptable_filter].data.end+2ae04d/3be901>
Trace; c322f74c <[iptable_filter].data.end+2ae04d/3be901>
Trace; c322f744 <[iptable_filter].data.end+2ae045/3be901>
Trace; c322f744 <[iptable_filter].data.end+2ae045/3be901>
Trace; c01056d0 <arch_kernel_thread+28/38>
Trace; c322f74c <[iptable_filter].data.end+2ae04d/3be901>
Proc;  rpc.mountd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c015267a <do_poll+86/dc>
Trace; c01526b0 <do_poll+bc/dc>
Trace; c0152884 <sys_poll+1b4/2a3>
Trace; c0151bdc <__pollwait+0/c0>
Trace; c0107143 <system_call+33/38>
Proc;  sshd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c01fe467 <sock_poll+23/28>
Trace; c0151f0c <do_select+1c8/204>
Trace; c0151bdc <__pollwait+0/c0>
Trace; c015238a <sys_select+41a/5fc>
Trace; c0107143 <system_call+33/38>
Proc;  xfs

>>EIP; c2287f14 <[lvm-mod].bss.end+fd355/175441>   <=====

Trace; c01228b8 <schedule_timeout+90/b0>
Trace; c012281c <process_timeout+0/c>
Trace; c0151f0c <do_select+1c8/204>
Trace; c0151bdc <__pollwait+0/c0>
Trace; c015238a <sys_select+41a/5fc>
Trace; c011dd7d <sys_gettimeofday+25/54>
Trace; c0107143 <system_call+33/38>
Proc;  atd

>>EIP; f7a31f60 <END_OF_CODE+2a6e61/????>   <=====

Trace; c01228b8 <schedule_timeout+90/b0>
Trace; c012281c <process_timeout+0/c>
Trace; c01229ec <sys_nanosleep+104/209>
Trace; c0107143 <system_call+33/38>
Proc;  cron

>>EIP; c2281f60 <[lvm-mod].bss.end+f73a1/175441>   <=====

Trace; c01228b8 <schedule_timeout+90/b0>
Trace; c012281c <process_timeout+0/c>
Trace; c01229ec <sys_nanosleep+104/209>
Trace; c0107143 <system_call+33/38>
Proc;  apache

>>EIP; c227df14 <[lvm-mod].bss.end+f3355/175441>   <=====

Trace; c01228b8 <schedule_timeout+90/b0>
Trace; c012281c <process_timeout+0/c>
Trace; c0151f0c <do_select+1c8/204>
Trace; c0151bdc <__pollwait+0/c0>
Trace; c015238a <sys_select+41a/5fc>
Trace; c0107143 <system_call+33/38>
Proc;  getty

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c0196084 <read_chan+3b4/7e8>
Trace; c01960cf <read_chan+3ff/7e8>
Trace; c0191c3a <tty_read+da/128>
Trace; c0140be7 <sys_read+8f/100>
Trace; c0107143 <system_call+33/38>
Proc;  getty

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c0196084 <read_chan+3b4/7e8>
Trace; c01960cf <read_chan+3ff/7e8>
Trace; c0191c3a <tty_read+da/128>
Trace; c0140be7 <sys_read+8f/100>
Trace; c0107143 <system_call+33/38>
Proc;  getty

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c0196084 <read_chan+3b4/7e8>
Trace; c01960cf <read_chan+3ff/7e8>
Trace; c0191c3a <tty_read+da/128>
Trace; c0140be7 <sys_read+8f/100>
Trace; c0107143 <system_call+33/38>
Proc;  getty

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c0196084 <read_chan+3b4/7e8>
Trace; c01960cf <read_chan+3ff/7e8>
Trace; c0191c3a <tty_read+da/128>
Trace; c0140be7 <sys_read+8f/100>
Trace; c0107143 <system_call+33/38>
Proc;  getty

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c0196084 <read_chan+3b4/7e8>
Trace; c01960cf <read_chan+3ff/7e8>
Trace; c0191c3a <tty_read+da/128>
Trace; c0140be7 <sys_read+8f/100>
Trace; c0107143 <system_call+33/38>
Proc;  getty

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c0196084 <read_chan+3b4/7e8>
Trace; c01960cf <read_chan+3ff/7e8>
Trace; c0191c3a <tty_read+da/128>
Trace; c0140be7 <sys_read+8f/100>
Trace; c0107143 <system_call+33/38>
Proc;  kjournald

>>EIP; f7a9d294 <END_OF_CODE+312195/????>   <=====

Trace; c0105da8 <__down+5c/bc>
Trace; c0105f40 <__down_failed+8/c>
Trace; c017c0b4 <.text.lock.commit+5/141>
Trace; c0115f53 <do_schedule+36f/3c4>
Trace; c0115f5f <do_schedule+37b/3c4>
Trace; c017de26 <kjournald+176/250>
Trace; c017dca0 <commit_timeout+0/c>
Trace; c01056d0 <arch_kernel_thread+28/38>
Proc;  screen

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c0151f0c <do_select+1c8/204>
Trace; c0151bdc <__pollwait+0/c0>
Trace; c015238a <sys_select+41a/5fc>
Trace; c0107143 <system_call+33/38>
Proc;  rlbench.sh

>>EIP; 00000000 Before first symbol

Trace; c011d6d6 <sys_wait4+386/3bc>
Trace; c0107143 <system_call+33/38>
Proc;  rlbench

>>EIP; c93dff60 <[sunrpc].bss.end+608f44d/343f34ed>   <=====

Trace; c01228b8 <schedule_timeout+90/b0>
Trace; c012281c <process_timeout+0/c>
Trace; c01229ec <sys_nanosleep+104/209>
Trace; c0107143 <system_call+33/38>
Proc;  tee

>>EIP; c936e000 <[sunrpc].bss.end+601d4ed/343f34ed>   <=====

Trace; c014afeb <pipe_wait+5b/84>
Trace; c014b0c4 <pipe_read+b0/1fc>
Trace; c0140be7 <sys_read+8f/100>
Trace; c0107143 <system_call+33/38>
Proc;  screen

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c0151f0c <do_select+1c8/204>
Trace; c0151bdc <__pollwait+0/c0>
Trace; c015238a <sys_select+41a/5fc>
Trace; c0107143 <system_call+33/38>
Proc;  bash

>>EIP; 00000000 Before first symbol

Trace; c011d6d6 <sys_wait4+386/3bc>
Trace; c0107143 <system_call+33/38>
Proc;  screen

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c0151f0c <do_select+1c8/204>
Trace; c0151bdc <__pollwait+0/c0>
Trace; c015238a <sys_select+41a/5fc>
Trace; c0107143 <system_call+33/38>
Proc;  bash

>>EIP; 00000000 Before first symbol

Trace; c011d6d6 <sys_wait4+386/3bc>
Trace; c0107143 <system_call+33/38>
Proc;  bonnie++

>>EIP; f7a9d294 <END_OF_CODE+312195/????>   <=====

Trace; c0105da8 <__down+5c/bc>
Trace; c0105f40 <__down_failed+8/c>
Trace; c017adfa <.text.lock.transaction+5/26b>
Trace; c0178ffd <journal_start+95/c4>
Trace; c0173d48 <ext3_dirty_inode+74/108>
Trace; c0156cbe <__mark_inode_dirty+32/b0>
Trace; c01584aa <update_atime+4e/54>
Trace; c012e882 <__do_generic_file_read+4e2/4f0>
Trace; c012ec64 <generic_file_read+90/1d8>
Trace; c012eac0 <file_read_actor+0/114>
Trace; c016f007 <ext3_file_write+23/bc>
Trace; c0140be7 <sys_read+8f/100>
Trace; c0107143 <system_call+33/38>
Proc;  bonnie++

>>EIP; c17fe560 <_end+145faec/1dad58c>   <=====
Proc;  bonnie++

>>EIP; d7933f30 <[sunrpc].bss.end+145e341d/343f34ed>   <=====

Trace; c01228b8 <schedule_timeout+90/b0>
Trace; c012281c <process_timeout+0/c>
Trace; c01526b0 <do_poll+bc/dc>
Trace; c0152884 <sys_poll+1b4/2a3>
Trace; c0151bdc <__pollwait+0/c0>
Trace; c0107143 <system_call+33/38>
Proc;  bonnie++

>>EIP; e157ff30 <[sunrpc].bss.end+1e22f41d/343f34ed>   <=====

Trace; c01228b8 <schedule_timeout+90/b0>
Trace; c012281c <process_timeout+0/c>
Trace; c01526b0 <do_poll+bc/dc>
Trace; c0152884 <sys_poll+1b4/2a3>
Trace; c0151bdc <__pollwait+0/c0>
Trace; c0107143 <system_call+33/38>
Proc;  screen

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c0151f0c <do_select+1c8/204>
Trace; c0151bdc <__pollwait+0/c0>
Trace; c015238a <sys_select+41a/5fc>
Trace; c0107143 <system_call+33/38>
Proc;  bash

>>EIP; 00000000 Before first symbol

Trace; c011d6d6 <sys_wait4+386/3bc>
Trace; c0107143 <system_call+33/38>
Proc;  bonnie++

>>EIP; f7a9d294 <END_OF_CODE+312195/????>   <=====

Trace; c0105da8 <__down+5c/bc>
Trace; c0105f40 <__down_failed+8/c>
Trace; c017adfa <.text.lock.transaction+5/26b>
Trace; c0178ffd <journal_start+95/c4>
Trace; c0173d48 <ext3_dirty_inode+74/108>
Trace; c0156cbe <__mark_inode_dirty+32/b0>
Trace; c01584aa <update_atime+4e/54>
Trace; c012e882 <__do_generic_file_read+4e2/4f0>
Trace; c012ec64 <generic_file_read+90/1d8>
Trace; c012eac0 <file_read_actor+0/114>
Trace; c0140be7 <sys_read+8f/100>
Trace; c0107143 <system_call+33/38>
Proc;  bonnie++

>>EIP; df49ff30 <[sunrpc].bss.end+1c14f41d/343f34ed>   <=====

Trace; c01228b8 <schedule_timeout+90/b0>
Trace; c012281c <process_timeout+0/c>
Trace; c01526b0 <do_poll+bc/dc>
Trace; c0152884 <sys_poll+1b4/2a3>
Trace; c0151bdc <__pollwait+0/c0>
Trace; c0107143 <system_call+33/38>
Proc;  lpd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c01fe467 <sock_poll+23/28>
Trace; c0151f0c <do_select+1c8/204>
Trace; c0151bdc <__pollwait+0/c0>
Trace; c015238a <sys_select+41a/5fc>
Trace; c01ff657 <sys_socketcall+9b/1fc>
Trace; c0107143 <system_call+33/38>
Proc;  apache

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c021f5ed <wait_for_connect+105/1d8>
Trace; c021f77a <tcp_accept+ba/234>
Trace; c0239a44 <inet_accept+2c/1b8>
Trace; c01fec56 <sys_accept+66/fc>
Trace; c0113d58 <do_page_fault+0/5fb>
Trace; c012c729 <unmap_fixup+165/174>
Trace; c0124543 <sys_rt_sigaction+67/80>
Trace; c01ff66c <sys_socketcall+b0/1fc>
Trace; c0107143 <system_call+33/38>
Proc;  apache

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c021f5ed <wait_for_connect+105/1d8>
Trace; c021f77a <tcp_accept+ba/234>
Trace; c0239a44 <inet_accept+2c/1b8>
Trace; c01fec56 <sys_accept+66/fc>
Trace; c0113d58 <do_page_fault+0/5fb>
Trace; c012c729 <unmap_fixup+165/174>
Trace; c0124543 <sys_rt_sigaction+67/80>
Trace; c01ff66c <sys_socketcall+b0/1fc>
Trace; c0107143 <system_call+33/38>
Proc;  apache

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c021f5ed <wait_for_connect+105/1d8>
Trace; c021f77a <tcp_accept+ba/234>
Trace; c0239a44 <inet_accept+2c/1b8>
Trace; c01fec56 <sys_accept+66/fc>
Trace; c0113d58 <do_page_fault+0/5fb>
Trace; c012c729 <unmap_fixup+165/174>
Trace; c0124543 <sys_rt_sigaction+67/80>
Trace; c01ff66c <sys_socketcall+b0/1fc>
Trace; c0107143 <system_call+33/38>
Proc;  apache

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c021f5ed <wait_for_connect+105/1d8>
Trace; c021f77a <tcp_accept+ba/234>
Trace; c0239a44 <inet_accept+2c/1b8>
Trace; c01fec56 <sys_accept+66/fc>
Trace; c0113d58 <do_page_fault+0/5fb>
Trace; c012c729 <unmap_fixup+165/174>
Trace; c0124543 <sys_rt_sigaction+67/80>
Trace; c01ff66c <sys_socketcall+b0/1fc>
Trace; c0107143 <system_call+33/38>
Proc;  apache

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c021f5ed <wait_for_connect+105/1d8>
Trace; c021f77a <tcp_accept+ba/234>
Trace; c0239a44 <inet_accept+2c/1b8>
Trace; c01fec56 <sys_accept+66/fc>
Trace; c0113d58 <do_page_fault+0/5fb>
Trace; c012c729 <unmap_fixup+165/174>
Trace; c0124543 <sys_rt_sigaction+67/80>
Trace; c01ff66c <sys_socketcall+b0/1fc>
Trace; c0107143 <system_call+33/38>
Proc;  sshd

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c0151f0c <do_select+1c8/204>
Trace; c0151bdc <__pollwait+0/c0>
Trace; c015238a <sys_select+41a/5fc>
Trace; c0107143 <system_call+33/38>
Proc;  bash

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c0196084 <read_chan+3b4/7e8>
Trace; c01960cf <read_chan+3ff/7e8>
Trace; c0191c3a <tty_read+da/128>
Trace; c0140be7 <sys_read+8f/100>
Trace; c0107143 <system_call+33/38>
Proc;  cron

>>EIP; e291a000 <[sunrpc].bss.end+1f5c94ed/343f34ed>   <=====

Trace; c014afeb <pipe_wait+5b/84>
Trace; c014b0c4 <pipe_read+b0/1fc>
Trace; c0140be7 <sys_read+8f/100>
Trace; c0107143 <system_call+33/38>
Proc;  sh

>>EIP; 00000000 Before first symbol

Trace; c011d6d6 <sys_wait4+386/3bc>
Trace; c0107143 <system_call+33/38>
Proc;  run-parts

>>EIP; 7fffffff Before first symbol   <=====

Trace; c012283c <schedule_timeout+14/b0>
Trace; c0151f0c <do_select+1c8/204>
Trace; c0151bdc <__pollwait+0/c0>
Trace; c015238a <sys_select+41a/5fc>
Trace; c0107143 <system_call+33/38>
Proc;  find

>>EIP; 00000000 Before first symbol

Trace; c011d6d6 <sys_wait4+386/3bc>
Trace; c0107143 <system_call+33/38>
Proc;  updatedb

>>EIP; 00000000 Before first symbol

Trace; c011d6d6 <sys_wait4+386/3bc>
Trace; c0107143 <system_call+33/38>
Proc;  updatedb

>>EIP; 00000000 Before first symbol

Trace; c011d6d6 <sys_wait4+386/3bc>
Trace; c0107143 <system_call+33/38>
Proc;  find

>>EIP; f735cac0 <[sunrpc].bss.end+3400bfad/343f34ed>   <=====

Trace; c0141e75 <__wait_on_buffer+69/8c>
Trace; c01715e2 <ext3_bread+56/7c>
Trace; c016eca6 <ext3_readdir+96/390>
Trace; c01493d4 <cp_new_stat64+134/150>
Trace; c01510f4 <vfs_readdir+94/e0>
Trace; c01516e0 <filldir64+0/104>
Trace; c015182e <sys_getdents64+4a/96>
Trace; c01516e0 <filldir64+0/104>
Trace; c015087b <sys_fcntl64+7f/88>
Trace; c0107143 <system_call+33/38>
Proc;  sort

>>EIP; 0000000c Before first symbol   <=====
Proc;  frcode

>>EIP; e20ea000 <[sunrpc].bss.end+1ed994ed/343f34ed>   <=====

Trace; c014afeb <pipe_wait+5b/84>
Trace; c014b0c4 <pipe_read+b0/1fc>
Trace; c0140be7 <sys_read+8f/100>
Trace; c0107143 <system_call+33/38>


1 warning issued.  Results may not be reliable.

--------------040305040207040801090600--

