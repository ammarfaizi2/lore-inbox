Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262397AbVGNXkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbVGNXkm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 19:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbVGNXkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 19:40:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10182 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262397AbVGNXkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 19:40:39 -0400
Date: Thu, 14 Jul 2005 16:39:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel McNeil <daniel@osdl.org>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [rfc patch 2/2] direct-io: remove address alignment check
Message-Id: <20050714163947.3fb952f1.akpm@osdl.org>
In-Reply-To: <1121373639.6025.70.camel@ibm-c.pdx.osdl.net>
References: <1121298112.6025.21.camel@ibm-c.pdx.osdl.net.suse.lists.linux.kernel>
	<p73hdex5xws.fsf@bragg.suse.de>
	<1121356952.6025.33.camel@ibm-c.pdx.osdl.net>
	<20050714182325.GI23737@wotan.suse.de>
	<1121373639.6025.70.camel@ibm-c.pdx.osdl.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil <daniel@osdl.org> wrote:
>
> Do drivers have problems with odd addresses or with
>  non-512 addresses?

I do recall hearing rumours that some bus-masters have fairly strict memory
alignment requirements.  A cacheline size, perhaps - that would be 32 bytes
given the age of the hardware.

But yeah, it's v.  risky to assume that all bus masters can cope with
memory alignments down to two bytes.

It would be sane to put the minimum alignment into ->backing_dev_info,
default to 512, get the device drivers to override that as they are tested.

But this introduces a very very bad problem: people will write applications
which work on their hardware, ship the things and then find that the apps
break on other people's hardware.  So we can't do that.

Instead, we need to work out the minimum alignment requirement for all disk
controllers and DMA controllers and motherboards in the world.  And that
includes catering for weird ones which appear to work but which
occasionally fail in mysterious ways with finer alignments.  That's hard. 
It's easier to continue to make application developers jump through hoops.
