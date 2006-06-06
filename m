Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWFFON0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWFFON0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 10:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWFFON0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 10:13:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6016 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750959AbWFFONZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 10:13:25 -0400
Date: Tue, 6 Jun 2006 10:17:55 -0400
From: Don Zickus <dzickus@redhat.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Miles Lane <miles.lane@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Message-ID: <20060606141755.GN2839@redhat.com>
References: <4480C102.3060400@goop.org> <4483DF32.4090608@goop.org> <20060605004823.566b266c.akpm@osdl.org> <a44ae5cd0606050135w66c2abeu698394b4268e4790@mail.gmail.com> <1149576246.32046.166.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149576246.32046.166.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2006 at 02:44:06PM +0800, Shaohua Li wrote:
> On Mon, 2006-06-05 at 16:35 +0800, Miles Lane wrote:
> > On 6/5/06, Andrew Morton <akpm@osdl.org> wrote:
> > 
> > > Do you think the suspend breakage is related to that patch? 
> > > 
> > > Miles also reports that every second suspend fails for him.  Miles,
> > does 
> > > 'nmi_watchdog=0' make it better?
> > 
> > I tried using that as an appended boot option, but it didn't change
> > the 
> > behavior.
> Does below patch help? The nmi suspend/resume doesn't look good to me.
> Only CPU0 uses the suspend/resume code path. Other CPUs run the CPU
> hotplug code path.
>

This patch makes sense.  I was unaware that the suspend/resume case was
only for CPU0.  

However, I am still concerned about one thing though.  After looking
through the bugzilla attachments, the reason why Jeremy's machine is
crashing on the second suspend is because one of the watchdog timers is
turning on after the resume.  

Because he is using a i386 machine, the nmi watchdog is disabled by
default.  This is evident by his attachment ('cat /proc/interrupts | grep
NMI was zero).  The machine suspends then resumes.  Running the same 'cat'
command again, we see NMI output.  My guess is during the second suspend,
the NMI watchdog code sees one watchdog is enabled but tries to disable
all of them (this is a bug and I will provide that patch).  Upon disabling
the 'disabled' watchdog, the BUG_ON is hit and the machine goes down.  

My concern is _why_ one of the watchdog timers was re-enable during
resume.  It makes sense that CPU0 was still disabled, but apparently the
hotplug case for CPU1 didn't realize that CPU1 was previously disabled or
that the default is to remain off.  I need to look at the code for this.
Any inputs from those that know the hotplug code better than I?

Cheers,
Don
 
