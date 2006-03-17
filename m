Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWCQGMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWCQGMK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 01:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752535AbWCQGMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 01:12:10 -0500
Received: from vidur.ministry.se ([62.95.69.217]:18090 "EHLO vidur.ministry.se")
	by vger.kernel.org with ESMTP id S1751441AbWCQGMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 01:12:09 -0500
Date: Fri, 17 Mar 2006 07:11:49 +0100 (MET)
From: kernel@ministry.se
X-X-Sender: fwadmin@celeborn.ministry.se
To: Valdis.Kletnieks@vt.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel cache mem bug(?) 
In-Reply-To: <200603162042.k2GKgEUR019711@turing-police.cc.vt.edu>
Message-ID: <Pine.GHP.4.44.0603170658530.15349-100000@celeborn.ministry.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 16 Mar 2006 18:41:02 +0100, kernel@ministry.se said:
> > [X.] Other notes, patches, fixes, workarounds:
>
> >     Workaround: When we disable HyperThreading in BIOS, this
> >     problem goes away. We re-enabling HT, it comes back...
>
> Have you ruled out marginal memory, or overclocking/overheating?

No overclocking done, no overheating happening. All RAM memory checks
turn out just fine, with and without HT.

> For that matter, this looks racy:
>
> while [ 0$MD5LOOPS -gt 0 ]; do
>   md5sum cache.*-*-* >> md5log.$PID.lis
>   MD5LOOPS=`expr 0$MD5LOOPS - 1`
> done &
>
>  AMNT=`awk '$1!="91b82dcc83230890dbcdfc6b80571ddd"' md5log.$PID.lis | wc -l`
>
> If md5sum uses stdio to write the output, and it writes more than 4K or so,
> it's possible you can get a partial line right at the buffer boundary,
> which will then come up as a mismatch according to the awk.  You might want
> to actually output the mismatched line in its entirety, and make sure you're
> looking at a complete line, and not a partial....

Well, the script itself was not how we noticied the problem. It was
created to see if the problem was reproducable. It was, during mentioned
conditions.

Regarding a possible race condition, the log file (md5log.*.lis) is left
for manual inspection if needed.

Following line will fix this (possible) event:
  AMNT=`awk 'length($1)==32 && $1!="91b82dcc83230890dbcdfc6b80571ddd"' \
    md5log.$PID.lis | wc -l`

//D

