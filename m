Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315870AbSG1MiR>; Sun, 28 Jul 2002 08:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315988AbSG1MiR>; Sun, 28 Jul 2002 08:38:17 -0400
Received: from mail3.alphalink.com.au ([202.161.124.59]:64119 "EHLO
	mail3.alphalink.com.au") by vger.kernel.org with ESMTP
	id <S315870AbSG1MiQ>; Sun, 28 Jul 2002 08:38:16 -0400
Message-ID: <3D43E623.B8496CB5@alphalink.com.au>
Date: Sun, 28 Jul 2002 22:40:03 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>,
       Michael Elizabeth Chastain <mec@shout.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch for xconfig
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day,

Pete Zaitcev wrote:
> 
> My customers complain that using certain canned configurations
> xconfig does not work (naturally, it works with defconfig).
> A problem that I am trying to fix is that it can refuse to
> quit with something like "Variable CONSTANT_M does not exist".
> The necessary "global" is indeed missing.
>
> Can someone knowledgeable (like Chastain) have a look at
> the attached patch?

I don't claim to be knowledgeable, but I can confirm that this is a
real bug and the patch fixes it.  Here is the patch re-jigged to apply
cleanly to 2.5.29.

diff -ruN --exclude-from=dontdiff linux-2.5.29-orig/scripts/tkgen.c linux-2.5.29/scripts/tkgen.c
--- linux-2.5.29-orig/scripts/tkgen.c	Sun Jul 28 22:34:05 2002
+++ linux-2.5.29/scripts/tkgen.c	Sun Jul 28 22:32:23 2002
@@ -625,6 +625,7 @@
 		if ( ! vartable[i].global_written )
 		{
 		    global( vartable[i].name );
+		    vartable[i].global_written = 1;
 		}
 		printf( "\t" );
 	    }
@@ -696,6 +697,19 @@
 	    }
 	    break;
 	}
+    }
+
+    /*
+     * Generate global declarations for the dependency chain (e.g. CONSTANT_M).
+     */
+    for ( tmp = cfg->depend; tmp; tmp = tmp->next )
+    {
+       int i = get_varnum( tmp->name );
+       if ( ! vartable[i].global_written )
+       {
+           global( vartable[i].name );
+           vartable[i].global_written = 1;
+       }
     }
 
     /*


Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
