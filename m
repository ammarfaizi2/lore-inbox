Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVGIWvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVGIWvk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 18:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVGIWvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 18:51:35 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:60899 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261767AbVGIWux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 18:50:53 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Stelian Pop <stelian@popies.net>,
       Johannes Berg <johannes@sipsolutions.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Frank Arnold <frank@scirocco-5v-turbo.de>
Subject: Re: [PATCH] Apple USB Touchpad driver (new)
References: <20050708101731.GM18608@sd291.sivit.org>
	<1120821481.5065.2.camel@localhost>
	<20050708121005.GN18608@sd291.sivit.org>
	<20050709191357.GA2244@ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 10 Jul 2005 00:48:30 +0200
In-Reply-To: <20050709191357.GA2244@ucw.cz>
Message-ID: <m33bqnr3y9.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> Btw, what I don't completely understand is why you need linear
> regression, when you're not trying to detect motion or something like
> that. Basic floating average, or even simpler filtering like the input
> core uses for fuzz could work well enough I believe.

Indeed, this function doesn't make much sense:

+static inline int smooth_history(int x0, int x1, int x2, int x3)
+{
+	return x0 - ( x0 * 3 + x1 - x2 - x3 * 3 ) / 10;
+}

In the X driver, a derivative estimate is computed from the last 4
absolute positions, and in that case the least squares estimate is
given by the factors [.3 .1 -.1 -.3]. However, in this case you want
to compute an absolute position estimate from the last 4 absolute
positions, and in this case the least squares estimate is given by the
factors [.25 .25 .25 .25], ie a floating average. If the function is
changed to this:

+static inline int smooth_history(int x0, int x1, int x2, int x3)
+{
+	return (x0 + x1 + x2 + x3) / 4;
+}

the standard deviation of the noise will be reduced by a factor of 2
compared to the unfiltered values. With the old smooth_history()
function, the noise reduction will only be a factor of 1.29.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
