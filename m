Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265108AbUELOqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbUELOqY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 10:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265106AbUELOqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 10:46:22 -0400
Received: from smtpq1.home.nl ([213.51.128.196]:9629 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S265104AbUELOp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 10:45:59 -0400
Message-ID: <40A23845.2030508@keyaccess.nl>
Date: Wed, 12 May 2004 16:44:21 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
References: <409F4944.4090501@keyaccess.nl> <200405111537.23535.bzolnier@elka.pw.edu.pl> <40A1073E.3030605@keyaccess.nl> <200405120236.00085.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405120236.00085.bzolnier@elka.pw.edu.pl>
Content-Type: multipart/mixed;
 boundary="------------080809030603050704030003"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080809030603050704030003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Bartlomiej Zolnierkiewicz wrote:

>>Vanilla 2.6.6:
>>
>>rene@7ixe4:~/cache$ grep wcache settings-2.6.6
>>wcache                  1               0               1               rw
>>
>>2.6.6 with the de{flush,spin}ification patches:
>>
>>rene@7ixe4:~/cache$ grep wcache settings-2.6.6-hackedup
>>wcache                  0               0               1               rw
>>
>>Hrmpf. 0?
> 
> Very interesting, can you try vanilla 2.6.5 (or some other 2.6.x)?

2.4.26		: wcache = 0, 0, 1
2.6.6-rc3-mm2	: wcache = 0, 0, 1
2.6.6		: wcache = 1, 0, 1
2.6.6-hackedup	: wcache = 0, 0, 1

(on none of these hdparm -W0/1 has any effect, by the way)

> We are getting close to the real problem.

Indeed. I have attached two "tiobench" seq. write results, one for 
vanilla 2.6.6, and one for 2.6.6-hackedup (your changes). I remember the 
result for the latter are the normal ones I got with previous kernels as 
well. The differences are very interesting.

2.6.6-vanilla (ie, the one showing wcache=1): +/- 10MB/s
2.6.6-hackedup (ie, shows wcache=0)	    : +/- 46MB/s

As said, that 46 is the expected value. Is this a logic inversion bug in 
either driver (but then both 2.4.26 and 2.6) or drive firmware?

Rene.


--------------080809030603050704030003
Content-Type: text/plain;
 name="tiobench-2.6.6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tiobench-2.6.6"

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.6                         1534  4096    1   10.74 9.440%     0.298     2641.08   0.00102  0.00000   114
2.6.6                         1534  4096    2   10.64 9.999%     0.586     7005.74   0.00331  0.00000   106
2.6.6                         1534  4096    4   10.64 9.730%     1.129    17964.34   0.02550  0.00025   109
2.6.6                         1534  4096    8   10.12 9.423%     2.099    28425.08   0.04065  0.00256   107

--------------080809030603050704030003
Content-Type: text/plain;
 name="tiobench-2.6.6-hackedup"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tiobench-2.6.6-hackedup"

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.6                         1534  4096    1   46.59 57.01%     0.069      598.21   0.00000  0.00000    82
2.6.6                         1534  4096    2   42.44 50.34%     0.155     1951.60   0.00000  0.00000    84
2.6.6                         1534  4096    4   44.65 52.23%     0.267     1336.76   0.00000  0.00000    85
2.6.6                         1534  4096    8   37.78 41.34%     0.604     6720.81   0.00307  0.00000    91

--------------080809030603050704030003--
