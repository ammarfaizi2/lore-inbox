Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132078AbRAKH3K>; Thu, 11 Jan 2001 02:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132448AbRAKH3A>; Thu, 11 Jan 2001 02:29:00 -0500
Received: from d83b5259.dsl.flashcom.net ([216.59.82.89]:1415 "EHLO
	home.lameter.com") by vger.kernel.org with ESMTP id <S132078AbRAKH2x>;
	Thu, 11 Jan 2001 02:28:53 -0500
Date: Wed, 10 Jan 2001 23:22:55 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
To: linux-kernel@vger.rutgers.edu, khttpd-users@zgp.org
Subject: Kernel HTTP server: Patch for name based virtual domains
In-Reply-To: <Pine.LNX.4.21.0101071655090.1110-100000@home.lameter.com>
Message-ID: <Pine.LNX.4.21.0101102317200.11936-100000@home.lameter.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch against 2.4.0 which enables the use of virtual domains. I
ma running multiple domains on my server and was not able to use the
kernel webserver. The machine is only a Cyrix 166 and since it also serves
lots of files using the kernel server is a tremendous boost.

Settings for khttpd:

echo 80 >/proc/sys/net/khttpd/serverport
echo 8080 >/proc/sys/net/khttpd/clientport
echo "(lameter,com,www.lameter.com)/home/clameter/lameter:(vdm.org)/home/clameter/vdm:/var/www" >/proc/sys/net/khttpd/documentroot
echo 1 >/proc/sys/net/khttpd/start

The docs are included in the source below.

diff -urN linux-orig/net/khttpd/rfc.c linux/net/khttpd/rfc.c
--- linux-orig/net/khttpd/rfc.c	Mon Aug 23 10:41:25 1999
+++ linux/net/khttpd/rfc.c	Wed Jan 10 19:48:04 2001
@@ -23,6 +23,34 @@
  *
  ****************************************************************/
 
+/*
+  Virtual Host parser by Christoph Lameter <christoph@lameter.com>, January 10, 2001
+  
+  The proc file in /proc/sys/net/khttpd/document can either be set to a single webroot or
+  can contain a specification of a pathlist of webroots. Each path is prefixed by the virtual
+  hostnames in parentheses. For example.
+  
+  echo "(home.lameter.com,localhost)/a/christoph/new:(virtual3.cc.com)/home/richard:/var/www" >documentroot
+  
+  would redirect requests for http://lameter.com and http://localhost to /a/christoph/new.
+  Requests for http://virtual3.cc.com will be served from /home/richard.
+  Requests for other domains will be served from /var/www.
+
+  The syntax for specifying virtual host mappings is:
+  
+  <virtual-hostmap< { , <virtual_hostmap> } : <defaultpath>
+  
+  where
+  
+  <defaultmap>		=	Unix path
+  <virtual-hostmap>	=	( <hostname> { , <hostname> } ) : <path>
+  <hostname>		=	legal DNS name of a host
+  <path>		=	Unix path
+  
+  An additional enhancement of khttpd is that no attempt is made to open directories.
+  Instead index.html is appended to a directory to simulate classic webserver behavior.
+  
+*/
 
 #include <linux/kernel.h>
 
@@ -280,6 +308,8 @@
 void ParseHeader(char *Buffer,const int length, struct http_request *Head)
 {
 	char *Endval,*EOL,*tmp;
+	char *filename=NULL;
+	int filenamelen;
 	
 	EnterFunction("ParseHeader");
 	Endval = Buffer + length;
@@ -311,7 +341,6 @@
 		
 		if (strncmp("GET ",Buffer,4)==0)
 		{
-			int PrefixLen;
 			Buffer+=4;
 			
 			tmp=strchr(Buffer,' ');
@@ -323,12 +352,9 @@
 				Head->HTTPVER = 10;
 			
 			if (tmp>Endval) continue;
-			
-			strncpy(Head->FileName,sysctl_khttpd_docroot,sizeof(Head->FileName));
-			PrefixLen = strlen(sysctl_khttpd_docroot);
-			Head->FileNameLength = min(255,tmp-Buffer+PrefixLen);		
-			
-			strncat(Head->FileName,Buffer,min(255-PrefixLen,tmp-Buffer));
+
+			filename=Buffer;
+			filenamelen=tmp-Buffer;
 					
 			Buffer=EOL+1;	
 #ifdef BENCHMARK
@@ -369,6 +395,67 @@
 		}
 #endif		
 		Buffer = EOL+1;  /* Skip line */
+	}
+	if (filename) {
+
+	    char PrefixLen;
+
+	    if (sysctl_khttpd_docroot[0]=='(') {
+
+		char *p=sysctl_khttpd_docroot;
+		char *q;
+
+		while (*p=='(') {
+			do {
+				p++;
+				q=p;	/* Mark position of virtual hostname */
+
+				while (*p && *p!=')' && *p!=',') p++;		/* Find the end of the hostname */
+
+				if (*p==0) { printk(KERN_ERR ") missing in virtual host string.\n");return; }
+
+				if (strnicmp(Head->Host,q,p-q)==0) {
+					/* virtual hostname match */
+					while (*p && *p!=')') p++;	/* Skip to the end of the vhostname list */
+					if (*p == 0) printk(KERN_ERR "path missing for virtual host");
+
+					p++;
+					goto rootfound;
+				}
+			} while (*p==',');
+
+			if (*p==')') { /* at end of virtual host names need to skip the webroot since nothing matched */
+
+				while (*p && *p!=':') p++;
+				if (*p==0) { printk(KERN_ERR "closing : of virtual host specification missing.\n");return; }
+				p++;
+			}
+
+		}
+	rootfound:
+		if (*p==0) { printk(KERN_ERR "Error in virtual host specification.\n");return; }
+
+		/* p is pointing to matching webroot for this virtual host or the default root */
+		q=p;while (*p && *p!=':') p++;		/* Find the end of the pathname */
+		PrefixLen=p-q;
+		strncpy(Head->FileName,q,PrefixLen);
+
+	    } else {
+
+	       strncpy(Head->FileName,sysctl_khttpd_docroot,sizeof(Head->FileName));
+	       PrefixLen = strlen(sysctl_khttpd_docroot);
+
+	    }
+
+	    Head->FileNameLength = min(255,filenamelen+PrefixLen);		
+	    strncat(Head->FileName,filename,min(255-PrefixLen,filenamelen));
+	    
+	    if (Head->FileName[Head->FileNameLength-1]=='/' && Head->FileNameLength<255-10) {
+	    
+	    	/* A directory! khttpd will not be able to successfully open it. But it might be able to access index.html */
+	    	memcpy(Head->FileName+Head->FileNameLength,"index.html",10);
+	    	Head->FileNameLength+=10;
+	    }
 	}
 	LeaveFunction("ParseHeader");
 }


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
