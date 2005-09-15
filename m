Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030396AbVIONHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbVIONHI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 09:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbVIONHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 09:07:07 -0400
Received: from web8401.mail.in.yahoo.com ([202.43.219.149]:21632 "HELO
	web8401.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S1030396AbVIONHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 09:07:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=bVDR56o4glM25ub7S/ifHJlWLdUFpUMM3e/PG0z1ZNTN4wu0UuQJ/xVOkXW0DcvUgAIP1JMZobxPh8RV5Q+w0craIIjpV/5BI4YDLieY5+8XI77uLN0e7sO8a2EHqsACoatte+bX7z2gmJcWUwWzJSQugSxIer9LH9DNXH0/1LE=  ;
Message-ID: <20050915130655.48637.qmail@web8401.mail.in.yahoo.com>
Date: Thu, 15 Sep 2005 14:06:54 +0100 (BST)
From: shashank kharche <shashank_pict@yahoo.com>
Subject: Problem in writing simple block device driver...
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1243732093-1126789614=:47523"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1243732093-1126789614=:47523
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

I have written a simple block device driver in which i
m just displaying messages
in read & write part e.g " Device Reading .... " &  "
Device Writing .....".
I have succesfully loaded that module in memory using
"insmod" . 
& then use " mknod " command ...as   : 

                   mknod block_dev b 100 0 
  where , block_dev : name of device
                  b : as i m using block device driver
                100 : major number
                  0 : minor number
   
Even this is also working without error, now after
this command device "block_dev" is created (i have
checked it wit ls command ).
But , now while using "cat" & "echo" i am getting
error as :
       
       [root@localhost root]# cat block_dev
       cat: block_dev : No such device or address

       [root@localhost root]# echo "hello" > block_dev
       bash: block_dev : No such device or address
               
Is it ok to use 'b' in mknod command while working
with block device driver,
as i hav used (shown above).

Im attaching C-code also,so plz help me....if you have
another simple code for block device driver please
send me : shashank_pict@yahoo.com 

Please tell me what is going wrong in this code.....


		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
--0-1243732093-1126789614=:47523
Content-Type: text/x-csrc; name="bdd.c"
Content-Description: 2940518666-bdd.c
Content-Disposition: inline; filename="bdd.c"

#include <linux/config.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/init.h>
#include <linux/sched.h>
#include <linux/kernel.h>	
#include <linux/slab.h>		
#include <linux/fs.h>		
#include <linux/errno.h>	
#include <linux/types.h>	
#include <linux/fcntl.h>	
#include <linux/kdev_t.h>


#define DEVICE_NAME "block_dev"
#define MAJOR_NUM 100
MODULE_LICENSE("GPL");
atomic_t Device_Open = ATOMIC_INIT(0);

struct block_dev
{
     struct request_queue *queue ;
     spinlock_t lock;
};

struct block_dev *dev;

static void bdd_request(request_queue_t *q)
{
	struct request *req;
	int write ;
        while ((req = elv_next_request(q)) != NULL) 
	{
		if (! blk_fs_request(req))
	      {
			printk (KERN_ALERT "Skip non-fs request\n");
			end_request(req, 0);
			continue;
		}
            write=rq_data_dir(req);
            if(write==0)
 		      printk(KERN_ALERT "Reading Device .....");
            else
     		      printk(KERN_ALERT "Writing Device .....");
        	end_request(req, 1);
	}
}

static int device_open(struct inode *inode, struct file *file)
{
        printk(KERN_ALERT "OPENING DEVICE.....\n");  
 	atomic_inc(&Device_Open);
	try_module_get(THIS_MODULE);
	return 0;
}

static int device_release(struct inode *inode, struct file *file)
{
	printk(KERN_ALERT "RELEASING DEVICE....\n");
        atomic_dec(&Device_Open);
	module_put(THIS_MODULE);
	return 0;
}


static struct block_device_operations bdd_ops = 
{
	.open     = device_open,
	.release  = device_release,
};

static int init_function(void)
{ 
  int ret_val;
  dev = (struct block_dev*)kmalloc(sizeof(struct block_dev),GFP_KERNEL);
  ret_val=register_blkdev(MAJOR_NUM,DEVICE_NAME);
  if(ret_val<0)
  {	
      printk(KERN_ALERT "Sorry, registering the block device");   
      return ret_val;
  } 
  printk(KERN_ALERT "Initialization\n");
  dev->queue=blk_init_queue(bdd_request,&dev->lock);
  return 0;
}

static void exit_function(void)
{
  int ret_val;
  ret_val=unregister_blkdev(MAJOR_NUM,DEVICE_NAME);
  printk(KERN_ALERT "Exit\n");
  if(ret_val<0)
  {	
      printk(KERN_ALERT "Sorry, Error in Unregistering the block device");   
  } 
}	

module_init(init_function);
module_exit(exit_function);
 


--0-1243732093-1126789614=:47523--
