Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWH3EAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWH3EAu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 00:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWH3EAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 00:00:50 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:11920 "EHLO
	ms-smtp-05.texas.rr.com") by vger.kernel.org with ESMTP
	id S1751385AbWH3EAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 00:00:49 -0400
Message-ID: <44F50D86.8050706@austin.rr.com>
Date: Tue, 29 Aug 2006 23:01:10 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: eparis@parisplace.org, jmorris@redhat.com, linux-kernel@vger.kernel.org
CC: shaggy@austin.ibm.com, shirishp@us.ibm.com, akpm@osdl.org
Subject: Re: [PATCH] SELinux: work around filesystems which call d_instantiate
 before setting inode mode
References: <OF333D0451.97EE96CD-ON872571DA.001579E9-862571DA.001591D1@us.ibm.com>
In-Reply-To: <OF333D0451.97EE96CD-ON872571DA.001579E9-862571DA.001591D1@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------010008000507090801040109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010008000507090801040109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Eric,
Does this patch do what you need?

It rearranges the cifs call to d_instantiate until after the inode is 
filled in in fs/cifs/readdir.c
which IIRC was the only place which did the reverse order from what you 
expected (at
least the only place in cifs).   I will try it tomorrow but I don't know 
SE Linux
scenarios to try that would prove whether it works.



