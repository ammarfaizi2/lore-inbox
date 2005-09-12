Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbVILP0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbVILP0c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbVILP0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 11:26:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54720 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751108AbVILP0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 11:26:31 -0400
Message-ID: <43259C84.5020209@redhat.com>
Date: Mon, 12 Sep 2005 11:19:32 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, dwmw2@infradead.org, bunk@stusta.de,
       johnstul@us.ibm.com, drepper@redhat.com, Franz.Fischer@goyellow.de,
       linux-kernel@vger.kernel.org
Subject: Re: [UPDATE PATCH][Bug 5132] fix sys_poll() large timeout handling
References: <20050831200109.GB3017@us.ibm.com> <20050906212514.GB3038@us.ibm.com> <20050910003525.GC24225@us.ibm.com> <20050909181658.221eb6f9.akpm@osdl.org> <20050910022330.GD24225@us.ibm.com> <20050909193621.5d578583.akpm@osdl.org> <20050910025534.GE24225@us.ibm.com> <4325910E.8080707@redhat.com> <20050912150541.GA25471@us.ibm.com>
In-Reply-To: <20050912150541.GA25471@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------070104020403010402010200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070104020403010402010200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nishanth Aravamudan wrote:

>
>I don't think the embedded folks are going to be ok with adding a 64-bit
>div in the poll() common-path... But otherwise the patch looks pretty
>sane, except I think you want s64, not int64_t? I can't ever remember
>myself :)
>  
>

Oops, I missed an include which is required.  The updated patch is attached.

A 64 bit quantity divided by a 32 bit quantity seems to be a standard
interface in the kernel and is used fairly widely, so I suspect that
the embedded folks have already done the work.

I don't know which should be used, s64 or int64_t.  I chose int64_t
because then it would (more or less) match the interface of do_div().

>I agree the interface mght be mis-defined. And changing timeout_msecs()
>to an integer is consistent with the size of millisecond-unit variables
>used elsewhere in the kernel.
>

Yes, it also makes the kernel definition for sys_poll() match the user level
definition for poll(2) found in <poll.h>.

    Thanx...

       ps

Signed-off-by: Peter Staubach <staubach@redhat.com>

--------------070104020403010402010200
Content-Type: text/plain;
 name="select.devel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="select.devel"

--- linux-2.6.13/fs/select.c.org	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13/fs/select.c	2005-09-12 11:11:53.000000000 -0400
@@ -24,6 +24,7 @@
 #include <linux/fs.h>
 
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 #define ROUND_UP(x,y) (((x)+(y)-1)/(y))
 #define DEFAULT_POLLMASK (POLLIN | POLLOUT | POLLRDNORM | POLLWRNORM)
@@ -457,25 +458,34 @@ static int do_poll(unsigned int nfds,  s
 	return count;
 }
 
-asmlinkage long sys_poll(struct pollfd __user * ufds, unsigned int nfds, long timeout)
+asmlinkage long sys_poll(struct pollfd __user * ufds, unsigned int nfds, int timeout_msecs)
 {
 	struct poll_wqueues table;
  	int fdcount, err;
  	unsigned int i;
 	struct poll_list *head;
  	struct poll_list *walk;
+	long timeout;
+	int64_t lltimeout;
 
 	/* Do a sanity check on nfds ... */
 	if (nfds > current->files->max_fdset && nfds > OPEN_MAX)
 		return -EINVAL;
 
-	if (timeout) {
-		/* Careful about overflow in the intermediate values */
-		if ((unsigned long) timeout < MAX_SCHEDULE_TIMEOUT / HZ)
-			timeout = (unsigned long)(timeout*HZ+999)/1000+1;
-		else /* Negative or overflow */
+	if (timeout_msecs) {
+		if (timeout_msecs < 0)
 			timeout = MAX_SCHEDULE_TIMEOUT;
-	}
+		else {
+			lltimeout = (int64_t)timeout_msecs * HZ + 999;
+			do_div(lltimeout, 1000);
+			lltimeout++;
+			if (lltimeout > MAX_SCHEDULE_TIMEOUT)
+				timeout = MAX_SCHEDULE_TIMEOUT;
+			else
+				timeout = (long)lltimeout;
+		}
+	} else
+		timeout = 0;
 
 	poll_initwait(&table);
 
--- linux-2.6.13/include/linux/syscalls.h.org	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13/include/linux/syscalls.h	2005-09-12 10:22:25.000000000 -0400
@@ -420,7 +420,7 @@ asmlinkage long sys_socketpair(int, int,
 asmlinkage long sys_socketcall(int call, unsigned long __user *args);
 asmlinkage long sys_listen(int, int);
 asmlinkage long sys_poll(struct pollfd __user *ufds, unsigned int nfds,
-				long timeout);
+				int timeout_msecs);
 asmlinkage long sys_select(int n, fd_set __user *inp, fd_set __user *outp,
 			fd_set __user *exp, struct timeval __user *tvp);
 asmlinkage long sys_epoll_create(int size);

--------------070104020403010402010200--
