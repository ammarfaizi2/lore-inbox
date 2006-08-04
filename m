Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161398AbWHDUX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161398AbWHDUX5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 16:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWHDUX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 16:23:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:56508 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932621AbWHDUX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 16:23:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tPZDT8cMTZ3NgmVsxquszRNzdPwE/yGLLqYsANx4krz1m/IriX3qFMYgkyaiGMpspAIIhXB4yMQKipUSM15dkMPd9zWmFBi30v6tNISH6k6hVhsBihCrANcx6dPrA5m/l4xlRj5mHqRRaa5nA2UTK2yWZtGw+/8LpBgt9DHYBCI=
Message-ID: <806dafc20608041323v5c1fecd6we801df9353a2d87d@mail.gmail.com>
Date: Fri, 4 Aug 2006 16:23:54 -0400
From: "Christopher Montgomery" <xiphmont@gmail.com>
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Stability-Problem of EHCI with a larger number of USB-Hubs/Devices
Cc: linux-usb-devel@lists.sourceforge.net,
       "Matthias Schniedermeyer" <ms@citd.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200608041108.19549.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44C126C3.9000105@citd.de> <200608041108.19549.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/06, David Brownell <david-b@pacbell.net> wrote:
> Did you try with 2.6.18-rc3?  There's a Kconfig option for an
> improved interrupt scheduler, which might help especially with
> all those low speed devices.

Actually, assuming I'm reading the spec right, I've come to realize
Dan's improved scheduler patch allows illegal QH schedules that the
old scheduler prevented (as the old scheduler would not allow any set
of complete splits to overlap).  Dan's patch allows complete splits to
be serviced in a different order than the original start splits, which
will cause the out of order responses to be dropped on the floor.

QHs splits must be scheduled in the order the QHs appear in a given
frame; if QH B is scheduled after QH A and uses a later microframe for
its SS, but appears in a higher period level of the tree such that it
actually occurs earlier in the frame, QH A may see all of its complete
splits lost; this is subject to uncertainties due to bti stuffing and
bandwidth recovery/error recovery.  It is possible in our current
scheduler with Dan's improvement patch.

Monty
