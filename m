Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263575AbTDGRom (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 13:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbTDGRom (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 13:44:42 -0400
Received: from fmr02.intel.com ([192.55.52.25]:35042 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S263575AbTDGRok (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 13:44:40 -0400
Message-ID: <F760B14C9561B941B89469F59BA3A84725A24D@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Andrew Morton <akpm@digeo.com>, Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: felipe_alfaro@linuxmail.org, linux-kernel@vger.kernel.org
Subject: RE: 2.5.66-bk12: acpi_power_off: sleeping function called from il
	legal context
Date: Mon, 7 Apr 2003 10:56:03 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andrew Morton [mailto:akpm@digeo.com] 
> Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
> >
> > -	if (in_atomic())
> > +	if (in_atomic() || irqs_disabled())
> >  		timeout = 0;
> 
> Andy, why does the ACPI code have this test?
> 
> Is it to determine whether a caller of this functon is 
> currently holding a spinlock?  If so then it will only work 
> on a preemptible kernel.

No, see below.

> A non-preempt kernel will not increment preempt_count() when 
> it takes a spinlock and ACPI could mistakenly schedule away 
> and cause a system deadlock.

acpi_enter_sleep_state should not be acquiring any semaphores. All calls
to acpi_set_register in that function should be called with
ACPI_MTX_DO_NOT_LOCK. Problem solved. :)

Andrew, as to why we are doing this:

The main function of the ACPI interpreter is to execute control methods.
We never execute a control method from an interrupt, we always do it
from thread context. We have semaphores to protect various resources,
and use this function (acpi_os_wait_semaphore) to acquire them. We
usually call it with timeout value ACPI_WAIT_FOREVER, which results in a
down().

However, we also have to execute control methods early in the boot
sequence. down() would never block but it thinks it might, so we want to
call down_trylock instead. in_atomic() seemed to be a good (?) way to
tell whether we need to avoid down() or not.

Thoughts on better ways to do this, perhaps? I guess I should at least
add a comment above that line.

Regards -- Andy
