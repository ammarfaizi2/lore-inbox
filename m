Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932574AbWHCP5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbWHCP5k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbWHCP5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:57:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:60141 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932574AbWHCP5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:57:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AN6pPgbNpwONMatKrhRGfVGmuY1V2ibBZ8w11FRxZWiFCMYJNWofNCgl6QaY/Z7kpqxPBrVawQTYGZGi1XENk4uykJy0YIFNW1L1WKlDz/DR9r/zBpfrxEVAQeigy0rlfHnefG4upQxebEV6rQ4nOVxP1eX63iMp/xrpofwvT4g=
Message-ID: <41b516cb0608030857h1d55820rfd4ccd0cc56dd71d@mail.gmail.com>
Date: Thu, 3 Aug 2006 08:57:36 -0700
From: "Chris Leech" <chris.leech@gmail.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: problems with e1000 and jumboframes
Cc: "Krzysztof Oledzki" <olel@ans.pl>, "Arnd Hannemann" <arnd@arndnet.de>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060803151631.GA14774@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44D1FEB7.2050703@arndnet.de> <20060803135925.GA28348@2ka.mipt.ru>
	 <44D20A2F.3090005@arndnet.de> <20060803150330.GB12915@2ka.mipt.ru>
	 <Pine.LNX.4.64.0608031705560.8443@bizon.gios.gov.pl>
	 <20060803151631.GA14774@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> > Strange, why this skb_shared_info cannon be added before first alignment?
> > And what about smaller frames like 1500, does this driver behave similar
> > (first align then add)?
>
> It can be.
> Could attached  (completely untested) patch help?

Note that e1000 uses power of two buffers because that's what the
hardware supports.  Also, there's no program able MTU - only a single
bit for "long packet enable" that disables frame length checks when
using jumbo frames.  That means that if you tell the e1000 it has a
16k buffer, and a 16k frame shows up on the wire, it's going to write
to the entire 16k regardless of your 9k MTU setting.  If a 32k frame
shows up, two full 16k buffers get written to (OK, assuming the frame
can fit into the receive FIFO)

That's why I've always been against trying to optimize the allocation
sizes in the driver, even with your small change the skb_shinfo area
can get corrupted.  It may be unlikely, because the frame still has to
be valid, but some switches aren't real picky about what sized frame
they'll forward on if you enable jumbo support either.  So any box on
the LAN could send you larger than MTU frames in an attempt to corrupt
memory.

I believe that if you tell a hardware device it has a buffer of a
certain size, you need to be prepared for that entire buffer to get
written to.  Unfortunately that means wasteful allocations for e1000
if a single buffer per frame is going to be used.

- Chris
