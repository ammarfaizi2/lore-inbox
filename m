Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268097AbUH3Ox5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268097AbUH3Ox5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 10:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268452AbUH3Ox4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 10:53:56 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:20201 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S268097AbUH3Osc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 10:48:32 -0400
Date: Mon, 30 Aug 2004 07:48:30 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Libata VIA woes continue. Worked around - *wrong*
Message-ID: <20040830144830.GD16320@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resending, there was a typo in the kernel address.

Date: Mon, 30 Aug 2004 07:45:52 -0700
From: Larry McVoy <lm@work.bitmover.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Brad Campbell <brad@wasp.net.au>, linux-ide@vger.kernel.org,
        linxu-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>,
        Linus Torvalds <torvalds@osdl.org>
Subject: Re: Libata VIA woes continue. Worked around - *wrong*

> Since BK changesets are ordered as a progression, you can also do a 
> bsearch by clone trees to specific changesets, such as
> 
> bk changes -rv2.6.6..2.6.7 > /tmp/changes.txt
> # view changes.txt, pick out cset 1.1587.39.1 as your "top of tree"
> bk clone -r1.1587.39.1 vanilla-2.6 brad-test-2.6.6-bk
> # compile and test the kernel in brad-test-2.6.6-bk

A couple of comments:
    - BK changesets are not a linear progression, they are in the form of
      a graph called a lattice.  Getting a path through there that you can
      do binary search on is not straightforward.

    - The CVS tree represents one such straight path, get just the ChangeSet
      file from the CVS tree and do an rlog on it - you are looking for the
      lines like:

      BKrev: 41316382Cxbyp1_yHDX8LmymGot3Ww

      That rev is the "md5key" of the BK rev and can be used anywhere a BK
      rev may be used (bk clone -r41316382Cxbyp1_yHDX8LmymGot3Ww ...)

    - The biggest time saver is knowing where to look for your bug.  If you
      knew that the bug was in drivers/scsi/libata-core.c then you could
      find each changeset which touched that file like so

      $ bk rset -lv2.6.6 | grep drivers/scsi/libata-core.c
      drivers/scsi/libata-core.c|1.39
      $ bk prs -hnd:I: -r1.39.. drivers/scsi/libata-core.c | while read rev
      do  bk r2c -r$rev drivers/scsi/libata-core.c
      done

      That will crunch away and spit out (in this case) 63 revs like

      1.1803.1.40
      1.1803.1.39
      1.1803.1.38
      ...

      and a binary search over those revs is likely to be fair more fruitful
      because the history of that one file is pretty linear.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
