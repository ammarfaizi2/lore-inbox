Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWHNBKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWHNBKA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 21:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWHNBKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 21:10:00 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:16008 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751388AbWHNBKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 21:10:00 -0400
Date: Mon, 14 Aug 2006 03:09:54 +0200
From: Voluspa <lista1@comhem.se>
To: arjan@linux.intel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockdep: disable lock debugging when kernel state
 becomes untrusted
Message-Id: <20060814030954.c3a57e05.lista1@comhem.se>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.4.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-07-10 21:02:59 git-commits-head received:
> commit 2c16e9c888985761511bd1905b00fb271169c3c0
> tree e17756b3ed27b0f4953547c39cf46864cdd6f818
> parent e54695a59c278b9ff48cd4b263da7a1d392f5061
> author Arjan van de Ven Mon, 10 Jul 2006
> 18:45:42 -0700 committer Linus Torvalds Tue, 11
> Jul 2006 03:24:27 -0700
>
> [PATCH] lockdep: disable lock debugging when kernel state becomes
> untrusted
>
> Disable lockdep debugging in two situations where the integrity of the
> kernel no longer is guaranteed: when oopsing and when hitting a
> tainting-condition.  The goal is to not get weird lockdep traces that
> don't make sense or are otherwise undebuggable, to not waste time.
>
> Lockdep assumes that the previous state it knows about is valid to
> operate, which is why lockdep turns itself off after the first
> violation it reports, after that point it can no longer make that
> assumption.
>
> A kernel oops means that the integrity of the kernel compromised; in
> addition anything lockdep would report is of lesser importance than the
> oops.
>
> All the tainting conditions are of similar integrity-violating nature
> and also make debugging/diagnosing more difficult.

On my x86_64 notebook I need ndiswrapper. No but-s, if-s or anything-s.
Period. I also have to work outside of X in a clean terminal (console).

This patch unfortunately creates a 'pipe' directly from
 /var/log/messages to the screen. So if I work in a textbased program,
and something happens in the log, the program gets a broken interface.
Programs that simultaniously output to the log becomes unusable.

It is also darn irritating when text strings materializes at the shell
prompt...

Once the 'pipe' is established (by tainting) it can not be reverted by
eg rmmod ndiswrapper.

I haven't even enabled any lockdep debugging:

loke:sleipner:/usr/src/testing$ grep -i debug 2.6.18-rc4-.config 
# CONFIG_PM_DEBUG is not set
# CONFIG_ACPI_DEBUG is not set
# CONFIG_CPU_FREQ_DEBUG is not set
# CONFIG_PCMCIA_DEBUG is not set
# CONFIG_NETDEBUG is not set
# CONFIG_IRDA_DEBUG is not set
# CONFIG_PNP_DEBUG is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_DETECT is not set
# CONFIG_SND_PCM_XRUN_DEBUG is not set
# CONFIG_USB_DEBUG is not set
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_MMC_DEBUG is not set
# CONFIG_JBD_DEBUG is not set
# CONFIG_NTFS_DEBUG is not set
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_DEBUG_FS is not set

And there is no interface to disable the lockdep:

loke:sleipner:/usr/src/testing$ grep -i lockdep 2.6.18-rc4-.config 
CONFIG_LOCKDEP_SUPPORT=y

So, reverting the offending patch is the only way to sanity. A direct
link (instead of my mangled quoting):

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=2c16e9c888985761511bd1905b00fb271169c3c0;hp=e54695a59c278b9ff48cd4b263da7a1d392f5061

> Signed-off-by: Arjan van de Ven
> Signed-off-by: Ingo Molnar
> Signed-off-by: Andrew Morton
> Signed-off-by: Linus Torvalds
>
> kernel/panic.c |    2 ++
> 1 files changed, 2 insertions(+)

> diff --git a/kernel/panic.c b/kernel/panic.c
> index ab13f0f..d8a0bca 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -172,6 +172,7 @@ const char *print_tainted(void)
> 
> void add_taint(unsigned flag)
> {
> +	debug_locks_off(); /* can't trust the integrity of the kernel
> anymore */ tainted |= flag;
> }
> EXPORT_SYMBOL(add_taint);
> @@ -256,6 +257,7 @@ int oops_may_print(void)
>  */
> void oops_enter(void)
> {
> +	debug_locks_off(); /* can't trust the integrity of the kernel
> anymore */ do_oops_enter_exit();
> }

Mvh
Mats Johannesson
 
