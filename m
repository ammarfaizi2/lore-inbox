Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291460AbSCMAq3>; Tue, 12 Mar 2002 19:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291477AbSCMAqU>; Tue, 12 Mar 2002 19:46:20 -0500
Received: from ns01.vbnet.com.br ([200.230.208.6]:4305 "EHLO iron.vbnet.com.br")
	by vger.kernel.org with ESMTP id <S291460AbSCMAqL>;
	Tue, 12 Mar 2002 19:46:11 -0500
Message-Id: <200203130242.g2D2gEI15215@iron.vbnet.com.br>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carlos E Gorges <carlos@techlinux.com.br>
To: Linux <linux-kernel@vger.kernel.org>
Subject: Re: uname reports 'unknown'
Date: Tue, 12 Mar 2002 21:46:37 -0300
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <15303.1015975366@kao2.melbourne.sgi.com> <3C8E914F.1070701@lexus.com>
In-Reply-To: <3C8E914F.1070701@lexus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12 Mar 2002 20:37, J Sloan wrote:

Try w/ this patch.

--- sh-utils-2.0.11/src/uname.c	Sat May  6 11:17:53 2000
+++ sh-utils-2.0.11-carlos/src/uname.c	Tue Mar 12 21:42:02 2002
@@ -48,6 +48,7 @@
 #define AUTHORS "David MacKenzie"
 
 static void print_element PARAMS ((unsigned int mask, char *element));
+void __sysinfo_processor_type(char*);
 
 /* Values that are bitwise or'd into `toprint'. */
 /* Operating system name. */
@@ -118,7 +119,7 @@
 {
   struct utsname name;
   int c;
-  char processor[256];
+  char processor[BUFSIZ];
 
   program_name = argv[0];
   setlocale (LC_ALL, "");
@@ -183,12 +184,7 @@
   if (uname (&name) == -1)
     error (1, errno, _("cannot get system name"));
 
-#if defined (HAVE_SYSINFO) && defined (SI_ARCHITECTURE)
-  if (sysinfo (SI_ARCHITECTURE, processor, sizeof (processor)) == -1)
-    error (1, errno, _("cannot get processor type"));
-#else
-  strcpy (processor, "unknown");
-#endif
+  __sysinfo_processor_type(processor);
 
   print_element (PRINT_SYSNAME, name.sysname);
   print_element (PRINT_NODENAME, name.nodename);
@@ -213,3 +209,25 @@
       printf ("%s%c", element, toprint ? ' ' : '\n');
     }
 }
+
+
+/* Carlos E. Gorges
+return vendor_id from proc cpuinfo
+*/
+
+void
+__sysinfo_processor_type (char* proc_info) {
+	FILE *ffd;
+	char temp_string[BUFSIZ],final_string[BUFSIZ]="unknown";
+	
+	if ((ffd=fopen("/proc/cpuinfo", "r") )!=NULL) {
+		while ( fscanf(ffd, "%s :", temp_string) != EOF)
+			if (!(strcmp(temp_string, "vendor_id"))) {
+					fscanf(ffd, "%s", final_string);
+					break;
+			}
+		fclose(ffd);
+	}
+	strncpy(proc_info,final_string,BUFSIZ);
+}
+
---

> Keith Owens wrote:
> >On 12 Mar 2002 17:59:53 -0500,
> >
> >Shawn Starr <spstarr@sh0n.net> wrote:
> >>Perhaps it should display P54C which is my P200 processor type?
> >
> >Talk to sh-utils, uname -p is not kernel defined.
>
> Yes the kernel part is fine, has been fine.
>
> sh-utils comes with a broken uname, but the
> patch is trivial - wonder when the vendors
> will pick it up, it works fine here -
>
> Linux uranium 2.4.19-pre2aa1 #1 Thu Mar 7 12:33:56 PST 2002 i686
> GenuineIntel
>
> Joe

-- 
	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil                   
	 _________________________

