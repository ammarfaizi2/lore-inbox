Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262743AbUKMAZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbUKMAZA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 19:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbUKMAXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 19:23:42 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:44481 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262745AbUKMAWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 19:22:14 -0500
Message-ID: <419553B3.7000802@us.ibm.com>
Date: Fri, 12 Nov 2004 16:22:11 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: 2.6.10-rc1-mm2 DIO failures
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I see LTP DIO test failures on 2.6.10-rc1-mm2 while doing
direct-IO write to filesystem files.

This is due to the changes in generic_file_direct_IO(). I haven't
looked at what exactly happening here (whats faling with page shoot 
down). But we end up getting -EIO.

  /*
- * Called under i_sem for writes to S_ISREG files
+ * Called under i_sem for writes to S_ISREG files.   Returns -EIO if 
something
+ * went wrong during pagecache shootdown.
   */
  ssize_t
  generic_file_direct_IO(int rw, struct kiocb *iocb, const struct iovec 
*iov,
@@ -2539,14 +2540,24 @@ generic_file_direct_IO(int rw, struct ki
         struct address_space *mapping = file->f_mapping;
         ssize_t retval;

+       /*
+        * If it's a write, unmap all mmappings of the file up-front.  This
+        * will cause any pte dirty bits to be propagated into the 
pageframes
+        * for the subsequent filemap_write_and_wait().
+        */
+       if (rw == WRITE && mapping_mapped(mapping))
+               unmap_mapping_range(mapping, 0, -1, 0);
...


Thanks,
Badari


  # ./diotest2
diotest02    1  PASS  :  Read with Direct IO, Write without
write failed:Input/output error
[2] Write Direct failed
diotest02    2  FAIL  :  Write with Direct IO, Read without
diotest02    3  PASS  :  Read, Write with Direct IO
diotest2 1/3 testblocks failed
