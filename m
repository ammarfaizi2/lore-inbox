Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422773AbWJLHFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422773AbWJLHFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422771AbWJLHFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:05:18 -0400
Received: from holoclan.de ([62.75.158.126]:49578 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S1422774AbWJLHFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:05:14 -0400
Date: Thu, 12 Oct 2006 09:01:32 +0200
From: Martin Lorenz <martin@lorenz.eu.org>
To: linux-thinkpad@linux-thinkpad.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
       acpi-devel@kernel.org, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [ltp] Re: X60s w/t kern 2.6.19-rc1-git: two BUG warnings
Message-ID: <20061012070132.GA27832@gimli>
Mail-Followup-To: linux-thinkpad@linux-thinkpad.org,
	Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
	"Brown, Len" <len.brown@intel.com>, acpi-devel@kernel.org,
	Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>
References: <20061010062826.GC9895@gimli> <452BECAE.2070001@goop.org> <m17iz7oj3w.fsf@ebiederm.dsl.xmission.com> <20061011070650.GA7003@gimli>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011070650.GA7003@gimli>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Wed, Oct 11, 2006 at 09:06:50AM +0200, Dipl.-Ing.
	Martin Lorenz wrote: > On Tue, Oct 10, 2006 at 05:18:27PM -0600, Eric W.
	Biederman wrote: > > Jeremy Fitzhardinge <jeremy@goop.org> writes: > > >
	> > Martin Lorenz wrote: > > >> Dear kernel gurus, > > >> > > > > > >
	(CC:s added to various interested parties.) > > > > > >> whatever I do
	and whic problem I seem to get fixed new ones arise: > > >> > > >> now I
	loose ACPI events after suspend/resume. not every time, but roughly 3 >
	> >> out of 4 times. > > >> > > > > > > Yes, I'm seeing this as well. It
	used to be a 100% failure, so there has been > > > some improvement. On
	the other hand, before that it used to work perfectly... > > >
	Unfortunately I don't have a good feeling for when these changes
	happened. > > > > So the first symptom is not the failure in e1000 open
	but this. > > [ 6727.082000] Trying to free already-free IRQ 20 > >
	Which I suspect comes from e1000_close as it happens after > > the e1000
	watchdog timer goes off because it hasn't gotten > > interrupts for a
	while. > > > > We have other bits of suspicious code as well. > > The
	e1000 rolls it's own version of pci_save_state but doesn't > > call any
	of the msi save/restore state routines. > > > > The bug is from the
	attempt to allocate an already allocated irq. > > So it appears somehow
	in the save/restore mess the msi code > > thought the irq code was
	allocates but the irq code did not? > > > > this morning I tried and
	booted the machine with pci=nomsi > the BUG does not come up as expected
	but the symptom of loosing ACPI after > suspend/resume remains... > I
	have to say sorry for insisting on the ACPI issue after digging a little
	deeper I found that it must come from somewhere in the ibm_acpi code and
	maybe even in a helper script. I still have to seek for that one and
	read the ibm_acpi patches and discussion that go on for over a week now
	in ltp... [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 09:06:50AM +0200, Dipl.-Ing. Martin Lorenz wrote:
> On Tue, Oct 10, 2006 at 05:18:27PM -0600, Eric W. Biederman wrote:
> > Jeremy Fitzhardinge <jeremy@goop.org> writes:
> > 
> > > Martin Lorenz wrote:
> > >> Dear kernel gurus,
> > >>
> > >
> > > (CC:s added to various interested parties.)
> > >
> > >> whatever I do and whic problem I seem to get fixed new ones arise:
> > >>
> > >> now I loose ACPI events after suspend/resume. not every time, but roughly 3
> > >> out of 4 times.
> > >>
> > >
> > > Yes, I'm seeing this as well.  It used to be a 100% failure, so there has been
> > > some improvement.  On the other hand, before that it used to work perfectly...
> > > Unfortunately I don't have a good feeling for when these changes happened.
> > 
> > So the first symptom is not the failure in e1000 open but this.
> > [ 6727.082000] Trying to free already-free IRQ 20
> > Which I suspect comes from e1000_close as it happens after
> > the e1000 watchdog timer goes off because it hasn't gotten
> > interrupts for a while.
> > 
> > We have other bits of suspicious code as well.
> > The e1000 rolls it's own version of pci_save_state but doesn't
> > call any of the msi save/restore state routines.
> > 
> > The bug is from the attempt to allocate an already allocated irq.
> > So it appears somehow in the save/restore mess the msi code
> > thought the irq code was allocates but the irq code did not?
> > 
> 
> this morning I tried and booted the machine with pci=nomsi
> the BUG does not come up as expected but the symptom of loosing ACPI after
> suspend/resume remains...
> 
I have to say sorry for insisting on the ACPI issue
after digging a little deeper I found that it must come from somewhere in
the ibm_acpi code and maybe even in a helper script. I still have to seek
for that one and read the ibm_acpi patches and discussion that go on for
over a week now in ltp...

maybe soneone can quickly tell me, what it is trying to point out with this
messages from the suspend or resume code:

Calling INT 0x15 (F000:5E81)
 EAX is 0x10005F00
Calling INT 0x15 (F000:5E81)
 EAX is 0x10005F40
Calling INT 0x15 (F000:5E81)
 EAX is 0x5F34
Calling INT 0x15 (F000:5E81)
 EAX is 0x5F35

my current workaround is to send a reset to /proc/acpi/ibm/hotkey
as last command on resume

> I put up some information on my current configuration on
> http://www.lorenz.eu.org/~mlo/kernel/
> tell me, what I should add to help 
> 
I will add dumps of /proc/acpi/ibm/* before and after resume shortly

> BTW: can someone tell me, why I can't pull from
>      git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>      anymore?
>      I keep getting 'fatal: unable to connect a socket (Connection refused)'
>      since yesterday afternoon (first noticed ~2pm UTC)

I would love to pull the latest git, but still can't...

> 
> > I have scratched the msi code enough lately that something may have
> > shaken loose.   In particular in commit: 
> > d7bd007e480672c99d8656c7b7b12ef0549432c37 I explicitly disallowed some
> > weird double allocation/deallocation code that could have masked this
> > problem.  

the msi BUG warning remains untouched

> > 
> > The e1000 watchdog doesn't seem to be going off in the functioning
> > case so that may not be it.
> > 
> > My problem is I have been given two incomplete dmesg traces one
> > that works and one that doesn't and without any background in this
> > area beyond noting the e1000 watchdog timer is firing I can't say what
> > happened.
> > 
> > In the working cases do you have trouble if you up and down the
> > network interface?
> > 
> > We seem to be at that nasty interface layer where every piece is
> > making assumptions about how someone else's piece works, and someone
> > has their assumptions wrong.
> > 
> > If someone who understands the how suspend/resume is supposed to work
> > for these kinds of things can speak up that would help.
> > 
> > >
> > >> the only errornous things I see in the logs are those:
> > >>
> > >> [ 6727.089000] BUG: warning at drivers/pci/msi.c:680/pci_enable_msi()
> > >> [ 6727.089000]  [<c0103bd9>] dump_trace+0x69/0x1af
> > >> [ 6727.089000]  [<c0103d37>] show_trace_log_lvl+0x18/0x2c
> > >> [ 6727.089000]  [<c01043d6>] show_trace+0xf/0x11
> > >> [ 6727.089000]  [<c01044d9>] dump_stack+0x15/0x17
> > >> [ 6727.089000]  [<c0208cd6>] pci_enable_msi+0x78/0x22e
> > >> [ 6727.090000]  [<c0257fe5>] e1000_open+0x64/0x176
> > >> [ 6727.091000]  [<c029b121>] dev_open+0x2b/0x62
> > >> [ 6727.092000]  [<c0299c2f>] dev_change_flags+0x47/0xe4
> > >> [ 6727.093000]  [<c02cdceb>] devinet_ioctl+0x252/0x556
> > >> [ 6727.094000]  [<c0290e9a>] sock_ioctl+0x19e/0x1c2
> > >> [ 6727.095000]  [<c016979b>] do_ioctl+0x1f/0x62
> > >> [ 6727.095000]  [<c0169a23>] vfs_ioctl+0x245/0x257
> > >> [ 6727.096000]  [<c0169a81>] sys_ioctl+0x4c/0x67
> > >> [ 6727.096000]  [<c0102dc3>] syscall_call+0x7/0xb
> > >> [ 6727.096000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
> > >> [ 6727.096000]
> > >> [ 6727.096000] Leftover inexact backtrace:
> > >> [ 6727.096000]
> > >> [ 6727.096000]  [<c02e007b>] unix_stream_connect+0x15b/0x367
> > >> [ 6727.096000]  =======================
> > >>
> > >> which occurs in variations but very often
> > >>
> > >
> > > This just seems to be something thinking the IRQ isn't MSI-capable.  It doesn't
> > > seem to have any negative effect - the e1000 works fine anyway.
> > 
> > It is a BUG.  The first symptoms of which where the failure to free
> > the irq in by the e1000 watchdog.  The normal irq code said you didn't
> > have an irq handler registered for that irq.  
> > 
> > Does anyone know how the irq handler could go aways in the weird
> > suspend/resume world?
> > 
> > >> [ 6708.389000] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full
> > > Duplex
> > >> [ 6708.389000] e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
> > >> [ 6727.082000] Trying to free already-free IRQ 20
> > >> [ 6727.089000] BUG: warning at drivers/pci/msi.c:680/pci_enable_msi()
> > >> [ 6727.089000]  [<c0103bd9>] dump_trace+0x69/0x1af
> > >> [ 6727.089000]  [<c0103d37>] show_trace_log_lvl+0x18/0x2c
> > >> [ 6727.089000]  [<c01043d6>] show_trace+0xf/0x11
> > >> [ 6727.089000]  [<c01044d9>] dump_stack+0x15/0x17
> > >> [ 6727.089000]  [<c0208cd6>] pci_enable_msi+0x78/0x22e
> > >> [ 6727.090000]  [<c0257fe5>] e1000_open+0x64/0x176
> > >> [ 6727.091000]  [<c029b121>] dev_open+0x2b/0x62
> > >> [ 6727.092000]  [<c0299c2f>] dev_change_flags+0x47/0xe4
> > >> [ 6727.093000]  [<c02cdceb>] devinet_ioctl+0x252/0x556
> > >> [ 6727.094000]  [<c0290e9a>] sock_ioctl+0x19e/0x1c2
> > >> [ 6727.095000]  [<c016979b>] do_ioctl+0x1f/0x62
> > >> [ 6727.095000]  [<c0169a23>] vfs_ioctl+0x245/0x257
> > >> [ 6727.096000]  [<c0169a81>] sys_ioctl+0x4c/0x67
> > >> [ 6727.096000]  [<c0102dc3>] syscall_call+0x7/0xb
> > >> [ 6727.096000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
> > >> [ 6727.096000] [ 6727.096000] Leftover inexact backtrace:
> > >> [ 6727.096000] [ 6727.096000]  [<c02e007b>] unix_stream_connect+0x15b/0x367
> > >> [ 6727.096000]  =======================
> > >> [ 6728.719000] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full
> > > Duplex
> > >> [ 6728.719000] e1000: eth0: e1000_watchdog: 10/100 speed: disabling
> > >TSO
> > 
> > Eric
gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107
