Return-Path: <linux-kernel-owner+w=401wt.eu-S965163AbWLTVTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbWLTVTQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 16:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbWLTVTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 16:19:15 -0500
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:41235 "HELO
	smtp105.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965163AbWLTVTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 16:19:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=gEKCK/Y+eK4SImftntgbZI96ZmfspYJDh/zJLmdbfFJJMDoowsrvyKmW484pBIUnuLpIo8ybpy0n8s225xYFL6wg3QEF4avffNXisAMEzoBK6UvK68GHuJJcTEdJOS15fU9/N2Jp0zm7M4ZIV6jtPkgay/9u7yrkhCJ2QWtJy7k=  ;
X-YMail-OSG: gSrmI80VM1lsWJV3QEuI9UPVtwqkECnDJTO_Z6Gltov84lPGwv5QbrluwZHQYSMwBAuqalbhTbucFBqf2UyRcEm2.AFHxCNxnXLlyJVOOUcDdN9UZ29roySB43r95zPc_02W0NuELyCwWeYDfBTF440tfrRS56Ey9a31fugtp3xcBJVF_1qjesMUE1ve
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.20-rc1 0/6] arch-neutral GPIO calls
Date: Wed, 20 Dec 2006 13:04:02 -0800
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>
References: <200611111541.34699.david-b@pacbell.net>
In-Reply-To: <200611111541.34699.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612201304.03912.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Based on earlier discussion, I'm sending a refresh of the generic GPIO
patch, with several (ARM based) implementations in separate patches:

 - Core patch, doc + <asm-arm/gpio.h> + <asm-generic/gpio.h>
 - OMAP implementation
 - AT91 implementation
 - PXA implementation
 - SA1100 implementation
 - S3C2410 implementation

I know there's an AVR32 implementation too; and there's been interest
in this for some PPC support as well.

This time I'm proposing that at least the core patch go into the MM
tree; I think there's been enough discussion, and a general acceptance
that we need this kind of API.  Russell usually wants ARM patches to
go through his system, so those implementations above should probably
not go through MM.


With the exception of the AT91 implementation, those are all trivial
wrappers around the existing calls ... which should highlight the fact
that this API reflects existing practice, but with more generic syntax.
AT91 differed only because it needed to split out a "configure as GPIO"
primitive, not merged with the "set gpio direction" call.

Other than clarifications, the main change in the doc is defining
new calls safe for use with GPIOs on things like pcf8574 I2C gpio
expanders; those new calls can sleep, but are otherwise the same as
the spinlock-safe versions.  The implementations above implement that
as a wrapper (the asm-generic header) around the spinlock-safe calls.

This API is orthogonal to pin configuration (configure ball X17 as
GPIO 23 rather than R33, with pulldown, etc) which is in any case
highly platform-specific.

Also, as an API rather than an implementation framework, this does
not expose a notion of a "GPIO controller", of which any given
system might have several.  It's allowed by the API (e.g. see the
OMAP code), but is not required.  I expect that sort of thing will
come later; it's common enough to have SOC-based boards with GPIOs
on the SOC as well as a couple external chips.  

- Dave

