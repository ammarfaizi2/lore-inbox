Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264077AbTICRGt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264079AbTICRGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:06:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:48548 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264077AbTICRGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:06:38 -0400
Date: Wed, 3 Sep 2003 10:07:16 -0700
From: Dave Olien <dmo@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Daniel McNeil <daniel@osdl.org>,
       Mary Edie Meredith <maryedie@osdl.org>
Subject: FYI: dbt testing on 2.6.0-test4-mm4 fails
Message-ID: <20030903170716.GA23487@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

I'm just mailing you this to keep you informed, Daniel McNeil and
I are investigating a failure of the dbt database workload test on
2.6.0-test4-mm4.

The failure MAY have begun as early as 2.6.0-test4.  We were able
to test on test4 only after I generated a patch to raw_open() for that
kernel version.  The database test4 failure LOOKS the same as the
test4-mm4 failure.  But we haven't investigated it as closely there yet.
We know test3 worked OK.  We may try some of the test3-mm patches to
see if something happened on one of those patches.

In the test4-mm4 case, the kernel doesn't oops or hang. Instead, the
database software detects a failure of some sort.  We've done an
strace on the database processes, and in one of them we see the following
output:

_llseek(38, 8192, [8192], SEEK_SET) = 0
write(38, "\0\0\0\0\4\3\1\0\7\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 8192)                     = 0

A seek on file descriptor 38 to offset 8192, followed by a write of 8k.
The write returns with 0 bytes written.

Immediately after this, we can see this process writing to the error
log a message indicating an error has been detected.

File descriptor 38 is for the file /dev/raw/raw1.  This is the
transaction log file for the database.  This is early in itialization
of the database, so it's initializing the transaction log file.
