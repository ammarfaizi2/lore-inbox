Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSH3WhK>; Fri, 30 Aug 2002 18:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314548AbSH3WhK>; Fri, 30 Aug 2002 18:37:10 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:46758 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314529AbSH3WhG>;
	Fri, 30 Aug 2002 18:37:06 -0400
Date: Sat, 31 Aug 2002 00:40:10 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Russell King <rmk@arm.linux.org.uk>
Cc: James Simmons <jsimmons@transvirtual.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.31-serport
Message-ID: <20020831004010.C33615@ucw.cz>
References: <E17ktTz-000359-00@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E17ktTz-000359-00@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, Aug 30, 2002 at 10:39:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 10:39:11PM +0100, Russell King wrote:
> This patch appears not to be in 2.5.32, but applies cleanly.
> 
> serport/serio presently has several problems.  This is by no means a
> definitive list (for example, the locking problems that hch reported
> back in 2.4.0-test time):
> 
> 1. Insomnia.  When someone closes the serport device, it wakes up a
>    thread in serport_ldisc_read().  Unfortunately, if serport->serio.type
>    is non-zero and we haven't received a signal, we re-call schedule()
>    without changing current->state.  So schedule returns, and repeat
>    for ever.
>  
>    A better sleep solution would be:
>    
>         wait_event_interruptible((&serport->wait, serport->serio.type); 
> 
>    which contains all the knoweldge of handling sleeping.
> 
>    Someone might also think about what serport_serio_close() is actually
>    trying to do.  If its intended to cause the thread in ldisc_read exit,
>    it should set serport->serio.type to 0.

I'll answer to this as soon as I get some sleep. No pun originally
intended.

> 2. What happens if I open and try to read from this port while something
>    has the serport_ldisc attached?  I suspect that you'll create nice
>    loop of serio devices in serio.c and an infinite loop when you try to
>    traverse the list to remove a different serio device.

Just to make sure - the scenario would be: inputattach opening
/dev/ttyS0, setting N_MOUSE ldisc. Mouse driver opening that serio, etc,
etc. Then I run minicom on /dev/ttyS0?

> 3. Naming:
> 
> #ifdef CONFIG_DEVFS_FS
>         sprintf(name, tty->driver.name, minor(tty->device) - tty->driver.minor_start);
> #else
>         sprintf(name, "%s%d", tty->driver.name, minor(tty->device) - tty->driver.minor_start);
> #endif
>    
>    should probably be using tty_name(), rather than trying to construct
>    the name itself.

Definitely. Not sure if that existed at the time this was written.
Probably yes, though.

> 4. Stack overflows.  There seems to be confusion about how long a tty name
>    can be, and we seem to add characters to the name ("/serio0") and then
>    squash it into a smaller buffer.
> 
>         char ttyname[64];
> ...     
>         strcpy(ttyname, tty->driver.name);
> ...     
>         sprintf(serport->phys, "%s%d/serio0", ttyname, minor(tty->device) - tty$   
>    However, serport->phys is declared as:
> 
> struct serport {
>         char phys[32];
> };
>    
>    I'd suggest using strncpy() and snprintf() here, and adjusting the size of
>    those strings so they're sensible.

Indeed.

> This patch fixes (1) and (3) completey.  (4) needs the sizes reviewed and fixed.
> (2) is NOT fixed by this patch.
> 
>  drivers/input/serio/serio.c   |    8 ++++++++
>  drivers/input/serio/serport.c |   26 ++++++++------------------
>  2 files changed, 16 insertions, 18 deletions
> 
> diff -ur orig/drivers/input/serio/serio.c linux/drivers/input/serio/serio.c
> --- orig/drivers/input/serio/serio.c	Fri Aug  2 21:13:28 2002
> +++ linux/drivers/input/serio/serio.c	Sun Aug 11 16:15:00 2002
> @@ -122,6 +122,8 @@
>  
>  void serio_register_port(struct serio *serio)
>  {
> +	BUG_ON(serio->next);
> +
>  	serio->next = serio_list;	
>  	serio_list = serio;
>  	serio_find_dev(serio);
> @@ -134,6 +136,8 @@
>          while (*serioptr && (*serioptr != serio)) serioptr = &((*serioptr)->next);
>          *serioptr = (*serioptr)->next;
>  
> +	serio->next = NULL;
> +
>  	if (serio->dev && serio->dev->disconnect)
>  		serio->dev->disconnect(serio);
>  }
> @@ -142,6 +146,8 @@
>  {
>  	struct serio *serio = serio_list;
>  
> +	BUG_ON(dev->next);
> +
>  	dev->next = serio_dev;	
>  	serio_dev = dev;
>  
> @@ -159,6 +165,8 @@
>  
>          while (*devptr && (*devptr != dev)) devptr = &((*devptr)->next);
>          *devptr = (*devptr)->next;
> +
> +	dev->next = NULL;
>  
>  	while (serio) {
>  		if (serio->dev == dev && dev->disconnect)

This should better be fixed by switching to <linux/list.h> for the
linked lists.

> diff -ur orig/drivers/input/serio/serport.c linux/drivers/input/serio/serport.c
> --- orig/drivers/input/serio/serport.c	Sat Jul 27 13:55:18 2002
> +++ linux/drivers/input/serio/serport.c	Sun Aug 11 16:33:59 2002
> @@ -96,11 +96,14 @@
>  	serport->tty = tty;
>  	tty->disc_data = serport;
>  
> -	strcpy(ttyname, tty->driver.name);
> -	for (i = 0; ttyname[i] != 0 && ttyname[i] != '/'; i++);
> +	strncpy(ttyname, tty->driver.name, sizeof(ttyname) - 1);
> +
> +	for (i = 0; ttyname[i] != 0 && ttyname[i] != '/' &&
> +		    i < sizeof(ttyname) - 1; i++);
>  	ttyname[i] = 0;
>  
> -	sprintf(serport->phys, "%s%d/serio0", ttyname, minor(tty->device) - tty->driver.minor_start);
> +	snprintf(serport->phys, sizeof(serport->phys), "%s%d/serio0",
> +		ttyname, minor(tty->device) - tty->driver.minor_start);
>  
>  	serport->serio.name = serport_name;
>  	serport->serio.phys = serport->phys;
> @@ -161,26 +164,13 @@
>  static ssize_t serport_ldisc_read(struct tty_struct * tty, struct file * file, unsigned char * buf, size_t nr)
>  {
>  	struct serport *serport = (struct serport*) tty->disc_data;
> -	DECLARE_WAITQUEUE(wait, current);
>  	char name[32];
>  
> -#ifdef CONFIG_DEVFS_FS
> -	sprintf(name, tty->driver.name, minor(tty->device) - tty->driver.minor_start);
> -#else
> -	sprintf(name, "%s%d", tty->driver.name, minor(tty->device) - tty->driver.minor_start);
> -#endif
> -
>  	serio_register_port(&serport->serio);
>  
> -	printk(KERN_INFO "serio: Serial port %s\n", name);
> -
> -	add_wait_queue(&serport->wait, &wait);
> -	set_current_state(TASK_INTERRUPTIBLE);
> -
> -	while(serport->serio.type && !signal_pending(current)) schedule();
> +	printk(KERN_INFO "serio: Serial port %s\n", tty_name(tty, name));
>  
> -	set_current_state(TASK_RUNNING);
> -	remove_wait_queue(&serport->wait, &wait);
> +	wait_event_interruptible(serport->wait, serport->serio.type != 0);
>  
>  	serio_unregister_port(&serport->serio);
>  

-- 
Vojtech Pavlik
SuSE Labs
