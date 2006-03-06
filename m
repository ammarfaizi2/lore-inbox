Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWCFBLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWCFBLQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 20:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWCFBLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 20:11:16 -0500
Received: from ms-smtp-05-smtplb.tampabay.rr.com ([65.32.5.135]:39142 "EHLO
	ms-smtp-05.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751321AbWCFBLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 20:11:15 -0500
Message-ID: <440B8C16.4050008@cfl.rr.com>
Date: Sun, 05 Mar 2006 20:10:46 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060213)
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: linux kernel <linux-kernel@vger.kernel.org>, bfennema@ix.netcom.com
Subject: Re: [PATCH] udf: fix uid/gid options and add uid/gid=ignore and forget
 options
References: <4409EB37.5050308@cfl.rr.com> <84144f020603051122k33872fa7p1e7baebcc2b67cda@mail.gmail.com>
In-Reply-To: <84144f020603051122k33872fa7p1e7baebcc2b67cda@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> On 3/4/06, Phillip Susi <psusi@cfl.rr.com> wrote:
>> This patch fixes a bug in udf where it would write uid/gid = 0 to the
>> disk for files owned by the id given with the uid=/gid= mount options.
> 
> I don't think it does. You can still get zero uid/gid written on disk
> if you specify uid/gid mount options when not specifying uid=forget. I
> am not against new features but lets fix the bug first, okay? Adding
> new mount options to work around buggy code is not the right solution.
> 

My bad, I meant to remove those ifs, not just prepend them with an else.  Try this one:

Subject: [PATCH] udf: fix uid/gid options and add uid/gid=ignore and forget options

This patch fixes a bug in udf where it would write uid/gid = 0 to the
disk for files owned by the id given with the uid=/gid= mount options.
It also adds 4 new mount options: uid/gid=forget and uid/gid=ignore.
Without any options the id in core and on disk always match.  Giving
uid/gid=nnn specifies a default ID to be used in core when the on disk ID
is -1.  uid/gid=ignore forces the in core ID to allways be used no matter
what the on disk ID is.  uid/gid=forget forces the on disk ID to always be
written out as -1.

The use of these options allows you to override ownerships on a disk or
disable ownwership information from being written, allowing the media
to be used portably between different computers and possibly different users
without permissions issues that would require root to correct.

Signed-off-by: Phillip Susi <psusi@cfl.rr.com>

---

 fs/udf/inode.c  |   18 +++++++++++-------
 fs/udf/super.c  |   18 +++++++++++++++++-
 fs/udf/udf_sb.h |    4 ++++
 3 files changed, 32 insertions(+), 8 deletions(-)

c8393f6e4fe6159fd916f3c68091e76bbfdc5fd8
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 395e582..49aeac3 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1045,10 +1045,12 @@ static void udf_fill_inode(struct inode 
 	}
 
 	inode->i_uid = le32_to_cpu(fe->uid);
-	if ( inode->i_uid == -1 ) inode->i_uid = UDF_SB(inode->i_sb)->s_uid;
+	if ( inode->i_uid == -1 || UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_UID_IGNORE) )
+	  inode->i_uid = UDF_SB(inode->i_sb)->s_uid;
 
 	inode->i_gid = le32_to_cpu(fe->gid);
-	if ( inode->i_gid == -1 ) inode->i_gid = UDF_SB(inode->i_sb)->s_gid;
+	if ( inode->i_gid == -1 || UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_GID_IGNORE) )
+	  inode->i_gid = UDF_SB(inode->i_sb)->s_gid;
 
 	inode->i_nlink = le16_to_cpu(fe->fileLinkCount);
 	if (!inode->i_nlink)
@@ -1335,11 +1337,13 @@ udf_update_inode(struct inode *inode, in
 		return err;
 	}
 
-	if (inode->i_uid != UDF_SB(inode->i_sb)->s_uid)
-		fe->uid = cpu_to_le32(inode->i_uid);
-
-	if (inode->i_gid != UDF_SB(inode->i_sb)->s_gid)
-		fe->gid = cpu_to_le32(inode->i_gid);
+	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_UID_FORGET))
+	  fe->uid = cpu_to_le32(-1);
+	else fe->uid = cpu_to_le32(inode->i_uid);
+
+	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_GID_FORGET))
+	  fe->gid = cpu_to_le32(-1);
+	else fe->gid = cpu_to_le32(inode->i_gid);
 
 	udfperms =	((inode->i_mode & S_IRWXO)     ) |
 			((inode->i_mode & S_IRWXG) << 2) |
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 4a6f49a..368d8f8 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -269,7 +269,7 @@ enum {
 	Opt_gid, Opt_uid, Opt_umask, Opt_session, Opt_lastblock,
 	Opt_anchor, Opt_volume, Opt_partition, Opt_fileset,
 	Opt_rootdir, Opt_utf8, Opt_iocharset,
-	Opt_err
+	Opt_err, Opt_uforget, Opt_uignore, Opt_gforget, Opt_gignore
 };
 
 static match_table_t tokens = {
@@ -282,6 +282,10 @@ static match_table_t tokens = {
 	{Opt_adinicb, "adinicb"},
 	{Opt_shortad, "shortad"},
 	{Opt_longad, "longad"},
+	{Opt_uforget, "uid=forget"},
+	{Opt_uignore, "uid=ignore"},
+	{Opt_gforget, "gid=forget"},
+	{Opt_gignore, "gid=ignore"},
 	{Opt_gid, "gid=%u"},
 	{Opt_uid, "uid=%u"},
 	{Opt_umask, "umask=%o"},
@@ -414,6 +418,18 @@ udf_parse_options(char *options, struct 
 				uopt->flags |= (1 << UDF_FLAG_NLS_MAP);
 				break;
 #endif
+			case Opt_uignore:
+				uopt->flags |= (1 << UDF_FLAG_UID_IGNORE);
+				break;
+			case Opt_uforget:
+				uopt->flags |= (1 << UDF_FLAG_UID_FORGET);
+				break;
+			case Opt_gignore:
+			    uopt->flags |= (1 << UDF_FLAG_GID_IGNORE);
+				break;
+			case Opt_gforget:
+			    uopt->flags |= (1 << UDF_FLAG_GID_FORGET);
+				break;
 			default:
 				printk(KERN_ERR "udf: bad mount option \"%s\" "
 						"or missing value\n", p);
diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
index 6636698..110f8d6 100644
--- a/fs/udf/udf_sb.h
+++ b/fs/udf/udf_sb.h
@@ -20,6 +20,10 @@
 #define UDF_FLAG_VARCONV		8
 #define UDF_FLAG_NLS_MAP		9
 #define UDF_FLAG_UTF8			10
+#define UDF_FLAG_UID_FORGET     11    /* save -1 for uid to disk */
+#define UDF_FLAG_UID_IGNORE     12    /* use sb uid instead of on disk uid */
+#define UDF_FLAG_GID_FORGET     13
+#define UDF_FLAG_GID_IGNORE     14
 
 #define UDF_PART_FLAG_UNALLOC_BITMAP	0x0001
 #define UDF_PART_FLAG_UNALLOC_TABLE	0x0002
-- 
1.1.3

