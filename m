Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266176AbRGYAIn>; Tue, 24 Jul 2001 20:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266198AbRGYAIe>; Tue, 24 Jul 2001 20:08:34 -0400
Received: from myth10.Stanford.EDU ([171.64.15.24]:16113 "EHLO
	myth10.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S266176AbRGYAIX>; Tue, 24 Jul 2001 20:08:23 -0400
Date: Tue, 24 Jul 2001 17:08:23 -0700 (PDT)
From: Evan Parker <nave@stanford.edu>
To: <linux-kernel@vger.kernel.org>
cc: <mc@cs.stanford.edu>
Subject: [CHECKER] repetitive/contradictory comparison bugs for 2.4.7
Message-ID: <Pine.GSO.4.31.0107241704430.11742-100000@myth10.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Enclosed are 11 possible bugs found by an automatic checker run over
kernel 2.4.7.  The checker is designed to look at the internal consistency
of conditionals that compare pointers against NULL, specifically for
repetitive or contradictory comparisons.  Take the following code:

if (!p) {
  ...
  if (p) ...
  ...
  if (!p) ...
}

The first conditional inside the if would be marked as a contradiction,
and the second would be marked as a repetition.  The following code would
also be marked as a contradiction, since on all paths leading to the
second if statment p would have to be non-NULL:

if (!p)
  return;

...

if (!p) ...

Now usually such repetitions and contradictions are just the result of
putting in too many checks: this is not a bad thing--in fact, it is good
coding style.  But obviously repetitve or contradictory comparisons can
often indicate bad code and/or bugs.  Out of a total of about 45 code
pieces marked by the checker, these 11 looked the most suspicious.

One of them, the last one, is pretty clearly a bug, but the
other 10 are questionable.  Those 10 are all simple variations on the
following code:

Start --->
	if (!tmp_buf) {
		page = get_free_page(GFP_KERNEL);

Error --->
		if (tmp_buf)
			free_page(page);
		else
			tmp_buf = (unsigned char *) page;
	}

One of the other variations uses a semaphore protecting the whole if
statement, and another variation uses cli() and restore_flags() to protect
just the inner if statement, but otherwise they are all basically the
same.  So my understanding is that get_free_page can block, in which case
tmp_buf might be modified by another process, making the two if statements
necessary.  But if concurrency is a problem, then shouldn't there be some
sort of protection, maybe a semaphore or a cli()/restore_flags() pair
around the inner if statement to ensure it is an atomic block?  Some of
the cases do do this, but some don't.  In any case, the variations make
it seem suspicious, so check them out.  I'm not claiming they are actually
bugs--I don't know enough to tell--but they're worth a look just to make sure.

# Summary for 2.4.7
#  Total Errors for 2.4.7	  = 11
# BUGs	|	File Name
2	|	/home/eparker/tmp/linux/2.4.7/drivers/char/generic_serial.c/
1	|	/home/eparker/tmp/linux/2.4.7/drivers/char/serial.c/
1	|	/home/eparker/tmp/linux/2.4.7/drivers/char/specialix.c/
1	|	/home/eparker/tmp/linux/2.4.7/drivers/md/md.c/
1	|	/home/eparker/tmp/linux/2.4.7/drivers/char/riscom8.c/
1	|	/home/eparker/tmp/linux/2.4.7/drivers/char/moxa.c/
1	|	/home/eparker/tmp/linux/2.4.7/drivers/video/tdfxfb.c/
1	|	/home/eparker/tmp/linux/2.4.7/drivers/char/cyclades.c/
1	|	/home/eparker/tmp/linux/2.4.7/drivers/char/rocket.c/
1	|	/home/eparker/tmp/linux/2.4.7/drivers/char/mxser.c/



############################################################
# errors
#
---------------------------------------------------------
[BUG] confusing code...there would be no need to check tmp_buf twice,
unless there is the possibility of it being modified while get_free_page
sleeps.  But then why the comment that the cli() shouldn't make a
difference?
/home/eparker/tmp/linux/2.4.7/drivers/char/generic_serial.c:953:gs_init_port: ERROR:INTERNAL_NULL3:949:953: Contradiction: "tmp_buf" is NULL so the conditional "tmp_buf != 0" will always evaluate to false! [nbytes = 1]  [distance=3]
{
	unsigned long flags;
	unsigned long page;

	save_flags (flags);
Start --->
	if (!tmp_buf) {
		page = get_free_page(GFP_KERNEL);

		cli (); /* Don't expect this to make a difference. */
Error --->
		if (tmp_buf)
			free_page(page);
		else
			tmp_buf = (unsigned char *) page;
---------------------------------------------------------
[BUG] similar to above
/home/eparker/tmp/linux/2.4.7/drivers/char/generic_serial.c:975:gs_init_port: ERROR:INTERNAL_NULL3:967:975: Contradiction: "port->xmit_buf" is NULL so the conditional "port->xmit_buf != 0" will always evaluate to false! [distance=4]
	}

	if (port->flags & ASYNC_INITIALIZED)
		return 0;

Start --->
	if (!port->xmit_buf) {
		/* We may sleep in get_free_page() */
		unsigned long tmp;

		tmp = get_free_page(GFP_KERNEL);

		/* Spinlock? */
		cli ();
Error --->
		if (port->xmit_buf)
			free_page (tmp);
		else
			port->xmit_buf = (unsigned char *) tmp;
---------------------------------------------------------
[BUG] confusing: why check twice? race condition?
/home/eparker/tmp/linux/2.4.7/drivers/md/md.c:1633:do_md_run: ERROR:INTERNAL_NULL3:1627:1633: Repetitive check: "pers[pnum]" is NULL so the conditional "pers[pnum] == 0" will always evaluate to true! [distance=4]
		 */
		printk(BAD_CHUNKSIZE);
		return -EINVAL;
	}

Start --->
	if (!pers[pnum])
	{
#ifdef CONFIG_KMOD
		char module_name[80];
		sprintf (module_name, "md-personality-%d", pnum);
		request_module (module_name);
Error --->
		if (!pers[pnum])
#endif
			return -EINVAL;
	}
---------------------------------------------------------
[BUG] similar to earlier bug in drivers/char/generic_serial.c,
moxaXmitBuff is protected by a semaphore instead of a simple cli() and
restore_flags()...but the semaphore is downed outside the first check, so
there should be no need for the second check inside the if statement...very
confusing.
/home/eparker/tmp/linux/2.4.7/drivers/char/moxa.c:576:moxa_open: ERROR:INTERNAL_NULL3:570:576: Contradiction: "moxaXmitBuff" is NULL so the conditional "moxaXmitBuff != 0" will always evaluate to false! [nbytes = 1]  [distance=13]
	if (!MoxaPortIsValid(port)) {
		tty->driver_data = NULL;
		return (-ENODEV);
	}
	down(&moxaBuffSem);
Start --->
	if (!moxaXmitBuff) {
		page = get_free_page(GFP_KERNEL);
		if (!page) {
			up(&moxaBuffSem);
			return (-ENOMEM);
		}
Error --->
		if (moxaXmitBuff)
			free_page(page);
		else
			moxaXmitBuff = (unsigned char *) page;
---------------------------------------------------------
[BUG] again, similar to the one in drivers/char/generic_serial.c, except
there is no effort to guard against race conditions: no semaphores, no
cli() and restore_flags()...so why check tmp_buf twice?  Looks like there
should be some sort of protection around the check and then assignment of
tmp_buf.
/home/eparker/tmp/linux/2.4.7/drivers/char/rocket.c:905:rp_open: ERROR:INTERNAL_NULL3:901:905: Contradiction: "tmp_buf" is NULL so the conditional "tmp_buf != 0" will always evaluate to false! [nbytes = 1]  [distance=13]
	unsigned long page;

	line = MINOR(tty->device) - tty->driver.minor_start;
	if ((line < 0) || (line >= MAX_RP_PORTS))
		return -ENODEV;
Start --->
	if (!tmp_buf) {
		page = get_free_page(GFP_KERNEL);
		if (!page)
			return -ENOMEM;
Error --->
		if (tmp_buf)
			free_page(page);
		else
			tmp_buf = (unsigned char *) page;
---------------------------------------------------------
[BUG] same
/home/eparker/tmp/linux/2.4.7/drivers/char/mxser.c:734:mxser_open: ERROR:INTERNAL_NULL3:730:734: Contradiction: "mxvar_tmp_buf" is NULL so the conditional "mxvar_tmp_buf != 0" will always evaluate to false! [nbytes = 1]  [distance=13]

	info->count++;
	tty->driver_data = info;
	info->tty = tty;

Start --->
	if (!mxvar_tmp_buf) {
		page = get_free_page(GFP_KERNEL);
		if (!page)
			return (-ENOMEM);
Error --->
		if (mxvar_tmp_buf)
			free_page(page);
		else
			mxvar_tmp_buf = (unsigned char *) page;
---------------------------------------------------------
[BUG] same
/home/eparker/tmp/linux/2.4.7/drivers/char/serial.c:3166:rs_open: ERROR:INTERNAL_NULL3:3160:3166: Contradiction: "tmp_buf" is NULL so the conditional "tmp_buf != 0" will always evaluate to false! [nbytes = 1]  [distance=13]
#endif
#if (LINUX_VERSION_CODE > 0x20100)
	info->tty->low_latency = (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
#endif

Start --->
	if (!tmp_buf) {
		page = get_zeroed_page(GFP_KERNEL);
		if (!page) {
			MOD_DEC_USE_COUNT;
			return -ENOMEM;
		}
Error --->
		if (tmp_buf)
			free_page(page);
		else
			tmp_buf = (unsigned char *) page;
---------------------------------------------------------
[BUG] same
/home/eparker/tmp/linux/2.4.7/drivers/char/cyclades.c:2667:cy_open: ERROR:INTERNAL_NULL3:2663:2667: Contradiction: "tmp_buf" is NULL so the conditional "tmp_buf != 0" will always evaluate to false! [nbytes = 1]  [distance=13]
    info->count++;
#ifdef CY_DEBUG_COUNT
    printk("cyc:cy_open (%d): incrementing count to %d\n",
        current->pid, info->count);
#endif
Start --->
    if (!tmp_buf) {
	page = get_free_page(GFP_KERNEL);
	if (!page)
	    return -ENOMEM;
Error --->
	if (tmp_buf)
	    free_page(page);
	else
	    tmp_buf = (unsigned char *) page;
---------------------------------------------------------
[BUG] same
/home/eparker/tmp/linux/2.4.7/drivers/char/specialix.c:1238:sx_setup_port: ERROR:INTERNAL_NULL3:1231:1238: Contradiction: "port->xmit_buf" is NULL so the conditional "port->xmit_buf != 0" will always evaluate to false! [distance=13]
	unsigned long flags;

	if (port->flags & ASYNC_INITIALIZED)
		return 0;

Start --->
	if (!port->xmit_buf) {
		/* We may sleep in get_free_page() */
		unsigned long tmp;

		if (!(tmp = get_free_page(GFP_KERNEL)))
			return -ENOMEM;

Error --->
		if (port->xmit_buf) {
			free_page(tmp);
			return -ERESTARTSYS;
		}
---------------------------------------------------------
[BUG] similar; again, looks like there might be a race condition here
/home/eparker/tmp/linux/2.4.7/drivers/char/riscom8.c:863:rc_setup_port: ERROR:INTERNAL_NULL3:856:863: Contradiction: "port->xmit_buf" is NULL so the conditional "port->xmit_buf != 0" will always evaluate to false! [distance=13]
	unsigned long flags;

	if (port->flags & ASYNC_INITIALIZED)
		return 0;

Start --->
	if (!port->xmit_buf) {
		/* We may sleep in get_free_page() */
		unsigned long tmp;

		if (!(tmp = get_free_page(GFP_KERNEL)))
			return -ENOMEM;

Error --->
		if (port->xmit_buf) {
			free_page(tmp);
			return -ERESTARTSYS;
		}
---------------------------------------------------------
[BUG] [GEM] looks like they should be checking fb_info.bufbase_virt rather than fb_info.regbase_virt
/home/eparker/tmp/linux/2.4.7/drivers/video/tdfxfb.c:1927:tdfxfb_init: ERROR:INTERNAL_NULL3:1915:1927: Contradiction: "fb_info.regbase_virt" is not NULL so the conditional "fb_info.regbase_virt == 0" will always evaluate to false! [distance=15]
	break;
      }
      fb_info.regbase_phys = pci_resource_start(pdev, 0);
      fb_info.regbase_size = 1 << 24;
      fb_info.regbase_virt = ioremap_nocache(fb_info.regbase_phys, 1 << 24);
Start --->
      if(!fb_info.regbase_virt) {
	printk("fb: Can't remap %s register area.\n", name);
	return -ENXIO;
      }

      fb_info.bufbase_phys = pci_resource_start (pdev, 1);
      if(!(fb_info.bufbase_size = do_lfb_size())) {
	iounmap(fb_info.regbase_virt);
	printk("fb: Can't count %s memory.\n", name);
	return -ENXIO;
      }
      fb_info.bufbase_virt = ioremap_nocache(fb_info.bufbase_phys, fb_info.bufbase_size);
Error --->
      if(!fb_info.regbase_virt) {
	printk("fb: Can't remap %s framebuffer.\n", name);
	iounmap(fb_info.regbase_virt);
	return -ENXIO;






--------------------------------------------------------------------
Evan Parker
nave@stanford.edu
home: (650) 497-4928
cell: (650) 207-3646
--------------------------------------------------------------------

