Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130608AbRBLKTv>; Mon, 12 Feb 2001 05:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130704AbRBLKTl>; Mon, 12 Feb 2001 05:19:41 -0500
Received: from [194.213.32.137] ([194.213.32.137]:5380 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130608AbRBLKTZ>;
	Mon, 12 Feb 2001 05:19:25 -0500
Message-ID: <20010211230448.J3748@bug.ucw.cz>
Date: Sun, 11 Feb 2001 23:04:48 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tony Hoyle <tmh@magenta-netlogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI slowdown...
In-Reply-To: <3A818BC4.7020007@magenta-netlogic.com> <3A81920A.90601@magenta-netlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A81920A.90601@magenta-netlogic.com>; from Tony Hoyle on Wed, Feb 07, 2001 at 06:20:58PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Tony Hoyle wrote:
> 
> I'm talking to myself :-)
> 
> OK I see that safe_halt() will re-enable interrupts.  However this is only
> called in S1.  If your machine gets as far as S3 you have...
> 
>          for (;;) {
>                  unsigned long time;
>                  unsigned long diff;
> 
>                  __cli();
>                  if (current->need_resched)
>                          goto out;
>                  if (acpi_bm_activity())
>                          goto sleep2;
> 
>                  time = acpi_read_pm_timer();
>                  inb(acpi_pblk + ACPI_P_LVL3);
>                  /* Dummy read, force synchronization with the PMU */
>                  acpi_read_pm_timer();
>                  diff = acpi_compare_pm_timers(time, acpi_read_pm_timer());
> 
>                  __sti();
>                  if (diff < acpi_c3_exit_latency)
>                          goto sleep2;
>          }
> 
> There is no halt here... the interrupts are enabled for only a couple of 
> instructions (one comparison and a jump) before being disabled again. 
> It seems to me if the computer gets into S3 it'll effectively die until 
> some kind of busmaster device wakes it up (DMA?).

No.

If interrupts come in cli-ed section, it will be postponed until
sti. It then comes, and sets need_resched and recovers.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
