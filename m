Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288788AbSAIEhB>; Tue, 8 Jan 2002 23:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288783AbSAIEgx>; Tue, 8 Jan 2002 23:36:53 -0500
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:43015 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S288480AbSAIEgh>; Tue, 8 Jan 2002 23:36:37 -0500
Message-ID: <003801c198e0$5a85a9d0$4b53cc8e@zhujj>
From: "Michael Zhu" <mylinuxk@yahoo.ca>
To: "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20020107213749.18573.qmail@web14911.mail.yahoo.com> <20020108081515.A19380@suse.de>
Subject: Re: About the request queue of block device
Date: Tue, 8 Jan 2002 23:36:27 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jens, thank you very much for you kindly reply.
Your advice is very helpful to me. I've made some
revisions according to your advice. The attachment
contains some functions of mine. I don't know whether
I am right. I've done some test, but failed.

In your mail you said that I can replace floppy
blk_dev
make_request_fn with my own that does the encryption
on write and stacks a new buffer head on top of the
other for READ, defining my own b_end_io function for
that to decrypt on READ end I/O. How can I stacks a
new buffer head on top of the other for READ? Is it
necessary? How to implement this? Please give me a
hand on this. Thank you very much.

BTW, I've browsed the source code of __make_request()
function in the ll_rw_blk.c file. Do I need to call
the 'bh = create_bounce(rw, bh);' before I can access
the bh->b_data? You know the buffer data may point
into the high memory. My failure is because of this?

I am so sorry to take you so much time and trouble.
But I really need your help. Thank you very much.

Michael


P.S.: The following is my source code.


asmlinkage void kti_b_end_io(struct buffer_head *bh, int uptodate)
{
        int j;
        pmy_b_end_io private;

        private = bh->b_private;
        bh->b_private = NULL;
        bh->b_end_io = private->b_end_io;

        if(uptodate){
                for(j = 0; j < bh->b_size; j ++)
                        bh->b_data[j] ^= 0xaa;
        }

        bh->b_end_io(bh, uptodate);

        kfree(private);
}

asmlinkage int (*original_make_request_fn)(request_queue_t * q, int rw,
                                  struct buffer_head *bh);

asmlinkage pmy_b_end_io kti_get_private(void)
{
	pmy_b_end_io ptr = NULL;
        while (!ptr) {
        	ptr = (pmy_b_end_io)kmalloc(sizeof(my_b_end_io), GFP_NOIO);
                if(!ptr) {
                	__set_current_state(TASK_RUNNING);
                                current->policy |= SCHED_YIELD;
                                schedule();
                }
        }

        return ptr;
}

asmlinkage int kti_make_request_fn(request_queue_t * q, int rw,
                             struct buffer_head *bh)
{
        int retcode;
        int i;
        pmy_b_end_io private;

        switch (rw) {
            case READA:
            case READ:
                private = kti_get_private();
                private->bh = bh;
                private->b_end_io = bh->b_end_io;
                bh->b_private = private;

                bh->b_end_io = kti_b_end_io;

                break;

            case WRITE:
                for(i = 0; i < bh->b_size; i ++)
                        bh->b_data[i] ^= 0xaa;

                break;
        }

    retcode = original_make_request_fn(q, rw, bh);
    return retcode;
}

int init_module()
{
    int i;

    spin_lock_irq(&io_request_lock);
    original_make_request_fn = blk_dev[2].request_queue.make_request_fn;
    blk_dev[2].request_queue.make_request_fn = kti_make_request_fn;
    spin_unlock_irq(&io_request_lock);

    return 0;
}

void cleanup_module()
{
    spin_lock_irq(&io_request_lock);
    blk_dev[2].request_queue.make_request_fn = original_make_request_fn;
    spin_unlock_irq(&io_request_lock);
}



----- Original Message ----- 
From: "Jens Axboe" <axboe@suse.de>
To: "Michael Zhu" <mylinuxk@yahoo.ca>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, January 07, 2002 11:15 PM
Subject: Re: About the request queue of block device


> On Mon, Jan 07 2002, Michael Zhu wrote:
> > Hello, everyone, I have a question about the request
> > queue of block device.
> > 
> > I intercept the request function of floppy disk device
> > by changing the pointer, 
> >  "blk_dev[2].request_queue.request_fn", in my kernel
> > module. The following is the source code.
> > 
> > original_request_fn_proc =
> > blk_dev[2].request_queue.request_fn;
> > blk_dev[2].request_queue.request_fn =
> > my_request_fn_proc;
> 
> I'm sure you are protecting access to the queues appropriately?
> 
> > In my own my_request_fn_proc() I use the "req =
> > blkdev_entry_next_request(&rq->queue_head)" function
> > to get the pointer of the request structure. When
> > req->cmd is WRITE I encrypt all the b_data buffer of
> > the buffer header. Then I call the
> > original_request_fn_proc(). And it works. The data on
> > the floppy disk is some kind of cipher data. The
> 
> Irk... You are effectively killing plugging of the floppy driver with
> this approach. You do realise that when your replacement request_fn is
> called, there are probably more than one request on the queue?
> 
> > trouble is when the req->cmd is READ. I don't know
> > whether the b_data buffer contains the data read from
> > the floppy disk after I call the
> > original_request_fn_proc() function. When read a block
> > from the block device, where is the data is placed?
> 
> If it's quick, then it's _probably_ there. The problem is, you'll
> basically have to iterate all buffers in the request and do get_bh on
> them prior to submitting to the original floppy request_fn, then
> afterwards wait on completion (out of your own request_fn context). You
> should probably off load that to a dedicated thread. And then do
> processing on a make_request_fn basis instead so you only have to deal
> with single buffer_heads at the time, ie replace floppy blk_dev
> make_request_fn with your own that does the encryption on write and
> stacks a new buffer head on top of the other for READ, defining your own
> b_end_io function for that to decrypt on READ end I/O.
> 
> Any particular reason your not using the loop device and just writing
> your own crypt plugin??
> 
> > In my module I use the blkdev_next_request() function
> > to get the next request. When I want to do the same
> > thing to this next request, the Linux kernel
> > deadlocked. I must reboot the OS. What is wrong?
> 
> You are probably walking right into the queue head and using that as a
> request, boom.
> 
> -- 
> Jens Axboe


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

