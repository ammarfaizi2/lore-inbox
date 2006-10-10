Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWJJRUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWJJRUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWJJRTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:19:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:7306 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964849AbWJJRQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:16:05 -0400
Date: Tue, 10 Oct 2006 10:15:15 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Yeasah Pell <yeasah@schwide.net>, Steven Toth <stoth@hauppauge.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 11/19] Video: cx24123: fix PLL divisor setup
Message-ID: <20061010171515.GL6339@kroah.com>
References: <20061010165621.394703368@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="video-cx24123-fix-pll-divisor-setup.patch"
In-Reply-To: <20061010171350.GA6339@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Yeasah Pell <yeasah@schwide.net>

The cx24109 datasheet says: "NOTE: if A=0, then N=N+1"

The current code is the result of a misinterpretation of the datasheet to
mean exactly the opposite of the requirement -- The actual value of N is 1 greater than the value written when A is 0, so 1 needs to be *subtracted*
from it to compensate.

Signed-off-by: Yeasah Pell <yeasah@schwide.net>
Signed-off-by: Steven Toth <stoth@hauppauge.com>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/media/dvb/frontends/cx24123.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17.13.orig/drivers/media/dvb/frontends/cx24123.c
+++ linux-2.6.17.13/drivers/media/dvb/frontends/cx24123.c
@@ -579,8 +579,8 @@ static int cx24123_pll_calculate(struct 
 	ndiv = ( ((p->frequency * vco_div * 10) / (2 * XTAL / 1000)) / 32) & 0x1ff;
 	adiv = ( ((p->frequency * vco_div * 10) / (2 * XTAL / 1000)) % 32) & 0x1f;
 
-	if (adiv == 0)
-		ndiv++;
+	if (adiv == 0 && ndiv > 0)
+		ndiv--;
 
 	/* control bits 11, refdiv 11, charge pump polarity 1, charge pump current, ndiv, adiv */
 	state->pllarg = (3 << 19) | (3 << 17) | (1 << 16) | (pump << 14) | (ndiv << 5) | adiv;

--
