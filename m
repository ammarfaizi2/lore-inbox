Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130207AbRANDK7>; Sat, 13 Jan 2001 22:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130348AbRANDKu>; Sat, 13 Jan 2001 22:10:50 -0500
Received: from d83b5259.dsl.flashcom.net ([216.59.82.89]:28035 "EHLO
	home.lameter.com") by vger.kernel.org with ESMTP id <S130207AbRANDKj>;
	Sat, 13 Jan 2001 22:10:39 -0500
Date: Sat, 13 Jan 2001 19:10:36 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
To: linux-kernel@vger.kernel.org, khttpd-users@zgp.org
Subject: khttpd: patch for range support + accumulated patches
Message-ID: <Pine.LNX.4.21.0101131904100.15669-100000@home.lameter.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch adds the following functionality to khttpd:

- Range support. Only simple ranges (from-to) are supported. Range suport
  enables the debian apt tool to resume aborted http file-transfers. Very
  important if one plans to run a kernel/debian mirror with khttpd.

- Virtual Host support (see docs in patch)

- Persistant connections

- simple logging via printk if /proc/sys/net/khttpd/logging is set to 1.

diff -urN linux-orig/net/khttpd/accept.c linux/net/khttpd/accept.c
--- linux-orig/net/khttpd/accept.c	Sat Jan 22 11:54:58 2000
+++ linux/net/khttpd/accept.c	Fri Jan 12 21:19:55 2001
@@ -107,6 +107,7 @@
 		memset(NewRequest,0,sizeof(struct http_request));  
 		
 		NewRequest->sock = NewSock;
+		NewRequest->LastActive = jiffies;
 		
 		NewRequest->Next = threadinfo[CPUNR].WaitForHeaderQueue;
 		
diff -urN linux-orig/net/khttpd/datasending.c linux/net/khttpd/datasending.c
--- linux-orig/net/khttpd/datasending.c	Fri Nov 17 11:36:27 2000
+++ linux/net/khttpd/datasending.c	Sat Jan 13 17:58:21 2001
@@ -105,7 +105,7 @@
 		
 		Space = sock_wspace(CurrentRequest->sock->sk);
 		
-		ReadSize = min(4*4096,CurrentRequest->FileLength - CurrentRequest->BytesSent);
+		ReadSize = min(4*4096,CurrentRequest->End - (CurrentRequest->BytesSent+CurrentRequest->Offset));
 		ReadSize = min(ReadSize , Space );
 
 		if (ReadSize>0)
@@ -119,7 +119,7 @@
 				read_descriptor_t desc;
 				loff_t *ppos;
 		
-				CurrentRequest->filp->f_pos = CurrentRequest->BytesSent;
+				CurrentRequest->filp->f_pos = CurrentRequest->BytesSent+CurrentRequest->Offset;
 
 				ppos = &CurrentRequest->filp->f_pos;
 
@@ -137,7 +137,7 @@
 			else  /* FS doesn't support sendfile() */
 			{
 				mm_segment_t oldfs;
-				CurrentRequest->filp->f_pos = CurrentRequest->BytesSent;
+				CurrentRequest->filp->f_pos = CurrentRequest->BytesSent+CurrentRequest->Offset;
 				
 				oldfs = get_fs(); set_fs(KERNEL_DS);
 				retval = CurrentRequest->filp->f_op->read(CurrentRequest->filp, Block[CPUNR], ReadSize, &CurrentRequest->filp->f_pos);
@@ -160,7 +160,7 @@
 		   If end-of-file or closed connection: Finish this request 
 		   by moving it to the "logging" queue. 
 		*/
-		if ((CurrentRequest->BytesSent>=CurrentRequest->FileLength)||
+		if ((CurrentRequest->BytesSent+CurrentRequest->Offset>=CurrentRequest->End)||
 		    (CurrentRequest->sock->sk->state!=TCP_ESTABLISHED
 		     && CurrentRequest->sock->sk->state!=TCP_CLOSE_WAIT))
 		{
diff -urN linux-orig/net/khttpd/logging.c linux/net/khttpd/logging.c
--- linux-orig/net/khttpd/logging.c	Wed Aug 18 09:45:10 1999
+++ linux/net/khttpd/logging.c	Fri Jan 12 21:27:05 2001
@@ -29,6 +29,8 @@
 #include <asm/uaccess.h>
 #include "structure.h"
 #include "prototypes.h"
+#include "sysctl.h"
+
 
 /*
 
@@ -58,9 +60,22 @@
 	while (CurrentRequest!=NULL)
 	{
 
+		CurrentRequest->ReqCount++; 
+		CurrentRequest->LastActive = jiffies;
+
+		if (sysctl_khttpd_logging) {
+			CurrentRequest->FileName[CurrentRequest->FileNameLength]=0;
+			printk(KERN_NOTICE "File=%s Host=%s Length=%d Userspace=%d\n",CurrentRequest->FileName,CurrentRequest->Host,CurrentRequest->FileLength,CurrentRequest->IsForUserspace);
+		}
 		Req = CurrentRequest->Next;
 
-		CleanUpRequest(CurrentRequest);
+		if (CurrentRequest->Persistent) {
+			sanitize_request(CurrentRequest);
+			CurrentRequest->Next = threadinfo[CPUNR].WaitForHeaderQueue;
+			threadinfo[CPUNR].WaitForHeaderQueue = CurrentRequest;
+		}
+		else
+			CleanUpRequest(CurrentRequest);
 		
 		threadinfo[CPUNR].LoggingQueue = Req;
 			
diff -urN linux-orig/net/khttpd/misc.c linux/net/khttpd/misc.c
--- linux-orig/net/khttpd/misc.c	Thu Sep  2 11:47:20 1999
+++ linux/net/khttpd/misc.c	Fri Jan 12 21:19:55 2001
@@ -132,6 +132,89 @@
 	LeaveFunction("CleanUpRequest");
 }
 
+static char Buffer[1024];
+
+static void DummyRead(struct socket *sock, int Size)
+{
+	struct msghdr		msg;
+	struct iovec		iov;
+	int			len,totalbytes=0;
+
+	mm_segment_t		oldfs;
+	
+	
+	EnterFunction("DummyRead");
+	
+	
+	if (sock->sk==NULL)
+		return;
+
+	len = 1;
+	
+	totalbytes = 0;
+	
+	while ((len>0)&&(totalbytes<Size)) {
+		msg.msg_name     = 0;
+		msg.msg_namelen  = 0;
+		msg.msg_iov	 = &iov;
+		msg.msg_iovlen   = 1;
+		msg.msg_control  = NULL;
+		msg.msg_controllen = 0;
+		msg.msg_flags    = MSG_DONTWAIT;
+	
+		msg.msg_iov->iov_base = &Buffer[0];
+		msg.msg_iov->iov_len  = (__kernel_size_t)max(1024,Size-totalbytes);
+	
+		len = 0;
+		oldfs = get_fs(); set_fs(KERNEL_DS);
+		len = sock_recvmsg(sock,&msg,1024,MSG_DONTWAIT);
+		set_fs(oldfs);
+		if (len>0)
+			totalbytes+=len;
+	}
+	LeaveFunction("DummyRead");
+}
+
+
+
+/*
+sanitize_request
+@request: the request to clean
+
+sanitize_requests cleans all URL specific parts of a request, while
+saving the connection specific parts in order to do persistent connections.
+  
+*/
+void sanitize_request(struct http_request *request)
+{
+	EnterFunction("sanitize_request");
+	/* Close the file-pointer */
+	if (request->filp!=NULL)
+	{
+	    	fput(request->filp);
+	    	request->filp = NULL;
+	}
+	
+	DummyRead(request->sock,request->Headersize);
+
+	request->FileLength = 0;
+	request->Time = 0;
+	request->BytesSent = 0;
+	request->FileName[0]=0;
+	request->FileNameLength = 0;
+	request->IMS[0]=0;
+	request->Host[0]=0;
+	request->IMS_Time =0;
+	request->TimeS[0] =0;
+	request->LengthS[0] =0;
+	request->MimeType = NULL;
+	request->MimeLength = 0;
+	
+	LeaveFunction("sanitize_request");
+
+}
+
+
 
 /*
 
@@ -215,6 +298,7 @@
 */
 
 static char NoPerm[] = "HTTP/1.0 403 Forbidden\r\nServer: kHTTPd 0.1.6\r\n\r\n";
+static char TimeOut[] = "HTTP/1.0 408 Request timed out\r\nServer: kHTTPd 0.1.6\r\nConnection: close\r\n\r\n";
 static char TryLater[] = "HTTP/1.0 503 Service Unavailable\r\nServer: kHTTPd 0.1.6\r\nContent-Length: 15\r\n\r\nTry again later";
 static char NotModified[] = "HTTP/1.0 304 Not Modified\r\nServer: kHTTPd 0.1.6\r\n\r\n";
 
@@ -225,6 +309,14 @@
 	(void)SendBuffer(sock,NoPerm,strlen(NoPerm));
 	LeaveFunction("Send403");
 }
+
+void Send408(struct socket *sock)
+{
+	EnterFunction("Send408");
+	(void)SendBuffer(sock,TimeOut,strlen(TimeOut));
+	LeaveFunction("Send408");
+}
+
 
 void Send304(struct socket *sock)
 {
diff -urN linux-orig/net/khttpd/prototypes.h linux/net/khttpd/prototypes.h
--- linux-orig/net/khttpd/prototypes.h	Mon Dec 11 13:32:10 2000
+++ linux/net/khttpd/prototypes.h	Sat Jan 13 13:45:36 2001
@@ -65,9 +65,11 @@
 /* misc.c */
 
 void CleanUpRequest(struct http_request *Req);
+void sanitize_request(struct http_request *request);
 int SendBuffer(struct socket *sock, const char *Buffer,const size_t Length);
 int SendBuffer_async(struct socket *sock, const char *Buffer,const size_t Length);
 void Send403(struct socket *sock);
+void Send408(struct socket *sock);
 void Send304(struct socket *sock);
 void Send50x(struct socket *sock);
 
diff -urN linux-orig/net/khttpd/rfc.c linux/net/khttpd/rfc.c
--- linux-orig/net/khttpd/rfc.c	Mon Aug 23 10:41:25 1999
+++ linux/net/khttpd/rfc.c	Sat Jan 13 18:45:28 2001
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
+  <virtual-hostmap> { : <virtual_hostmap> } : <defaultpath>
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
 
@@ -156,85 +184,26 @@
 
 
 static char HeaderPart1[] = "HTTP/1.0 200 OK\r\nServer: kHTTPd/0.1.6\r\nDate: ";
-#ifdef BENCHMARK
-static char HeaderPart1b[] ="HTTP/1.0 200 OK";
-#endif
-static char HeaderPart3[] = "\r\nContent-type: ";
-static char HeaderPart5[] = "\r\nLast-modified: ";
-static char HeaderPart7[] = "\r\nContent-length: ";
-static char HeaderPart9[] = "\r\n\r\n";
+static char HeaderPart2[] = "HTTP/1.0 206 Partial Content\r\nServer: kHTTPd/0.1.6\r\nDate: ";
+static char HeaderPart3[] = "\r\nContent-Type: ";
+static char HeaderPart5[] = "\r\nLast-Modified: ";
+static char HeaderPart7[] = "\r\nContent-Length: ";
+static char HeaderPart9[] = "\r\nConnection: Keep-Alive\r\n\r\n";
+static char HeaderPart9close[] = "\r\nConnection: Close\r\n\r\n";
+static char HeaderPartPartial[] = "\r\nContent-Range: bytes %u-%u/%u";
 
-#ifdef BENCHMARK
-/* In BENCHMARK-mode, just send the bare essentials */
 void SendHTTPHeader(struct http_request *Request)
 {
 	struct msghdr	msg;
 	mm_segment_t	oldfs;
-	struct iovec	iov[9];
+	struct iovec	iov[10];
 	int 		len,len2;
-	
+	int		cindex;
 	
 	EnterFunction("SendHTTPHeader");
-		
-	msg.msg_name     = 0;
-	msg.msg_namelen  = 0;
-	msg.msg_iov	 = &iov[0];
-	msg.msg_iovlen   = 6;
-	msg.msg_control  = NULL;
-	msg.msg_controllen = 0;
-	msg.msg_flags    = 0;  /* Synchronous for now */
-	
-	iov[0].iov_base = HeaderPart1b;
-	iov[0].iov_len  = 15;
-	iov[1].iov_base = HeaderPart3;
-	iov[1].iov_len  = 16;
-	iov[2].iov_base = Request->MimeType;
-	iov[2].iov_len  = Request->MimeLength;
-	
-	iov[3].iov_base = HeaderPart7;
-	iov[3].iov_len  = 18;
-	
-	
-	sprintf(Request->LengthS,"%i",Request->FileLength);
-	iov[4].iov_base = Request->LengthS;
-	iov[4].iov_len  = strlen(Request->LengthS);
-	iov[5].iov_base = HeaderPart9;
-	iov[5].iov_len  = 4;
-	
-	len2=15+16+18+iov[2].iov_len+iov[4].iov_len+4;
-	
-	
-	len = 0;
-	
-
-	oldfs = get_fs(); set_fs(KERNEL_DS);
-	len = sock_sendmsg(Request->sock,&msg,len2);
-	set_fs(oldfs);
-
 	
-	return;	
-}
-#else
-void SendHTTPHeader(struct http_request *Request)
-{
-	struct msghdr	msg;
-	mm_segment_t	oldfs;
-	struct iovec	iov[9];
-	int 		len,len2;
-	__kernel_size_t	slen;
-	
-	EnterFunction("SendHTTPHeader");
-	
-	msg.msg_name     = 0;
-	msg.msg_namelen  = 0;
-	msg.msg_iov	 = &(iov[0]);
-	msg.msg_iovlen   = 9;
-	msg.msg_control  = NULL;
-	msg.msg_controllen = 0;
-	msg.msg_flags    = 0;  /* Synchronous for now */
-	
-	iov[0].iov_base = HeaderPart1;
-	iov[0].iov_len  = 45;
+	iov[0].iov_base = Request->Offset ? HeaderPart2: HeaderPart1;
+	iov[0].iov_len  = strlen(iov[0].iov_base);
 	iov[1].iov_base = CurrentTime;
 	iov[1].iov_len  = 29;
 	iov[2].iov_base = HeaderPart3;
@@ -250,12 +219,32 @@
 	iov[6].iov_base = HeaderPart7;
 	iov[6].iov_len  = 18;
 	iov[7].iov_base = &(Request->LengthS[0]);
-	slen = strlen(Request->LengthS); 
-	iov[7].iov_len  = slen;
-	iov[8].iov_base = HeaderPart9;
-	iov[8].iov_len  = 4;
+	iov[7].iov_len = strlen(Request->LengthS); 
+	
+	cindex = 8;
+	if (Request->Offset || Request->End < Request->FileLength) {
+		sprintf(Request->ContentRange,HeaderPartPartial,Request->Offset,Request->End,Request->FileLength);
+		iov[cindex].iov_base = Request->ContentRange;
+		iov[cindex].iov_len = strlen(Request->ContentRange);
+		cindex++;
+	}
+	iov[cindex].iov_base = HeaderPart9close;
+	iov[cindex].iov_len  = 23;
+
+	if (Request->Persistent) {
+		iov[cindex].iov_base = HeaderPart9;
+		iov[cindex].iov_len  = 28;
+	}
+
+	msg.msg_name     = 0;
+	msg.msg_namelen  = 0;
+	msg.msg_iov	 = &(iov[0]);
+	msg.msg_iovlen   = cindex+1;
+	msg.msg_control  = NULL;
+	msg.msg_controllen = 0;
+	msg.msg_flags    = 0;  /* Synchronous for now */
 	
-	len2=45+2*29+16+17+18+slen+4+iov[3].iov_len;
+	len2=0;while (cindex>=0) { len2+=iov[cindex].iov_len;cindex--; }
 	
 	len = 0;
 
@@ -264,10 +253,8 @@
 	set_fs(oldfs);
 	LeaveFunction("SendHTTPHeader");
 	
-
 	return;	
 }
-#endif
 
 
 
@@ -280,6 +267,8 @@
 void ParseHeader(char *Buffer,const int length, struct http_request *Head)
 {
 	char *Endval,*EOL,*tmp;
+	char *filename=NULL;
+	int filenamelen;
 	
 	EnterFunction("ParseHeader");
 	Endval = Buffer + length;
@@ -288,6 +277,8 @@
 	tmp = strstr(Buffer,"\r\n\r\n"); 
 	if (tmp!=NULL)
 	    Endval = tmp;
+	    
+	Head->Headersize = Endval - Buffer+4;
 	
 	
 	while (Buffer<Endval)
@@ -311,7 +302,6 @@
 		
 		if (strncmp("GET ",Buffer,4)==0)
 		{
-			int PrefixLen;
 			Buffer+=4;
 			
 			tmp=strchr(Buffer,' ');
@@ -323,12 +313,9 @@
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
@@ -347,6 +334,16 @@
 			continue;
 		}
 
+		if (strncmp("If-Range: ",Buffer,10)==0)
+		{
+			Buffer+=10;
+			
+			strncpy(Head->IfRange,Buffer,min(127,EOL-Buffer-1));
+					
+			Buffer=EOL+1;	
+			continue;
+		}
+
 		if (strncmp("User-Agent: ",Buffer,12)==0)
 		{
 			Buffer+=12;
@@ -361,14 +358,96 @@
 		if (strncmp("Host: ",Buffer,6)==0)
 		{
 			Buffer+=6;
-			
-			strncpy(Head->Host,Buffer,min(127,EOL-Buffer-1));
-					
+
+			Head->Host[min(126,EOL-Buffer-1)]=0;
+			strncpy(Head->Host,Buffer,min(126,EOL-Buffer-1));		
 			Buffer=EOL+1;	
 			continue;
 		}
 #endif		
+		if (strncmp("Connection: Keep-Alive",Buffer,22)==0)
+		{
+			Buffer+=22;
+			Buffer=EOL+1;
+			Head->Persistent = 1;
+			continue;
+		}
+
+		if (strncmp("Range: bytes=",Buffer,13)==0)
+		{
+			Buffer+=13;
+			if (*Buffer!='-') Head->Offset = simple_strtoul(Buffer,&Buffer,10);
+			if (*Buffer == '-') {
+				Buffer++;
+				Head->End = simple_strtoul(Buffer,NULL,10);
+			} else Head->Offset=0;
+			Buffer=EOL+1;
+			continue;
+		}
+
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
+	    Head->FileName[Head->FileNameLength]=0;
 	}
 	LeaveFunction("ParseHeader");
 }
diff -urN linux-orig/net/khttpd/structure.h linux/net/khttpd/structure.h
--- linux-orig/net/khttpd/structure.h	Mon Dec 11 13:32:10 2000
+++ linux/net/khttpd/structure.h	Sat Jan 13 13:44:59 2001
@@ -15,6 +15,11 @@
 	/* Network and File data */
 	struct socket	*sock;		
 	struct file	*filp;		
+	
+	/* Info for persistent connections / timeouts */
+	int		ReqCount; 	/* Number of requests served already */
+	int		Persistent;	/* 1 if the socket needs to remain open */
+	unsigned long	LastActive;	/* Last active, in absolute jiffies */
 
 	/* Raw data about the file */
 	
@@ -30,10 +35,15 @@
 	/* HTTP request information */
 	char		FileName[256];	/* The requested filename */
 	int		FileNameLength; /* The length of the string representing the filename */
-	char		Agent[128];	/* The agent-string of the remote browser */
 	char		IMS[128];	/* If-modified-since time, rfc string format */
 	char		Host[128];	/* Value given by the Host: header */
+	char		Agent[128];
 	int		HTTPVER;        /* HTTP-version; 9 for 0.9,   10 for 1.0 and above */
+	int		Headersize;	/* Size of the request in bytes */
+	unsigned long	Offset;		/* If !=0 then a range request has been parsed. */
+	unsigned long	End;		/* End of Range if specified */
+	char		IfRange[200];	/* IfRange time, rfc string format */
+	char		ContentRange[50];	/* HTTP header piece for ranges */
 
 
 	/* Derived date from the above fields */	
diff -urN linux-orig/net/khttpd/sysctl.c linux/net/khttpd/sysctl.c
--- linux-orig/net/khttpd/sysctl.c	Mon Aug 23 13:44:03 1999
+++ linux/net/khttpd/sysctl.c	Fri Jan 12 21:19:55 2001
@@ -63,6 +63,7 @@
 int 	sysctl_khttpd_sloppymime= 0;
 int	sysctl_khttpd_threads	= 2;
 int	sysctl_khttpd_maxconnect = 1000;
+int 	sysctl_khttpd_timeout	= 20;
 
 
 static struct ctl_table_header *khttpd_table_header;
diff -urN linux-orig/net/khttpd/sysctl.h linux/net/khttpd/sysctl.h
--- linux-orig/net/khttpd/sysctl.h	Wed Aug 18 09:45:10 1999
+++ linux/net/khttpd/sysctl.h	Fri Jan 12 21:19:55 2001
@@ -13,5 +13,6 @@
 extern int 	sysctl_khttpd_sloppymime;
 extern int 	sysctl_khttpd_threads;
 extern int	sysctl_khttpd_maxconnect;
+extern int	sysctl_khttpd_timeout;
 
 #endif
diff -urN linux-orig/net/khttpd/waitheaders.c linux/net/khttpd/waitheaders.c
--- linux-orig/net/khttpd/waitheaders.c	Sun Apr  2 15:53:28 2000
+++ linux/net/khttpd/waitheaders.c	Sat Jan 13 18:01:06 2001
@@ -44,6 +44,7 @@
 
 #include "structure.h"
 #include "prototypes.h"
+#include "sysctl.h"
 
 static	char			*Buffer[CONFIG_KHTTPD_NUMCPU];
 
@@ -57,8 +58,12 @@
 	struct sock *sk;
 	int count = 0;
 	
+	unsigned long timeout;
+	
 	EnterFunction("WaitForHeaders");
 	
+	timeout = jiffies - sysctl_khttpd_timeout * HZ;
+	
 	CurrentRequest = threadinfo[CPUNR].WaitForHeaderQueue;
 	
 	Prev = &(threadinfo[CPUNR].WaitForHeaderQueue);
@@ -94,6 +99,7 @@
 		{
 			struct http_request *Next;
 			
+			CurrentRequest->LastActive = jiffies;
 			
 			
 			/* Decode header */
@@ -127,7 +133,43 @@
 			CurrentRequest = Next;
 			continue;
 		
-		}	
+		} else {  /* No data */
+			if ( CurrentRequest->LastActive < timeout ) {
+				struct http_request *Next;
+				
+				/* Timed out session.
+				 *
+				 * There are 2 possibilities here:
+				 * 1) It is a "fresh" connection; this is tricky and should
+				 *    be left to userspace
+				 * 2) It is a "Keep-alive" connection; RFC 2616 is clear on this and
+				 *    we MAY close it with a 408 message.
+				 */
+	
+				/* Remove from WaitForHeaderQueue */		
+			
+				Next= CurrentRequest->Next;
+		
+				*Prev = Next;
+				count++;
+			
+			
+				if (CurrentRequest->ReqCount==0)
+				{
+					CurrentRequest->Next = threadinfo[CPUNR].UserspaceQueue;
+					threadinfo[CPUNR].UserspaceQueue = CurrentRequest;	
+				} else
+				{
+					Send408(CurrentRequest->sock);
+					CurrentRequest->Next = threadinfo[CPUNR].LoggingQueue;
+					threadinfo[CPUNR].LoggingQueue = CurrentRequest;
+					CurrentRequest->Persistent=0; /* We don't want to continue */	
+				} 	
+				
+				CurrentRequest = Next;
+				continue;
+			}
+		}
 
 		
 		Prev = &(CurrentRequest->Next);
@@ -243,15 +285,31 @@
 		Request->FileLength = (int)Request->filp->f_dentry->d_inode->i_size;
 		Request->Time       = Request->filp->f_dentry->d_inode->i_mtime;
 		Request->IMS_Time   = mimeTime_to_UnixTime(Request->IMS);
-		sprintf(Request->LengthS,"%i",Request->FileLength);
+		
+		if (Request->End ==0) Request->End = Request->FileLength;
+
+		if (Request->Offset >= Request->FileLength)
+		{	/* Bad Range request. Fall back to transferring whole page  */
+			Request->Offset=0;
+		}
+
 		time_Unix2RFC(min(Request->Time,CurrentTime_i),Request->TimeS);
    	        /* The min() is required by rfc1945, section 10.10:
    	           It is not allowed to send a filetime in the future */
+   	        
+   	        if (Request->Offset && mimeTime_to_UnixTime(Request->IfRange)>Request->Time)
+   	        {	/* Modified since last piece was transferred. Fall back to beginning */
+   	        	Request->Offset=0;
+   	        }
+
+		sprintf(Request->LengthS,"%i",Request->End-Request->Offset);
 
 		if (Request->IMS_Time>Request->Time)
 		{	/* Not modified since last time */
 			Send304(Request->sock);
 			Request->FileLength=0;
+			Request->End=0;
+			Request->Offset=0;
 		}
 		else   /* Normal Case */
 		{

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
