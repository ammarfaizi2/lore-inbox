Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbUCLSAm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 13:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbUCLSAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 13:00:42 -0500
Received: from stine.vestdata.no ([195.204.68.10]:35017 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP id S262349AbUCLSAi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 13:00:38 -0500
Date: Fri, 12 Mar 2004 18:59:59 +0100
From: Ragnar =?iso-8859-15?Q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arthur Corliss <corliss@digitalmages.com>, watters@sgi.com, law@sgi.com,
       te@scali.com
Subject: Re: [PATCH][RFC] fix BSD accounting (w/ long-term perspective ;-)
Message-ID: <20040312175959.GN1066@vestdata.no>
References: <Pine.LNX.4.53.0403082241200.16420@gockel.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0403082241200.16420@gockel.physik3.uni-rostock.de>
User-Agent: Mutt/1.5.2i
X-Zet.no-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ CCing Sam Watters and Linda Walsh at SGI for feedback about using
pid/ppid/pgid/sid/paggid/whatever to track jobs in accounting-logs ]

On Tue, Mar 09, 2004 at 12:03:27AM +0100, Tim Schmielau wrote:
> BSD accounting currently reports only the lower 16 bits of 32 bit uids,
> reports times in units of 1/HZ seconds while it announces a unit of
> 1/100 seconds in the header file (which hurts especially on i386 where
> HZ changed since 2.4) and cannot report times longer that 49 days.

Red Hat uses a patch that adds 32 bit uids and 32 bit gids at the end of
struct acct, reducing the size of the padding to 2 bytes. If a simular
extension is added to the official kernel it would be nice if they were
compatible.


There is also a few other problems with the current implementation that
we would like to see fixed if there is going to be a format-change
anyway:
- Architecture indepencence. It would be nice if the binary format was
  independent of the architecture so files can be processed on other
  hosts. This would involve defining padding and byte-ordering, as well
  as either stop using 1/HZ units in the file or add AHZ to the record.

- Better accuracy. Specificly the records don't include an exact
  termination-time for the process. One can estimate termination-time
  based on creation time and elapsed time but since elapsed time is
  truncated into comp_t it is not accurate for long-lived processes.

- More information. Accounting is typically used to keep track of
  what resources different jobs have used, where the definition of
  "job" may differ from site to site. Quite often "job" is a group
  of related processes, so including pid/ppid would allow
  post-processing to rebuild the process-hierarchy and deduce what
  processes were part of the same job. Even better, if usespace
  could notify the kernel what job a process belongs to, it would be
  easier to track jobs across multiple nodes in a cluster and so on.
  Maybe adding pid, ppid and jobid to the format and then use the sid
  as the jobid for now? And then it can be replaced by a proper jobid
  from e.g. PAGG later?

>    My proposed solution: keep backwards compatibility with 2.4 by using
>    a unit of 1/USER_HZ, announce that correctly in the header file,
>    and simply admit that BSD accounting on i386 is broken in 2.6.0-2.6.4.

Sounds good.

>  - store a version number in the last byte of struct acct, which allows
>    for a smooth transition to a new binary format when 2.7 comes out.
>    For 2.7, extend uid/gid fields to 32 bit, report times in terms
>    of AHZ=100 on all platforms (thus allowing to report times up to 1988 
>    days), and remove the compatibility stuff from the kernel.

It may be useful to have the version-information in the beginning of the
struct to allow future versions to use a struct of a different size.
There should be some bits available in the flag-field, maybe that's
enough?


-- 
Ragnar Kjørstad
Software Engineer
Scali - http://www.scali.com
High Performance Clustering
