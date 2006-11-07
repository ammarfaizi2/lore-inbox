Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753886AbWKGOwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886AbWKGOwb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 09:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753876AbWKGOwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 09:52:31 -0500
Received: from wr-out-0506.google.com ([64.233.184.237]:41806 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1753886AbWKGOwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 09:52:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bAWjpl1yG+9wlkanMcVjnUGC9m7stJhLSW9K6/PG1HnnP6sIJMuvh/nnD/JIArFNuD+Rv8gQSpdzDeoCKiiYccVLCzNkHMWdpaWBsivEGknV2oZg7VR1pgOvT0KVerSM239c1IBQkpgQZI/RlSVuSwuMk/+60EpsBV/qEOzQjbw=
Message-ID: <f356cfa0611070652u75eb5622v2144daa9fa4b563f@mail.gmail.com>
Date: Tue, 7 Nov 2006 09:52:27 -0500
From: "Robotis Konstantinos" <krobotis@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: write data to a file from a kernel module
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am trying to create a module for kernel 2.4.27 that writes data to a
file when it
receives a packet from the network interface card. In the code below
the pkt_handler function is called each time a packet is received. A
while after the insmod, the CPU reaches 100% and the pc freezes.

Is there something wrong with the code or is there an alternate way to
write data to a file?  I think the problem is because the opening and
writing are happening too often. Don't tell me to use the proc
filesystem, it is
not appropriate in my case.

Thanks in advance.

(I've commented out the semaphore operations because they don't seem to
work as they are currently used)

/* Packet handler. It is called by the kernel when a new packet has
been received.  */
int pkt_handler (struct sk_buff *skb, struct net_device *dv, struct
packet_type *pt)
{
 static int calls = 0;
 kfree_skb (skb);

 printk (KERN_ALERT "packet %d received\n", calls);
 if (calls++ > 10) {
   open_f_and_write ("/tmp/tmp.log");
   calls = 0;
 }

 return 0;
}


int open_f_and_write (const char *file_name)
{
 struct file *file = NULL;
 mm_segment_t fs;
 char *tmp;
 struct inode *inode;

 tmp = getname (file_name);

 file = filp_open (tmp, O_CREAT | O_WRONLY | O_APPEND, S_IRWXU);
 if (IS_ERR (file)) {
   int errno = PTR_ERR (file);
   printk (KERN_DEBUG "error %i\n", errno);
   return 2;
 }
 if (!file->f_op->write) {
   fput (file);
   return 3;
 }

 fs = get_fs ();
 set_fs (KERNEL_DS);
 //inode = file->f_dentry->d_inode;
 //down (&inode->i_sem);

 {
   char *buffer = "write something\n";
   int p = file->f_op->write (file, buffer, m_strlen (buffer),
&file->f_pos);
   printk (KERN_ALERT "write returned %d\n", p);
 }
 //up(&inode->i_sem);
 set_fs (fs);
 putname (tmp);
 filp_close (file, NULL);

 return 0;
}
