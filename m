Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbWE0NTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWE0NTx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 09:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWE0NTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 09:19:53 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:51426 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751511AbWE0NTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 09:19:52 -0400
Message-ID: <348735988.17875@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Sat, 27 May 2006 21:20:02 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, joern@wohnheim.fh-wedel.de,
       ioe-lkml@rameria.de, Martin Peschke <mp3@de.ibm.com>
Subject: Re: [PATCH 09/33] readahead: events accounting
Message-ID: <20060527132002.GA4814@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	joern@wohnheim.fh-wedel.de, ioe-lkml@rameria.de,
	Martin Peschke <mp3@de.ibm.com>
References: <20060524111246.420010595@localhost.localdomain> <348469540.16036@ustc.edu.cn> <20060525093627.4d37e789.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060525093627.4d37e789.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 09:36:27AM -0700, Andrew Morton wrote:
> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> > A debugfs file named `readahead/events' is created according to advises from
> >  J?rn Engel, Andrew Morton and Ingo Oeser.
> 
> If everyone's patches all get merged up we'd expect that this facility be
> migrated over to use Martin Peschke's statistics infrastructure.
> 
> That's not a thing you should do now, but it would be a useful test of
> Martin's work if you could find time to look at it and let us know whether
> the infrastructure which he has provided would suit this application,
> thanks.

Hi, Martin is doing a great job, thanks.

I have read about its doc.  It should be suitable for various
readahead numbers. And it seems a trivial work to port to it :)

However it might also make sense to keep the current _table_ interface.
It shows us the whole picture at a glance:

% cat /debug/readahead/events
[table requests]     total   newfile     state   context  contexta [...]
cache_miss          136302       538      3860     11317       490
read_random          62176       160       424      1633        60
io_congestion            0         0         0         0         0
io_cache_hit         34521       663     10071     15611      1423
io_block            204302     42174     10408     68277      2226
readahead           251478     70746     96846     73636      2561
lookahead           136315     14805     86267     32738      2505
lookahead_hit       103384      8038     74605      9097       598
lookahead_ignore         0         0         0         0         0
readahead_mmap        6911         0         0         0         0
readahead_eof        70793     55935      8500       648       581
readahead_shrink       473         0       473         0         0
readahead_thrash         0         0         0         0         0
readahead_mutilt      2526        24      1079      1403        20
readahead_rescue      1209         0         0         0         0

[table pages]        total   newfile     state   context  contexta
cache_miss      1292350444    282817  35557285  86087568   5592690
read_random       10299237       177       426      1903        63
io_congestion            0         0         0         0         0
io_cache_hit       2194663      9289   1507054    414311    184715
io_block            204302     42174     10408     68277      2226
readahead         26122947    770681  21815335   3097682    259587
readahead_hit     23101714    588811  19906233   2209547    191269
lookahead         21397630    173502  19872014    936474    415640
lookahead_hit     18663196     98004  17879848    596562     88782
lookahead_ignore         0         0         0         0         0
readahead_mmap      170509         0         0         0         0
readahead_eof      1950484    432763   1342148     47368     34742
readahead_shrink     19900         0     19900         0         0
readahead_thrash         0         0         0         0         0
readahead_mutilt    220331       485    186922     29900      3024
readahead_rescue    119592         0         0         0         0

[table summary]      total   newfile     state   context  contexta
random_rate            19%        0%        0%        2%        2%
ra_hit_rate            88%       76%       91%       71%       73%
la_hit_rate            75%       54%       86%       27%       23%
var_ra_size          13850       130      5802      6709     10563
avg_ra_size            104        11       225        42       101
avg_la_size            157        12       230        29       166


When Martin's work is included into -mm, I would like to reduce
several col/rows from the table to Martin's infrastructure, and
perhaps add some more items. One obvious candidate collection is the
ra_account(NULL, ...) calls, which do not quite fit the table
interface and deserves individual files.

Wu
