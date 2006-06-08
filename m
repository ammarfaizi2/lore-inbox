Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbWFHHGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbWFHHGN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 03:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbWFHHGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 03:06:12 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12451 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932545AbWFHHGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 03:06:11 -0400
Date: Thu, 8 Jun 2006 09:05:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: Daniel Drake <dsd@gentoo.org>
Cc: Jiri Benc <jbenc@suse.cz>, linville@tuxdriver.com,
       kernel list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: [patch] workaround zd1201 interference problem
Message-ID: <20060608070525.GE3688@elf.ucw.cz>
References: <20060607140045.GB1936@elf.ucw.cz> <20060607160828.0045e7f5@griffin.suse.cz> <20060607141536.GD1936@elf.ucw.cz> <4486FD2F.8040205@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4486FD2F.8040205@gentoo.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Well, I'll try _enable() alone, but it seems to me that _enable()
> >command is needed to initialize radio properly. I do not think we can
> >get much further without firmware sources...
> 
> If you can formulate a proper and technical description of the issue 
> (and exactly what is needed to workaround it), I can contact ZyDAS for 
> you. They have been very helpful with ZD1211.

Okay, the issue is:

if you plug zd1201 into USB, it starts jamming radio,
immediately. Enable/disable, or iwlist wlan0 scan, or basically any
operation unjams the radio. This patch works it around:

diff --git a/drivers/net/wireless/zd1201.c b/drivers/net/wireless/zd1201.c
index 335eaf3..dcc7bc7 100644
--- a/drivers/net/wireless/zd1201.c
+++ b/drivers/net/wireless/zd1201.c
@@ -1835,8 +1835,8 @@ static int zd1201_probe(struct usb_inter
 	    zd->dev->name);
 	
 	usb_set_intfdata(interface, zd);
-	zd1201_enable(zd);
-	zd1201_disable(zd);
+	zd1201_enable(zd);	/* zd1201 likes to startup enabled, interfering */
+	zd1201_disable(zd); 	/* with all the wifis in range */
 	return 0;
 
 err_net:


....question is "is that right solution, or is something different
needed to solve that problem properly"?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
