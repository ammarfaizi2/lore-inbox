Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbULBQlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbULBQlT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 11:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbULBQlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 11:41:19 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:43241 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S261673AbULBQkH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 11:40:07 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-19
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <12808.195.245.190.93.1101992381.squirrel@195.245.190.93>
References: <17532.195.245.190.94.1101829198.squirrel@195.245.190.94>
	 <20041201103251.GA18838@elte.hu>
	 <32831.192.168.1.5.1101905229.squirrel@192.168.1.5>
	 <20041201154046.GA15244@elte.hu> <20041201160632.GA3018@elte.hu>
	 <20041201162034.GA8098@elte.hu>
	 <33059.192.168.1.5.1101927565.squirrel@192.168.1.5>
	 <20041201212925.GA23410@elte.hu> <20041201213023.GA23470@elte.hu>
	 <32788.192.168.1.8.1101938057.squirrel@192.168.1.8>
	 <20041201220916.GA24992@elte.hu>
	 <32786.192.168.1.5.1101940309.squirrel@192.168.1.5>
	 <47441.195.245.190.94.1101978748.squirrel@195.245.190.94>
	 <12808.195.245.190.93.1101992381.squirrel@195.245.190.93>
Content-Type: multipart/mixed; boundary="=-5jLUtqj34/AthP/Z0hFF"
Organization: 
Message-Id: <1102005486.7229.4.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Dec 2004 08:38:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5jLUtqj34/AthP/Z0hFF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2004-12-02 at 04:59, Rui Nuno Capela wrote:
> >
> > Next step is really trying to increase the stress and look after when it
> > will break apart. It will not take too long...
> >
> > First attempts, by just increasing the client count from 16 to 20, are
> > leading to what will be the next "horror show" :) CPU tops above 90%, and
> > after a couple of minutes running steadly it enters into some kind of
> > turbulence and hangs. Yeah, it just freezes completely.
> >
> > So I guess we're having a lot more food to mangle ;)
> >
> 
> After a bit of investigation, I've found some evidence that the "horror
> show" is primarily due to XRUN fprintf stderr storm. If I simply remove
> that fprintf line from jack/drivers/alsa/alsa_driver.c (around line 1084),
> I can run more than 20 jack_test3_client's without hosing the system.
> 
> Most probably, the main issue is about fprintf(stderr) being called in a
> RT thread context. 

Yes, that's what's happening. I've been seeing this for a while under
very high loads. 

> This is a jackd issue, not of RT kernel's. I remember
> there's a jack patch, somewhere in the limbo, for queing all printable
> messages out of the jackd RT threads.

There is one I created a while ago, I'm attaching it. It has not been
made part of jack because a proper patch is needed (this one does not
cover all possible uses of printf, the VERBOSE macro itself should be
changed, and apparently it should be made thread safe - but I'm using
this in production machines without problems and it covers the most
obnoxious uses of printf). 

> I think I'm urging for that patch right now, even though I'm probably
> pushing all this pressure into real/physical/hard limits ;) OK. I'll look
> if I can take that back from the jackit-devel archives and see what I can
> do about it.
>
> Back to a latency-trace enabled RT-0V0.7.31-19, and a patched jackd
> 0.99.17cvs, I've trapped some more traces (on attachment). These were
> taken while running some jack_test3 with light stress (10~12 clients, 4
> ports each).

Rui: [MANY] thanks for the amazing job of tracking stuff you are
doing...

-- Fernando


--=-5jLUtqj34/AthP/Z0hFF
Content-Disposition: attachment; filename=jack-0.99.0-messagebuffer.patch
Content-Type: text/x-patch; name=jack-0.99.0-messagebuffer.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -uNr jack-audio-connection-kit-0.98.8-orig/jackd/engine.c jack-audio-connection-kit-0.98.8/jackd/engine.c
--- jack-audio-connection-kit-0.98.8-orig/jackd/engine.c	2004-08-11 12:57:49.175398640 -0700
+++ jack-audio-connection-kit-0.98.8/jackd/engine.c	2004-08-11 13:46:26.275931952 -0700
@@ -58,6 +58,7 @@
 #endif
 
 #include "transengine.h"
