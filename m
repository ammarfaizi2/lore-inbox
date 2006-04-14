Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWDNQUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWDNQUb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 12:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWDNQUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 12:20:30 -0400
Received: from mail.suse.de ([195.135.220.2]:54979 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751267AbWDNQU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 12:20:29 -0400
Date: Fri, 14 Apr 2006 09:19:27 -0700
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kay.sievers@vrfy.org, linux-kernel@vger.kernel.org
Subject: Re: modprobe bug for aliases with regular expressions
Message-ID: <20060414161927.GA15830@kroah.com>
References: <20060413233518.GA7597@kroah.com> <1144990770.31267.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144990770.31267.29.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2006 at 02:59:30PM +1000, Rusty Russell wrote:
> On Thu, 2006-04-13 at 16:35 -0700, Greg KH wrote:
> > Recently it's been pointed out to me that the modprobe functionality
> > with aliases doesn't quite work properly for some USB modules.
> 
> Sorry, my bad.  I got a patch for this a while ago from Sam Morris.
> Originally noone was using ranges in [].
> 
> This is fixed in 3.3-pre1.  I should release 3.3 proper sometime this
> weekend.

So, the patch that fixes it is the patch below? (needed for distros that
don't want to rev the whole package...)

thanks,

greg k-h


diff -Naur module-init-tools-3.2.2/modprobe.c module-init-tools-3.3-pre1/modprobe.c
--- module-init-tools-3.2.2/modprobe.c	2005-12-01 15:42:09.000000000 -0800
+++ module-init-tools-3.3-pre1/modprobe.c	2006-02-04 15:18:07.000000000 -0800
@@ -990,13 +990,27 @@
 	return ret;
 }
 
+/* Careful!  Don't munge - in [ ] as per Debian Bug#350915 */
 static char *underscores(char *string)
 {
 	if (string) {
 		unsigned int i;
-		for (i = 0; string[i]; i++)
-			if (string[i] == '-')
-				string[i] = '_';
+		int inbracket = 0;
+		for (i = 0; string[i]; i++) {
+			switch (string[i]) {
+			case '[':
+				inbracket++;
+				break;
+			case ']':
+				inbracket--;
+				break;
+			case '-':
+				if (!inbracket)
+					string[i] = '_';
+			}
+		}
+		if (inbracket)
+			warn("Unmatched bracket in %s\n", string);
 	}
 	return string;
 }
