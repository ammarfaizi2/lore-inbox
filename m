Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318682AbSG0CkJ>; Fri, 26 Jul 2002 22:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318683AbSG0CkJ>; Fri, 26 Jul 2002 22:40:09 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:1392 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S318682AbSG0CkI>; Fri, 26 Jul 2002 22:40:08 -0400
Date: Fri, 26 Jul 2002 22:43:25 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Pete Zaitcev <zaitcev@redhat.com>
Subject: Patch for xconfig
Message-ID: <20020726224325.A16725@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My customers complain that using certain canned configurations
xconfig does not work (naturally, it works with defconfig).
A problem that I am trying to fix is that it can refuse to
quit with something like "Variable CONSTANT_M does not exist".
The necessary "global" is indeed missing.

Can someone knowledgeable (like Chastain) have a look at
the attached patch?

Thanks,
-- Pete

--- linux-2.4.18-7.80/scripts/tkgen.c	Fri Jul 26 11:56:29 2002
+++ linux-2.4.18-7.80-xcf/scripts/tkgen.c	Fri Jul 26 13:30:45 2002
@@ -625,6 +625,7 @@
 		if ( ! vartable[i].global_written )
 		{
 		    global( vartable[i].name );
+                    vartable[i].global_written = 1;
 		}
 		printf( "\t" );
 	    }
@@ -698,6 +699,19 @@
 	}
     }
 
+    /*
+     * Generate global declarations for the dependency chain (e.g. CONSTANT_M).
+     */
+    for ( tmp = cfg->depend; tmp; tmp = tmp->next )
+    {
+        int i = get_varnum( tmp->name );
+	if ( ! vartable[i].global_written )
+	{
+	    global( vartable[i].name );
+	    vartable[i].global_written = 1;
+	}
+    }
+
     /*
      * Generate indentation.
      */
