Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272689AbTHPKEW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 06:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272691AbTHPKEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 06:04:22 -0400
Received: from mail.lmcg.wisc.edu ([144.92.101.145]:1735 "EHLO
	mail.lmcg.wisc.edu") by vger.kernel.org with ESMTP id S272689AbTHPKEU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 06:04:20 -0400
Date: Sat, 16 Aug 2003 05:04:15 -0500
From: Daniel Forrest <forrest@lmcg.wisc.edu>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "'Daniel Forrest'" <forrest@lmcg.wisc.edu>,
       "'Timothy Miller'" <miller@techsource.com>,
       "'Willy Tarreau'" <willy@w.ods.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: generic strncpy - off-by-one error
Message-ID: <20030816050415.A6986@rda07.lmcg.wisc.edu>
Reply-To: Daniel Forrest <forrest@lmcg.wisc.edu>
References: <D069C7355C6E314B85CF36761C40F9A42E20BC@mailse02.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <D069C7355C6E314B85CF36761C40F9A42E20BC@mailse02.se.axis.com>; from peter.kjellerstedt@axis.com on Sat, Aug 16, 2003 at 11:19:30AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 11:19:30AM +0200, Peter Kjellerstedt wrote:
> 
> Actually, it should be:
> 
> 	while (count && ((long)tmp & (sizeof(long) - 1)))
> 

Oops, you're right, I forgot that the count could be small.

But, now that I think of it, maybe this would be best...

 char *strncpy(char *dest, const char *src, size_t count)
 {
 	char *tmp = dest;
 
 	while (count && *src) {
 		*tmp++ = *src++;
 		count--;
 	}
 
-	if (count) {
+	if (count >= sizeof(long)) {
 		size_t count2;
 
-		while (count && ((long)tmp & (sizeof(long) - 1))) {
+		while ((long)tmp & (sizeof(long) - 1)) {
 			*tmp++ = '\0';
 			count--;
 		}
 
 		count2 = count / sizeof(long);
 		while (count2) {
 			*((long *)tmp)++ = '\0';
 			count2--;
 		}
 
 		count &= (sizeof(long) - 1);
-		while (count) {
-			*tmp++ = '\0';
-			count--;
-		}
+	}
+
+	while (count) {
+		*tmp++ = '\0';
+		count--;
 	}
 
 	return dest;
 }

-- 
Dan
