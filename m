Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275044AbTHLFim (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 01:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275045AbTHLFim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 01:38:42 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:22759 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S275044AbTHLFil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 01:38:41 -0400
Subject: Re: NAT + IPsec in 2.6.0-test2
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Jim Carter <jimc@math.ucla.edu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0308112150430.4824@xena.cft.ca.us>
References: <1060662905.1840.103.camel@iso-8590-lx.zeusinc.com>
	 <Pine.LNX.4.53.0308112150430.4824@xena.cft.ca.us>
Content-Type: text/plain
Message-Id: <1060666691.1840.117.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 12 Aug 2003 01:38:11 -0400
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-3.7, required 10,
	AWL, EMAIL_ATTRIBUTION, IN_REP_TO, REFERENCES, SPAM_PHRASE_00_01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-12 at 00:56, Jim Carter wrote:
> Could it be that the *name* of the ipsec device has changed?  Messing with
> vtun, I did that to myself recently and suffered a similar loss of
> connectivity through the tunnel.  My solution was an iptables rule saying
> that packets going to any interface except the house network get NATted.

Because the new IPsec code is built in there is no "ipsec" device to
speak of.  My initial analysis is that FreeS/WAN basically fed a packet
through the system twice, once via the real interface and once via the
tunnel.  This allowed for easy separation of rules.

This simply doesn't seem to be the case anymore, packets leaving an
interface are either encrypted or not based on kernel policies set via
setkey.  It looks like it's been encrypted before it reaches the
POSTROUTING rule thus precluding it from being NAT'd.

My rule doesn't use an interface anyway, it's this:

iptables -t nat -A POSTROUTING -s ! 10.250.1.129/32 -d 10.0.0.0/8 -j
SNAT --to-source 10.250.1.129

Which basically says if a packet is going to 10.0.0.0/8 and it's source
is not 10.250.1.129 to SNAT it to that address.

Later,
Tom


