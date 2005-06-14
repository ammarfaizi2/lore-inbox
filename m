Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVFNCUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVFNCUP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 22:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVFNCUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 22:20:15 -0400
Received: from web30707.mail.mud.yahoo.com ([68.142.200.140]:15468 "HELO
	web30707.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261308AbVFNCUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 22:20:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=1QnbgoAlK6CrfRZHWJbbOE/HBMwzTtKV43II8XKmwLL0tJV6a47QHxh8eMUz377xLVrakPVAc5x96eI2UyYsEUO2jFDNJbGA94/5xdnDflLdtGvGXxuB60J6ioeUAZTxWgUFRK6tj87fMbPPjgncPnTZYb+hWjEr1Wb29gpJ7dQ=  ;
Message-ID: <20050614021959.99775.qmail@web30707.mail.mud.yahoo.com>
Date: Mon, 13 Jun 2005 19:19:59 -0700 (PDT)
From: <spaminos-ker@yahoo.com>
Reply-To: spaminos-ker@yahoo.com
Subject: Re: cfq misbehaving on 2.6.11-1.14_FC3
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050611022959.3954ff6b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andrew Morton <akpm@osdl.org> wrote:
> It might be useful to test 2.6.12-rc6-mm1 - it has a substantially
> rewritten CFQ implementation.
> 

Just did, and while things seem to be a little better, cfq still gets
performance even worst than noop.

For this type of load, I think that cfq should get latencies much lower than
noop.

I ran an automated vi "write to file", to get a more persistant test, on the
different i/o scheduler.

while true ; do time vi -c '%s/a/aa/g' -c '%s/aa/a/g' -c 'x' /root/somefile >
/dev/null ; sleep 1m ; done

For some reason, doing a "cp" or appending to files is very fast. I suspect
that vi's mmap calls are the reason for the latency problem.

the times I got (to save a 200 bytes file on ext3) in seconds:

cfq 13,19,23,19,23,15,14,16,14 = 17.3 avg

deadline 7,12,11,15,15,8,17,14,16,11 = 12.6 avg

noop 23,12,14,12,12,13,14,14,14 = 14.2 avg

anticipatory 9,13,13,15,19,15,23,15,12 = 14.8 avg


Here is the memory status

top - 17:07:44 up  1:42,  1 user,  load average: 3.74, 3.62, 3.29
Tasks:  55 total,   2 running,  53 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.0% us,  0.0% sy,  0.0% ni,  0.0% id, 99.0% wa,  1.0% hi,  0.0% si
Mem:   1035156k total,  1019344k used,    15812k free,    30092k buffers
Swap:  4192956k total,        0k used,  4192956k free,   671724k cached

and the disk activity (as you can see, mostly writes at this point, as I think
most of the data is cached in memory).

# vmstat 1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  1      0  20368  30320 670780    0    0    45  1189  498   201 26  2 20 52
 0  3      0  19376  30320 671916    0    0   128  1052  512   211 77  5  0 18
 0  3      0  19376  30320 671960    0    0     0  1220  543   231  3  0  0 97
 0  3      0  19128  30320 672136    0    0     0  2284  658   250 13  1  0 86
 0  3      0  19128  30320 672220    0    0     0  1160  535   222  7  0  0 93
 1  2      0  18880  30320 672376    0    0     0  1040  509   204 13  0  0 87
 0  3      0  18756  30320 672496    0    0     0  1076  514   210 11  1  0 88
 0  3      0  18260  30320 672680    0    0     0  1052  559   356 18  3  0 79
 1  1      0  19376  30328 671692    0    0     0   876  529   187 64  3  0 33
 1  3      0  18384  30340 672620    0    0   128  2856  515   197 64  5  0 31
 0  4      0  18136  30340 672856    0    0     0  1204  546   234 21  0  0 79
 0  4      0  18136  30340 672916    0    0     0  1124  530   231  5  2  0 93
 0  4      0  18136  30340 672976    0    0     0  2212  627   255  7  1  0 92
 0  4      0  18012  30340 673064    0    0     0  1092  523   235  7  1  0 92
 0  4      0  17888  30340 673228    0    0     0  1188  545   239 12  0  0 88
 1  3      0  17640  30340 673500    0    0     0  1092  515   229 26  0  0 74
 0  4      0  17392  30340 673684    0    0     0  1032  515   236 15  1  0 84
 1  1      0  17888  30348 672480    0    0     0  1560  568   249 41  4  0 55
 1  3      0  16896  30360 673524    0    0   128  1976  586   223 74  3  0 23
 0  4      0  16524  30360 673800    0    0     0  1112  522   233 25  1  0 74
 0  4      0  16524  30360 673844    0    0     0  1600  588   257  4  1  0 95


