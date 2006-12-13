Return-Path: <linux-kernel-owner+w=401wt.eu-S965147AbWLMUC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbWLMUC4 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbWLMUC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:02:56 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:50859 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965147AbWLMUCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:02:55 -0500
X-Originating-Ip: 74.109.98.100
Date: Wed, 13 Dec 2006 14:58:33 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: lots of code could be simplified by using ARRAY_SIZE()
Message-ID: <Pine.LNX.4.64.0612131450270.5979@localhost.localdomain>
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


  there are numerous places throughout the source tree that apparently
calculate the size of an array using the construct
"sizeof(fubar)/sizeof(fubar[0])". see for yourself:

  $ grep -Er "sizeof\((.*)\) ?/ ?sizeof\(\1\[0\]\)" *

but we already have, from "include/linux/kernel.h":

  #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

a simple script to make the appropriate cleanup, given the directory
name as an argument:

================== cut ================
#!/bin/sh

DIR=$1

for f in $(grep -Erl "sizeof\((.*)\) ?/ ?sizeof\(\1\[0\]\)" ${DIR}) ;
do
  echo "Fixing $f ..."
  perl -pi -e "s|sizeof\((.*)\) ?/ ?sizeof\(\1\[0\]\)|ARRAY_SIZE\(\1\)|" $f
done
=======================================

  of course, the file must (eventually) include linux/kernel.h but one
would think that applies to the majority of the source tree, no?

  just a thought.

rday
