Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312674AbSCVFZw>; Fri, 22 Mar 2002 00:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312673AbSCVFZm>; Fri, 22 Mar 2002 00:25:42 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:13574 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S312671AbSCVFZ1>;
	Fri, 22 Mar 2002 00:25:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15514.48690.588277.606822@gargle.gargle.HOWL>
Date: Fri, 22 Mar 2002 16:16:34 +1100
From: Christopher Yeoh <cyeoh@samba.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] msync writing when MS_INVALIDATE set and memory locked
X-Mailer: VM 7.03 under Emacs 21.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For msync, SUSv2 states that it will fail if:

"[EBUSY] Some or all of the addresses in the range starting at addr
and continuing for len bytes are locked, and MS_INVALIDATE is
specified."

This check isn't being done. The following patch (against 2.4.19pre4)
adds the correct behaviour:

--- linux-2.4.18/mm/filemap.c~	Thu Mar 21 16:04:48 2002
+++ linux-2.4.18/mm/filemap.c	Fri Mar 22 15:48:40 2002
@@ -2205,6 +2205,9 @@
 	int ret = 0;
 	struct file * file = vma->vm_file;
 
+	if ( (flags & MS_INVALIDATE) && (vma->vm_flags & VM_LOCKED) )
+		return -EBUSY;
+
 	if (file && (vma->vm_flags & VM_SHARED)) {
 		ret = filemap_sync(vma, start, end-start, flags);
 
Chris
-- 
cyeoh@au.ibm.com
IBM OzLabs Linux Development Group
Canberra, Australia