+#include "message_buffer.h"
 
 #define JACK_ERROR_WITH_SOCKETS 10000000
 
@@ -687,20 +687,20 @@
 	now = jack_get_microseconds ();
 
 	if (status != 0) {
-		VERBOSE (engine, "at %" PRIu64
-			 " waiting on %d for %" PRIu64
-			 " usecs, status = %d sig = %" PRIu64
-			 " awa = %" PRIu64 " fin = %" PRIu64
-			 " dur=%" PRIu64 "\n",
-			 now,
-			 client->subgraph_wait_fd,
-			 now - then,
-			 status,
-			 ctl->signalled_at,
-			 ctl->awake_at,
-			 ctl->finished_at,
-			 ctl->finished_at? (ctl->finished_at -
-					    ctl->signalled_at): 0);
+		MB_VERBOSE (engine, "at %" PRIu64
+			    " waiting on %d for %" PRIu64
+			    " usecs, status = %d sig = %" PRIu64
+			    " awa = %" PRIu64 " fin = %" PRIu64
+			    " dur=%" PRIu64 "\n",
+			    now,
+			    client->subgraph_wait_fd,
+			    now - then,
+			    status,
+			    ctl->signalled_at,
+			    ctl->awake_at,
+			    ctl->finished_at,
+			    ctl->finished_at? (ctl->finished_at -
+					       ctl->signalled_at): 0);
 
 		/* we can only consider the timeout a client error if
 		 * it actually woke up.  its possible that the kernel
@@ -819,9 +820,9 @@
 				 engine->driver->period_usecs)) * 50.0f
 			+ (engine->control->cpu_load * 0.5f);
 
-		VERBOSE (engine, "load = %.4f max usecs: %.3f, "
-			 "spare = %.3f\n", engine->control->cpu_load,
-			 max_usecs, engine->spare_usecs);
+		MB_VERBOSE (engine, "load = %.4f max usecs: %.3f, "
+			    "spare = %.3f\n", engine->control->cpu_load,
+			    max_usecs, engine->spare_usecs);
 	}
 
 }
@@ -921,13 +921,13 @@
 			    ctl->state > NotTriggered &&
 			    ctl->state != Finished &&
 			    ctl->timed_out++) {
-				VERBOSE(engine, "client %s error: awake_at = %"
-					 PRIu64
-					 " state = %d timed_out = %d\n",
-					 ctl->name,
-					 ctl->awake_at,
-					 ctl->state,
-					 ctl->timed_out);
+				MB_VERBOSE(engine, "client %s error: awake_at = %"
+					   PRIu64
+					   " state = %d timed_out = %d\n",
+					   ctl->name,
+					   ctl->awake_at,
+					   ctl->state,
+					   ctl->timed_out);
 				client->error++;
 			}
 		}
@@ -2374,9 +2374,9 @@
 	    engine->spare_usecs &&
 	    ((WORK_SCALE * engine->spare_usecs) <= delayed_usecs)) {
 
-		fprintf (stderr, "delay of %.3f usecs exceeds estimated spare"
-			 " time of %.3f; restart ...\n",
-			 delayed_usecs, WORK_SCALE * engine->spare_usecs);
+		MB_MESSAGE ("delay of %.3f usecs exceeds estimated spare"
+			    " time of %.3f; restart ...\n",
+			    delayed_usecs, WORK_SCALE * engine->spare_usecs);
 		
 		if (++consecutive_excessive_delays > 10) {
 			jack_error ("too many consecutive interrupt delays "
@@ -2448,9 +2448,9 @@
 
 	if (engine->verbose) {
 		if (nframes != b_size) { 
-			VERBOSE (engine, 
-				"late driver wakeup: nframes to process = %"
-				PRIu32 ".\n", nframes);
+			MB_VERBOSE (engine, 
+				    "late driver wakeup: nframes to process = %"
+				    PRIu32 ".\n", nframes);
 		}
 	}
 
@@ -2677,8 +2677,8 @@
 static void
 jack_zombify_client (jack_engine_t *engine, jack_client_internal_t *client)
 {
-	VERBOSE (engine, "removing client \"%s\" from the processing chain\n",
-		 client->control->name);
+	MB_VERBOSE (engine, "removing client \"%s\" from the processing chain\n",
+		    client->control->name);
 
 	/* caller must hold the client_lock */
 
@@ -2698,7 +2698,7 @@
 
 	/* caller must hold the client_lock */
 
-	VERBOSE (engine, "removing client \"%s\"\n", client->control->name);
+	MB_VERBOSE (engine, "removing client \"%s\"\n", client->control->name);
 
 	/* if its not already a zombie, make it so */
 
@@ -2956,7 +2956,7 @@
 
 	subgraph_client = 0;
 
-	VERBOSE(engine, "++ jack_rechain_graph():\n");
+	MB_VERBOSE(engine, "++ jack_rechain_graph():\n");
 
 	event.type = GraphReordered;
 
@@ -3000,20 +3000,20 @@
 				if (subgraph_client) {
 					subgraph_client->subgraph_wait_fd =
 						jack_get_fifo_fd (engine, n);
-					VERBOSE (engine, "client %s: wait_fd="
-						 "%d, execution_order="
-						 "%lu.\n", 
-						 subgraph_client->
-						 control->name,
-						 subgraph_client->
-						 subgraph_wait_fd, n);
+					MB_VERBOSE (engine, "client %s: wait_fd="
+						    "%d, execution_order="
+						    "%lu.\n", 
+						    subgraph_client->
+						    control->name,
+						    subgraph_client->
+						    subgraph_wait_fd, n);
 					n++;
 				}
 
-				VERBOSE (engine, "client %s: internal "
-					 "client, execution_order="
-					 "%lu.\n", 
-					 client->control->name, n);
+				MB_VERBOSE (engine, "client %s: internal "
+					    "client, execution_order="
+					    "%lu.\n", 
+					    client->control->name, n);
 
 				/* this does the right thing for
 				 * internal clients too 
@@ -3036,13 +3036,13 @@
 					subgraph_client = client;
 					subgraph_client->subgraph_start_fd =
 						jack_get_fifo_fd (engine, n);
-					VERBOSE (engine, "client %s: "
-						 "start_fd=%d, execution"
-						 "_order=%lu.\n",
-						 subgraph_client->
-						 control->name,
-						 subgraph_client->
-						 subgraph_start_fd, n);
+					MB_VERBOSE (engine, "client %s: "
+						    "start_fd=%d, execution"
+						    "_order=%lu.\n",
+						    subgraph_client->
+						    control->name,
+						    subgraph_client->
+						    subgraph_start_fd, n);
 					
 					/* this external client after this will have
 					   jackd as its upstream connection.
@@ -3052,13 +3052,13 @@
 
 				} 
 				else {
-					VERBOSE (engine, "client %s: in"
-						 " subgraph after %s, "
-						 "execution_order="
-						 "%lu.\n",
-						 client->control->name,
-						 subgraph_client->
-						 control->name, n);
+					MB_VERBOSE (engine, "client %s: in"
+						    " subgraph after %s, "
+						    "execution_order="
+						    "%lu.\n",
+						    client->control->name,
+						    subgraph_client->
+						    control->name, n);
 					subgraph_client->subgraph_wait_fd = -1;
 					
 					/* this external client after this will have
@@ -3084,7 +3084,7 @@
 	if (subgraph_client) {
 		subgraph_client->subgraph_wait_fd =
 			jack_get_fifo_fd (engine, n);
-		VERBOSE (engine, "client %s: wait_fd=%d, "
+		MB_VERBOSE (engine, "client %s: wait_fd=%d, "
 			 "execution_order=%lu (last client).\n", 
 			 subgraph_client->control->name,
 			 subgraph_client->subgraph_wait_fd, n);
@@ -3513,9 +3513,9 @@
 		jack_unlock_graph (engine);
 		return -1;
 	} else {
-		VERBOSE (engine, "connect %s and %s\n",
-			 srcport->shared->name,
-			 dstport->shared->name);
+		MB_VERBOSE (engine, "connect %s and %s\n",
+			    srcport->shared->name,
+			    dstport->shared->name);
 
 		dstport->connections =
 			jack_slist_prepend (dstport->connections, connection);
@@ -3560,9 +3560,9 @@
 		if (connect->source == srcport &&
 		    connect->destination == dstport) {
 
-			VERBOSE (engine, "DIS-connect %s and %s\n",
-				 srcport->shared->name,
-				 dstport->shared->name);
+			MB_VERBOSE (engine, "DIS-connect %s and %s\n",
+				    srcport->shared->name,
+				    dstport->shared->name);
 			
 			srcport->connections =
 				jack_slist_remove (srcport->connections,
@@ -3616,8 +3616,8 @@
 		return -1;
 	}
 
-	VERBOSE (engine, "clear connections for %s\n",
-		 engine->internal_ports[port_id].shared->name);
+	MB_VERBOSE (engine, "clear connections for %s\n",
+		    engine->internal_ports[port_id].shared->name);
 
 	jack_lock_graph (engine);
 	jack_port_clear_connections (engine, &engine->internal_ports[port_id]);
@@ -3894,8 +3894,8 @@
 	jack_port_registration_notify (engine, port_id, TRUE);
 	jack_unlock_graph (engine);
 
-	VERBOSE (engine, "registered port %s, offset = %u\n",
-		 shared->name, (unsigned int)shared->offset);
+	MB_VERBOSE (engine, "registered port %s, offset = %u\n",
+		    shared->name, (unsigned int)shared->offset);
 
 	req->x.port_info.port_id = port_id;
 
diff -uNr jack-audio-connection-kit-0.98.8-orig/jackd/jackd.c jack-audio-connection-kit-0.98.8/jackd/jackd.c
--- jack-audio-connection-kit-0.98.8-orig/jackd/jackd.c	2004-08-11 12:57:49.251387088 -0700
+++ jack-audio-connection-kit-0.98.8/jackd/jackd.c	2004-08-11 13:17:25.632549968 -0700
@@ -39,6 +39,8 @@
 #include <jack/shm.h>
 #include <jack/driver_parse.h>
 
+#include "message_buffer.h"
+
 #ifdef USE_CAPABILITIES
 
 #include <sys/stat.h>
@@ -170,6 +172,9 @@
 			sigaction (i, &action, 0);
 		} 
 	}
+
+	/* start a thread to display messages from realtime threads */
+	mb_init("");
 	
 	if (verbose) {
 		fprintf (stderr, "%d waiting for signals\n", getpid());
diff -uNr jack-audio-connection-kit-0.98.8-orig/jackd/Makefile.am jack-audio-connection-kit-0.98.8/jackd/Makefile.am
--- jack-audio-connection-kit-0.98.8-orig/jackd/Makefile.in	2004-04-06 21:52:58.000000000 -0700
+++ jack-audio-connection-kit-0.98.8/jackd/Makefile.in	2004-08-11 13:17:25.843517896 -0700
@@ -55,7 +55,7 @@
 binPROGRAMS_INSTALL = $(INSTALL_PROGRAM)
 PROGRAMS = $(bin_PROGRAMS)
 am_jackd_OBJECTS = jackd.$(OBJEXT) engine.$(OBJEXT) \
-	transengine.$(OBJEXT)
+	transengine.$(OBJEXT) message_buffer.$(OBJEXT)
 jackd_OBJECTS = $(am_jackd_OBJECTS)
 am__DEPENDENCIES_1 =
 jackd_DEPENDENCIES = ../libjack/libjack.la $(am__DEPENDENCIES_1)
@@ -236,9 +236,9 @@
 @USE_CAPABILITIES_FALSE@CAP_LIBS = 
 @USE_CAPABILITIES_TRUE@CAP_LIBS = -lcap
 AM_CFLAGS = $(JACK_CFLAGS) -DJACK_LOCATION=\"$(bindir)\"
-jackd_SOURCES = jackd.c engine.c transengine.c
+jackd_SOURCES = jackd.c engine.c transengine.c message_buffer.c
 jackd_LDADD = ../libjack/libjack.la $(CAP_LIBS) @OS_LDFLAGS@
-noinst_HEADERS = jack_md5.h md5.h md5_loc.h transengine.h
+noinst_HEADERS = jack_md5.h md5.h md5_loc.h transengine.h message_buffer.h
 BUILT_SOURCES = jack_md5.h
 jackstart_SOURCES = jackstart.c md5.c
 jackstart_LDFLAGS = -lcap
diff -uNr jack-audio-connection-kit-0.98.8-orig/jackd/message_buffer.c jack-audio-connection-kit-0.98.8/jackd/message_buffer.c
--- jack-audio-connection-kit-0.98.8-orig/jackd/message_buffer.c	1969-12-31 16:00:00.000000000 -0800
+++ jack-audio-connection-kit-0.98.8/jackd/message_buffer.c	2004-06-21 17:47:26.000000000 -0700
@@ -0,0 +1,56 @@
+/* -*- c-basic-offset: 4 -*-  vi:set ts=8 sts=4 sw=4: */
+
+/* message_buffer.c
+
+   This file is in the public domain.
+*/
+
+#include <unistd.h>
+#include <string.h>
+#include <pthread.h>
+#include <stdio.h>
+
+#define BUFFERS      16		/* must be 2^n */
+#define BUFFER_SIZE 256
+
+static char buffer[BUFFERS][BUFFER_SIZE];
+static const char *mb_prefix;
+static unsigned int initialised = 0;
+static unsigned int in_buffer = 0;
+static unsigned int out_buffer = 0;
+static pthread_t writer_thread;
+
+void *mb_thread_func(void *arg);
+
+void add_message(const char *msg)
+{
+    strncpy(buffer[in_buffer], msg, BUFFER_SIZE - 1);
+    in_buffer = (in_buffer + 1) & (BUFFERS - 1);
+}
+
+void mb_init(const char *prefix)
+{
+    if (initialised) {
+	return;
+    }
+    mb_prefix = prefix;
+
+    pthread_create(&writer_thread, NULL, &mb_thread_func, NULL);
+
+    initialised = 1;
+}
+
+void *mb_thread_func(void *arg)
+{
+    while (1) {
+	while (out_buffer != in_buffer) {
+	    fprintf(stderr, "%s%s", mb_prefix, buffer[out_buffer]);
+	    out_buffer = (out_buffer + 1) & (BUFFERS - 1);
+	}
+	usleep(1000);
+    }
+
+    return NULL;
+}
+
+/* vi:set ts=8 sts=4 sw=4: */
diff -uNr jack-audio-connection-kit-0.98.8-orig/jackd/message_buffer.h jack-audio-connection-kit-0.98.8/jackd/message_buffer.h
--- jack-audio-connection-kit-0.98.8-orig/jackd/message_buffer.h	1969-12-31 16:00:00.000000000 -0800
+++ jack-audio-connection-kit-0.98.8/jackd/message_buffer.h	2004-08-11 13:41:21.696235104 -0700
@@ -0,0 +1,30 @@
+/* -*- c-basic-offset: 4 -*-  vi:set ts=8 sts=4 sw=4: */
+
+/* message_buffer.h
+
+   This file is in the public domain.
+*/
+
+#ifndef MESSAGE_BUFFER_H
+#define MESSAGE_BUFFER_H
+
+#define MB_MESSAGE(fmt...) { \
+	char _m[256]; \
+	snprintf(_m, 255, fmt); \
+	add_message(_m); \
+}
+
+#define MB_VERBOSE(engine,format,args...)   \
+    if ((engine)->verbose) {		    \
+	char _m[256];			    \
+	snprintf(_m, 255, format, ## args); \
+	add_message(_m);		    \
+    }
+
+void mb_init(const char *prefix);
+
+void add_message(const char *msg);
+
+#endif
+
+/* vi:set ts=8 sts=4 sw=4: */

--=-5jLUtqj34/AthP/Z0hFF--

