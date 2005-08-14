Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVHNV52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVHNV52 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 17:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbVHNV52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 17:57:28 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:22752 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S932316AbVHNV51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 17:57:27 -0400
Message-ID: <42FFBDCB.2040804@austin.rr.com>
Date: Sun, 14 Aug 2005 16:55:23 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] [CIFS]  Two small cifs patches 
Content-Type: multipart/mixed;
 boundary="------------010400050204010204020705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010400050204010204020705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Based on testing at the cifs plugfest last week these were the two most 
important patches from among those pending in my tree.   The rest can 
wait until after 2.6.12

--------------010400050204010204020705
Content-Type: text/x-patch;
 name="CIFS-Fix-missing-entries-in-search-results-when-very-long-file-names-and.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="CIFS-Fix-missing-entries-in-search-results-when-very-long-file-names-and.patch"

[PATCH] [CIFS] Fix missing entries in search results when very long file names and
more than 50 (or so) of such long search entries in the directory.  FindNext
could send corrupt last byte of resume name when resume key was a few hundred
bytes long file name or longer.

Fixes Samba Bug # 2932

Signed-off-by: Steve French (sfrench@us.ibm.com)
---

 fs/cifs/cifssmb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

ef6724e32142c2d9ca252d423cacc435c142734e
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -2628,6 +2628,9 @@ int CIFSFindNext(const int xid, struct c
 	if(name_len < PATH_MAX) {
 		memcpy(pSMB->ResumeFileName, psrch_inf->presume_name, name_len);
 		byte_count += name_len;
+		/* 14 byte parm len above enough for 2 byte null terminator */
+		pSMB->ResumeFileName[name_len] = 0;
+		pSMB->ResumeFileName[name_len+1] = 0;
 	} else {
 		rc = -EINVAL;
 		goto FNext2_err_exit;

--------------010400050204010204020705
Content-Type: text/x-patch;
 name="CIFS-Fix-path-name-conversion-for-long-filenames-when-mapchars-mount.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="CIFS-Fix-path-name-conversion-for-long-filenames-when-mapchars-mount.patch"

[PATCH] [CIFS] Fix path name conversion for long filenames when mapchars mount
option was specified at mount time.

Signed-off-by: Steve French (sfrench@us.ibm.com)
---

 fs/cifs/CHANGES |    6 ++++++
 fs/cifs/misc.c  |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

f4cfd69cf349dd27e00d5cf804b57aee04e059c2
diff --git a/fs/cifs/CHANGES b/fs/cifs/CHANGES
--- a/fs/cifs/CHANGES
+++ b/fs/cifs/CHANGES
@@ -1,3 +1,9 @@
+Version 1.35
+------------
+Add writepage performance improvements.  Fix path name conversions
+for long filenames on mounts which were done with "mapchars" mount option
+specified.
+
 Version 1.34
 ------------
 Fix error mapping of the TOO_MANY_LINKS (hardlinks) case.
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -611,6 +611,7 @@ cifsConvertToUCS(__le16 * target, const 
 		src_char = source[i];
 		switch (src_char) {
 			case 0:
+				target[j] = 0;
 				goto ctoUCS_out;
 			case ':':
 				target[j] = cpu_to_le16(UNI_COLON);

--------------010400050204010204020705--
