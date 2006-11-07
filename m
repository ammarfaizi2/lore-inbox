Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753063AbWKGVOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbWKGVOt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 16:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753096AbWKGVOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 16:14:49 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:176 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1753061AbWKGVOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 16:14:48 -0500
Date: Tue, 7 Nov 2006 22:14:32 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Robotis Konstantinos <krobotis@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: write data to a file from a kernel module
In-Reply-To: <f356cfa0611070652u75eb5622v2144daa9fa4b563f@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0611072209010.30665@yvahk01.tjqt.qr>
References: <f356cfa0611070652u75eb5622v2144daa9fa4b563f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
>
> I am trying to create a module for kernel 2.4.27 that writes data to a
> file when it
> receives a packet from the network interface card. In the code below

What makes tcpdump and friends not usable that you need to write kernel 
code?

> the pkt_handler function is called each time a packet is received. A
> while after the insmod, the CPU reaches 100% and the pc freezes.
>
> Is there something wrong with the code or is there an alternate way to
> write data to a file?  I think the problem is because the opening and
> writing are happening too often. Don't tell me to use the proc
> filesystem, it is
> not appropriate in my case.

If at all, you should use a character device and do the copying with 
copy_to_user() rather than trying to open/write files in kernelspace.

>
> Thanks in advance.
>
> (I've commented out the semaphore operations because they don't seem to
> work as they are currently used)
>
> /* Packet handler. It is called by the kernel when a new packet has
> been received.  */
> int pkt_handler (struct sk_buff *skb, struct net_device *dv, struct
> packet_type *pt)
> {
> static int calls = 0;

Your indentation is broekn, it's hard to read.

> kfree_skb (skb);
>
> printk (KERN_ALERT "packet %d received\n", calls);
> if (calls++ > 10) {
> open_f_and_write ("/tmp/tmp.log");

You repeatedly open and write. That's a CPU buster for sure.
How about opening it once? (Of course that leaves the question where to 
close it - which is why you should use alternate methods such as char 
devs, (proc) or SOCK_RAW)

open_f_and_write()s return value is not examined. In case you run into a 
problem, you will continue to do so -- not so good, better stop when 
there is a problem.

> calls = 0;
> }
>
> return 0;
> }
>
>
> int open_f_and_write (const char *file_name)
> {
> struct file *file = NULL;
> mm_segment_t fs;
> char *tmp;
> struct inode *inode;
>
> tmp = getname (file_name);
>
> file = filp_open (tmp, O_CREAT | O_WRONLY | O_APPEND, S_IRWXU);
> if (IS_ERR (file)) {

tmp is not freed. So it's more than just logical for the box to lockup 
someday.

> int errno = PTR_ERR (file);
> printk (KERN_DEBUG "error %i\n", errno);
> return 2;

You usually would return -PTR_ERR(file) here;

> }
> if (!file->f_op->write) {
> fput (file);

tmp is not freed here either.

> return 3;
> }
>
> fs = get_fs ();
> set_fs (KERNEL_DS);
> //inode = file->f_dentry->d_inode;
> //down (&inode->i_sem);
>
> {
> char *buffer = "write something\n";
> int p = file->f_op->write (file, buffer, m_strlen (buffer),

strlen(buffer) is probably better, whatever m_strlen() is.

> &file->f_pos);
> printk (KERN_ALERT "write returned %d\n", p);
> }
> //up(&inode->i_sem);
> set_fs (fs);
> putname (tmp);
> filp_close (file, NULL);
>
> return 0;
> }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

	-`J'
-- 
