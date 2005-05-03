Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVECXN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVECXN1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 19:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVECXN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 19:13:27 -0400
Received: from palrel12.hp.com ([156.153.255.237]:29880 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261900AbVECXNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 19:13:20 -0400
Date: Tue, 3 May 2005 16:13:19 -0700
To: breed@zuzulu.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jouni Malinen <jkmaline@cc.hut.fi>, chessing@users.sourceforge.net
Subject: Re: [PATCH] dynamic wep keys for airo.c
Message-ID: <20050503231319.GA22452@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20050503183335.GA19691@bougret.hpl.hp.com> <32958.198.4.83.52.1115159671.squirrel@zuzulu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32958.198.4.83.52.1115159671.squirrel@zuzulu.com>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 05:34:31PM -0500, breed@zuzulu.com wrote:
> Jean,
> 
> There is no patch to xsupplicant that will work without patching the
> airo.c driver. The current airo.c driver always disables the MAC before
> setting the WEP key whether it is temporary or permanent. This is
> incorrect. When the MAC is disabled the card disassociates causing the
> whole handshake to start over again.

	Yes, I know perfectly. A patch is needed, however I don't
think your current patch is the most appropriate solution.

	The current solution is :
	1) set perm key -> goes in the eeprom, reset MAC
	2) set temp key -> not in the eeprom, reset MAC
	o /proc can set (1) and (2)
	o iwconfig can only set (1)
	o xsupplicant always set (1) - broken

	You solution is :
	1) set temp key -> not in the eeprom, not reset MAC
	2a) set perm key -> goes in the eeprom, reset MAC
	2b) set perm key -> goes in the eeprom, not reset MAC
	o module parameter select (2a) or (2b)
	o iwconfig can set (2) {default} or (1) {temp keyword}
	o old xsupplicant set (2) - may work, depend on module parameter
	o new xsupplicant set (1) - always work

	First, do we know for sure that all Aironet firmware will
accept to change the perm WEP key without having to reset the MAC ?
Maybe the Cisco driver does it this way, but it only target the latest
firware rev, whereas up to know we have included in the driver code
for very antique firmware rev. I don't have the answer to that one.
	Second, I think that the module parameter is counter
productive. What we want there is people migrating to the new
xsupplicant that does the right thing. Also, module parameter is not
something that can be changed on the fly, and is one more thing to
configure. We want things to always work, all the time.

	What I would think is better long term :
	1) set temp key -> not in the eeprom, not reset MAC
	2) set perm key -> goes in the eeprom, reset MAC
	o iwconfig can set (2) {default} or (1) {temp keyword}
	o old xsupplicant set (2) - always broken
	o new xsupplicant set (1) - always work

	But, that's only my personal opinion, and you may want to
check what the new xsupplicant is doing before making the final
decision.

> ben

	Have fun...

	Jean
