Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275412AbTHIUr7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 16:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275411AbTHIUr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 16:47:59 -0400
Received: from iwoars.net ([217.160.110.113]:49673 "HELO iwoars.net")
	by vger.kernel.org with SMTP id S275412AbTHIUr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 16:47:57 -0400
Date: Sat, 9 Aug 2003 22:48:54 +0200
From: Thomas Themel <themel@iwoars.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: cryptoloop data corruption (was Re: Device-backed loop broken in 2.6.0-test2?)
Message-ID: <20030809204854.GA16573@iwoars.net>
References: <20030806224022.GA3741@iwoars.net> <20030806174043.27fd674a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806174043.27fd674a.akpm@osdl.org>
User-Agent: Mutt/1.4i
X-Jabber-ID: themel0r@jabber.at
X-ICQ-UIN: 8774749
X-Postal: Hauptplatz 8/4, 9500 Villach, Austria
X-Phone: +43 676 846623 13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton (akpm@osdl.org) wrote on 2003-08-07:
> Thomas Themel <themel@iwoars.net> wrote:
> > it seems that device backed loopback is broken in the 2.6.0-test2 series.
> 
> doh.

Hm, it seems that this patch doesn't apply to 2.6.0-test3, so I assume
that the 'other fix' from -mm5 is included? 

I still get data corruption on cryptoloop, but now it is a bit more
subtle... One bit of every byte at multiples of 0x200 is flipped,
starting with the one at 0x1000. 

See this for a short example (xxd output of file before and after copy
to cryptoloop):

--- good.xxd	2003-08-09 22:33:21.000000000 +0200
+++ b0rk.xxd	2003-08-09 22:32:59.000000000 +0200
@@ -256,3 +256,3 @@
 0000ff0: ffff ffff ffff ffff ffff ffff ffff ffff  ................
-0001000: ffff ffff ffff ffff ffff ffff ffff ffff  ................
+0001000: f7ff ffff ffff ffff ffff ffff ffff ffff  ................
 0001010: ffff ffff ffff ffff ffff ffff ffff ffff  ................
@@ -288,3 +288,3 @@
 00011f0: 0ae0 004b 0000 0000 0000 0960 0000 0000  ...K.......`....
-0001200: 0001 2c00 0000 0000 0025 8000 0000 ffff  ..,......%......
+0001200: 0801 2c00 0000 0000 0025 8000 0000 ffff  ..,......%......
 0001210: ffff ffff ffff ffff ffff ffff ffff ffff  ................
@@ -320,3 +320,3 @@
 00013f0: ffff ffff ffff ffff ffff ffff ffff ffff  ................
-0001400: ffff ffff ffff ffff ffff ffff ffff ffff  ................
+0001400: f7ff ffff ffff ffff ffff ffff ffff ffff  ................
 0001410: ffff ffff ffff ffff ffff ffff ffff ffff  ................
@@ -352,3 +352,3 @@
 00015f0: ffff ffff ffff ffff ffff ffff ffff ffff  ................
-0001600: ffff ffff ffff ffff ffff ffff ffff ffff  ................

Any ideas what's causing this? The files are ext3 on an AES cryptoloop
backed by an IDE partition. 

ciao,
-- 
[*Thomas  Themel*] US law prohibits boycotting Israel
[extended contact] 
[info provided in] <http://news.bbc.co.uk/2/hi/business/2403303.stm>
[*message header*] <http://www.bxa.doc.gov/AntiboycottCompliance/Default.htm>
