Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269096AbTGJIHm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 04:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269056AbTGJIHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 04:07:25 -0400
Received: from fmr01.intel.com ([192.55.52.18]:48120 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S269096AbTGJIF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 04:05:57 -0400
Message-ID: <3F0D217B.4040900@intel.com>
Date: Thu, 10 Jul 2003 11:19:07 +0300
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alexander Viro <viro@math.psu.edu>
Subject: PATCH: seq_file interface to provide large data chunks
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

seq_file interface, as it exist in last official kernel, never provides 
more then one page for each 'read' call. Old read_proc_t did loop to 
fill more than one page.

Following patch against 2.4.21 fixes seq_file to provide more than one 
page if user requests it.
Many programs do read(large_buffer) once, instead of looping while 
read()>0. They work wrong with seq_file. Also, one may expect read() to 
provide whole information atomically (OK, relatively to other process 
context stuff).
This patch loops over while some space remains in user provided buffer.

I am not subscribed to lkml, thus please cc: me (Vladimir Kondratiev 
<vladimir.kondratiev@intel.com>) explicitly.

--- linux-2.4.21/fs/seq_file.c    2003-06-13 17:51:37.000000000 +0300
+++ linux/fs/seq_file.c    2003-07-10 10:47:53.000000000 +0300
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
+    size -= n;
+    buf += n;
     if (m->count)
         m->from = n;
     else
         pos++;
     m->index = pos;
+    goto Again;
 Done:
     if (!copied)
         copied = err;


