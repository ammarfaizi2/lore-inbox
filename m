Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbTJaHqk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 02:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbTJaHqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 02:46:40 -0500
Received: from www1.cdi.cz ([194.213.194.49]:3784 "EHLO www1.cdi.cz")
	by vger.kernel.org with ESMTP id S263085AbTJaHqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 02:46:36 -0500
Date: Fri, 31 Oct 2003 08:40:06 +0100 (CET)
From: devik <devik@cdi.cz>
X-X-Sender: <devik@devix>
To: "David S. Miller" <davem@redhat.com>
cc: <daniel.blueman@gmx.net>, <netdev@oss.sgi.com>,
       <linux-net@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test9] QoS HTB crash...
In-Reply-To: <20031030130859.605f856d.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0310310839100.11221-100000@devix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CDI: passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm - I have to look at 2.6's definition of rb_next. It
might be the case ! I'll check it.

Thanks, devik

On Thu, 30 Oct 2003, David S. Miller wrote:

> On Thu, 30 Oct 2003 20:50:16 +0100 (CET)
> devik <devik@cdi.cz> wrote:
>
> > thanks for the report. I know that there is an issue regarding
> > HTB in 2.6.x. Please send me net/sched/sch_htb.o,
> > net/sched/sch_htb.c (just to be sure) and be sure that you
> > build the kernel with debugging symbols (see debugging section
> > of menuconfig/xconfig).
>
> I think the problem is the changes that were made
> in 2.5.x to htb_next_rb_node().  It used to be:
>
> static void htb_next_rb_node(rb_node_t **n)
> {
>         rb_node_t *p;
>         if ((*n)->rb_right) {
>                 /* child at right. use it or its leftmost ancestor */
>                 *n = (*n)->rb_right;
>                 while ((*n)->rb_left)
>                         *n = (*n)->rb_left;
>                 return;
>         }
>         while ((p = (*n)->rb_parent) != NULL) {
>                 /* if we've arrived from left child then we have next node */
>                 if (p->rb_left == *n) break;
>                 *n = p;
>         }
>         *n = p;
> }
>
> But it was changed into:
>
> static void htb_next_rb_node(struct rb_node **n)
> {
>         *n = rb_next(*n);
> }
>
> This is wrong, the new code has much different side effects
> than the original code.
>
> This looks like the problem, devik what do you think?
>
>

