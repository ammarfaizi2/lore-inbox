Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVADPAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVADPAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 10:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVADO5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 09:57:14 -0500
Received: from sccmmhc91.asp.att.net ([204.127.203.211]:18602 "EHLO
	sccmmhc91.asp.att.net") by vger.kernel.org with ESMTP
	id S261681AbVADOyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 09:54:04 -0500
Date: Tue, 04 Jan 2005 09:54:00 -0500 (EST)
Message-Id: <20050104.095400.98874084.wscott@bitmover.com>
To: jgarzik@pobox.com, torvalds@osdl.org
Cc: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: BK: imports fail disconnected.
From: Wayne Scott <wscott@bitmover.com>
X-Mailer: Mew version 4.0.65 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff & Linus,

Larry asked me to look at the problems discussed in the recent "[BK]
disconnected operation" thread on lkml.

In that thread there were basically two problems identified.  The
first is that machines that change hostnames when they disconnect
don't work disconnected because we include the hostname in the
bookkeeping about when you have connected the openlogging server.
This is a known problem, and most commonly hits people with powerbooks
since OSX does this by default. (We will revisit solutions to this in
the future.)

The second problem was reported by James Bottomly and it was that he
was totally unable to use bk disconnected and he provided an example
where he was doing imports using the BK-kernel-tools repository.  In
this case the problem was real, but it was with the import script.
The following patch needs to be committed to bktools.

===== applypatch 1.13 vs edited =====
--- 1.13/applypatch     2002-10-09 10:39:09 -05:00
+++ edited/applypatch   2005-01-03 16:37:44 -05:00
@@ -1,6 +1,7 @@
 #!/bin/sh
 # name: $1, domain: $2, Subject: $3, Explanation: $4, diff-file: stdin
 # test checkin
+export BK_IMPORTER=`bk getuser`
 export BK_USER="$1"
 export BK_HOST="$2"
 export SUBJECT=`echo "$3" | sed 's/\(\(Re: \)*\[[^]]*\]\)* *\(.*\)/\3/'`

(This was mailed to Linus in Aug '03, but I guess it got lost.)


The BK_IMPORTER tells bk that we are doing an import and
BK_USER/BK_HOST are faked to change the history.  Without it bk ends
up contacting openlogging.org for every different patch.  This would
be really slow, and does not work disconnected.

The other important point is that bitkeeper will record the person
making the imports so that when people import the same patch in
parallel we don't have problems with identical deltas appearing under
different changesets.

With this fix I believe that bk will work disconnected if you use it
at least once a week connected.  You can disconnect for up to 30 days,
but there you need to run 'bk lease renew' manually before
disconnecting.

Please report any other problems to support@bitmover.com.  (Sadly I
just don't have time to read lkml regularly.)

-Wayne
