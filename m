Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266324AbUFPVs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUFPVs0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 17:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266325AbUFPVsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 17:48:25 -0400
Received: from [213.146.154.40] ([213.146.154.40]:36768 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266324AbUFPVpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 17:45:30 -0400
Date: Wed, 16 Jun 2004 22:45:20 +0100 (BST)
From: jsimmons@pentafluge.infradead.org
To: Egmont Koblinger <egmont@uhulinux.hu>
cc: Zilvinas Valinskas <zilvinas@gemtek.lt>, Jeff Garzik <jgarzik@pobox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       David MacKenzie <djm@gnu.ai.mit.edu>
Subject: Re: Linux 2.6.7 (stty rows 50 columns 140 reports : No such device
 or address)
In-Reply-To: <Pine.LNX.4.58L0.0406162313450.20508@sziami.cs.bme.hu>
Message-ID: <Pine.LNX.4.56.0406162244300.16739@pentafluge.infradead.org>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org> 
 <20040616095805.GC14936@gemtek.lt>  <40D0432A.1080006@pobox.com>
 <1087395424.5314.2.camel@swoop.gemtek.lt> <Pine.LNX.4.56.0406161728150.14901@pentafluge.infradead.org>
 <Pine.LNX.4.58L0.0406162313450.20508@sziami.cs.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 NO_REAL_NAME           From: does not include a real name
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ug. Missed that. I don't know how but my system always worked. 
Here is the new patch.

--- stty.c.orig	2004-05-07 17:48:51.000000000 -0700
+++ stty.c	2004-06-16 14:38:21.000000000 -0700
@@ -733,6 +733,10 @@
   int speed_was_set;
   int verbose_output;
   int recoverable_output;
+#ifdef TIOCGWINSZ
+  int size_was_set = 0;
+  int cols = -1, rows = -1;
+#endif
   int k;
   int noargs = 1;
   char *file_name = NULL;
@@ -1004,8 +1008,8 @@
 		  usage (EXIT_FAILURE);
 		}
 	      ++k;
-	      set_window_size ((int) integer_arg (argv[k]), -1,
-			       fd, device_name);
+	      rows = integer_arg (argv[k]);
+	      size_was_set = 1;
 	    }
 	  else if (STREQ (argv[k], "cols")
 		   || STREQ (argv[k], "columns"))
@@ -1016,8 +1020,8 @@
 		  usage (EXIT_FAILURE);
 		}
 	      ++k;
-	      set_window_size (-1, (int) integer_arg (argv[k]),
-			       fd, device_name);
+	      cols = integer_arg (argv[k]);
+	      size_was_set = 1;	
 	    }
 	  else if (STREQ (argv[k], "size"))
 	    {
@@ -1063,6 +1067,12 @@
       k++;
     }
 
+#ifdef TIOCGWINSZ
+  if (size_was_set) 
+    {
+      set_window_size (rows, cols, fd, device_name);
+    }
+#endif
   if (require_set_attr)
     {
       struct termios new_mode;
