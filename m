Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264905AbTFUPqR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 11:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264928AbTFUPqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 11:46:17 -0400
Received: from dm4-159.slc.aros.net ([66.219.220.159]:13245 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S264905AbTFUPp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 11:45:59 -0400
Message-ID: <3EF480F9.1080205@aros.net>
Date: Sat, 21 Jun 2003 09:59:53 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>, steve@chygwyn.com
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [RFC][PATCH] nbd driver for 2.5.72
References: <3EF3F08B.5060305@aros.net> <20030620234422.74533c65.akpm@digeo.com>
In-Reply-To: <20030620234422.74533c65.akpm@digeo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Lou Langholtz <ldl@aros.net> wrote:
>  
>
>>The following (attached) patch to the network block device driver (nbd)
>>    
>>
>
>is enormous.  It is a shame that the changes were not broken into separate
>logical patches.
>  
>
You're right... it is larger than desirable. This is my fault and came 
about from starting with integrating Steve's thread patch  as the first 
change. But the thread patch is probably the greatest source of line 
changes so things kind of got out of hand from the standpoint you're 
promoting (which I agree with). I've been reconsidering the threads 
change quite a bit. In 2.4 series kernel where I/O is conventionally all 
wrapped around a single lock in a single threaded fassion this makes 
more sense. Of course 2.4 actually supports using multiple request 
queue's but I didn't figure that out till I was way into integrating 
Steve's thread patch. That paired with dropping the single spin lock 
before any blocking operations and then picking it up again afterward 
should be enough then to fix what I'm guessing Steve found to be the 
cause for the deadlocking condition. Going forward (ie. in 2.5+), none 
of this matters anymore since conventionally every block device is 
implemented with its own request queue and spin lock so I think the 
threaded change can all be removed. And as an option, the network 
data_ready callback used instead to provide the reply handling thread 
functionality instead of holding the user process down. Steve even 
suggested as much (instead of using multiple kernel threads) but I 
didn't understand well enough at the time how that would work (and I was 
already familiar with a multithreaded approach from my work improving 
the nbd server code).

>>- * 01-12-6 Fix deadlock condition by making queue locks independent of
>>+ * 01-12-6 Fix deadlock condition by making queue locks independant of
>>    
>>
>
>Actually "independent" is correct.
>  
>
Thanks for catching this.

>>  *   the transmit lock. <steve@chygwyn.com>
>>  * 02-10-11 Allow hung xmit to be aborted via SIGKILL & various fixes.
>>  *   <Paul.Clements@SteelEye.com> <James.Bottomley@SteelEye.com>
>>+ * 03-05-02 Ported thread patch by <steve@uk.sistina.com> which moves
>>+ *   network I/O into seperate kernel threads so request function no longer
>>+ *   blocks. <ldl@aros.net>
>>+ * 03-05-02 Switched to configurable debugging output. <ldl@aros.net>
>>
. . .

>>+ * 03-06-13 Implemented NBD_WRITE_NOCHK. <ldl@aros.net>
>>+ * 03-06-15 Fixed code to report proper size even when using nbd-client.
>>+ *   <ldl@aros.net>
>>  *
>>    
>>
>
>The above appears to be a good description of how you should have
>structured the patch series.
>
Very true. I'll redo the work as a series of patches instead of one 
giant one. This also makes code validation easier too. ;-)

>>+#  define REQUEST_QUEUE(req) (&(req)->queuelist)
>>+#  define REQUEST_QUEUE_NEXT_REQUEST(q) (elv_next_request(q))
>>+#  define REQUEST_CMD(req) ((req)->cmd[0])
>>+#  define DAEMONIZE(fmt...) daemonize(fmt)
>>+#  define NBD_BYTESIZE(lo) ((lo)->bytesize)
>>+#  define NBD_BLKSIZE(lo) ((lo)->blksize)
>>+#  define INODE_TO_NBD(i) ((i)->i_bdev->bd_disk->private_data)
>>    
>>
>
>These guys should just be open-coded.  They do not add anything, and they
>tend to obscure.
>  
>
Agreed again. I had these like this cause I wrote the driver originally 
using LINUX_VERSION macro checking so that the same source file compiled 
on either 2.4.20 or 2.5.72. Pavel & Steve rightly had suggested getting 
rid of the the pre-2.5 code sections to clean away the extra #ifdefs but 
I neglected to open-code/inline away these remaining macros.

>>+static nbd_device_t nbd_devs[MAX_NBD];
>>+static struct request_queue nbd_queue[MAX_NBD];
>>+static spinlock_t nbd_lock[MAX_NBD];
>>+static uint32_t request_magic;
>>+static uint32_t reply_magic;
>>    
>>
>
>u32 here?
>
What's the standard convention these days for this? I was reading 
somewhere that the uXX forms came about prior to the uintXX_t forms 
being accepted standards in C and have basically just stayed around. 
Seems like new linux code should now use the new C standards then no?

>>-void nbd_send_req(struct nbd_device *lo, struct request *req)
>>+static inline void wait_for_completion_interuptably(struct completion *x)
>>    
>>
>
>"interruptibly" is spelled better.  "interruptible" is more consistent with
>other things.
>
Thanks again for pointing the spelling errors out.

>Maybe this function should be in kernel/sched.c
>	
>
I'd love that. Seems like various other inline have an "interruptible" 
form (like the semaphore down code). Why not also wait_for_completion???

