Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbTKZF1N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 00:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTKZF1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 00:27:13 -0500
Received: from 5.86.35.65.cfl.rr.com ([65.35.86.5]:33665 "EHLO
	drunkencodepoets.com") by vger.kernel.org with ESMTP
	id S262119AbTKZF1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 00:27:11 -0500
Date: Wed, 26 Nov 2003 00:27:13 -0500
From: Pat Erley <paterley@mail.drunkencodepoets.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] trivial change in kernel/sched.c in 2.6.0-test9+
Message-Id: <20031126002713.1f8707f8.paterley@mail.drunkencodepoets.com>
Organization: drunkencodepoets.com
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this ends up saving a few math operations any time a child
process exits. ( calling sched_exit(task_t * p) )

here's my exact comment on the contents of the patch (left
out of the actual patch)

    /*
     * the funcion below was origionally this, for anyone
     * wondering what I changed.  I mearly used some algebra
     * to factor out a 1 / (EXIT_WEIGHT + 1)
     *
     *      p->parent->sleep_avg = p->parent->sleep_avg /
     *      (EXIT_WEIGHT + 1) * EXIT_WEIGHT + p->sleep_avg /
     *      (EXIT_WEIGHT + 1);
     *
     * the only possible effects I see this having are:
     *
     *    1. less math operations for each child process exiting
     *    2. higher accuracy in the value of p->parent->sleep_avg
     *       due to using only 1 division over 2
     *
     */

patches clean(a little offset, but no fuzz) on test9, test9-mms, 
test10, test10-mm1

Pat Erley

/*************** patch follows ******************/


--- linux-2.6.0-test9/kernel/sched.c    2003-11-23 02:33:34.000000000 -0500
+++ linux/kernel/sched.c        2003-11-23 02:47:29.730649061 -0500
@@ -720,8 +720,8 @@
         * the sleep_avg of the parent as well.
         */
        if (p->sleep_avg < p->parent->sleep_avg)
-               p->parent->sleep_avg = p->parent->sleep_avg /
-               (EXIT_WEIGHT + 1) * EXIT_WEIGHT + p->sleep_avg /
+               p->parent->sleep_avg = ( p->parent->sleep_avg *
+               EXIT_WEIGHT + p->sleep_avg ) /
                (EXIT_WEIGHT + 1);
 }


-- 