>-
>
>Eric Paris <eparis@parisplace.org> wrote on 08/29/2006 03:08:25 PM:
>  
>
>>One filesystem in particular, CIFS, is known to call d_instantiate
>>before setting the mode for for some operations.  It will create a
>>dentry for any children when doing a directory search and thereby is
>>calling d_instantiate.   But it does so before setting the inode mode
>>for the child inodes.  Thus the selinux sclass in the corresponding
>>inode security struct is set incorrectly to always believe these inodes
>>are regular files.  Then when operations are performed on these inodes
>>at a later point in time SELinux will deny operations which may be
>>allowed for the correct class but not for files or SELinux may check for
>>access permissions to do operations which do not even pertain to the
>>'file' class.  An example would be the user may attempt to remove a
>>subdirectory which would need SELinux permissions to rmdir what it
>>believes is a 'file.'  rmdir'ing a regular file doesn't make sense and
>>is obviously not properly defined.  What this patch does is to
>>recalculate the sclass for each inode on each permission check.  Thus if
>>a filesystem decided to later (after the d_instantiate) set the mode
>>bits (as CIFS does) we will make the correct security checks.  We also
>>output a warning message letting the user know that they have a
>>filesystem which doing operations in a questionable order.
>>(Questionable because after calling d_instantiate the new inode may be
>>available to other threads through the dentry cache with the mode set
>>improperly)
>>
>>I believe that the CIFS people were contacted twice trying to get this
>>changed but we want SELinux users to be able to work now and we want to
>>know if any other filesystem uses this same ordering or choose to
>>implement it in the future.
>>
>>Signed-off-by: Eric Paris <eparis@redhat.com>
>>Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
>>Acked-by: James Morris <jmorris@redhat.com>
>>
>> security/selinux/hooks.c       |   27 +++++++++++++++++++++++++++
>> security/selinux/include/avc.h |    2 ++
>> security/selinux/avc.c         |   14 +++++++++++++-
>> 3 files changed, 42 insertions(+), 1 deletions(-)
>>
>>diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>index 5d1b8c7..5527aec 100644
>>--- a/security/selinux/hooks.c
>>+++ b/security/selinux/hooks.c
>>@@ -1066,6 +1066,25 @@ static int task_has_system(struct task_s
>>              SECCLASS_SYSTEM, perms, NULL);
>> }
>>
>>+/*
>>+ * Update the sclass of an inode.  This shouldn't ever do anything 
>>unless a FS
>>+ * actually called d_instantiate before it set the i_mode.
>>+ */
>>+static inline void inode_update_sclass(struct inode *inode)
>>+{
>>+   struct inode_security_struct *isec = inode->i_security;
>>+   if (isec->sclass == SECCLASS_FILE)
>>+   {
>>+      isec->sclass = inode_mode_to_security_class(inode->i_mode);
>>+      if (unlikely(isec->sclass != SECCLASS_FILE) && 
>>    
>>
>printk_ratelimit())
>  
>
>>+         printk(KERN_WARNING "SELinux: Inode on a %s filesystem "
>>+            "with sclass=file but should have been sclass="
>>+            "%s, fixing up this issue\n",
>>+            inode->i_sb->s_type->name,
>>+            avc_class_to_string(isec->sclass));
>>+   }
>>+}
>>+
>> /* Check whether a task has a particular permission to an inode.
>>    The 'adp' parameter is optional and allows other audit
>>    data to be passed (e.g. the dentry). */
>>@@ -1081,6 +1100,8 @@ static int inode_has_perm(struct task_st
>>    tsec = tsk->security;
>>    isec = inode->i_security;
>>
>>+   inode_update_sclass(inode);
>>+
>>    if (!adp) {
>>       adp = &ad;
>>       AVC_AUDIT_DATA_INIT(&ad, FS);
>>@@ -1220,6 +1241,8 @@ static int may_link(struct inode *dir,
>>    dsec = dir->i_security;
>>    isec = dentry->d_inode->i_security;
>>
>>+   inode_update_sclass(dentry->d_inode);
>>+
>>    AVC_AUDIT_DATA_INIT(&ad, FS);
>>    ad.u.fs.dentry = dentry;
>>
>>@@ -1266,6 +1289,8 @@ static inline int may_rename(struct inod
>>    old_is_dir = S_ISDIR(old_dentry->d_inode->i_mode);
>>    new_dsec = new_dir->i_security;
>>
>>+   inode_update_sclass(old_dir);
>>+
>>    AVC_AUDIT_DATA_INIT(&ad, FS);
>>
>>    ad.u.fs.dentry = old_dentry;
>>@@ -2260,6 +2285,8 @@ static int selinux_inode_setxattr(struct
>>    if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
>>       return -EPERM;
>>
>>+   inode_update_sclass(inode);
>>+
>>    AVC_AUDIT_DATA_INIT(&ad,FS);
>>    ad.u.fs.dentry = dentry;
>>
>>diff --git a/security/selinux/include/avc.h 
>>    
>>
>b/security/selinux/include/avc.h
>  
>
>>index 960ef18..043d479 100644
>>--- a/security/selinux/include/avc.h
>>+++ b/security/selinux/include/avc.h
>>@@ -125,6 +125,8 @@ int avc_add_callback(int (*callback)(u32
>>            u32 events, u32 ssid, u32 tsid,
>>            u16 tclass, u32 perms);
>>
>>+const char *avc_class_to_string(u16 tclass);
>>+
>> /* Exported to selinuxfs */
>> int avc_get_hash_stats(char *page);
>> extern unsigned int avc_cache_threshold;
>>diff --git a/security/selinux/avc.c b/security/selinux/avc.c
>>index a300702..88bba69 100644
>>--- a/security/selinux/avc.c
>>+++ b/security/selinux/avc.c
>>@@ -218,7 +218,7 @@ static void avc_dump_query(struct audit_
>>       audit_log_format(ab, " tcontext=%s", scontext);
>>       kfree(scontext);
>>    }
>>-   audit_log_format(ab, " tclass=%s", class_to_string[tclass]);
>>+   audit_log_format(ab, " tclass=%s", avc_class_to_string(tclass));
>> }
>>
>> /**
>>@@ -913,3 +913,15 @@ int avc_has_perm(u32 ssid, u32 tsid, u16
>>    avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata);
>>    return rc;
>> }
>>+
>>+/**
>>+ * avc_class_to_string - return a human readable string given an 
>>object class.
>>+ * @tclass: the target class we wish to translate
>>+ *
>>+ * Simply take the target object class passed to us and return the 
>>    
>>
>human
>  
>
>>+ * readable string associated with that class
>>+ */
>>+const char *avc_class_to_string(u16 tclass)
>>+{
>>+   return class_to_string[tclass];
>>+}
>>    
>>
>
>  
>


--------------010008000507090801040109
Content-Type: text/plain;
 name="cifs-readdir-dentry-instantiate-ordering-change.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cifs-readdir-dentry-instantiate-ordering-change.diff"

diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index 105761e..9aeb58a 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -82,7 +82,6 @@ static int construct_dentry(struct qstr 
 			if(*ptmp_inode == NULL)
 				return rc;
 			rc = 1;
-			d_instantiate(tmp_dentry, *ptmp_inode);
 		}
 	} else {
 		tmp_dentry = d_alloc(file->f_dentry, qstring);
@@ -99,9 +98,7 @@ static int construct_dentry(struct qstr 
 			tmp_dentry->d_op = &cifs_dentry_ops;
 		if(*ptmp_inode == NULL)
 			return rc;
-		rc = 1;
-		d_instantiate(tmp_dentry, *ptmp_inode);
-		d_rehash(tmp_dentry);
+		rc = 2;
 	}
 
 	tmp_dentry->d_time = jiffies;
@@ -870,6 +867,12 @@ static int cifs_filldir(char *pfindEntry
 				pfindEntry, &obj_type, rc);
 	else
 		fill_in_inode(tmp_inode, 1 /* NT */, pfindEntry, &obj_type, rc);
+
+	if(rc) /* new inode - needs to be tied to dentry */ {
+		d_instantiate(tmp_dentry, tmp_inode);
+		if(rc == 2)
+			d_rehash(tmp_dentry);
+	}
 	
 	
 	rc = filldir(direntry,qstring.name,qstring.len,file->f_pos,

--------------010008000507090801040109--
