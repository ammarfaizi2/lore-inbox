Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUC0EkA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 23:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbUC0EkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 23:40:00 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:48543 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261672AbUC0Ejz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 23:39:55 -0500
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH/2.4]: do_write_mem() return value check
Date: Fri, 26 Mar 2004 19:16:39 +0100
User-Agent: KMail/1.5
References: <20040326033339.GD1997@logos.cnet>
In-Reply-To: <20040326033339.GD1997@logos.cnet>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200403261916.39399.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 04:33, venerdì 26 marzo 2004, Marcelo Tosatti ha scritto:
> On Wed, Mar 24, 2004 at 07:59:01PM +0100, BlaisorBlade wrote:
> > From: Andrew Morton, and me (I did a first fix for 2.6 and sent to him,
> > he checked everything and committed it and I changed the trivial bits for
> > 2.4).

> Do you actually have any practical problem caused by the current broken
> "always return -EFAULT" ?

It is not only that, there can be also data corruption:

- The  "always return -EFAULT" one is a little bug, so you can discard the 
first and third hunk which fix that; anyway, it was Andrew Morton who noticed 
that, so I've no idea (I agree with you but I'm a kernel newbie). Note I 
posted a 2nd version of the patch which fixes a bug in the third hunk (see at 
the end).

- BUT in the hunk below (the 2nd in the patch), without the patch, the var 
"wrote" can be == -EFAULT and WE CAN DO
		p += -EFAULT, 
                buf += -EFAULT;

so that we can read, afterwards, some bytes of junk from buf - EFAULT and put 
them into p - EFAULT, *corrupting memory* !!!!

> > - Add checking for copy_from_user() failures in do_write_mem()

        if (p < (unsigned long) high_memory) {
+               ssize_t written;
+
                wrote = count;
                if (count > (unsigned long) high_memory - p)
                        wrote = (unsigned long) high_memory - p;

-               wrote = do_write_mem(file, (void*)p, p, buf, wrote, ppos);
+               written = do_write_mem((void*)p, p, buf, wrote, ppos);
+               if (written != wrote)
+                       return written;
+               wrote = written;

                p += wrote;
                buf += -EFAULT;


Fix in the second version of the patch, for the 3rd hunk:
- Fix this line:
+                              unwritten = copy_from_user(kbuf, buf, len);
+                              if (unwritten != len) {
					[... error handling]
to this:
+                              unwritten = copy_from_user(kbuf, buf, len);
+                              if (unwritten != 0) {
					[...error handling]
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

