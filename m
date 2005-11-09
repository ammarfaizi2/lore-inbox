Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbVKIRLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbVKIRLo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbVKIRLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:11:44 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:820 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751417AbVKIRLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:11:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=PNhxOTmDjK+OfLICddJx2EuGaqfILiZK9WCaHoYJtDjz3PUggnj63p8XjC85VfgIU1bLIySuu7+vfTZNTdXzIU+Nx9onUNbRmvgh36MHkheyV5XK81OOPsFjl6xqqj4qFVjxqulOu33VTJGDTrAX/L5gwNDleCJ9s8S/ayHIXwE=
Date: Thu, 10 Nov 2005 02:11:34 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] blk: fix string handling in elv_iosched_store
Message-ID: <20051109171134.GA24115@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

elv_iosched_store doesn't terminate string passed from userspace if
it's too long.  Also, if the written length is zero (probably not
possible), it accesses elevator_name[-1].  This patch fixes both bugs.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/block/elevator.c b/block/elevator.c
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -744,13 +744,15 @@ error:
 ssize_t elv_iosched_store(request_queue_t *q, const char *name, size_t count)
 {
 	char elevator_name[ELV_NAME_MAX];
+	size_t len;
 	struct elevator_type *e;
 
 	memset(elevator_name, 0, sizeof(elevator_name));
-	strncpy(elevator_name, name, sizeof(elevator_name));
+	strncpy(elevator_name, name, sizeof(elevator_name) - 1);
+	len = strlen(elevator_name);
 
-	if (elevator_name[strlen(elevator_name) - 1] == '\n')
-		elevator_name[strlen(elevator_name) - 1] = '\0';
+	if (len && elevator_name[len - 1] == '\n')
+		elevator_name[len - 1] = '\0';
 
 	e = elevator_get(elevator_name);
 	if (!e) {
