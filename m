Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271041AbTHCGks (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 02:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271042AbTHCGks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 02:40:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24979 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271041AbTHCGkp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 02:40:45 -0400
Message-ID: <3F2CAE61.7070401@pobox.com>
Date: Sun, 03 Aug 2003 02:40:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
CC: Werner Almesberger <werner@almesberger.net>,
       Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: TOE brain dump
References: <20030802140444.E5798@almesberger.net> <3F2BF5C7.90400@us.ibm.com> <3F2C0C44.6020002@pobox.com> <20030802184901.G5798@almesberger.net>
In-Reply-To: <20030802184901.G5798@almesberger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> Jeff Garzik wrote:
> 
>>jabbering at the same time.  TCP is a "one size fits all" solution, but 
>>it doesn't work well for everyone.
> 
> 
> But then, ten "optimized xxPs" that work well in two different
> scenarios each, but not so good in the 98 others, wouldn't be
> much fun either.
> 
> It's been tried a number of times. Usually, real life sneaks
> in at one point or another, leaving behind a complex mess.
> When they've sorted out these problems, regular TCP has caught
> up with the great optimized transport protocols. At that point,
> they return to their niche, sometimes tail between legs and
> muttering curses, sometimes shaking their fist and boldly
> proclaiming how badly they'll rub TCP in the dirt in the next
> round. Maybe they shed off some of the complexity, and trade it
> for even more aggressive optimization, which puts them into
> their niche even more firmly. Eventually, they fade away.
> 
> There are cases where TCP doesn't work well, like a path of
> badly mismatched link layers, but such paths don't treat any
> protocol following the end-to-end principle kindly.
> 
> Another problem of TCP is that it has grown a bit too many
> knobs you need to turn before it works over your really fast
> really long pipe. (In one of the OLS after dinner speeches,
> this was quite appropriately called the "wizard gap".)
> 
> 
>>It's obviously not over a WAN...
> 
> 
> That's why NFS turned off UDP checksums ;-) As soon as you put
> it on IP, it will crawl to distances you didn't imagine in your
> wildest dreams. It always does.

Really fast, really long pipes in practice don't exist for 99.9% of all 
Internet users.


When you approach traffic levels that push you want to offload most of 
the TCP net stack, then TCP isn't the right solution for you anymore, 
all things considered.


The Linux net stack just isn't built to be offloaded.  TOE engines will 
either need to (1) fall back to Linux software for all-but-the-common 
case (otherwise netfilter, etc. break), or, (2) will need to be 
hideously complex beasts themselves.  And I can't see ASIC and firmware 
designers being excited about implementing netfilter on a PCI card :)

Unfortunately some vendors seem to choosing TOE option #3:  TCP offload 
which introduces many limitations (connection limits, netfilter not 
supported, etc.) which Linux never had before.  Vendors don't seem to 
realize TOE has real potential to damage the "good network neighbor" 
image the net stack has.  The Linux net stack's behavior is known, 
documented, predictable.  TOE changes all that.

There is one interesting TOE solution, that I have yet to see created: 
run Linux on an embedded processor, on the NIC.  This stripped-down 
Linux kernel would perform all the header parsing, checksumming, etc. 
into the NIC's local RAM.  The Linux OS driver interface becomes a 
virtual interface with a large MTU, that communicates from host CPU to 
NIC across the PCI bus using jumbo-ethernet-like data frames. 
Management frames would control the ethernet interface on the other side 
of the PCI bus "tunnel".


>>So, fix the other end of the pipeline too, otherwise this fast network 
>>stuff is flashly but pointless.  If you want to serve up data from disk, 
>>then start creating PCI cards that have both Serial ATA and ethernet 
>>connectors on them :)  Cut out the middleman of the host CPU and host 
>>memory bus instead of offloading portions of TCP that do not need to be 
>>offloaded.
> 
> 
> That's a good point. A hierarchical memory structure can help
> here. Moving one end closer to the hardware, and letting it
> know (e.g. through sendfile) that also the other end is close
> (or can be reached more directly that through some hopelessly
> crowded main bus) may help too.

Definitely.

	Jeff



