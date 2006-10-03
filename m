Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWJCPT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWJCPT4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 11:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWJCPT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 11:19:56 -0400
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:26410 "EHLO
	outbound4-sin-R.bigfish.com") by vger.kernel.org with ESMTP
	id S964865AbWJCPTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 11:19:54 -0400
X-BigFish: VP
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Date: Tue, 3 Oct 2006 09:07:23 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-fbdev-devel@lists.sourceforge.net
cc: "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       devel@laptop.org
Subject: Re: video: Get the default mode from the right database
Message-ID: <20061003150723.GG7716@cosmic.amd.com>
References: <20061002225738.GD7716@cosmic.amd.com>
 <Pine.LNX.4.62.0610030901070.28197@pademelon.sonytel.be>
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.62.0610030901070.28197@pademelon.sonytel.be>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 03 Oct 2006 14:57:59.0710 (UTC)
 FILETIME=[5151CBE0:01C6E6FC]
X-WSS-ID: 693CA5F20Y45084029-01-01
Content-Type: multipart/mixed;
 boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On 03/10/06 09:04 +0200, Geert Uytterhoeven wrote:
> >      if (!default_mode)
> > -	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
> > +	default_mode = &db[DEFAULT_MODEDB_INDEX];
> >      if (!default_bpp)
> >  	default_bpp = 8;
> 
> Although currently DEFAULT_MODEDB_INDEX is defined to be 0, perhaps we need a
> more rigorous check now it may apply to the custom video mode database?
> Probably you always want the first mode of your custom video mode database to
> be the default?

Indeed.  I'm not sure how many people out there actually change
DEFAULT_MODEDB_INDEX to be non zero, but can't think of a reason why the
default shouldn't just always use the first index in the database.  

At least, thats the way I thought fb_find_mode() worked before I looked into 
the internals. Still, there might be some people attached to 
DEFAULT_MODEDB_INDEX, so I've attached a new patch that should make everybody 
happy.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>

--E39vaYmALEf/7YXx
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=modedb-fix.patch
Content-Transfer-Encoding: 7bit

[PATCH] video: Get the default mode from the right database

From: Jordan Crouse <jordan.crouse@amd.com>

If no default mode is specified, it should be grabbed from the supplied
database, not the default one.  

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/video/modedb.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index d126790..4c04413 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -505,8 +505,11 @@ int fb_find_mode(struct fb_var_screeninf
 	db = modedb;
 	dbsize = ARRAY_SIZE(modedb);
     }
-    if (!default_mode)
+    if (!default_mode && db != modedb)
+	default_mode = &db[0];
+    else
 	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
+
     if (!default_bpp)
 	default_bpp = 8;
 

--E39vaYmALEf/7YXx--


