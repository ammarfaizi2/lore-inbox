Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263865AbUGFNmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbUGFNmH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 09:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263881AbUGFNmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 09:42:07 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:7840 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263865AbUGFNl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 09:41:59 -0400
Date: Tue, 6 Jul 2004 08:41:16 -0500
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>, linas@austin.ibm.com
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] PPC64: log firmware errors during boot.
Message-Id: <20040706084116.11ab7988.moilanen@austin.ibm.com>
In-Reply-To: <16610.39955.554139.858593@cargo.ozlabs.ibm.com>
References: <20040629191046.Q21634@forte.austin.ibm.com>
	<16610.39955.554139.858593@cargo.ozlabs.ibm.com>
Organization: LTC
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Firmware can report errors at any time, and not atypically during boot.
> > However, these reports were being discarded until th rtasd comes up,
> > which occurs fairly late in the boot cycle.  As a result, firmware
> > errors during boot were being silently ignored.

Linas, the main consumer of error-log is events coming in from
event-scan.  We don't call event-scan until rtasd is up (eg they are
queued in FW until we call event-scan).  The only events I see us
missing are epow events, eeh? and anything coming from check-exception. 
epow is set up pretty late as well, and I don't think we even support
check-exception on 2.6.  eeh might be an issue.

> 
> > This patch at least gets them printk'ed so that at least they show
> > up in boot.msg/syslog.  There are two other logging mechanisms,
> > nvram and rtas, that I didn't touch because I don't understand
> > the reprecussions.  In particular, nvram logging isn't enabled
> > until late in the boot ... but what's the point of nvram logging
> > if not to catch messages that occured very early in boot ??
> 
> Indeed.
> 
> As for printk'ing the errors, it is annoying and it seems of somewhat
> dubious benefit to me, given that it is just incomprehensible hex
> numbers that can go on and on.  There has to be a better way.  Putting
> it in nvram seems like a better option to me.  I don't know of any
> reason why we can't use nvram quite early on.
> 

Paul,

We can initialize nvram very early, but we shouldn't discard an event
stored in nvram until rtasd is up and can pull the event out as it might
have been the error that took the system down on the previous boot.

We could probably start rtasd up a little earlier, but I'm not sure it
buys us that much.

Thanks,
Jake
