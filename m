Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264972AbTAESc2>; Sun, 5 Jan 2003 13:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264975AbTAESc2>; Sun, 5 Jan 2003 13:32:28 -0500
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:63422 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S264972AbTAESc1>; Sun, 5 Jan 2003 13:32:27 -0500
Date: Sun, 5 Jan 2003 13:23:54 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] acpi_os_queue_for_execution()
Message-ID: <20030105132354.G628@nightmaster.csn.tu-chemnitz.de>
References: <F760B14C9561B941B89469F59BA3A84725A107@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A107@orsmsx401.jf.intel.com>; from andrew.grover@intel.com on Fri, Jan 03, 2003 at 11:00:04AM -0800
X-Spam-Score: -2.9 (--)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18VFhj-0003VN-00*LJZe4pkPijc*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Fri, Jan 03, 2003 at 11:00:04AM -0800, Grover, Andrew wrote:
> > From: Pavel Machek [mailto:pavel@ucw.cz] 
> > Acpi seems to create short-lived kernel threads, and I don't quite
> > understand why. 
[...]
> > and acpi_thermal_run creates kernel therad that runs
> > acpi_thermal_check. Why is not acpi_thermal_check called directly? I
> > don't like idea of thread being created every time thermal zone needs
> > to be polled...
> 
> Are we allowed to block in a timer callback? One of the things
> thermal_check does is call a control method, which in turn can be very
> slow, sleep, etc., so I'd guess that's why the code tries to execute
> things in its own thread.

No you just have to switch completely to schedule_work() as you
do for calls from interrupts. The limitations you mention in
osl.c for this function are lifted (look at linux/kernel/workqueue.c) and
we have per CPU workqueues now.

So no need for this uglification and less code to maintain for
you ;-)

The short lived threads are not necessary anymore. If this
thermal check will happen often an extra permanent thread for
this, which is kicked by a timer might be more apropriate here.

That thread could be started, once the thermal control is loaded.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