>  
>
>>+static int wait_for_io_threads(nbd_device_t *lo)
>>+{
>>...
>>+	add_wait_queue(&lo->no_io_waiters, &wait);
>>+	if (atomic_read(&lo->num_io_threads) > 0) {
>>+		dprintk(NBD_DEBUG_SESSION, "nb%d: %s: going to sleep...\n",
>>+			minor, __FUNCTION__);
>>+		set_current_state(TASK_INTERRUPTIBLE);
>>+		schedule();
>>+		set_current_state(TASK_RUNNING);
>>+		if (signal_pending(current))
>>+			signaled = 1;
>>+		dprintk(NBD_DEBUG_SESSION, "nb%d: %s: woken up (%s)\n",
>>+			minor, __FUNCTION__, signaled? "signaled": "done");
>>    
>>
>
>This looks buggy.  If num_io_threads goes to zero before the
>set_current_state() then the code will still sleep.  Making it
>
>	if (atomic_read(&lo->num_io_threads) > 0)
>		schedule();
>
>will fix that.
>  
>
Well the thread sleeping is still predicated on the add_wait_queue() 
call which should handle setting the thread state such that the 
atomic_read() followed by schedule() won't miss the wake_up correct??? 
If not, you're fix still has the race you're talking about no???

>>+ * This function must be called with io_request_lock held & interupts disabled.
>>    
>>
>
>io_request_lock went away.
>
But the comment wasn't updated for the 2.5+ case. My bad!

>. . .
>  
>
>>+#ifdef USE_ZEROCOPY
>>    
>>
>
>Can you tell us about this?  Why is it optional?  Does it work OK?  Any
>restrictions or concerns about it?
>  
>
I added calls to the network sendpage() routine pretty late in this work 
at Steve's recommendation. I wasn't sure what I was doing (I'm still 
unclear about a lot of implementation details of the network code like 
using the  sock data_ready callback). So I wanted the code easy to 
identity and back out in case it didn't work. I also wanted to be able 
to easily generate two different module binaries that I could run time 
tests on. I've run some time tests now with 100Mbps networking and 
basically the results are too obfuscated by external events to make any 
conlusion other than the network I/O itself is so much slower than the 
time wasted by additional copying. That said, the way I use sendpage() 
does seem to work correctly so at least conceptually there's no need to 
have the other code in there anymore and we can rest assured that we may 
spare some cycles this way for some other thread's benefit at least. ;-)

>>. . . 
>>+	spin_unlock_irqrestore(&current->sighand->siglock, flags);
>>+	if (unblocked)
>>+		dprintk(NBD_DEBUG_THREADS, "%s[%d]: SIGKILL unblocked.\n",
>>+				current->comm, current->pid);
>> }
>>    
>>
>
>I believe it would be better to not attempt to control kernel threads with
>signals in this manner.  This is not userspace - it is kernel, and we can
>employ much simpler means of interprocess communications in-kernel.  See
>how kjournald gets shut down, for instance.
>
>Using signals is complex, bloaty and tends to go wrong.  It would be a nice
>cleanup if you could get rid of all the signal stuff.
>  
>
There's a lot of need though to control any I/O blocking with something 
as natural as killing the blocked process. Having signal handling code 
also provides an easy way to notify the driver to "disconnect". That is 
one doesn't need to use or even have nbd-client to disconnect a NBD 
device from its server this way. But I'm going to rip the thread change 
back out to try using the data_ready callback instead and do some more 
time tests (and see what difference it makes). So long as I don't see it 
consistantly being slower, I'll be convinced that this is the better way 
both conceptually as well as practically.

>>-module_init(nbd_init);
>>-module_exit(nbd_cleanup);
>>+static int session_loop(void *data)
>>+{
>>+	nbd_device_t *lo = (nbd_device_t *)data;
>>+	int rv = 0, seconds, ncleared;
>>+#ifndef NDEBUG
>>+	int minor = DEVICE_TO_MINOR(lo);
>>+#endif /* NDEBUG */
>>+
>>+	__module_get(THIS_MODULE);
>>+	DAEMONIZE("nb%d-sess", lo - nbd_devs);
>>+	spin_lock(&lo->lock);
>>+	lo->ss_thread.task = current;
>>+	spin_unlock(&lo->lock);
>>    
>>
>
>This locking isn't needed is it?
>
I think it is but if I can get NBD working without the two threads per 
network block device this question will be moot. NBD is uncomfortably 
large without managing threads. Having the additional overhead of the 
two threads per nbd is a lot of extra code and data anyway that I think 
everyone would rather see trimmed down. I'd really like to hear from 
Steve though on the deadlock condition he originally did the thread 
patch to avoid and make sure I understand this situation correctly.

>. . . 
>  
>
>>+static int rx_loop(void *data)
>>+static int tx_loop(void *data)
>>    
>>
>
>What was the deadlock which necessitated the creation of these kernel
>threads?
>  
>
Was it just blocking other nbd's from getting to send out other requests 
to their respective servers??? Steve???

>My eyes glazed over at this point.
>
>It is good that you are caring for NBD.  It has always been a bit sick and
>people seem to find it useful.  If you could have a think about the above
>(especially the signal thing) and send me the result I shall beat on it a
>bit.
>
>Thanks.
>  
>
Following the diff code is dizzying for me too (and I even wrote a lot 
of the new code!). I very much want to thank  you and everyone else who 
has commented so far on their great suggestions!! And I will get back 
with a series of patches to the 2.5.72 nbd distribution that tackles 
just one thing at a time like discussed, starting with making it work at 
all in the 2.5 framework (as it is I don't think it will actually do 
more than compile).

In the meantime:

   1. Will someone see about getting the interuptible variant of
      wait_for_completion into the kernel (please)?
   2. Can others chime in on the u32 vs. uint32_t issue or point me to
      where this has been recently hashed out?
   3. Steve, please shed some light on the deadlock condition that
      caused you to do the original thread patches. And accept my
      appology again for not just going with the callback approach that
      you did recommend over this threaded design.


Thanks again!!!

Lou

