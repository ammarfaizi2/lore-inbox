Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135259AbRDLTDW>; Thu, 12 Apr 2001 15:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135262AbRDLTDN>; Thu, 12 Apr 2001 15:03:13 -0400
Received: from dfmail.f-secure.com ([194.252.6.39]:9165 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S135259AbRDLTDD>; Thu, 12 Apr 2001 15:03:03 -0400
Date: Thu, 12 Apr 2001 22:12:10 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
        <Valdis.Kletnieks@vt.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: scheduler went mad?
In-Reply-To: <Pine.LNX.4.21.0104121456020.18260-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.30.0104122145520.19377-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Apr 2001, Rik van Riel wrote:
> On Thu, 12 Apr 2001, Szabolcs Szakacsits wrote:
> > I still feel a bit unconfortable about processes looping forever in
> > __alloc_pages and because of this oom_killer also can't be moved to
> > page fault handler where I think its place should be. I'm using the
> > patch below.
> It's BROKEN.  This means that if you have one task using up
> all memory and you're waiting for the OOM kill of that task
> to have effect, your syslogd, etc... will have their allocations
> fail and will die.

You mean without dropping out_of_memory() test in kswapd and calling
oom_kill() in page fault [i.e. without additional patch]? Yes, you're
competely true but I have the patch [see example below, 'm1' is the bad
guy] just didn't have time to extensively test it and don't know whether
there is side efffects getting rid of this infinite looping in
__alloc_pages() but locked up processes apparently don't make people
very happy ;)

	Szaka

Out of Memory: Killed process 830 (m1), saved process 696 (httpd)
   procs                      memory    swap          io     system
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs
 6  0  0      0   9492    100   1496   0   0  1386     2 2904  3877
 5  0  0      0   7812    104   1788   0   0   289     0  689    22
 5  0  0      0   6248    104   1788   0   0     0     0  108    19
 5  0  0      0   4748    108   1840   0   0    56     0  219    21
 5  0  0      0   3268    108   1868   0   0    28     0  165    23
 5  0  1      0   1864     76   1868   0   0     0     5  120    61
 5  0  1      0   1432     76   1252   0   0     0     0  108  1130
 5  0  1      0   1236     80    796   0   0    65     0  246  4588
 5  0  1      0   1236     80    668   0   0     0     0  110  8869
 6  0  1      0    948    112    696   0   0   805     0 1814  8231
Out of Memory: Killed process 858 (m1), saved process 811 (vmstat)
 5  0  1      0    924    152    444   0   0  1153     0 2731 18231
 4  0  1      0   1720    148    828   0   0   750     3 1711  1876
 5  0  1      0   1156    148    760   0   0   290     0  723  1967
 4  0  1      0   1152    132    664   0   0    70     0  277  7249
 4  0  1      0   1140    144    560   0   0    54     0  238  7942
 4  0  1      0   1140    144    460   0   0    32     0  212  7521
Out of Memory: Killed process 834 (m1), saved process 418 (identd)

