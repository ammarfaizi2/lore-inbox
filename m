Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTJRJsj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 05:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbTJRJsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 05:48:39 -0400
Received: from platane.lps.ens.fr ([129.199.121.28]:6283 "EHLO
	platane.lps.ens.fr") by vger.kernel.org with ESMTP id S261380AbTJRJs3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 05:48:29 -0400
Date: Sat, 18 Oct 2003 11:48:12 +0200
From: =?unknown-8bit?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Power Management Update
Message-ID: <20031018094812.GA31297@lps.ens.fr>
References: <3F55B738.4070200@eskuel.com> <Pine.LNX.4.33.0309031522200.944-100000@localhost.localdomain> <20031013194127.GA16791@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031013194127.GA16791@lps.ens.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have the same symptoms with test8 (by tthe way, did you receive my
previous mail ?): standby sort of works (but fan speed goes up and screen
doesn't blank), mem shuts down the computer but screen stays black when I
hit the power button, and disk starts the suspend process but abort and
resume immediately (with high fan speed). In more details, here is what I
get when I try to suspend to disk:

Freeing unused kernel memory: 152k freed
Stopping tasks: =====|
Freeing memory: ..|
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Attempting to suspend to disk.
PM: snapshotting memory.
PCI: Setting latency timer of device 0000:00:1f.5 to 64
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
blk: queue df5e9a00, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
Restarting tasks... done

On Mon, Oct 13, 2003 at 09:41:27PM +0200, ?ric Brunet wrote:
> Hi,
> 
> I have tried today 2.6.0-pre7 and power management in it. My last series
> of tries were with the pre4 plus a series of patches you posted at the
> time. I used the same protocol as before: I boot with init=/bin/sh, mount
> /sys and echo stuff into /sys/power/state without running anything but
> bash (and ls, cd, cat, sleep), without loading any module. On the whole,
> it is for me a regression.  Here are the details:
> 
> standby
> ------
>   half works as before. The computer is standing by, but it is quite
> useless as the screen is not even shut down. Moreover, the sensors on the
> motherboard are reinitialized, which they should not be (I don't have i2c
> modules in the kernel. The bios put the sensors in a certain state where
> the fan is noiseless. If sensors get reinitialized, the fan goes full
> speed and I have no way to slow it down)
> 
> mem
> ---
>   As before. Computer seems to shut down very quickly. When I press the
> power button, fans and/or dosks are spinning, but the screen receives no
> signals (stays on standby). Computer is dead. (no led with caps locks, no
> sysrq, etc.) Have to press 4 seconds power button to shut it down.
> 
> disk
> ----
>   Here comes the regression. When I try to suspend, it starts to do it,
> and then resume instantaneously. It used to work for me. Actually, more
> precisely, it used to work for me until I applied the following patch of
> yours (see message below). I mentionned the fact to you at the time.
> Maybe that patch went mainstream ?
> 
> As before, everything on my computer on
> http://perso.nerim.net/~tudia/bug-reports.
> 
> Regards,
> 
> 	Éric Brunet
> 
> On Wed, Sep 03, 2003 at 03:41:14PM -0700, Patrick Mochel wrote:
> > 
> > > I've tested the patch you submitted for ide-io.c (I've tested it in 
> > > test4-mm5).
> > > It solves the ide-cd problem, and the suspend process get to next step. 
> > > It frees memory. However, just after that, the system get in a loop 
> > > displaying "Bad: scheduling while atomic". I'm not able to capture the 
> > > output of this, the laptop only responding to syrq.
> > > Hope it helps you.
> > 
> > Definitely. I take it you have preempt enabled, right? 
> > 
> > Below is a patch that should fix the problem. The problem was due to the
> > fact that I removed the kernel_fpu_end() call from
> > kernel/power/swsusp.c::swsusp_suspend(). kernel_fpu_end() disables
> > preempt, which causes any subsequent schedule() to trigger that BUG(). I
> > apologize for this regression.
> > 
> > The patch needs a bit more explanation, because I didn't simply replace 
> > the call. Doing so would be a layering violation of the structure of the 
> > code. kernel_fpu_end() is called by save_processor_state(), which is 
> > called by swsusp_arch_suspend(). We should be calling it from the same 
> > chain, and we shouldn't be calling a function from generic code that is 
> > defined on only two architectures. 
> > 
> > I modified swsusp_arch_suspend() to unconditionally call
> > restore_processor_state() when exiting, which provides the same layering. 
> > However, it is still too late WRT to the other things that 
> > swsusp_suspend() was doing (resuming drivers and writing the image). 
> > 
> > Since those are unrelated to snapshotting memory, I divorced them from the 
> > function. swsusp_save() now is the function that is responsible for 
> > snapshoting memory, while swsusp_write() is responsible for writing the 
> > image, only. 
> > 
> > The resulting code is cleaner and more streamlined. It behaves as
> > predicted locally. Please try it and report whether or not it works for 
> > you. 
> > 
> > Andrew, please apply this to -test4-mm5. I realize I said I would not
> > touch swsusp any more, and this patch may become irrelevant in the future. 
> > But, it fixes a real bug now. 
> > 
> > Thanks,
> > 
> > 
> > 	Pat
> > 
> > 
> > ===== arch/i386/power/swsusp.S 1.9 vs edited =====
> > --- 1.9/arch/i386/power/swsusp.S	Fri Aug 22 16:08:57 2003
> > +++ edited/arch/i386/power/swsusp.S	Wed Sep  3 15:23:20 2003
> > @@ -76,10 +76,10 @@
> >  	movl saved_context_edx, %edx
> >  	movl saved_context_esi, %esi
> >  	movl saved_context_edi, %edi
> > -	call restore_processor_state
> >  	pushl saved_context_eflags ; popfl
> >  	call swsusp_resume
> >  .L1449:
> > +	call restore_processor_state
> >  	popl %ebx
> >  	ret
> >  
> > ===== kernel/power/disk.c 1.2 vs edited =====
> > --- 1.2/kernel/power/disk.c	Tue Aug 26 12:25:46 2003
> > +++ edited/kernel/power/disk.c	Wed Sep  3 15:20:10 2003
> > @@ -163,27 +163,27 @@
> >  
> >  	pr_debug("PM: snapshotting memory.\n");
> >  	in_suspend = 1;
> > -	local_irq_disable();
> >  	if ((error = swsusp_save()))
> >  		goto Done;
> >  
> > -	pr_debug("PM: writing image.\n");
> > +	if (in_suspend) {
> > +		pr_debug("PM: writing image.\n");
> >  
> > -	/* 
> > -	 * FIXME: Leftover from swsusp. Are they necessary? 
> > -	 */
> > -	mb();
> > -	barrier();
> > -
> > -	error = swsusp_write();
> > -	if (!error && in_suspend) {
> > -		error = power_down(pm_disk_mode);
> > -		pr_debug("PM: Power down failed.\n");
> > +		/* 
> > +		 * FIXME: Leftover from swsusp. Are they necessary? 
> > +		 */
> > +		mb();
> > +		barrier();
> > +
> > +		error = swsusp_write();
> > +		if (!error) {
> > +			error = power_down(pm_disk_mode);
> > +			pr_debug("PM: Power down failed.\n");
> > +		}
> >  	} else
> >  		pr_debug("PM: Image restored successfully.\n");
> >  	swsusp_free();
> >   Done:
> > -	local_irq_enable();
> >  	finish();
> >  	return error;
> >  }
> > @@ -217,7 +217,6 @@
> >  
> >  	barrier();
> >  	mb();
> > -	local_irq_disable();
> >  
> >  	/* FIXME: The following (comment and mdelay()) are from swsusp. 
> >  	 * Are they really necessary? 
> > @@ -231,7 +230,6 @@
> >  
> >  	pr_debug("PM: Restoring saved image.\n");
> >  	swsusp_restore();
> > -	local_irq_enable();
> >  	pr_debug("PM: Restore failed, recovering.n");
> >  	finish();
> >   Free:
> > ===== kernel/power/swsusp.c 1.62 vs edited =====
> > --- 1.62/kernel/power/swsusp.c	Sat Aug 30 13:23:28 2003
> > +++ edited/kernel/power/swsusp.c	Wed Sep  3 15:23:35 2003
> > @@ -416,11 +416,12 @@
> >  }
> >  
> >  
> > -static int suspend_prepare_image(void)
> > +int swsusp_suspend(void)
> >  {
> >  	struct sysinfo i;
> >  	unsigned int nr_needed_pages = 0;
> >  
> > +	read_swapfiles();
> >  	drain_local_pages();
> >  
> >  	pagedir_nosave = NULL;
> > @@ -486,12 +487,10 @@
> >  static int suspend_save_image(void)
> >  {
> >  	int error;
> > -	local_irq_enable();
> >  	device_resume();
> >  	lock_swapdevices();
> >  	error = write_suspend_image();
> >  	lock_swapdevices();
> > -	local_irq_disable();
> >  	return error;
> >  }
> >  
> > @@ -515,35 +514,16 @@
> >  	if (!resume) {
> >  		save_processor_state();
> >  		SAVE_REGISTERS
> > -		swsusp_suspend();
> > -		return;
> > +		return swsusp_suspend();
> >  	}
> >  	GO_TO_SWAPPER_PAGE_TABLES
> >  	COPY_PAGES_BACK
> >  	RESTORE_REGISTERS
> >  	restore_processor_state();
> > -	swsusp_resume();
> > -
> > +	return swsusp_resume();
> >   */
> >  
> >  
> > -int swsusp_suspend(void)
> > -{
> > -	int error;
> > -	read_swapfiles();
> > -	error = suspend_prepare_image();
> > -	if (!error)
> > -		error = suspend_save_image();
> > -	if (error) {
> > -		printk(KERN_EMERG "%sSuspend failed, trying to recover...\n", 
> > -		       name_suspend);
> > -		barrier();
> > -		mb();
> > -		mdelay(1000);
> > -	}
> > -	return error;
> > -}
> > -
> >  /* More restore stuff */
> >  
> >  /* FIXME: Why not memcpy(to, from, 1<<pagedir_order*PAGE_SIZE)? */
> > @@ -870,11 +850,19 @@
> >  
> >  int swsusp_save(void) 
> >  {
> > +	int error;
> > +
> >  #if defined (CONFIG_HIGHMEM) || defined (COFNIG_DISCONTIGMEM)
> >  	printk("swsusp is not supported with high- or discontig-mem.\n");
> >  	return -EPERM;
> >  #endif
> > -	return arch_prepare_suspend();
> > +	if ((error = arch_prepare_suspend()))
> > +		return error;
> > +	
> > +	local_irq_disable();
> > +	error = swsusp_arch_suspend(0);
> > +	local_irq_enable();
> > +	return error;
> >  }
> >  
> >  
> > @@ -890,7 +878,7 @@
> >  
> >  int swsusp_write(void)
> >  {
> > -	return swsusp_arch_suspend(0);
> > +	return suspend_save_image();
> >  }
> >  
> >  
> > @@ -933,7 +921,11 @@
> >  
> >  int __init swsusp_restore(void)
> >  {
> > -	return swsusp_arch_suspend(1);
> > +	int error;
> > +	local_irq_disable();
> > +	error = swsusp_arch_suspend(1);
> > +	local_irq_enable();
> > +	return error;
> >  }
> >  
> >  
