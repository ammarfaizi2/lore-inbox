Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbTDHWsS (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 18:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTDHWsS (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 18:48:18 -0400
Received: from air-2.osdl.org ([65.172.181.6]:33207 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262272AbTDHWsP (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 18:48:15 -0400
Subject: Re: readprofile: 0 total     nan
From: Andy Pfiffer <andyp@osdl.org>
To: Shesha@asu.edu
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       Werner Almesberger <wa@almesberger.net>
In-Reply-To: <Pine.GSO.4.21.0304081503130.17450-100000@general3.asu.edu>
References: <Pine.GSO.4.21.0304081503130.17450-100000@general3.asu.edu>
Content-Type: multipart/mixed; boundary="=-FJLIJUhcOSrUxnp/8l+I"
Organization: 
Message-Id: <1049842780.2499.83.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 08 Apr 2003 15:59:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FJLIJUhcOSrUxnp/8l+I
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2003-04-08 at 15:41, Shesha@asu.edu wrote:
> I am running 2.4.18 kernel for ARM. I have one of the boot parameters
> "profile=2". The size of the /proc/profile file is shown as 16MB. But when I
> execute "readprofile" the output is ...  
> 0 total                                         nan
> 
> If I cat the file it just give me a ".". Can anyone suggest what i am doing
> wrong?

[ I swear I was just talking about this problem with someone else... ]

1. /proc/profile is a binary file.  cat won't show you anything
meaningful.

2. the 0 output by readprofile is a problem with the automatic
byte-order detection heuristic built into the code.  Try invoking
readprofile with the "-n" option, and see if your problem goes away.

FYI: For those that might also run into this, the essence of the problem
is this piece of code in readprofile.c (fragmented for clarity):

"optNative" is 0.
"buf" is an unsigned int *.


if (!optNative) {
        int entries = len/sizeof(*buf);
        int big = 0,small = 0,i;
        unsigned *p;

        for (p = buf+1; p < buf+entries; p++)
                if (*p) {
                        if (*p >= 1 << (sizeof(*buf)/2)) big++;
                        else small++;
                }       
        if (big > small) {
                fprintf(stderr,"Assuming reversed byte order. "
                   "Use -n to force native byte order.\n");
                <snipped>
                .
                .
                .
        }       
}

Based on my read of the code, "big" will be incremented if *p >= 4,
otherwise "small" will be incremented.  I can't see how this would ever
detect the byte order...

Werner proposed this as a solution, but it could still fail to correctly
detect the byteorder (although with much less frequency):



--=-FJLIJUhcOSrUxnp/8l+I
Content-Description: 
Content-Disposition: inline; filename=readprofile.patch
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- util-linux-2.11z/sys-utils/readprofile.c.orig	Tue Apr  8 15:23:05 2003
+++ util-linux-2.11z/sys-utils/readprofile.c	Tue Apr  8 15:29:29 2003
@@ -33,6 +33,8 @@
  * - make maplineno do something
  * 2002-11-28 Mads Martin Joergensen +
  * - also try /boot/System.map-`uname -r`
+ * 2003-04-08 Werner Almesberger <wa@almesberger.net>
+ * - fixed off-by eight error in byte order detection
  */
 
 #include <errno.h>
@@ -249,7 +251,7 @@ main(int argc, char **argv) {
 
 		for (p = buf+1; p < buf+entries; p++)
 			if (*p) {
-				if (*p >= 1 << (sizeof(*buf)/2)) big++;
+				if (*p >= 1 << (sizeof(*buf)*4)) big++;
 				else small++;
 			}
 		if (big > small) {

--=-FJLIJUhcOSrUxnp/8l+I--

