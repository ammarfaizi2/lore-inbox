Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264181AbTGBRGL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 13:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbTGBRGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 13:06:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16142 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264181AbTGBRGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 13:06:04 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: simple pnp bios io resources bug makes  system unusable
Date: 2 Jul 2003 17:20:21 GMT
Organization: Transmeta Corp
Message-ID: <1057166421.141082@palladium.transmeta.com>
References: <3F010229.4020201@bellsouth.net> <20030701223050.GA19402@neo.rr.com>
X-Trace: palladium.transmeta.com 1057166421 14947 127.0.0.1 (2 Jul 2003 17:20:21 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 2 Jul 2003 17:20:21 GMT
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: torvalds@penguin.transmeta.com (Linus Torvalds)
Cache-Post-Path: palladium.transmeta.com!unknown@torvalds-home.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030701223050.GA19402@neo.rr.com>,
Adam Belay  <ambx1@neo.rr.com> wrote:
>
>The pnpbios is reserving the complete range of every possible
>io port.  This causes device activation to fail for every device
>that needs an io port because that resource will always appear
>busy.

No, I don't think that's what it is doing at all. Quite the reverse, in
fact.

Look:

>On Mon, Jun 30, 2003 at 11:38:17PM -0400, CarlosRomero wrote:
>> 
>> cat /sys/devices/pnp0/00\:0c/resources
>> io 0x00000000-0xffffffff

This means that "io" was zero, but more importantly, it means that "len"
was zero too.

>> fixup: check for null io base, other devices are now able to initialize.
>
>Unfortunatly it's not quite that simple.

It _is_ that simple, but the code should check for "len" being zero, ie
the fix looks like it should be just a simple

	if (!len)
		return;

and that should fix it.

>Below are two examples that both use a base of 0 in a valid way.

Yes, and clearly they don't have "len == 0".

>Currently I'm leaning toward this logic...
>if we have any of the following situations
>- 0x00000000 for base and 0xffffffff for end
>- 0x00000000 for base and 0x00000000 for end
>- 0xffffffff for base and 0xffffffff for end
>then the resource range can be considered disabled.

I would suggest:

 - "len == 0"		=>  obviously disabled (both IO and memory)
 - "end < base"		=>  obviously disabled due to overflow crap
 - "end >= 0x10003"	=>  IO disabled (yeah, non-x86 can have IO above
			    that range in PCI, but I think it's undefined
			    behaviour)

all three should be cases of "obviously we can't validly have such a
resource", and the "len == 0" case should trivially fix the case that
CarlosRomero saw.

			Linus
