Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264182AbUFGV3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264182AbUFGV3s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 17:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbUFGV3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 17:29:48 -0400
Received: from 80-218-57-148.dclient.hispeed.ch ([80.218.57.148]:26887 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S264182AbUFGV3j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 17:29:39 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Aaron Mulder <ammulder@alumni.princeton.edu>,
       Dax Kelson <dax@gurulabs.com>, Vibol Hou <vibol@khmer.cc>
Subject: Re: Dell TrueMobile 1150 PCMCIA/Orinoco/Yenta problem w/ 2.6.4/5
Date: Mon, 7 Jun 2004 23:24:44 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406072324.44310.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if pcmcia does not work when the ethX alias is there....then may be this patch
patch against the fedora pcmcia init script may help...

and now i go wash my eyes 'cos i looked at fedora's rc.sysinit...eek.

rgds
-daniel

-------

the standard pcmcia-cs init script and therefor i guess all distro init scripts
get the situation wrong where pcmcia_core is already loaded due to a
dependency. the socket driver is not loaded in this situation...
(and it fixes a bug in stop with kernel 2.6)

--- pcmcia.old	2004-06-06 21:32:38.000000000 +0200
+++ pcmcia	2004-06-06 21:48:39.000000000 +0200
@@ -91,23 +91,46 @@
 	if [ ! -f $SC ] ; then umask 022 ; touch $SC ; fi
 	if [ "$SCHEME" ] ; then umask 022 ; echo $SCHEME > $SC ; fi
 	    
+
+	if [ -d /lib/modules/preferred ] ; then
+	    PC=/lib/modules/preferred/pcmcia
+	else
+	    PC=/lib/modules/`uname -r`/pcmcia
+	fi
+	KD=/lib/modules/`uname -r`/kernel/drivers/pcmcia
+
+	# make sure pcmcia_core is there
 	if ! grep -q pcmcia /proc/devices ; then
-	    if [ -d /lib/modules/preferred ] ; then
-		PC=/lib/modules/preferred/pcmcia
+	    if [ -x /sbin/modprobe ] ; then
+		/sbin/modprobe pcmcia_core $CORE_OPTS || break
+	    elif [ -d $PC ] ; then
+		/sbin/insmod $PC/pcmcia_core.o $CORE_OPTS
 	    else
-		PC=/lib/modules/`uname -r`/pcmcia
+		echo "module directory $PC not found."
+		break
 	    fi
-	    KD=/lib/modules/`uname -r`/kernel/drivers/pcmcia
+	fi
+
+	# load a socket driver
+	if ! grep -q "$PCIC\|yenta_socket" /proc/modules ; then
 	    if [ -x /sbin/modprobe ] ; then
-		/sbin/modprobe pcmcia_core $CORE_OPTS || break
 		/sbin/modprobe $PCIC $PCIC_OPTS >/dev/null 2>&1 ||
 		  (/sbin/modprobe yenta_socket >/dev/null 2>&1 &&
 		   echo "using yenta_socket instead of $PCIC") ||
 		  /sbin/modprobe $PCIC $PCIC_OPTS || break
-		/sbin/modprobe ds || break
 	    elif [ -d $PC ] ; then
-		/sbin/insmod $PC/pcmcia_core.o $CORE_OPTS
 		/sbin/insmod $PC/$PCIC.o $PCIC_OPTS
+	    else
+		echo "module directory $PC not found."
+		break
+	    fi
+	fi
+
+	# load ds
+	if ! grep -q "ds " /proc/modules ; then
+	    if [ -x /sbin/modprobe ] ; then
+		/sbin/modprobe ds || break
+	    elif [ -d $PC ] ; then
 		/sbin/insmod $PC/ds.o
 	    else
 		echo "module directory $PC not found."
@@ -115,6 +138,7 @@
 	    fi
 	fi
 
+	# start cardmgr
 	if [ -s /var/run/cardmgr.pid ] && \
 	    kill -0 `cat /var/run/cardmgr.pid` 2>/dev/null ; then
 	    echo "cardmgr is already running."
@@ -142,7 +166,7 @@
 	    done
 	fi
 	killall -q "CardBus Watcher"
-	if grep -q "ds  " /proc/modules ; then
+	if grep -q "ds " /proc/modules ; then
 	    /sbin/rmmod ds
 	    /sbin/rmmod $PCIC 2>/dev/null || \
 		/sbin/rmmod yenta_socket 2>/dev/null

