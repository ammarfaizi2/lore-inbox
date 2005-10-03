Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVJCNzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVJCNzx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 09:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVJCNzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 09:55:53 -0400
Received: from mgw-ext04.nokia.com ([131.228.20.96]:61900 "EHLO
	mgw-ext04.nokia.com") by vger.kernel.org with ESMTP id S932232AbVJCNzw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 09:55:52 -0400
Date: Mon, 3 Oct 2005 16:54:45 +0300
From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
To: linux-kernel@vger.kernel.org
Subject: CMD7 failing on ATP & Transcend MMC cards
Message-ID: <20051003135445.GA6560@angel.research.nokia.com>
Reply-To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: GNU/Linux angel.research.nokia.com
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 03 Oct 2005 13:54:27.0855 (UTC) FILETIME=[F88021F0:01C5C821]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some MMC cards were failing repeatedly on Omap1710 in the card 
select command CMD7.  Doing an extra status inquiry when leaving the card 
identification mode removed the problem.  This is possibly Omap1710 mmc 
controller only problem, but might also also appear on other mmc 
controllers.

So far, the problem occured only on ATP and Transcend cards when the card 
have already been detected and then mmc_detect_change() is called to
check if any new cards have been inserted.  After CMD2 the next card 
select command CMD7 fails due to illegal command error.

I don't know why only ATP and Transcend have this problem and why
doing status inquiry CMD13 helps.  Status inquiry command is neutral
and is claimed to not change the card state in the MMC spec. :-)

The order of commands must be CMD13 first, then CMD7.  CMD13 fails
also due to illegal instruction error after CMD2 but after this the
card is back to its senses.

If CMD7 is run first, and CMD13 once CMD7 is seen failing, this fails
to bring the card back to its senses.  Then the CMD7 fails repeatedly
due to command timeout before and after CMD13.

I got rid of the problem by simply adding call to mmc_check_cards()
at and of mmc_setup() function, which is perhaps an overkill. One could do
it also in mmc_rescan() after switching back to higher clock.

Jarkko Lavinen
