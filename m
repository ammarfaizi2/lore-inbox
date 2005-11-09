Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030621AbVKISDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030621AbVKISDF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 13:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030613AbVKISDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 13:03:05 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:8902 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030616AbVKISDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 13:03:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=bPeALnbzo1RzAbXaUu2FCl2TNrz3F7h4b6rIzK/zuRSdAtaqAXF2pEoNwe9cZZRgkibmW4tMwM9sL8uDLcde+eVZtUTbQPS51/ZrEiKUUSWqfyW3it4hluuRnKVvkuP2yF2pKsfnNQFbAGUInyV6hhKD/qlVTbhRbXMbH1Poj3Y=
Date: Thu, 10 Nov 2005 03:02:46 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Cc: bernd@firmix.at
Subject: Re: [PATCH] blk: fix string handling in elv_iosched_store
Message-ID: <20051109180246.GA27759@htj.dyndns.org>
References: <20051109171134.GA24115@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109171134.GA24115@htj.dyndns.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

elv_iosched_store doesn't terminate string passed from userspace if
it's too long.  Also, if the written length is zero (probably not
possible), it accesses elevator_name[-1].  This patch fixes both bugs.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Bernd Petrovitsch <bernd@firmix.at>

---

In a private mail, Bernd Petrovitsch pointed out that memset can be
replaced with elevator_name[sizeof(elevator_name) - 1] = '\0'.
Thanks.

diff --git a/block/elevator.c b/block/elevator.c
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -744,13 +744,15 @@ error:
 ssize_t elv_iosched_store(request_queue_t *q, const char *name, size_t count)
 {
 	char elevator_name[ELV_NAME_MAX];
+	size_t len;
 	struct elevator_type *e;
 
-	memset(elevator_name, 0, sizeof(elevator_name));
-	strncpy(elevator_name, name, sizeof(elevator_name));
+	elevator_name[sizeof(elevator_name) - 1] = '\0';
+	strncpy(elevator_name, name, sizeof(elevator_name) - 1);
+	len = strlen(elevator_name);
 
-	if (elevator_name[strlen(elevator_name) - 1] == '\n')
-		elevator_name[strlen(elevator_name) - 1] = '\0';
+	if (len && elevator_name[len - 1] == '\n')
+		elevator_name[len - 1] = '\0';
 
 	e = elevator_get(elevator_name);
 	if (!e) {
