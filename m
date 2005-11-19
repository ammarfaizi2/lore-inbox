Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161174AbVKSCIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161174AbVKSCIE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 21:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161183AbVKSCIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 21:08:04 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:18398 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1161174AbVKSCIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 21:08:02 -0500
Message-ID: <437E8904.40001@gentoo.org>
Date: Sat, 19 Nov 2005 02:08:04 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051104)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Clemens Koller <clemens.koller@anagramm.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.14.2 - Hard link count is wrong
References: <437E2494.6010005@anagramm.de>
In-Reply-To: <437E2494.6010005@anagramm.de>
Content-Type: multipart/mixed;
 boundary="------------060400040500020203060603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060400040500020203060603
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Clemens Koller wrote:
> I get
> 
> .....
> find: WARNING: Hard link count is wrong for .: this may be a bug in your 
> filesystem driver.  Automatically turning on find's -noleaf option.  
> Earlier results may have failed to include directories that should have 
> been searched.
> 
> According to google, this might be a kernel bug due to some problems in 
> /proc, see:
> https://www.redhat.com/archives/fedora-list/2005-September/msg02474.html
> Well, how to debug that problem?

That find check is somewhat incorrect (hard link count can be legally modified 
after the search was started and before it finished), but I did fix up the 
/proc problems that existed a while back.

This patch will give you a more useful error from findutils.

Daniel

--------------060400040500020203060603
Content-Type: text/x-patch;
 name="be-specific-about-hardlink-counts.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="be-specific-about-hardlink-counts.patch"

findutils-4.2.20 made me aware of the incorrect hardlink counts in /proc and
I've been fixing them up.

Although find made me aware of the issue, the message it prints could be more
useful: it doesn't show an accurate location of where the incorrect count
exists (instead, it seems to use the path that you gave to find on the command
line), and it would be nice if it could also report the hardlink count which
it read (on pseudo-filesystems like /proc this isn't very static). 

--- findutils-4.2.20/find/find.c.orig	2005-03-03 22:30:10.000000000 +0000
+++ findutils-4.2.20/find/find.c	2005-04-03 13:45:06.000000000 +0100
@@ -1811,8 +1811,8 @@ process_dir (char *pathname, char *name,
 		   * doesn't really handle hard links with Unix semantics.
 		   * In the latter case, -noleaf should be used routinely.
 		   */
-		  error(0, 0, _("WARNING: Hard link count is wrong for %s: this may be a bug in your filesystem driver.  Automatically turning on find's -noleaf option.  Earlier results may have failed to include directories that should have been searched."),
-			parent);
+		  error(0, 0, _("WARNING: Hard link count (%d) is wrong for %s: this may be a bug in your filesystem driver.  Automatically turning on find's -noleaf option.  Earlier results may have failed to include directories that should have been searched."),
+			statp->st_nlink, pathname);
 		  state.exit_status = 1; /* We know the result is wrong, now */
 		  options.no_leaf_check = true;	/* Don't make same
 						   mistake again */

--------------060400040500020203060603--
