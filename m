Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264477AbRFIS6D>; Sat, 9 Jun 2001 14:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264478AbRFIS5n>; Sat, 9 Jun 2001 14:57:43 -0400
Received: from mid-tgn-ngd-vty23.as.wcom.net ([216.192.73.23]:46599 "EHLO
	think.thunk.org") by vger.kernel.org with ESMTP id <S264477AbRFIS5e>;
	Sat, 9 Jun 2001 14:57:34 -0400
Date: Sat, 9 Jun 2001 14:07:18 -0400
From: Theodore Tso <tytso@mit.edu>
To: Hank Leininger <hlein@progressive-comp.com>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com, engler@csl.Stanford.EDU
Subject: Re: [CHECKER] security rules?  (and 2.4.5-ac4 security bug)
Message-ID: <20010609140718.A2570@think.thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Hank Leininger <hlein@progressive-comp.com>,
	linux-kernel@vger.kernel.org, alan@redhat.com,
	engler@csl.Stanford.EDU
In-Reply-To: <200106041220.IAA07493@mailer.progressive-comp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <200106041220.IAA07493@mailer.progressive-comp.com>; from linux-kernel@progressive-comp.com on Mon, Jun 04, 2001 at 08:20:01AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2001 at 08:20:01AM -0400, Hank Leininger wrote:
> On 2001-06-03, Dawson Engler <engler@csl.Stanford.EDU> wrote:
> 
> > Additionally, do people have suggestions for good security rules?
> > We're looking to expand our security checkers.  Right now we just have
> > checkers that warn when:
> 
> Do you already have checks for signed/unsigned issues?  Those often result
> in security problems, although you may already be checking for them simply
> for reliable-code purposes.  ...Hm, looking at the archives, I see Chris
> Evans responded about signedness issues when you asked last month :-P

Indeed; the bug in the uuid_strategy which you pointed out in the
random driver wasn't caused by the fact that we were using a
user-specified length (since the length was being capped to a maximum
value of 16).  The security bug was that the test was done on a signed
value, and copy_to_user() takes an unsigned value.

So your checker found a real bug, but it wasn't the one that the
checker thought it was.  :-)

Alan, I assume you've fixed this already, but here's a patch in case
you haven't.  Note this also fixes the problem the problem pointed out
by Florian Weimer about copy_to_user being passed a null pointer in
the RANDOM_UUID case.

						- Ted

--- random.c	2001/06/09 18:05:08	1.1
+++ random.c	2001/06/09 18:05:19
@@ -1793,7 +1793,7 @@
 			 void *newval, size_t newlen, void **context)
 {
 	unsigned char	tmp_uuid[16], *uuid;
-	int	len;
+	unsigned int	len;
 
 	if (!oldval || !oldlenp)
 		return 1;
@@ -1810,7 +1810,7 @@
 	if (len) {
 		if (len > 16)
 			len = 16;
-		if (copy_to_user(oldval, table->data, len))
+		if (copy_to_user(oldval, uuid, len))
 			return -EFAULT;
 		if (put_user(len, oldlenp))
 			return -EFAULT;
