Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbTICM6w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 08:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTICM6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 08:58:52 -0400
Received: from fmr09.intel.com ([192.52.57.35]:23806 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S262112AbTICM6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 08:58:50 -0400
Message-ID: <3F55E4CD.3030301@intel.com>
Date: Wed, 03 Sep 2003 15:55:41 +0300
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] seq_file - please review
X-Enigmail-Version: 0.76.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Could anyone review the following patch? It was generated for 2.4.21, but applies to 2.6 as well.
Below find problem description and patch itself. It is filled into 2.6's bugzilla, see
http://bugme.osdl.org/show_bug.cgi?id=952
So far the only input is that it is worth to push "Again:" label after kmalloc to save redundant if().
P.S. I do not subscribed to the list, thus please in your reply CC me 
(vladimir.kondratiev@intel.com)

seq_file's (fs/seq_file.c) implementation for read() do not allow more than one
page to be returned for one system call. This differs from old read_proc_t one:
old implementation used to loop until there is more data to provide. 
This mean, programs that used to work fine with old implementation, will not
work with seq_file. I mean programs that do read(large_buffer) once. Strictly
say, correct action would be for program to loop while read()>0, but:
- 1. unfortunately, programs like 'xlogmaster' and 'mc' falls into this category;
- 2. by filling large buffer, we reduce number of syscalls
- 3. data returned by one syscall produced (or may be produced) atomically w.r.t
process context stuff, i.e. it is not the same to do one read() and multiple.


--- linux-2.4.21/fs/seq_file.c	2003-06-13 17:51:37.000000000 +0300
+++ linux/fs/seq_file.c	2003-07-10 10:47:53.000000000 +0300
@@ -55,6 +55,7 @@
 		return -EPIPE;
 
 	down(&m->sem);
+Again:
 	/* grab buffer if we didn't have one */
 	if (!m->buf) {
 		m->buf = kmalloc(m->size = PAGE_SIZE, GFP_KERNEL);
@@ -123,11 +124,14 @@
 		goto Efault;
 	copied += n;
 	m->count -= n;
+	size -= n;
+	buf += n;
 	if (m->count)
 		m->from = n;
 	else
 		pos++;
 	m->index = pos;
+	goto Again;
 Done:
 	if (!copied)
 		copied = err;


