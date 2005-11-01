Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbVKAFT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbVKAFT3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 00:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbVKAFT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 00:19:29 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:39046 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965049AbVKAFT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 00:19:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=347NrXrLLwb2Z+xTCs1N3AVwU+Z6UceWsWBvkIfmJMixcvWAP9l8GL6alBrAudtK232Q2hodCWeXz7PRTYr9914vqzmGhEf27GE6hD3M4ittUSZrGi4fBfE3PY08R0SnqPoaUDvSrn4o3a+ILDzguJtuC1vNcWBuu0xTlXFbQnY=  ;
Message-ID: <4366FB4B.9000103@yahoo.com.au>
Date: Tue, 01 Nov 2005 16:21:15 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] vm: writeout watermarks
References: <4366FA9A.20402@yahoo.com.au> <4366FAF5.8020908@yahoo.com.au> <4366FB24.5010507@yahoo.com.au>
In-Reply-To: <4366FB24.5010507@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------080603010403000300080507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080603010403000300080507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

3/3

-- 
SUSE Labs, Novell Inc.


--------------080603010403000300080507
Content-Type: text/plain;
 name="vm-tune-writeout.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-tune-writeout.patch"

Slightly change the writeout watermark calculations so we keep background
and synchronous writeout watermarks in the same ratios after adjusting them.
This ensures we should always attempt to start background writeout before
synchronous writeout.

Signed-off-by: Nick Piggin <npiggin@suse.de>


Index: linux-2.6/mm/page-writeback.c
===================================================================
--- linux-2.6.orig/mm/page-writeback.c	2005-11-01 13:41:39.000000000 +1100
+++ linux-2.6/mm/page-writeback.c	2005-11-01 14:29:27.000000000 +1100
@@ -165,9 +165,11 @@ get_dirty_limits(struct writeback_state 
 	if (dirty_ratio < 5)
 		dirty_ratio = 5;
 
-	background_ratio = dirty_background_ratio;
-	if (background_ratio >= dirty_ratio)
-		background_ratio = dirty_ratio / 2;
+	/*
+	 * Keep the ratio between dirty_ratio and background_ratio roughly
+	 * what the sysctls are after dirty_ratio has been scaled (above).
+	 */
+	background_ratio = dirty_background_ratio * dirty_ratio/vm_dirty_ratio;
 
 	background = (background_ratio * available_memory) / 100;
 	dirty = (dirty_ratio * available_memory) / 100;

--------------080603010403000300080507--
Send instant messages to your online friends http://au.messenger.yahoo.com 
