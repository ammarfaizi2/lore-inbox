Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264269AbUFCU2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbUFCU2v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 16:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbUFCU2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 16:28:51 -0400
Received: from mail.ccur.com ([208.248.32.212]:63238 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S264269AbUFCU2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 16:28:48 -0400
Date: Thu, 3 Jun 2004 16:28:46 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] NFS no longer updates file modification times appropriately
Message-ID: <20040603202846.GA28479@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond,
 Paraphrased from one of my inhouse customers: "The timestamp of an
NFS-mounted file does not change when written to, when the below test is
run on a 2.6.6-rc1 to 2.6.7-rc2 kernel.  The timestamp is appropriately
updated when the test is run on a 2.6.5 kernel.  This is with NFSv3.
The type of system serving up the files does not seem to be a factor."

I was not able to narrow the problem/featureset change down to a cset.

Attached is the test program my customer used.

Regards,
Joe

#include <stdio.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <errno.h>

#define PATH "./my_file"

int
main()
{
	int status;
	int count = 0;
	int fd;
	struct stat wuz;
	struct stat iz;

	(void) unlink(PATH);

	fd = open (PATH, O_RDWR+O_CREAT+O_SYNC, 0666);
	if (fd < 0) {
		fprintf (stderr, "open(%s) fails, errno = %d\n", PATH, errno);
		return 1;
	}

	status = fstat (fd, &wuz);
	if (status) {
		fprintf (stderr, "fstat(%s) fails, errno = %d\n", PATH, errno);
		return 1;
	}

	for (;;) {
		status = write (fd, &status, sizeof(status));
		if (status != sizeof(status)) {
			fprintf (stderr, "write(%s) fails, errno = %d\n", PATH, errno);
			return 1;
		}
		status = fstat (fd, &iz);
		if (status) {
			fprintf (stderr, "fstat(%s) fails, errno = %d\n", PATH, errno);
			return 1;
		}
		if (iz.st_mtime != wuz.st_mtime) break;
		count++;
		if (count % 1000 == 0) {
			printf ("count = %d\n", count);
		}
	}

	printf ("File modification time changed after %d iterations\n", count);
}
