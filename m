Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWDJR7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWDJR7S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 13:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbWDJR7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 13:59:18 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:64147 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932067AbWDJR7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 13:59:17 -0400
Subject: [RFC][PATCH 0/3] ext3 percpu counter fixes to suppport for ext3
	unsigned long type free blocks counter
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: akpm@osdl.org
Cc: kiran@scalex86.org, Laurent Vivier <Laurent.Vivier@bull.net>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 10 Apr 2006 10:58:49 -0700
Message-Id: <1144691929.3964.53.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the proposed patches to allow the ext3 free block accounting
works with more than 8TB storage.

[PATCH 1] - Tries to fix the per cpu counter to handle the "overflow"
when dealing with unsigned long counters.

[PATCH 2] - Currently percpu_counter_read_positive() always return 1 if
the counter(singed type) is negative. This leads the ext3 always get
free blocks as 1 if there are more than 2**31 free blocks, thus prevent
non-root users to write(file creation) to the filesystem. This patch
fixed this by using percpu_counter_read() instead.

[PATCH 3] - Changes the places in ext3 when updating the free blocks
counter to use percpu_counter_mod_ll()(added in patch 1) to prevent
overflow.

patches against 2.6.16-mm2. Tested on a freshly created 10TB ext3,
filled the first 8TB storage with 6000 parallel dd (direct IO) first,
then tested the rest 2TB with overnight fsx.

