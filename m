Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbTJSVbn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 17:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbTJSVbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 17:31:43 -0400
Received: from mx01.netapp.com ([198.95.226.53]:36331 "EHLO mx01.netapp.com")
	by vger.kernel.org with ESMTP id S262241AbTJSVbg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 17:31:36 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: readahead never reads the last page of a file
Date: Sun, 19 Oct 2003 14:31:26 -0700
Message-ID: <482A3FA0050D21419C269D13989C6113127F5A@lavender-fe.eng.netapp.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: read ahead patch
Thread-Index: AcOWh7Up5MBRq/OeS7SMoQPf2ZE1MAAABNIw
From: "Lever, Charles" <Charles.Lever@netapp.com>
To: "Linux FS development (E-mail)" <linux-fsdevel@vger.kernel.org>
Cc: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ members of lkml: please cc me, as i am not on the linux kernel
  mailing list ].

i'm interested in comments and code review.  thanks!

the read ahead logic in generic_file_readahead never reads the
last page of a file.  that page must always be read by a separate
4KB readpage request.  probably not noticable in most cases, but
for NFS, it causes an extra on-the-wire operation at the end of
files, because the NFS client is never given the opportunity to
coalesce the last page of the file.

this can be pretty serious for a workload consisting of reading
many small files (such as a web server, or a build farm), or
when network round-trip latency is large.

the fix for this problem is simply changing a ">=" to a strict
">" in the while loop in generic_file_readahead.  i also noticed
there are rare cases where the "ahead" variable is off-by-one
coming out of the loop, causing the file's read ahead context
to be screwed up.  the patch below addresses that issue as well.


my test workload is tarring a 2.4.0 linux source tree over NFS
on a 100Mb link into an archive file residing in a tmpfs on the
client.  the client is running a 2.4.22 kernel on top of the
Red Hat 7.3 distribution patched to the latest errata RPMs.

the source tree is on a NetApp F880 and fits completely in the
filer's memory.  the filer is mounted with NFSv3, TCP, and
rsize=32768.  the filer is remounted between each test to
ensure the client has a cold cache.  the client can hold both
the source tree and archive file entirely in its memory.

the filer can report a histogram of read operation sizes.  the
client reports only a total number of reads.  in the first test,
i look only at read op count and the op size histogram.

stock 2.4.22
  filer read stats:
  op size          count
  4096-8191        10620
  8192-16383       1625
  16384-32767      2168
  32768+           527

  client total NFS read operations:  14940

2.4.22 with patch applied
  filer read stats:
  op size          count
  4096-8191        5412
  8192-16383       2572
  16384-32767      2783
  32768+           563

  client total NFS read operations:  11330

results:
1.  almost 25% fewer NFS read operations
2.  almost 50% fewer 4KB read operations


the second test examines improvements in client CPU
utilization and elapsed run time.  the "time" results
(avg over two runs, each) for the tar test described
above are:

stock 2.4.22:    0.15user  1.00system  0:35:85elapsed
2.4.22 + patch:  0.15user  0.85system  0:33.70elapsed

results:

1.  15% less system CPU time
2.  almost 6% faster elapsed time

here is the patch:


diff -X ../dont-diff -Naurp 01-slot_table/mm/filemap.c 02-readahead1/mm/filemap.c
--- 01-slot_table/mm/filemap.c	Mon Aug 25 07:44:44 2003
+++ 02-readahead1/mm/filemap.c	Thu Oct 16 13:53:14 2003
@@ -1288,11 +1288,14 @@ static void generic_file_readahead(int r
  */
 	ahead = 0;
 	while (ahead < max_ahead) {
-		ahead ++;
-		if ((raend + ahead) >= end_index)
+		unsigned long ra_index = raend + ahead + 1;
+
+		if (ra_index > end_index)
 			break;
-		if (page_cache_read(filp, raend + ahead) < 0)
+		if (page_cache_read(filp, ra_index) < 0)
 			break;
+
+		ahead++;
 	}
 /*
  * If we tried to read ahead some pages,

-- 
corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

