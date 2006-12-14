Return-Path: <linux-kernel-owner+w=401wt.eu-S964917AbWLNWbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWLNWbp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 17:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWLNWbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 17:31:45 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:52098 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964917AbWLNWbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 17:31:44 -0500
X-Originating-Ip: 74.109.98.100
Date: Thu, 14 Dec 2006 17:27:24 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Zach Brown <zach.brown@oracle.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lots of code could be simplified by using ARRAY_SIZE()
In-Reply-To: <2F8F687E-C5E5-4F7D-9585-97DA97AE1376@oracle.com>
Message-ID: <Pine.LNX.4.64.0612141721580.10217@localhost.localdomain>
References: <Pine.LNX.4.64.0612131450270.5979@localhost.localdomain>
 <2F8F687E-C5E5-4F7D-9585-97DA97AE1376@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006, Zach Brown wrote:

> >  there are numerous places throughout the source tree that
> > apparently calculate the size of an array using the construct
> > "sizeof(fubar)/sizeof(fubar[0])". see for yourself:

> >  $ grep -Er "sizeof\((.*)\) ?/ ?sizeof\(\1\[0\]\)" *
>
> Indeed, there seems to be lots of potential clean-up there.
> Including duplicate macros like:
>
> ./drivers/ide/ide-cd.h:#define ARY_LEN(a) ((sizeof(a) / sizeof(a[0])))

not surprisingly, i have a script "arraysize.sh":

============================================================
#!/bin/sh

DIR=$1

# grep -Er "sizeof\((.*)\) ?/ ?sizeof\(\1\[0\]\)" ${DIR}
# grep -Erl "sizeof\((.*)\) ?/ ?sizeof\(\1\[0\]\)" ${DIR}

for f in $(grep -Erl "sizeof\((.*)\) ?/ ?sizeof\(\1\[0\]\)" ${DIR}) ; do
  echo "ARRAY_SIZE()ing $f ..."
  perl -pi -e "s|sizeof\((.*)\) ?/ ?sizeof\(\1\[0\]\)|ARRAY_SIZE\(\1\)|" $f
done
===========================================================

  anyone who's interested can run it with a single argument of the
directory to process, eg.:

  $ arraysize.sh fs
  $ arraysize.sh drivers
  $ arraysize.sh .		# entire tree, of course

it's just a first pass, but it seems to produce reasonable code.

rday
