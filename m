Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129667AbQLGSH1>; Thu, 7 Dec 2000 13:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLGSHR>; Thu, 7 Dec 2000 13:07:17 -0500
Received: from dryline-fw.wireless-sys.com ([216.126.67.45]:39745 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S130204AbQLGSHB>; Thu, 7 Dec 2000 13:07:01 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14895.51841.431444.405949@somanetworks.com>
Date: Thu, 7 Dec 2000 12:36:01 -0500 (EST)
From: "Georg Nikodym" <georgn@somanetworks.com>
To: linux-kernel@vger.kernel.org
Cc: georgn@somanetworks.com, Keith Owens <kaos@ocs.com.au>,
        greg@wind.enjellic.com, sct@redhat.com
Subject: Re: linux-2.4.0-test11 and sysklogd-1.3-31 
In-Reply-To: <1348.976146369@kao2.melbourne.sgi.com>
In-Reply-To: <14894.48314.363938.770481@somanetworks.com>
	<1348.976146369@kao2.melbourne.sgi.com>
X-Mailer: VM 6.75 under 21.2  (beta37) "Pan" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "KO" == Keith Owens <kaos@ocs.com.au> writes:

 KO> I would prefer to see the oops decoding completely removed from
 KO> klogd.  The only justification for klogd converting the oops is
 KO> to save users from running ksymoops by hand.  I would not mind
 KO> klogd capturing the oops text, forking to run ksymoops then
 KO> logging the ksymoops output.  Just as along as the original text
 KO> was left alone and the ksymoops output was obviously
 KO> distinguished from real kernel output.

Since nobody else has weighed in on this issue, I quickly did the
necessary to effect Keith's suggestion.  What follows is a patch to
sysklogd-1.3-31 (which after applying, ksym_mod.c can be removed):

# This is a BitKeeper generated patch for the following project:
# Project Name: Trans-lab fsimage sub-gate
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.60    -> 1.62   
#	src/sysklogd-1.3-31/ksym.c	1.1     -> 1.2    
#	src/sysklogd-1.3-31/klogd.c	1.1     -> 1.2    
#	src/sysklogd-1.3-31/ksyms.h	1.1     -> 1.2    
#	src/sysklogd-1.3-31/Makefile	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 00/12/07	georgn@lh.somanetworks.com	1.61
# Remove ksym_mod.c to fix sysklogd build
# --------------------------------------------
# 00/12/07	georgn@lh.somanetworks.com	1.62
# Remove a remaining prototype associated with the now deleted ksym_mod.c
# --------------------------------------------
#
diff -Nru a/src/sysklogd-1.3-31/Makefile b/src/sysklogd-1.3-31/Makefile
--- a/src/sysklogd-1.3-31/Makefile	Thu Dec  7 11:53:56 2000
+++ b/src/sysklogd-1.3-31/Makefile	Thu Dec  7 11:53:56 2000
@@ -63,9 +63,8 @@
 syslogd: syslogd.o pidfile.o
 	${CC} ${LDFLAGS} -o syslogd syslogd.o pidfile.o ${LIBS}
 
-klogd:	klogd.o syslog.o pidfile.o ksym.o ksym_mod.o
-	${CC} ${LDFLAGS} -o klogd klogd.o syslog.o pidfile.o ksym.o \
-		ksym_mod.o ${LIBS}
+klogd:	klogd.o syslog.o pidfile.o ksym.o
+	${CC} ${LDFLAGS} -o klogd klogd.o syslog.o pidfile.o ksym.o ${LIBS}
 
 syslog_tst: syslog_tst.o
 	${CC} ${LDFLAGS} -o syslog_tst syslog_tst.o
diff -Nru a/src/sysklogd-1.3-31/klogd.c b/src/sysklogd-1.3-31/klogd.c
--- a/src/sysklogd-1.3-31/klogd.c	Thu Dec  7 11:53:56 2000
+++ b/src/sysklogd-1.3-31/klogd.c	Thu Dec  7 11:53:56 2000
@@ -415,7 +415,6 @@
 	if (symbol_lookup) {
 		if ( reload_symbols > 1 )
 			InitKsyms(symfile);
-		InitMsyms();
 	}
 	reload_symbols = change_state = 0;
 	return;
@@ -1059,7 +1058,6 @@
 	{
 		if (symbol_lookup) {
 			InitKsyms(symfile);
-			InitMsyms();
 		}
 		if ( (logsrc = GetKernelLogSrc()) == kernel )
 			LogKernelLine();
@@ -1075,7 +1073,6 @@
 	logsrc = GetKernelLogSrc();
 	if (symbol_lookup) {
 		InitKsyms(symfile);
-		InitMsyms();
 	}
 
         /* The main loop. */
diff -Nru a/src/sysklogd-1.3-31/ksym.c b/src/sysklogd-1.3-31/ksym.c
--- a/src/sysklogd-1.3-31/ksym.c	Thu Dec  7 11:53:56 2000
+++ b/src/sysklogd-1.3-31/ksym.c	Thu Dec  7 11:53:56 2000
@@ -656,9 +656,6 @@
 		last = sym_array[lp].name;
 	}
 
-	if ( (last = LookupModuleSymbol(value, sym)) != (char *) 0 )
-		return(last);
-
 	return((char *) 0);
 }
 
@@ -749,7 +746,7 @@
 	 * open for patches.
 	 */
 	if ( i_am_paranoid &&
-	     (strstr(line, "Oops:") != (char *) 0) && !InitMsyms() )
+	     (strstr(line, "Oops:") != (char *) 0) )
 		Syslog(LOG_WARNING, "Cannot load kernel module symbols.\n");
 	
 
diff -Nru a/src/sysklogd-1.3-31/ksyms.h b/src/sysklogd-1.3-31/ksyms.h
--- a/src/sysklogd-1.3-31/ksyms.h	Thu Dec  7 11:53:56 2000
+++ b/src/sysklogd-1.3-31/ksyms.h	Thu Dec  7 11:53:56 2000
@@ -32,4 +32,3 @@
 
 /* Function prototypes. */
 extern char * LookupSymbol(unsigned long, struct symbol *);
-extern char * LookupModuleSymbol(unsigned long int, struct symbol *);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
