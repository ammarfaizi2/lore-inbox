Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265119AbUADExo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 23:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbUADExn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 23:53:43 -0500
Received: from mta13.mail.adelphia.net ([68.168.78.44]:60913 "EHLO
	mta13.adelphia.net") by vger.kernel.org with ESMTP id S265119AbUADExj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 23:53:39 -0500
Subject: PCMCIA lockups on HP Pavilion laptop
From: Aubin LaBrosse <arl8778@rit.edu>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-yrj9ajvOkwfo1pScc9Qw"
Message-Id: <1073191980.1505.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 03 Jan 2004 23:53:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yrj9ajvOkwfo1pScc9Qw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

I have an HP pavilion ze4145 laptop running fedora core 1 with arjanv's
2.6.0-1.109 kernel. I have recently purchased an SMC 2532W-B 802.11b
wireless card.  I am not sure that this is supported under linux, but
the problem I am having is rooted deeper than that:

when the redhat pcmcia script is run, the laptop locks up solid.  sysrq
is enabled but i have not tried it yet, i'd have to look up the keys and
what they do.  regardless, i have traced the problem to cardmgr itself,
cardctl works alright though it can't provide much info on the card.  I
have pcmcia modularized as is most of the redhat kernel, and the modules
pcmcia_core, yenta_socket and ds are loaded.  when cardmgr runs, it
locks the box up when it is inside the adjust_resources function in
cardmgr.c - at least on this 2.6.0 kernel, though the pcmcia script also
locks the box up on the 2.4 fedora kernels (2.4.22-1.2135.nptl and
2.4.22-1.2115.nptl, both fedora core 1 stock kernels).
 
the version of the pcmcia kernel stuff installed with fedora is 3.1.31 -
i have also installed the 3.2.7 userspace utilities (not kernel side,
the configuration process from pcmcia-cs-3.2.7 detected that pcmcia was
already enabled in the kernel and only installed the userspace stuff.)

the way in which i determined that cardmgr was at fault was by running
it by hand, simply cardmgr -v.  I then traced it down further by adding
fprintfs to stderr to cardmgr.c - the specific line from which my box
never returns is 

 ret = ioctl(fd, DS_ADJUST_RESOURCE_INFO, &al->adj);

in adjust_resources() in cardmgr.c
the resource being adjusted is an io-range resource, and it's the second
one in the linked list that crashes my box, the first one succeeds just
fine

i also tried booting with noapic and acpi=off just to see if that had
anything to do with it, but no luck.  I have not yet tried a stock
kernel.org kernel. 

debugging this inside the ioctl is a bit out of my league, which is why
i have written this mail - any insight anyone else has (even if it's
just 'what the hell is wrong with you, you've screwed everything up by
doing xxx') would be much appreciated.  Not being a kernel-hacker but
being a compsci major in school probably makes me too dangerous for my
own good. ;-) so if i've totally made a mess of things just tell me so. 
I've attached the diff between my modified copy of cardmgr.c and the one
from pcmcia-cs-3.2.7. First diff I've ever made, so it could be wrong -
it's just fprintfs to see where it got while it was running.  I'll study
up on the format of adjust_list_t and see if i can figure out exactly
which io range the code is trying to adjust and failing at. 

thanks for any insights, all.  

-aubin

--=-yrj9ajvOkwfo1pScc9Qw
Content-Disposition: inline; filename=cardmgr.c.diff
Content-Type: text/x-patch; name=cardmgr.c.diff; charset=
Content-Transfer-Encoding: 7bit

--- pcmcia-cs-3.2.7/cardmgr/cardmgr.c	2003-11-27 17:00:14.000000000 -0500
+++ cardmgr.c	2004-01-03 23:08:27.000000000 -0500
@@ -1217,8 +1217,21 @@
     int fd = socket[0].fd;
     
     for (al = root_adjust; al; al = al->next) {
+	    fprintf( stderr, "calling ioctl to adjust resource info for a(n) ");
+	    switch( al->adj.Resource ) {
+		    case RES_MEMORY_RANGE:
+			    fprintf(stderr, "memory range resource\n");
+			    break;
+		    case RES_IO_RANGE:
+			    fprintf( stderr, "io range resource\n");
+			    break;
+		    case RES_IRQ:
+			    fprintf( stderr, "irq resource\n");
+	    }
 	ret = ioctl(fd, DS_ADJUST_RESOURCE_INFO, &al->adj);
+	fprintf( stderr, "made it back from ioctl resource adjust\n");
 	if (ret != 0) {
+		fprintf(stderr, "we failed to adjust a resource\n");
 	    switch (al->adj.Resource) {
 	    case RES_MEMORY_RANGE:
 		sprintf(tmp, "memory %#lx-%#lx",
@@ -1332,7 +1345,9 @@
 	syslog(LOG_INFO, "watching %d socket%s", sockets,
 	       (sockets != 1) ? "s" : "");
 
+    fprintf(stderr, "cardmgr calling adjust_resources()\n");
     adjust_resources();
+    fprintf( stderr, "cardmgr back from adjust_resources() call\n");
     return 0;
 }
 
@@ -1382,6 +1397,7 @@
 	    errflg = 1; break;
 	}
     }
+	fprintf(stderr, "cardmgr finished option parsing\n");
     if (errflg || (optind < argc)) {
 	fprintf(stderr, "usage: %s [-V] [-q] [-v] [-o] [-f] "
 		"[-c configpath] [-m modpath]\n               "
@@ -1414,12 +1430,15 @@
 	syslog(LOG_NOTICE, "cannot access %s: %m", modpath);
     /* We default to using modprobe if it is available */
     do_modprobe |= (access("/sbin/modprobe", X_OK) == 0);
-    
+    fprintf(stderr, "cardmgr calling load_config()\n");
     load_config();
-    
+    fprintf(stderr, "cardmgr calling init_sockets()\n");
     if (init_sockets() != 0)
-	exit(EXIT_FAILURE);
-
+	{
+		fprintf(stderr, "cardmgr init_sockets failed\n");
+		exit(EXIT_FAILURE);
+	}
+	fprintf( stderr, "cardmgr init_sockets() succeeded\n");
     closelog();
     close(0); close(1); close(2);
     if (!delay_fork && !one_pass)
@@ -1442,7 +1461,7 @@
     if (signal(SIGPWR, catch_signal) == SIG_ERR)
 	syslog(LOG_ERR, "signal(SIGPWR): %m");
 #endif
-
+	fprintf( stderr, "cardmgr finished sighandler setup\n");
     for (i = max_fd = 0; i < sockets; i++)
 	max_fd = (socket[i].fd > max_fd) ? socket[i].fd : max_fd;
 
@@ -1476,7 +1495,7 @@
 		syslog(LOG_INFO, "read(%d): %m\n", i);
 	    if (ret != 4)
 		continue;
-	    
+		fprintf(stderr, "cardmgr about to enter event switch\n");
 	    switch (event) {
 	    case CS_EVENT_CARD_REMOVAL:
 		socket[i].state = 0;

--=-yrj9ajvOkwfo1pScc9Qw--

