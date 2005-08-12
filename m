Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbVHLImQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVHLImQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 04:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVHLImQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 04:42:16 -0400
Received: from koto.vergenet.net ([210.128.90.7]:41610 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1750705AbVHLImP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 04:42:15 -0400
Date: Fri, 12 Aug 2005 17:41:47 +0900
From: Horms <horms@debian.org>
To: Alexander Pytlev <apytlev@tut.by>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Re: kernel 2.4.27-10: isofs driver ignore some parameters with mount
Message-ID: <20050812084146.GA12984@debian.org>
Mail-Followup-To: Alexander Pytlev <apytlev@tut.by>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
References: <1853917171.20050812104417@tut.by> <20050812082936.GB3302@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050812082936.GB3302@verge.net.au>
X-Cluestick: seven
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 05:29:36PM +0900, Horms wrote:
> On Fri, Aug 12, 2005 at 10:44:17AM +0300, Alexander Pytlev wrote:
> > Hello Debian,
> > 
> > Kernel 2.4.27-10
> > With mount isofs filesystem, any mount parameters after
> > iocharset=,map=,session= are ignored.
> > 
> > Sample:
> > 
> > mount -t isofs -o uid=100,iocharset=koi8-r,gid=100 /dev/cdrom /media/cdrom
> > 
> > gid=100 - was ignored
> > 
> > I look in source and find that problem. I make two patch, simply and full
> > (what addeded some functionality - ignore wrong mount parameters)
> 
> Thanks,
> 
> I will try and get the simple version of this patch into the next
> Sarge update.
> 
> I have also CCed Marcelo and the LKML for their consideration,
> as this problem still seems to be present in the lastest 2.4 tree.
> 
> -- 
> Horms

Marcelo and LKML, here is a rediff of the simple version of the patch
from Alexander Pytlev that I forwarded previously. The whitespace in his
version had been munged.

I haven't tested it, but it looks like it should resolve the problem
Alexander reported that mount parameters after iocharset, map and
session are ignored.

This should apply against current 2.4 git.  I took a peek into 2.6, and
the code there has seems to have been completely restructured.

Signed-off-by: Horms <horms@verge.net.au>


--- fs/isofs/inode.c.orig	2005-08-12 17:33:31.000000000 +0900
+++ fs/isofs/inode.c	2005-08-12 17:33:38.000000000 +0900
@@ -340,13 +340,13 @@
 			else if (!strcmp(value,"acorn")) popt->map = 'a';
 			else return 0;
 		}
-		if (!strcmp(this_char,"session") && value) {
+		else if (!strcmp(this_char,"session") && value) {
 			char * vpnt = value;
 			unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
 			if(ivalue < 0 || ivalue >99) return 0;
 			popt->session=ivalue+1;
 		}
-		if (!strcmp(this_char,"sbsector") && value) {
+		else if (!strcmp(this_char,"sbsector") && value) {
 			char * vpnt = value;
 			unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
 			if(ivalue < 0 || ivalue >660*512) return 0;
