Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129834AbRAKRKh>; Thu, 11 Jan 2001 12:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129842AbRAKRKS>; Thu, 11 Jan 2001 12:10:18 -0500
Received: from dsl081-146-215-chi1.dsl-isp.net ([64.81.146.215]:516 "EHLO
	manetheren.eigenray.com") by vger.kernel.org with ESMTP
	id <S129834AbRAKRKJ>; Thu, 11 Jan 2001 12:10:09 -0500
Date: Thu, 11 Jan 2001 10:45:13 -0600 (CST)
From: Paul Cassella <pwc@speakeasy.net>
To: Andrew Morton <andrewm@uow.edu.au>, Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: 2.4.0-ac3 write() to tcp socket returning errno of -3 (ESRCH:
 "No such process")
In-Reply-To: <Pine.LNX.4.21.0101090727000.834-100000@localhost>
Message-ID: <Pine.LNX.4.21.0101111023090.716-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Paul Cassella wrote:

> and mss_now seems to be less than skb->len when the printk happens.  My
> copy of K&R is at work; could that comparison be being done unsigned
> because of skb->len?  I wouldn't think so, but the alternative seems
> somewhat worse...

That'll teach me to post about integral promotions ...

> +		printk(KERN_ERR "%s:%d:%s: err is unexpectedly %d.\n", file, line, func, ret);

... and hand-edit patches before breakfast.


I'm not familiar enough with the tcp code to know if this patch (against
-ac6) is a solution, band-aid, or, in fact, wrong, but I've run with it
(on -ac3) and haven't seen the errors for over twelve hours, which is
three times longer than it had been able to go without it coming up.

--- tcp.c.orig	Thu Jan 11 08:54:50 2001
+++ tcp.c	Thu Jan 11 08:56:42 2001
@@ -954,7 +954,7 @@
 			 */
 			skb = sk->write_queue.prev;
 			if (tp->send_head &&
-			    (mss_now - skb->len) > 0) {
+			    (signed int)(mss_now - skb->len) > 0) {
 				copy = skb->len;
 				if (skb_tailroom(skb) > 0) {
 					int last_byte_was_odd = (copy % 4);


Or would this be better?

+			    (unsigned int)mss_now > skb->len) {

Or making mss_now unsigned in the first place?

-- 
Paul Cassella

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
