Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271229AbTGWTVc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 15:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271237AbTGWTTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 15:19:05 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:58592 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S271229AbTGWTRZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 15:17:25 -0400
Subject: Re: root= needs hex in 2.6.0-test1-mm2
From: Steven Cole <elenstev@mesatop.com>
To: Diego Calleja =?ISO-8859-1?Q?Garc=EDa?= <diegocg@teleline.es>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Christoph Hellwig <hch@infradead.org>, tcfelker@mtco.com,
       linux-kernel@vger.kernel.org, Daniel McNeil <daniel@osdl.org>
In-Reply-To: <20030723201737.27c8fce9.diegocg@teleline.es>
References: <200307230156.40762.tcfelker@mtco.com>
	 <20030723144351.A3367@infradead.org>
	 <1058972911.718.1.camel@teapot.felipe-alfaro.com>
	 <20030723201737.27c8fce9.diegocg@teleline.es>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1058988599.1675.115.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 23 Jul 2003 13:30:00 -0600
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-23 at 12:17, Diego Calleja García wrote:
> El 23 Jul 2003 17:08:31 +0200 Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> escribió:
> 
> > I didn't compile devfs in... However, root=/dev/xxx caused a panic
> > during bootup. So, I guess those panics aren't related exclusively to
> > devfs.
> 
> I can confirm this. It happens without devfsd.
> The hex trick worked ;)

In case you missed it, Daniel McNeil posted this patch here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=105898580610066&w=2
For some odd reason, that mail didn't show up in my lkml box,
but I grabbed his patch from the above, and it had some weird mailer
mangling in the archive, but nothing difficult to fix.

The patch works for me.  Now I can boot 2.6.0-test1-mm2 with
root=/dev/hda1 and no hex tricks.

Here is Daniel's patch.

Steven

--- linux-2.6.0-test1-mm2/init/do_mounts.c.orig	2003-07-23 12:52:21.000000000 -0600
+++ linux-2.6.0-test1-mm2/init/do_mounts.c	2003-07-23 13:04:32.000000000 -0600
@@ -58,6 +58,7 @@
 	char *s;
 	int len;
 	int fd;
+	unsigned int maj, min;
 
 	/* read device number from .../dev */
 
@@ -70,8 +71,12 @@
 	if (len <= 0 || len == 32 || buf[len - 1] != '\n')
 		goto fail;
 	buf[len - 1] = '\0';
-	res = (dev_t) simple_strtoul(buf, &s, 16);
-	if (*s)
+	/*
+	 * The format of dev is now %u:%u -- see print_dev_t()
+	 */
+	if (sscanf(buf, "%u:%u", &maj, &min) == 2)
+		res = MKDEV(maj, min);
+	else
 		goto fail;
 
 	/* if it's there and we are not looking for a partition - that's it */





