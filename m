Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129801AbQLFQHJ>; Wed, 6 Dec 2000 11:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbQLFQG7>; Wed, 6 Dec 2000 11:06:59 -0500
Received: from code.and.org ([63.113.167.33]:26385 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S129801AbQLFQGl>;
	Wed, 6 Dec 2000 11:06:41 -0500
To: Olaf Kirch <okir@caldera.de>
Cc: linux-kernel@vger.kernel.org, security-audit@ferret.lmh.ox.ac.uk
Subject: Re: Traceroute without s bit
In-Reply-To: <20001206135019.L9533@monad.caldera.de>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 06 Dec 2000 10:35:14 -0500
In-Reply-To: Olaf Kirch's message of "Wed, 6 Dec 2000 13:50:19 +0100"
Message-ID: <nnitoxh8b1.fsf@code.and.org>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Kirch <okir@caldera.de> writes:

>  3.	There seems to be a bug somewhere in the handling of poll().
> 	If you observe the traceroute process with strace, you'll
> 	notice that it starts spinning madly after receiving the
> 	first bunch of packets (those with ttl 1).
> 
> 	13:43:02 poll([{fd=4, events=POLLERR}], 1, 5) = 0
> 	13:43:02 poll([{fd=4, events=POLLERR}], 1, 5) = 0
> 	13:43:02 poll([{fd=4, events=POLLERR}], 1, 5) = 0
> 	13:43:02 poll([{fd=4, events=POLLERR}], 1, 5) = 0
> 	...
> 
> 	I.e. the poll call returns as if it had timed out, but it
> 	hasn't.

 I've just looked at it, but I'm pretty sure this is a bug in your
code. This should fix it...

--- traceroute.c.orig	Wed Dec  6 10:33:48 2000
+++ traceroute.c	Wed Dec  6 10:34:06 2000
@@ -193,7 +193,7 @@
 				timeout = hop->nextsend;
 		}
 
-		poll(pfd, m, timeout - now);
+		poll(pfd, m, (timeout - now) * 1000);
 
 		/* Receive any pending ICMP errors */
 		for (n = 0; n < m; n++) {


-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and.org
/dev/null
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
