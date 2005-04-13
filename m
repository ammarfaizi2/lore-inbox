Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVDMToG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVDMToG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 15:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVDMToF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 15:44:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55731 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261219AbVDMTnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 15:43:04 -0400
Date: Wed, 13 Apr 2005 14:43:03 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-105.boston.redhat.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       nuclearcat <nuclearcat@nuclearcat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: pty_chars_in_buffer NULL pointer (kernel oops)
In-Reply-To: <Pine.LNX.4.58.0502271130420.25732@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0504131416550.29279@dhcp83-105.boston.redhat.com>
References: <20050227100000.GB22439@logos.cnet> <Pine.LNX.4.58.0502271130420.25732@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 Feb 2005, Linus Torvalds wrote:

> 
> 
> On Sun, 27 Feb 2005, Marcelo Tosatti wrote:
> > 
> > Alan, Linus, what correction to the which the above thread discusses has 
> > been deployed? 
> 
> This is the hacky "hide the problem" patch that is in my current tree (and 
> was discussed in the original thread some time ago).
> 
> It's in no way "correct", in that the race hasn't actually gone away by 
> this patch, but the patch makes it unimportant. We may end up calling a 
> stale line discipline, which is still very wrong, but it so happens that 
> we don't much care in practice.
> 
> I think that in a 2.4.x tree there are some theoretical SMP races with
> module unloading etc (which the 2.6.x code doesn't have because module
> unload stops the other CPU's - maybe that part got backported to 2.4.x?), 
> but quite frankly, I suspect that even in 2.4.x they are entirely 
> theoretical and impossible to actually hit.
> 
> And again, in theory some line discipline might do something strange in
> it's "chars_in_buffer" routine that would be problematic. In practice
> that's just not the case: the "chars_in_buffer()" routine might return a
> bogus _value_ for a stale line discipline thing, but none of them seem to
> follow any pointers that might have become invalid (and in fact, most
> ldiscs don't even have that function).
> 
> So while this patch is wrogn in theory, it does have the advantage of
> being (a) very safe minimal patch and (b) fixing the problem in practice
> with no performance downside.
> 
> I still feel a bit guilty about it, though.
> 
> 			Linus
> 
> ---
> # This is a BitKeeper generated diff -Nru style patch.
> #
> # ChangeSet
> #   2005/02/25 19:39:39-08:00 torvalds@ppc970.osdl.org 
> #   Fix possible pty line discipline race.
> #   
> #   This ain't pretty. Real fix under discussion.
> # 
> # drivers/char/pty.c
> #   2005/02/25 19:39:32-08:00 torvalds@ppc970.osdl.org +4 -2
> #   Fix possible pty line discipline race.
> #   
> #   This ain't pretty. Real fix under discussion.
> # 
> diff -Nru a/drivers/char/pty.c b/drivers/char/pty.c
> --- a/drivers/char/pty.c	2005-02-27 11:31:57 -08:00
> +++ b/drivers/char/pty.c	2005-02-27 11:31:57 -08:00
> @@ -149,13 +149,15 @@
>  static int pty_chars_in_buffer(struct tty_struct *tty)
>  {
>  	struct tty_struct *to = tty->link;
> +	ssize_t (*chars_in_buffer)(struct tty_struct *);
>  	int count;
>  
> -	if (!to || !to->ldisc.chars_in_buffer)
> +	/* We should get the line discipline lock for "tty->link" */
> +	if (!to || !(chars_in_buffer = to->ldisc.chars_in_buffer))
>  		return 0;
>  
>  	/* The ldisc must report 0 if no characters available to be read */
> -	count = to->ldisc.chars_in_buffer(to);
> +	count = chars_in_buffer(to);
>  
>  	if (tty->driver->subtype == PTY_TYPE_SLAVE) return count;
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

hi,

I've implented another approach to this issue, based on some previous 
suggestions. The idea is to lock both sides of a ptmx/pty pair during line 
discipline changing. As previously discussed this has the advantage of 
being on a less often used path, as opposed to locking the ptmx/pty pair 
on read/write/poll paths.

The patch below, takes both ldisc locks in either order b/c the locks are 
both taken under the same spinlock(). I thought about locking the ptmx/pty 
separately, such as master always first but that introduces a 3 way 
deadlock. For example, process 1 does a blocking read on the slave side. 
Then, process 2 does an ldisc change on the slave side, which acquires the 
master ldisc lock but not the slave's. Finally, process 3 does a write 
which blocks on the process 2's ldisc reference. 

This patch does introduce some changes in semantics. For example, a line 
discipline change on side 'a' of a ptmx/pty pair, will now wait for a 
read/write to complete on the other side, or side 'b'. The current 
behavior is to simply wait for any read/writes on only side 'a', not both 
sides 'a' and 'b'. I think this behavior makes sense, but i wanted to 
point it out.

I've tested the patch with a bunch of read/write/poll while changing the  
line discipline out from underneath.

This patch obviates the need for the above "hide the problem" patch. 

thanks,

-Jason

--- linux/drivers/char/tty_io.c.bak
+++ linux/drivers/char/tty_io.c
@@ -458,21 +458,19 @@ static void tty_ldisc_enable(struct tty_
  
 static int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 {
-	int	retval = 0;
-	struct	tty_ldisc o_ldisc;
+	int retval = 0;
+	struct tty_ldisc o_ldisc;
 	char buf[64];
 	int work;
 	unsigned long flags;
 	struct tty_ldisc *ld;
+	struct tty_struct *o_tty;
 
 	if ((ldisc < N_TTY) || (ldisc >= NR_LDISCS))
 		return -EINVAL;
 
 restart:
 
-	if (tty->ldisc.num == ldisc)
-		return 0;	/* We are already in the desired discipline */
-	
 	ld = tty_ldisc_get(ldisc);
 	/* Eduardo Blanco <ejbs@cs.cs.com.uy> */
 	/* Cyrus Durgin <cider@speakeasy.org> */
@@ -483,45 +481,74 @@ restart:
 	if (ld == NULL)
 		return -EINVAL;
 
-	o_ldisc = tty->ldisc;
-
 	tty_wait_until_sent(tty, 0);
 
+	if (tty->ldisc.num == ldisc) {
+		tty_ldisc_put(ldisc);
+		return 0;
+	}
+
+	o_ldisc = tty->ldisc;
+	o_tty = tty->link;
+
 	/*
 	 *	Make sure we don't change while someone holds a
 	 *	reference to the line discipline. The TTY_LDISC bit
 	 *	prevents anyone taking a reference once it is clear.
 	 *	We need the lock to avoid racing reference takers.
 	 */
-	 
+
 	spin_lock_irqsave(&tty_ldisc_lock, flags);
-	if(tty->ldisc.refcount)
-	{
-		/* Free the new ldisc we grabbed. Must drop the lock
-		   first. */
+	if (tty->ldisc.refcount || (o_tty && o_tty->ldisc.refcount)) {
+		if(tty->ldisc.refcount) {
+			/* Free the new ldisc we grabbed. Must drop the lock
+			   first. */
+			spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+			tty_ldisc_put(ldisc);		
+			/*
+			 * There are several reasons we may be busy, including
+			 * random momentary I/O traffic. We must therefore
+			 * retry. We could distinguish between blocking ops
+			 * and retries if we made tty_ldisc_wait() smarter. That
+			 * is up for discussion.
+			 */
+			if (wait_event_interruptible(tty_ldisc_wait, tty->ldisc.refcount == 0) < 0)
+				return -ERESTARTSYS;
+			goto restart;
+		}
+		if(o_tty && o_tty->ldisc.refcount) {
+			spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+			tty_ldisc_put(ldisc);
+			if (wait_event_interruptible(tty_ldisc_wait, o_tty->ldisc.refcount == 0) < 0)
+				return -ERESTARTSYS;
+			goto restart;
+		}
+	}
+
+	/* if the TTY_LDISC bit is set, then we are racing against another ldisc change */
+
+	if (!test_bit(TTY_LDISC, &tty->flags)) {
 		spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 		tty_ldisc_put(ldisc);
-		/*
-		 * There are several reasons we may be busy, including
-		 * random momentary I/O traffic. We must therefore
-		 * retry. We could distinguish between blocking ops
-		 * and retries if we made tty_ldisc_wait() smarter. That
-		 * is up for discussion.
-		 */
-		if(wait_event_interruptible(tty_ldisc_wait, tty->ldisc.refcount == 0) < 0)
-			return -ERESTARTSYS;			
+		ld = tty_ldisc_ref_wait(tty);
+		tty_ldisc_deref(ld);
 		goto restart;
 	}
-	clear_bit(TTY_LDISC, &tty->flags);	
+
+	clear_bit(TTY_LDISC, &tty->flags);
 	clear_bit(TTY_DONT_FLIP, &tty->flags);
-	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
-	
+	if (o_tty) {
+		clear_bit(TTY_LDISC, &o_tty->flags);
+		clear_bit(TTY_DONT_FLIP, &o_tty->flags);
+	}
+	spin_unlock_irqrestore(&tty_ldisc_lock, flags);		
+
 	/*
 	 *	From this point on we know nobody has an ldisc
 	 *	usage reference, nor can they obtain one until
 	 *	we say so later on.
 	 */
-	 
+
 	work = cancel_delayed_work(&tty->flip.work);
 	/*
 	 * Wait for ->hangup_work and ->flip.work handlers to terminate
@@ -572,10 +599,12 @@ restart:
 	 */
 	 
 	tty_ldisc_enable(tty);
+	if (o_tty)
+		tty_ldisc_enable(o_tty);
 	
 	/* Restart it in case no characters kick it off. Safe if
 	   already running */
-	if(work)
+	if (work)
 		schedule_delayed_work(&tty->flip.work, 1);
 	return retval;
 }

