Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268142AbUJOCU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268142AbUJOCU2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 22:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268145AbUJOCU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 22:20:28 -0400
Received: from smtp-relay.dca.net ([216.158.48.66]:15053 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S268142AbUJOCUY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 22:20:24 -0400
Date: Thu, 14 Oct 2004 22:20:19 -0400
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: greg@kroah.com, sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] SMBus multiplexing for the Tyan S4882
Message-ID: <20041015022019.GC4035@jupiter.solarsys.private>
References: <K2nOCbfL.1097749885.3147790.khali@gcu.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <K2nOCbfL.1097749885.3147790.khali@gcu.info>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jean:

* Jean Delvare <khali@linux-fr.org> [2004-10-14 12:31:26 +0200]:

(snip)

> A patch against lm_sensors CVS can be seen here:
> http://khali.linux-fr.org/devel/i2c/lm_sensors-CVS-S4882.patch
> This is for Linux 2.4 but I plan to port it to 2.6 soon, which is why I
> am requesting for comments on the LKML.

(snip)

> Expected Objections & Answers:
> 
> O: The PCA9556 support could be moved to a separate driver.
> A: I don't see no benefit. There is very little code for the PCA9556
> driver among the code I added, and I believe that calling a PCA9556
> interface would represent no less code. There is not much code to reuse
> anyway, since the way the PCA9556 driver is used is specific to each
> board. It could even be used for something compeletly different than
> SMBus multiplexing, since it is a simple 8 channel I/O chip.
> 
> O: The specific S4882 support could be moved to a completely different
> driver.
> A: This would duplicate most of the i2c-amd756 driver code. The
> additional support will not affect non-S4882 users except for the size
> of the driver. People concerned about the size can recompile the driver
> without the S4882 support.
> 
> Before I commit my changes to the lm_sensors CVS and port them to the
> Linux 2.6 driver, I welcome constructive comments about my work.

Heh, you definitely predicted my objections. :)  But I think you can
support this board in an independent module without copying any amd756
code.  It would look very much like your patch already...

E.g. the i2c-s4882 module would act as a i2c-client for the mux chip,
but also export four virtual adapters for the segments behind the mux.
One would attach it to an existing adapter (in your case amd756) by
passing it a module parameter (i2c bus id).  Is there any reason this
wouldn't work?

The downside is that sensors-detect would need more help to recognize
this setup.  But detection is, after all, what it does.

The upside is that you don't need to modify the amd756 driver at all.
Maybe that's not a big deal for this one board, but that slope is
slippery.  How many other boards, slightly different, will need such
support?  I think it's better to leave the real bus adapters alone
and put the support for new combinations in new modules.

Somewhat related: since I wrote i2c-stub, I was thinking of creating
i2c-trace... which would attach to an existing adapter while exporting
another virtual adapter.  Anything attached to the i2c-trace adapter
would generate log messages just like i2c-stub.  That's similar to
your patch in a way; and that's why I think it can be independent
from the real bus adapter code.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

