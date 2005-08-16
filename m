Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965147AbVHPIq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbVHPIq4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 04:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbVHPIq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 04:46:56 -0400
Received: from koto.vergenet.net ([210.128.90.7]:43958 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S965147AbVHPIqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 04:46:54 -0400
Date: Tue, 16 Aug 2005 17:38:09 +0900
From: Horms <horms@debian.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alexander Pytlev <apytlev@tut.by>, linux-kernel@vger.kernel.org,
       debian-kernel@lists.debian.org,
       "Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>,
       Willy Tarreau <willy@w.ods.org>
Subject: Re: kernel 2.4.27-10: isofs driver ignore some parameters with mount
Message-ID: <20050816083807.GA31717@debian.org>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Alexander Pytlev <apytlev@tut.by>, linux-kernel@vger.kernel.org,
	debian-kernel@lists.debian.org,
	"Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>,
	Willy Tarreau <willy@w.ods.org>
References: <1853917171.20050812104417@tut.by> <20050812082936.GB3302@verge.net.au> <20050816011121.GB7807@dmt.cnet> <20050816053121.GD11925@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050816053121.GD11925@verge.net.au>
X-Cluestick: seven
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Marcelo's request I have taken a closer look at this.
It seems that Alexander Pytlev's original (simple) patch was correct.

Without it the logic looks a bit like this.

while (...) {
	if iocharset
		...
	else if map
		...
	if session
		...
	if sbsector
		...
	else if check
		...
		...
	else
		return 1;
}

Now, if iocharset, map or session are matched, then none of the if or
else if clauses under sbsector will match (that is none of these clauses
match iocharset, map or session), and thus the else clause will be hit,
and the function will return 1 without parsing any furhter options.

With Alexander's fix, the if session and if sbsector clauses
become else if, and its easy to see that the return 1 won't
be premeturely called.

I have tested that this patch works using the testcase options
iocharset=koi8-r,gid=100, and checking that gid is set correctly
with the patch, and incorrectly without.

Here is the patch and signoff again, just for the record.
I will send a second patch to clean up the *value = 0 code
that Marcelo cast concerns over - its bogus but harmless.

Signed-off-by: Horms <horms@verge.net.au>

--- a/fs/isofs/inode.c	2005-08-03 14:46:33.000000000 +0900
+++ b/fs/isofs/inode.c	2005-08-16 17:23:04.000000000 +0900
@@ -340,13 +337,13 @@
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
