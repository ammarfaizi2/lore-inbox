Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131428AbQLLBoo>; Mon, 11 Dec 2000 20:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131444AbQLLBod>; Mon, 11 Dec 2000 20:44:33 -0500
Received: from dryline-fw.wireless-sys.com ([216.126.67.45]:31514 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S131428AbQLLBoU>; Mon, 11 Dec 2000 20:44:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14901.31690.961664.201896@somanetworks.com>
Date: Mon, 11 Dec 2000 20:13:46 -0500 (EST)
From: "Georg Nikodym" <georgn@somanetworks.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: georgn@somanetworks.com, linux-kernel@vger.kernel.org,
        greg@wind.enjellic.com, sct@redhat.com,
        Linus Torvalds <torvalds@transmeta.com>,
        "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: linux-2.4.0-test11 and sysklogd-1.3-31 
In-Reply-To: <4977.976313761@ocs3.ocs-net>
In-Reply-To: <14897.3214.38818.625199@somanetworks.com>
	<4977.976313761@ocs3.ocs-net>
X-Mailer: VM 6.75 under 21.2  (beta37) "Pan" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "KO" == Keith Owens <kaos@ocs.com.au> writes:

 KO> klogd maps the kernel messages from <n>text to syslog levels and
 KO> does some fiddling with kernel log levels at start up.  It needs
 KO> to be more than a simple 'cat'.  When symbol handling was added
 KO> to klogd, ksymoops was built into the kernel and very unreliable.
 KO> Since then ksymoops has been moved to a separate package and is
 KO> now reliable.  Alas oops handling in sysklogd has not kept up to
 KO> date and is now the problem area.

Thanks for the background.

 KO> Linus, please do not apply.

 KO> User space applications _must_ not include kernel headers.  Even
 KO> modutils does not include linux/module.h, it has its own portable
 KO> (kernels 2.0 - 2.4) version.

 KO> I have strongly recommended to the sysklogd maintainers that they
 KO> strip all the symbol handling from klogd.  The oops decoding in
 KO> klogd is hopelessly out of date and broken.

Here's a patch (against sysklogd-1.3-31) that completely tear out the
symbol processing code.

Additionally, after application, the following files may be removed:

	ksyms.h
	ksym.c
	ksym_mod.c


diff -Nru a/src/sysklogd-1.3-31/Makefile b/src/sysklogd-1.3-31/Makefile
--- a/src/sysklogd-1.3-31/Makefile	Mon Dec 11 19:32:22 2000
+++ b/src/sysklogd-1.3-31/Makefile	Mon Dec 11 19:32:22 2000
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
--- a/src/sysklogd-1.3-31/klogd.c	Mon Dec 11 19:32:22 2000
+++ b/src/sysklogd-1.3-31/klogd.c	Mon Dec 11 19:32:22 2000
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
--- a/src/sysklogd-1.3-31/ksym.c	Mon Dec 11 19:32:22 2000
+++ b/src/sysklogd-1.3-31/ksym.c	Mon Dec 11 19:32:22 2000
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
--- a/src/sysklogd-1.3-31/ksyms.h	Mon Dec 11 19:32:23 2000
+++ b/src/sysklogd-1.3-31/ksyms.h	Mon Dec 11 19:32:23 2000
@@ -32,4 +32,3 @@
 
 /* Function prototypes. */
 extern char * LookupSymbol(unsigned long, struct symbol *);
-extern char * LookupModuleSymbol(unsigned long int, struct symbol *);
diff -Nru a/src/sysklogd-1.3-31/klogd.8 b/src/sysklogd-1.3-31/klogd.8
--- a/src/sysklogd-1.3-31/klogd.8	Mon Dec 11 19:32:23 2000
+++ b/src/sysklogd-1.3-31/klogd.8	Mon Dec 11 19:32:23 2000
@@ -3,6 +3,8 @@
 .\" Sun Jul 30 01:35:55 MET: Martin Schulze: Updates
 .\" Sun Nov 19 23:22:21 MET: Martin Schulze: Updates
 .\" Mon Aug 19 09:42:08 CDT 1996: Dr. G.W. Wettstein: Updates
+.\" Mon Dec 11 2000: Georg Nikodym: Removal of documentation related to
+.\"                  symbol resolution (the code has been removed).
 .\"
 .TH KLOGD 8 "24 November 1995" "Version 1.3" "Linux System Administration"
 .SH NAME
@@ -17,16 +19,10 @@
 .RB [ " \-f "
 .I fname
 ]
-.RB [ " \-iI " ]
 .RB [ " \-n " ]
 .RB [ " \-o " ]
-.RB [ " \-p " ]
 .RB [ " \-s " ]
-.RB [ " \-k "
-.I fname
-]
 .RB [ " \-v " ]
-.RB [ " \-x " ]
 .LP
 .SH DESCRIPTION
 .B klogd
@@ -45,12 +41,6 @@
 .BI "\-f " file
 Log messages to the specified filename rather than to the syslog facility.
 .TP
-.BI "\-i \-I"
-Signal the currently executing klogd daemon.  Both of these switches control
-the loading/reloading of symbol information.  The \-i switch signals the
-daemon to reload the kernel module symbols.  The \-I switch signals for a
-reload of both the static kernel symbols and the kernel module symbols.
-.TP
 .B "\-n"
 Avoid auto-backgrounding. This is needed especially if the
 .B klogd
@@ -62,24 +52,12 @@
 all the messages that are found in the kernel message buffers.  After
 a single read and log cycle the daemon exits.
 .TP
-.B "-p"
-Enable paranoia.  This option controls when klogd loads kernel module symbol
-information.  Setting this switch causes klogd to load the kernel module
-symbol information whenever an Oops string is detected in the kernel message
-stream.
-.TP
 .B "-s"
 Force \fBklogd\fP to use the system call interface to the kernel message
 buffers.
 .TP
-.BI "\-k " file
-Use the specified file as the source of kernel symbol information.
-.TP
 .B "\-v"
 Print version and exit.
-.TP
-.B "\-x"
-Omits EIP translation and there doesn't read the System.map.
 .LP
 .SH OVERVIEW
 The functionality of klogd has been typically incorporated into other
@@ -214,37 +192,6 @@
 .B ksymoops
 program which is included in the kernel sources.
 
-As a convenience
-.B klogd
-will attempt to resolve kernel numeric addresses to their symbolic
-forms if a kernel symbol table is available at execution time.  A
-symbol table may be specified by using the \fB\-k\fR switch on the
-command line.  If a symbol file is not explicitly specified the
-following filenames will be tried:
-
-.nf
-.I /boot/System.map
-.I /System.map
-.I /usr/src/linux/System.map
-.fi
-
-Version information is supplied in the system maps as of kernel
-1.3.43.  This version information is used to direct an intelligent
-search of the list of symbol tables.  This feature is useful since it
-provides support for both production and experimental kernels.
-
-For example a production kernel may have its map file stored in
-/boot/System.map.  If an experimental or test kernel is compiled with
-the sources in the 'standard' location of /usr/src/linux the system
-map will be found in /usr/src/linux/System.map.  When klogd starts
-under the experimental kernel the map in /boot/System.map will be
-bypassed in favor of the map in /usr/src/linux/System.map.
-
-Modern kernels as of 1.3.43 properly format important kernel addresses
-so that they will be recognized and translated by klogd.  Earlier
-kernels require a source code patch be applied to the kernel sources.
-This patch is supplied with the sysklogd sources.
-
 The process of analyzing kernel protections faults works very well
 with a static kernel.  Additional difficulties are encountered when
 attempting to diagnose errors which occur in loadable kernel modules.
@@ -262,70 +209,6 @@
 loadable module.  Without this location map it is not possible for a
 kernel developer to determine what went wrong if a protection fault
 involves a kernel module.
-
-.B klogd
-has support for dealing with the problem of diagnosing protection
-faults in kernel loadable modules.  At program start time or in
-response to a signal the daemon will interrogate the kernel for a
-listing of all modules loaded and the addresses in memory they are
-loaded at.  Individual modules can also register the locations of
-important functions when the module is loaded.  The addresses of these
-exported symbols are also determined during this interrogation
-process.
-
-When a protection fault occurs an attempt will be made to resolve
-kernel addresses from the static symbol table.  If this fails the
-symbols from the currently loaded modules are examined in an attempt
-to resolve the addresses.  At the very minimum this allows klogd to
-indicate which loadable module was responsible for generating the
-protection fault.  Additional information may be available if the
-module developer chose to export symbol information from the module.
-
-Proper and accurate resolution of addresses in kernel modules requires
-that
-.B klogd
-be informed whenever the kernel module status changes.  The
-.B \-i
-and
-.B \-I
-switches can be used to signal the currently executing daemon that
-symbol information be reloaded.  Of most importance to proper
-resolution of module symbols is the
-.B \-i
-switch.  Each time a kernel module is loaded or removed from the
-kernel the following command should be executed:
-
-.nf
-.I klogd \-i
-.fi
-
-The
-.B \-p
-switch can also be used to insure that module symbol information is up
-to date.  This switch instructs
-.B klogd
-to reload the module symbol information whenever a protection fault
-is detected.  Caution should be used before invoking the program in
-\'paranoid\' mode.  The stability of the kernel and the operating
-environment is always under question when a protection fault occurs.
-Since the klogd daemon must execute system calls in order to read the
-module symbol information there is the possibility that the system may
-be too unstable to capture useful information.  A much better policy
-is to insure that klogd is updated whenever a module is loaded or
-unloaded.  Having uptodate symbol information loaded increases the
-probability of properly resolving a protection fault if it should occur.
-
-Included in the sysklogd source distribution is a patch to the
-modules-2.0.0 package which allows the
-.B insmod,
-.B rmmod
-and
-.B modprobe
-utilities to automatically signal
-.B klogd
-whenever a module is inserted or removed from the kernel.  Using this
-patch will insure that the symbol information maintained in klogd is
-always consistent with the current kernel state.
 .PP
 .SH SIGNAL HANDLING
 The 
@@ -363,26 +246,6 @@
 .B LOG_INFO
 priority
 documenting the start/stop of logging.
-
-The 
-.BR SIGUSR1 " and " SIGUSR2
-signals are used to initiate loading/reloading of kernel symbol information.
-Receipt of the
-.B SIGUSR1
-signal will cause the kernel module symbols to be reloaded.  Signaling the
-daemon with
-.B SIGUSR2
-will cause both the static kernel symbols and the kernel module symbols to
-be reloaded.
-
-Provided that the System.map file is placed in an appropriate location the
-signal of generally greatest usefulness is the
-.B SIGUSR1
-signal.  This signal is designed to be used to signal the daemon when kernel
-modules are loaded/unloaded.  Sending this signal to the daemon after a
-kernel module state change will insure that proper resolution of symbols will
-occur if a protection fault occurs in the address space occupied by a kernel
-module.
 .LP
 .SH FILES
 .PD 0
diff -Nru a/src/sysklogd-1.3-31/klogd.c b/src/sysklogd-1.3-31/klogd.c
--- a/src/sysklogd-1.3-31/klogd.c	Mon Dec 11 19:32:23 2000
+++ b/src/sysklogd-1.3-31/klogd.c	Mon Dec 11 19:32:23 2000
@@ -213,6 +213,10 @@
  *	Shortened LOG_LINE_LENGTH in order to get long lines splitted
  *	up earlier and syslogd has a better chance concatenating them
  *	together again.
+ *
+ * Mon Dec 11, 2000: Georg Nikodym <georgn@somanetworks.com>
+ *	Removed all support for symbol resolution at the suggestion of
+ *	Keith Owens.
  */
 
 
@@ -229,7 +233,6 @@
 #include <paths.h>
 #include <stdlib.h>
 #include "klogd.h"
-#include "ksyms.h"
 #ifndef TESTING
 #include "pidfile.h"
 #endif
@@ -260,16 +263,13 @@
 		change_state = 0,
 		terminate = 0,
 		caught_TSTP = 0,
-		reload_symbols = 0,
 		console_log_level = 6;
 
 static int	use_syscall = 0,
 		one_shot = 0,
-		symbol_lookup = 1,
 		no_fork = 0;	/* don't fork - don't run in daemon mode */
 
-static char	*symfile = (char *) 0,
-		log_buffer[LOG_BUFFER_SIZE];
+static char	log_buffer[LOG_BUFFER_SIZE];
 
 static FILE *output_file = (FILE *) 0;
 
@@ -287,7 +287,6 @@
 extern void reload_daemon(int sig);
 static void Terminate(void);
 static void SignalDaemon(int);
-static void ReloadSymbols(void);
 static void ChangeLogging(void);
 static enum LOGSRC GetKernelLogSrc(void);
 static void LogLine(char *ptr, int len);
@@ -363,12 +362,10 @@
 
 {
 	change_state = 1;
-	reload_symbols = 1;
 
 
 	if ( sig == SIGUSR2 )
 	{
-		++reload_symbols;
 		signal(SIGUSR2, reload_daemon);
 	}
 	else
@@ -409,17 +406,6 @@
 }
 
 
-static void ReloadSymbols()
-
-{
-	if (symbol_lookup) {
-		if ( reload_symbols > 1 )
-			InitKsyms(symfile);
-	}
-	reload_symbols = change_state = 0;
-	return;
-}
-
 
 static void ChangeLogging(void)
 
@@ -432,13 +418,6 @@
 	Syslog(LOG_INFO, "klogd %s-%s, ---------- state change ----------\n", \
 	       VERSION, PATCHLEVEL);
 
-	/* Reload symbols. */
-	if ( reload_symbols > 0 )
-	{
-		ReloadSymbols();
-		return;
-	}
-
 	/* Stop kernel logging. */
 	if ( caught_TSTP == 1 )
 	{
@@ -627,24 +606,11 @@
 /*
  * Messages are separated by "\n".  Messages longer than
  * LOG_LINE_LENGTH are broken up.
- *
- * Kernel symbols show up in the input buffer as : "[<aaaaaa>]",
- * where "aaaaaa" is the address.  These are replaced with
- * "[symbolname+offset/size]" in the output line - symbolname,
- * offset, and size come from the kernel symbol table.
- *
- * If a kernel symbol happens to fall at the end of a message close
- * in length to LOG_LINE_LENGTH, the symbol will not be expanded.
- * (This should never happen, since the kernel should never generate
- * messages that long.
  */
 static void LogLine(char *ptr, int len)
 {
     enum parse_state_enum {
-        PARSING_TEXT,
-        PARSING_SYMSTART,      /* at < */
-        PARSING_SYMBOL,        
-        PARSING_SYMEND         /* at ] */
+        PARSING_TEXT
     };
 
     static char line_buff[LOG_LINE_LENGTH];
@@ -653,8 +619,6 @@
     static enum parse_state_enum parse_state = PARSING_TEXT;
     static int space                         = sizeof(line_buff)-1;
 
-    static char *sym_start;            /* points at the '<' of a symbol */
-
     auto   int delta = 0;              /* number of chars copied        */
 
     while( len > 0 )
@@ -678,165 +642,53 @@
             parse_state = PARSING_TEXT;
         }
 
-        switch( parse_state )
-        {
-        case PARSING_TEXT:
-               delta = copyin( line, space, ptr, len, "\n[%" );
-               line  += delta;
-               ptr   += delta;
-               space -= delta;
-               len   -= delta;
-
-               if( space == 0 || len == 0 )
-               {
-		  break;  /* full line_buff or end of input buffer */
-               }
-
-               if( *ptr == '\n' )  /* newline */
-               {
-                  *line++ = *ptr++;  /* copy it in */
-                  space -= 1;
-                  len   -= 1;
-
-                  *line = 0;  /* force null terminator */
-	          Syslog( LOG_INFO, line_buff );
-                  line  = line_buff;
-                  space = sizeof(line_buff)-1;
-                  break;
-               }
-               if( *ptr == '[' )   /* possible kernel symbol */
-               {
-                  *line++ = *ptr++;
-                  space -= 1;
-                  len   -= 1;
-                  parse_state = PARSING_SYMSTART;      /* at < */
-                  break;
-               }
-               if( *ptr == '%' )   /* dangerous printf marker */
-	       {
-		   delta = 0;
-		   while (len && *ptr == '%')
-		   {
-		       *line++ = *ptr++;	/* copy it in */
-		       space -= 1;
-		       len   -= 1;
-		       delta++;
-		   }
-		   if (delta % 2)	/* odd amount of %'s */
-		   {
-		       if (space)
-		       {
-			   *line++ = '%';	/* so simply add one */
-			   space -= 1;
-		       }
-		       else 
-		       {
-			   *line++ = '\0';	/* remove the last one / terminate the string */
-		       }
-
-		   }
-	       }
-               break;
-        
-        case PARSING_SYMSTART:
-               if( *ptr != '<' )
-               {
-                  parse_state = PARSING_TEXT;        /* not a symbol */
-                  break;
-               }
-
-               /*
-               ** Save this character for now.  If this turns out to
-               ** be a valid symbol, this char will be replaced later.
-               ** If not, we'll just leave it there.
-               */
-
-               sym_start = line; /* this will point at the '<' */
-
-               *line++ = *ptr++;
-               space -= 1;
-               len   -= 1;
-               parse_state = PARSING_SYMBOL;     /* symbol... */
-               break;
-
-        case PARSING_SYMBOL:
-               delta = copyin( line, space, ptr, len, ">\n[" );
-               line  += delta;
-               ptr   += delta;
-               space -= delta;
-               len   -= delta;
-               if( space == 0 || len == 0 )
-               {
-                  break;  /* full line_buff or end of input buffer */
-               }
-               if( *ptr != '>' )
-               {
-                  parse_state = PARSING_TEXT;
-                  break;
-               }
-
-               *line++ = *ptr++;  /* copy the '>' */
-               space -= 1;
-               len   -= 1;
-
-               parse_state = PARSING_SYMEND;
-
-               break;
-
-        case PARSING_SYMEND:
-               if( *ptr != ']' )
-               {
-                  parse_state = PARSING_TEXT;        /* not a symbol */
-                  break;
-               }
-
-               /*
-               ** It's really a symbol!  Replace address with the
-               ** symbol text.
-               */
-           {
-	       auto int sym_space;
-
-	       unsigned long value;
-	       auto struct symbol sym;
-	       auto char *symbol;
-
-               *(line-1) = 0;    /* null terminate the address string */
-               value  = strtoul(sym_start+1, (char **) 0, 16);
-               *(line-1) = '>';  /* put back delim */
-
-               symbol = LookupSymbol(value, &sym);
-               if ( !symbol_lookup || symbol == (char *) 0 )
-               {
-                  parse_state = PARSING_TEXT;
-                  break;
-               }
-
-               /*
-               ** verify there is room in the line buffer
-               */
-               sym_space = space + ( line - sym_start );
-               if( sym_space < strlen(symbol) + 30 ) /*(30 should be overkill)*/
-               {
-                  parse_state = PARSING_TEXT;  /* not enough space */
-                  break;
-               }
-
-               delta = sprintf( sym_start, "%s+%d/%d]",
-                                symbol, sym.offset, sym.size );
-
-               space = sym_space + delta;
-               line  = sym_start + delta;
-           }
-               ptr++;
-               len--;
-               parse_state = PARSING_TEXT;
-               break;
-
-        default: /* Can't get here! */
-               parse_state = PARSING_TEXT;
+	delta = copyin( line, space, ptr, len, "\n%" );
+	line  += delta;
+	ptr   += delta;
+	space -= delta;
+	len   -= delta;
+
+	if( space == 0 || len == 0 )
+	{
+	   break;  /* full line_buff or end of input buffer */
+	}
+
+	if( *ptr == '\n' )  /* newline */
+	{
+	   *line++ = *ptr++;  /* copy it in */
+	   space -= 1;
+	   len   -= 1;
+
+	   *line = 0;  /* force null terminator */
+	   Syslog( LOG_INFO, line_buff );
+	   line  = line_buff;
+	   space = sizeof(line_buff)-1;
+	   break;
+	}
+	if( *ptr == '%' )   /* dangerous printf marker */
+	{
+	   delta = 0;
+	   while (len && *ptr == '%')
+	   {
+	      *line++ = *ptr++;	/* copy it in */
+	      space -= 1;
+	      len   -= 1;
+	      delta++;
+	   }
+	   if (delta % 2)	/* odd amount of %'s */
+	   {
+	      if (space)
+	      {
+		 *line++ = '%';	/* so simply add one */
+		 space -= 1;
+	      }
+	      else 
+	      {
+		 *line++ = '\0';	/* remove the last one / terminate the string */
+	      }
 
-        }
+	   }
+	}
     }
 
     return;
@@ -911,7 +763,7 @@
 	chdir ("/");
 #endif
 	/* Parse the command-line. */
-	while ((ch = getopt(argc, argv, "c:df:iIk:nopsvx")) != EOF)
+	while ((ch = getopt(argc, argv, "c:df:nosv")) != EOF)
 		switch((char)ch)
 		{
 		    case 'c':		/* Set console message level. */
@@ -924,33 +776,18 @@
 			output = optarg;
 			use_output++;
 			break;
-		    case 'i':		/* Reload module symbols. */
-			SignalDaemon(SIGUSR1);
-			return(0);
-		    case 'I':
-			SignalDaemon(SIGUSR2);
-			return(0);
-		    case 'k':		/* Kernel symbol file. */
-			symfile = optarg;
-			break;
 		    case 'n':		/* don't fork */
 			no_fork++;
 			break;
 		    case 'o':		/* One-shot mode. */
 			one_shot = 1;
 			break;
-		    case 'p':
-			SetParanoiaLevel(1);	/* Load symbols on oops. */
-			break;	
 		    case 's':		/* Use syscall interface. */
 			use_syscall = 1;
 			break;
 		    case 'v':
 			printf("klogd %s-%s\n", VERSION, PATCHLEVEL);
 			exit (1);
-		    case 'x':
-			symbol_lookup = 0;
-			break;
 		}
 
 
@@ -1056,9 +893,6 @@
 	/* Handle one-shot logging. */
 	if ( one_shot )
 	{
-		if (symbol_lookup) {
-			InitKsyms(symfile);
-		}
 		if ( (logsrc = GetKernelLogSrc()) == kernel )
 			LogKernelLine();
 		else
@@ -1071,9 +905,6 @@
 	sleep(KLOGD_DELAY);
 #endif
 	logsrc = GetKernelLogSrc();
-	if (symbol_lookup) {
-		InitKsyms(symfile);
-	}
 
         /* The main loop. */
 	while (1)
diff -Nru a/src/sysklogd-1.3-31/klogd.h b/src/sysklogd-1.3-31/klogd.h
--- a/src/sysklogd-1.3-31/klogd.h	Mon Dec 11 19:32:23 2000
+++ b/src/sysklogd-1.3-31/klogd.h	Mon Dec 11 19:32:23 2000
@@ -33,8 +33,4 @@
 
 
 /* Function prototypes. */
-extern int InitKsyms(char *);
-extern int InitMsyms(void);
-extern char * ExpandKadds(char *, char *);
-extern void SetParanoiaLevel(int);
 extern void Syslog(int priority, char *fmt, ...);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
