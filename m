Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbVIHJ7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbVIHJ7H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 05:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVIHJ7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 05:59:07 -0400
Received: from fbxmetz.linbox.com ([81.56.128.63]:63164 "EHLO xiii.metz")
	by vger.kernel.org with ESMTP id S1751227AbVIHJ7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 05:59:06 -0400
Message-ID: <43200B5E.90401@linbox.com>
Date: Thu, 08 Sep 2005 11:58:54 +0200
From: Ludovic Drolez <ludovic.drolez@linbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Strange LVM2/DM data corruption with 2.6.11.12
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

We are developing (GPLed) disk cloning software similar to partimage: it's an 
intelligent 'dd' which backups only used sectors.

Recently I added LVM1/2 support to it, and sometimes we saw LVM restorations 
failing randomly (Disk images are not corrupted, but the result of the 
restoration can be lead to a corrupted filesystem). If a restoration fails, just 
try another one and it will work...

How the restoration program works:
- I restore the LVM2 administrative data (384 sectors, most of the time),
- I 'vgscan', 'vgchange',
- open for writing the '/dev/dm-xxxx',
- read a compressed file over NFS,
- and put the sectors in place, so it's a succession of '_llseek()' and 
'write()' to the DM device.

But, *sometimes*, for example, the current seek position is at 9GB, and some 
data is written to sector 0 ! It happens randomly.

Here is a typical strace of a restoration:

write(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
write(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
_llseek(5, 20963328, [37604032512], SEEK_CUR) = 0
_llseek(5, 0, [37604032512], SEEK_CUR)  = 0
_llseek(5, 2097152, [37606129664], SEEK_CUR) = 0
write(5, "\1\335E\0\f\0\1\2.\0\0\0\2\0\0\0\364\17\2\2..\0\0\0\0\0"..., 512) = 51
2
write(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
write(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
write(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
write(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
write(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
write(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
write(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
_llseek(5, 88076288, [37694210048], SEEK_CUR) = 0
_llseek(5, 0, [37694210048], SEEK_CUR)  = 0
_llseek(5, 20971520, [37715181568], SEEK_CUR) = 0
write(5, "\377\377\377\377\377\377\377\377\377\377\377\377\377\377"..., 512) = 5
12
....
....

As you can see, there are no seeks to sector 0, but something randomly write 
some data to sector 0 !
I could reproduce these random problems on different kind of PCs.

But, the strace above comes from an improved version, which aggregates 
'_llseek's. A previous version, which did *many* 512 bytes seeks had much more 
problems. Aggregating seeks made the corruption to appears very rarely... And I 
more likely to happen, for a 40GB restoration than for a 10GB one.

So less system calls to the DM/LVM2 layer seems to give less corruption probability.


Any ideas ? Newer kernel releases could have fixed such a problem ?


-- 
Ludovic DROLEZ                              Linbox / Free&ALter Soft
http://lrs.linbox.org - Linbox Rescue Server GPL edition
