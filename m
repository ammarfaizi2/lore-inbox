Return-Path: <linux-kernel-owner+w=401wt.eu-S964775AbWLTB7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWLTB7y (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 20:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932964AbWLTB7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 20:59:54 -0500
Received: from smtp.osdl.org ([65.172.181.25]:53559 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932968AbWLTB7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 20:59:53 -0500
Date: Tue, 19 Dec 2006 17:59:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robert Hancock <hancockr@shaw.ca>
Cc: kyle <kylewong@southa.com>, linux-kernel@vger.kernel.org
Subject: Re: schedule_timeout: wrong timeout value
Message-Id: <20061219175949.471dc3b4.akpm@osdl.org>
In-Reply-To: <45874FC3.503@shaw.ca>
References: <fa.n+5Mb4OrI3NXIfyW+9Do6h0Q2UA@ifi.uio.no>
	<45874FC3.503@shaw.ca>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006 20:34:43 -0600
Robert Hancock <hancockr@shaw.ca> wrote:

> kyle wrote:
> > Hi,
> > 
> > Recently my mysql servershows something like:
> > Dec 18 18:24:05 sql kernel: schedule_timeout: wrong timeout value 
> > ffffffff from c0284efd
> > Dec 18 18:24:36 sql last message repeated 19939 times
> > Dec 18 18:25:37 sql last message repeated 33392 times
> > 
> > from syslog every 1 or 2 days. Whenever the messages show, mysql server 
> > stop accept new connections from the same network, and I need to restart 
> > the mysql service and then it will keep running well for 1-2 days until 
> > the messages show up again.
> > 
> > The server has been running over 1 year without any problem, the problem 
> > started show up around 2 weeks ago. It's running kernel 2.6.12, and 
> > mysql server, nothing else. Hardware is Pentium 4 2.8GHz with 
> > hyperthreading enabled.
> > 
> > What does the kernel message mean and why it make mysql stop accept new 
> > connections? Is it hardware problem or try upgrade the kernel may help?
> > Please CC me if possible. Thank you
> 
> The message means some code in the kernel or in some module passed a 
> negative value to schedule_timeout which it shouldn't have. The c0284efd 
> value is the address of the function that made the call - you may be 
> able to look that up in your /proc/ksyms or the System.map file and 
> figure out what function that is..
> 

I queued this:


From: Andrew Morton <akpm@osdl.org>

Kyle is hitting this warning, and we don't have a clue what it's caused by. 
Add the obligatory dump_stack().

Cc: kyle <kylewong@southa.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 kernel/timer.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff -puN kernel/timer.c~schedule_timeout-improve-warning-message kernel/timer.c
--- a/kernel/timer.c~schedule_timeout-improve-warning-message
+++ a/kernel/timer.c
@@ -1344,11 +1344,10 @@ fastcall signed long __sched schedule_ti
 		 * should never happens anyway). You just have the printk()
 		 * that will tell you if something is gone wrong and where.
 		 */
-		if (timeout < 0)
-		{
+		if (timeout < 0) {
 			printk(KERN_ERR "schedule_timeout: wrong timeout "
-				"value %lx from %p\n", timeout,
-				__builtin_return_address(0));
+				"value %lx\n", timeout);
+			dump_stack();
 			current->state = TASK_RUNNING;
 			goto out;
 		}
_

