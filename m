Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933787AbWKSXwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933787AbWKSXwJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 18:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933788AbWKSXwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 18:52:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62670 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933785AbWKSXwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 18:52:05 -0500
Subject: Re: [patch 07/30] bcm43xx: Drain TX status before starting IRQs
From: Dan Williams <dcbw@redhat.com>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, netdev@vger.kernel.org, mb@bu3sch.de,
       greg@kroah.com, "John W. Linville" <linville@tuxdriver.com>
In-Reply-To: <455F59BB.6060204@lwfinger.net>
References: <20061116024332.124753000@sous-sol.org>
	 <20061116024511.458086000@sous-sol.org>  <455F59BB.6060204@lwfinger.net>
Content-Type: text/plain
Date: Sun, 19 Nov 2006 18:51:54 -0500
Message-Id: <1163980315.2881.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-18 at 13:06 -0600, Larry Finger wrote:
> Chris Wright wrote:
> > -stable review patch.  If anyone has any objections, please let us know.
> > ------------------
> > 
> > From: Michael Buesch <mb@bu3sch.de>
> > 
> > Drain the Microcode TX-status-FIFO before we enable IRQs.
> > This is required, because the FIFO may still have entries left
> > from a previous run. Those would immediately fire after enabling
> > IRQs and would lead to an oops in the DMA TXstatus handling code.
> > 
> > Cc: "John W. Linville" <linville@tuxdriver.com>
> > Signed-off-by: Michael Buesch <mb@bu3sch.de>
> > Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> > Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> > ---
> 
> Chris,
> 
> The regression turns out to be a locking problem involving bcm43xx, wpa_supplicant, and 
> NetworkManager. The exact cause is unknown; however, this patch is clearly not the problem. Please 
> reinstate it for inclusion in -stable.

NM should be using wpa_supplicant underneath.  But depending on the NM
version, NM may be issuing any one of SIWENCODE (only to clear keys),
[S|G]IWSCAN, GIWRANGE, GIWAP, [S|G]IWMODE, [S|G]IWFREQ.  Mainly, NM
cleans up after wpa_supplicant, gets information about the current
connection, and does scans.  All other connection setup and handling is
done by wpa_supplicant.  But note that NM will do any of the above
operations at any time, no matter what wpa_supplicant is doing at that
time.  So the locking in the driver needs to be right, but it should be
right anyway regardless of whether either one or both of NM and
wpa_supplicant is in the picture...

Dan

> Thanks,
> 
> Larry
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

