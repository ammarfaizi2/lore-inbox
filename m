Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbVJDNVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbVJDNVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 09:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVJDNVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 09:21:37 -0400
Received: from mgw-ext03.nokia.com ([131.228.20.95]:14503 "EHLO
	mgw-ext03.nokia.com") by vger.kernel.org with ESMTP id S932449AbVJDNVh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 09:21:37 -0400
Date: Tue, 4 Oct 2005 16:21:44 +0300
From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CMD7 failing on ATP & Transcend MMC cards
Message-ID: <20051004132144.GA13048@angel.research.nokia.com>
Reply-To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
References: <20051003135445.GA6560@angel.research.nokia.com> <20051003140252.GG16717@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003140252.GG16717@flint.arm.linux.org.uk>
X-Operating-System: GNU/Linux angel.research.nokia.com
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 04 Oct 2005 13:21:26.0709 (UTC) FILETIME=[860EFE50:01C5C8E6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 03:02:52PM +0100, Russell King wrote:
> I'm not surprised.  CMD2 is part way through the initialisation
> sequence, so no one should be sending a CMD7.

The command sequence in the initial card detection is:

  CMD1      card send its operation conditions
  CMD2      card sends its CID
  CMD3(rca) Card is given relative call address. Card enters standby and 
            switches to push pull mode and won't respond to CMD1-3 anymore.
  CMD2      Check for other cards. None responds. All cards have been
            identified. CMD2 is sent many times.  
  CMD7(rca) The card is addressed with its RCA and enters transfer state.

The card is then accessed normally and everything works and also
ATP and Transcend cards work up to this.

Problems appear when mmc_detect_change() is called from switch_handler().
This happens when cover switch interrupt comes but the card has not been
removed. Old cards are checked with CMD13 and new cards if any are 
detected:

   CMD7(0)    Deselect currently selected card. Its RCA remains the
              same.
   CMD1       
   CMD2       CMD2 sent many times, but no card replies. 
   CMD7(rca)  The selected card should respond. ATP and Transcend
              give illegal instruction instead and retries with CMD7
	      fail.


> After a CMD2, the next expected command is a CMD3 for MMC cards (maybe
> not SD cards).

Does this apply when threre are no new cards and no card replied to
CMD2?

Jarkko Lavinen
