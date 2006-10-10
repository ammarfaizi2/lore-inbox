Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWJJRQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWJJRQg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWJJRQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:16:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:51593 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964806AbWJJRPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:15:35 -0400
Date: Tue, 10 Oct 2006 10:14:38 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Trond Myklebust <Trond.Myklebust@netapp.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 04/19] LOCKD: Fix a deadlock in nlm_traverse_files()
Message-ID: <20061010171438.GE6339@kroah.com>
References: <20061010165621.394703368@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="lockd-fix-a-deadlock-in-nlm_traverse_files.patch"
In-Reply-To: <20061010171350.GA6339@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Trond Myklebust <Trond.Myklebust@netapp.com>

nlm_traverse_files() is not allowed to hold the nlm_file_mutex while calling
nlm_inspect file, since it may end up calling nlm_release_file() when
releaseing the blocks.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/lockd/svcsubs.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- linux-2.6.17.13.orig/fs/lockd/svcsubs.c
+++ linux-2.6.17.13/fs/lockd/svcsubs.c
@@ -238,19 +238,22 @@ static int
 nlm_traverse_files(struct nlm_host *host, int action)
 {
 	struct nlm_file	*file, **fp;
-	int		i;
+	int i, ret = 0;
 
 	mutex_lock(&nlm_file_mutex);
 	for (i = 0; i < FILE_NRHASH; i++) {
 		fp = nlm_files + i;
 		while ((file = *fp) != NULL) {
+			file->f_count++;
+			mutex_unlock(&nlm_file_mutex);
+
 			/* Traverse locks, blocks and shares of this file
 			 * and update file->f_locks count */
-			if (nlm_inspect_file(host, file, action)) {
-				mutex_unlock(&nlm_file_mutex);
-				return 1;
-			}
+			if (nlm_inspect_file(host, file, action))
+				ret = 1;
 
+			mutex_lock(&nlm_file_mutex);
+			file->f_count--;
 			/* No more references to this file. Let go of it. */
 			if (!file->f_blocks && !file->f_locks
 			 && !file->f_shares && !file->f_count) {
@@ -263,7 +266,7 @@ nlm_traverse_files(struct nlm_host *host
 		}
 	}
 	mutex_unlock(&nlm_file_mutex);
-	return 0;
+	return ret;
 }
 
 /*

--
