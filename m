Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWF3JlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWF3JlM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 05:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWF3JlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 05:41:12 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:38790 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932130AbWF3JlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 05:41:11 -0400
Message-ID: <44A4F1B1.1060406@openvz.org>
Date: Fri, 30 Jun 2006 13:41:05 +0400
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       marcelo.tosatti@cyclades.com, devel@openvz.org,
       "Vasily Averin" <vvs@sw.ru>, "Andrey Savochkin" <saw@sawoct.com>,
       Monakhov Dmintiy <dmonakhov@sw.ru>
Subject: [PATCH] EXT3: ext3 block bitmap leakage
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Chris,

this bug is not relevant for 2.6.17 and later.
However, it is relevant for all 2.4.x and <2.6.17 kernels,
so I think this can be of interest to some people and worth commiting to 
2.6.16.x



This patch fixes ext3 block bitmap leakage,
which leads to the following fsck messages on
_healthy_ filesystem:
Block bitmap differences:  -64159 -73707

All kernels up to 2.6.17 have this bug.

Found by
   Vasily Averin <vvs@sw.ru> and Andrey Savochkin <saw@sawoct.com>
Test case triggered the issue was created by
   Dmitry Monakhov <dmonakhov@sw.ru>

Signed-Off-By: Vasiliy Averin <vvs@sw.ru>
Signed-Off-By: Andrey Savochkin <saw@sawoct.com>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>
CC: Dmitry Monakhov <dmonakhov@sw.ru>

--- ./fs/ext3/inode.c.e3crp	2006-06-28 05:22:40.000000000 +0400
+++ ./fs/ext3/inode.c	2006-06-27 13:31:20.000000000 +0400
@@ -585,6 +585,7 @@ static int ext3_alloc_branch(handle_t *h

  	branch[0].key = cpu_to_le32(parent);
  	if (parent) {
+		keys = 1;
  		for (n = 1; n < num; n++) {
  			struct buffer_head *bh;
  			/* Allocate the next block */

