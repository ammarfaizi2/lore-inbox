Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314126AbSENTaD>; Tue, 14 May 2002 15:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316006AbSENTaC>; Tue, 14 May 2002 15:30:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39949 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314126AbSENTaB>; Tue, 14 May 2002 15:30:01 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] IDE PIO write Fix #2
Date: Tue, 14 May 2002 19:29:35 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <abroiv$ifs$1@penguin.transmeta.com>
In-Reply-To: <3CE0795B.62C956F0@cinet.co.jp> <3CE0D6DE.8090407@evision-ventures.com>
X-Trace: palladium.transmeta.com 1021404583 4799 127.0.0.1 (14 May 2002 19:29:43 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 14 May 2002 19:29:43 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3CE0D6DE.8090407@evision-ventures.com>,
Martin Dalecki  <dalecki@evision-ventures.com> wrote:
>> 
>> --- linux-2.5.15/drivers/ide/ide-taskfile.c.orig	Fri May 10 11:49:35 2002
>> +++ linux-2.5.15/drivers/ide/ide-taskfile.c	Tue May 14 10:40:43 2002
>> @@ -606,7 +606,7 @@
>>  		if (!ide_end_request(drive, rq, 1))
>>  			return ide_stopped;
>>  
>> -	if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
>> +	if ((rq->nr_sectors == 1) ^ ((stat & DRQ_STAT) != 0)) {

Well, that's definitely an improvement - the original code makes no
sense at all, since it's doing a bitwise xor on two bits that are not
the same, and then uses that as a boolean value.

Your change at least makes it use the bitwise xor on properly logical
values, making the bitwise xor work as a _logical_ xor. 

Although at that point I'd just get rid of the xor, and replace it by
the "!=" operation - which is equivalent on logical ops.

>>  		pBuf = ide_map_rq(rq, &flags);
>>  		DTF("write: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
>
>
>Hmm. There is something else that smells in the above, since the XOR operator
>doesn't seem to be proper. Why shouldn't we get DRQ_STAT at all on short
>request? Could you perhaps just try to replace it with an OR?

The XOR operation is a valid op, if you just use it on valid values,
which the patch does seem to make it do.

I don't know whether the logic is _correct_ after that, but at least
there is some remote chance that it might make sense.

		Linus
