Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318200AbSHMQFo>; Tue, 13 Aug 2002 12:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318203AbSHMQFo>; Tue, 13 Aug 2002 12:05:44 -0400
Received: from c-24-126-73-164.we.client2.attbi.com ([24.126.73.164]:19194
	"EHLO kegel.com") by vger.kernel.org with ESMTP id <S318200AbSHMQFl>;
	Tue, 13 Aug 2002 12:05:41 -0400
Date: Tue, 13 Aug 2002 09:14:13 -0700
From: dank@kegel.com
Message-Id: <200208131614.g7DGEDH03569@kegel.com>
To: linux-kernel@vger.kernel.org
Subject: [CHECKER] Fix "null-deref" error in khttpd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have not tested this, but it's "obviously correct", and it
should fix a minor error reported by the Stanford checker in khttpd;
see http://marc.theaimsgroup.com/?l=linux-kernel&m=99601418013486

It was posted to the khttpd mailing list a week or so ago.
Comments welcome.
- Dan

--- linux-2.4.19-pre9/net/khttpd/security.c.orig	Tue Aug  6 16:13:21 2002
+++ linux/net/khttpd/security.c	Tue Aug  6 16:33:08 2002
@@ -83,22 +83,21 @@
 */
 struct file *OpenFileForSecurity(char *Filename)
 {
-	struct file *filp;
+	struct file *filp = NULL;
 	struct DynamicString *List;
 	umode_t permission;
 	
-	
-
 	EnterFunction("OpenFileForSecurity");
 	if (Filename==NULL)
-		return NULL;
+		goto out_error;
 	
-	if (strlen(Filename)>=256 ) return NULL;  /* Sanity check */
+	if (strlen(Filename)>=256 )
+		goto out_error;  /* Sanity check */
 	
 	/* Rule no. 1  -- No "?" characters */
 #ifndef BENCHMARK	
 	if (strchr(Filename,'?')!=NULL)
-		return NULL;
+		goto out_error;
 
 	/* Intermediate step: decode all %hex sequences */
 	
@@ -106,9 +105,8 @@
 
 	/* Rule no. 2  -- Must start with a "/" */
 	
-	
 	if (Filename[0]!='/')
-		return NULL;
+		goto out_error;
 		
 #endif
 	/* Rule no. 3 -- Does the file exist ? */
@@ -116,55 +114,44 @@
 	filp = filp_open(Filename, O_RDONLY, 0);
 	
 	if (IS_ERR(filp))
-		return NULL;
+		goto out_error;
 
 #ifndef BENCHMARK		
 	permission = filp->f_dentry->d_inode->i_mode;
 	
 	/* Rule no. 4 : must have enough permissions */
 	
-	
 	if ((permission & sysctl_khttpd_permreq)==0)
-	{
-		if (filp!=NULL)
-			fput(filp);
-		filp=NULL;
-		return NULL;
-	}
-		
+		goto out_error_put;	
+
 	/* Rule no. 5 : cannot have "forbidden" permission */
 	
-	
 	if ((permission & sysctl_khttpd_permforbid)!=0)
-	{
-		if (filp!=NULL)
-			fput(filp);
-		filp=NULL;
-		return NULL;
-	}
+		goto out_error_put;	
 		
 	/* Rule no. 6 : No string in DynamicList can be a
 			substring of the filename */
-			
 	
 	List = DynamicList;
-	
 	while (List!=NULL)
 	{
 		if (strstr(Filename,List->value)!=NULL)
-		{
-			if (filp!=NULL)
-				fput(filp);
-			filp=NULL;
-			return NULL;
-		}
+			goto out_error_put;	
+
 		List = List->Next;
 	}
 	
 #endif	
 	LeaveFunction("OpenFileForSecurity - success");
-
+out:
 	return filp;
+
+out_error_put:
+	fput(filp);
+out_error:
+	filp=NULL;
+	LeaveFunction("OpenFileForSecurity - fail");
+	goto out;
 }
 
 /* 
