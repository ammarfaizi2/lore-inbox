Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282211AbRK2A0x>; Wed, 28 Nov 2001 19:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282213AbRK2A0o>; Wed, 28 Nov 2001 19:26:44 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:34950 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S282211AbRK2A0d>; Wed, 28 Nov 2001 19:26:33 -0500
Message-ID: <3C0580A8.5030706@us.ibm.com>
Date: Wed, 28 Nov 2001 16:26:16 -0800
From: "David C. Hansen" <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011128
X-Accept-Language: en-us
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from drivers' release functions
In-Reply-To: <E169EFX-0006TA-00@the-village.bc.nu> <3C057410.3090201@us.ibm.com> <20011128234505.C2561@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Wed, Nov 28, 2001 at 03:32:32PM -0800, David C. Hansen wrote:
>
>>Nothing, because the BKL is not held for all opens anymore.  In most of 
>>the cases that we addressed, the BKL was in release _only_, not in open 
>>at all.  There were quite a few drivers where we added a spinlock, or 
>>used atomic operations to keep open from racing with release.  
>>
>
>All char and block devs are opened with the BKL held - see chrdev_open in
>fs/devices.c and do_open in fs/block_dev.c
>
I wrote a quick and dirty char device driver to see if this happened. 
 If I run two tasks doing a bunch of opens and closes, the -EBUSY 
condition in the open function does happen.  Is my driver doing 
something wrong?

Here is the meat of the driver:

static int Device_Open = 0;

int testdev_open(struct inode *inode,  struct file *file)
{
  if ( test_and_set_bit(0,&Device_Open) )    {
      printk( "attempt to open testdev more than once\n" );
      return -EBUSY;
    }
  MOD_INC_USE_COUNT;
  return SUCCESS;
}

int testdev_release(struct inode *inode,  struct file *file)
{
  clear_bit(0,&Device_Open);
  MOD_DEC_USE_COUNT;
  return 0;
}

static int Major;
struct file_operations Fops = {
     open: testdev_open,
  release: testdev_release,
};

/* Initialize the module - Register the character device */
int init_module(void)
{
  Major = register_chrdev(0,
                          DEVICE_NAME,
                          &Fops);

  /* Negative values signify an error */
  if (Major < 0) {
    printk ("%s: %s device failed with %d\n",MODULE_NAME,
            "Sorry, registering the character",
            Major);
    return Major;
  }
  printk( "%s: loaded successfully on Major:%d\n",MODULE_NAME,Major);
  return 0;
}

void cleanup_module(void)
{
  int ret;
  ret = unregister_chrdev(Major, DEVICE_NAME);
  if (ret < 0)
    printk("%s: Error in unregister_MODULE_NAME: %d\n",
       MODULE_NAME, ret);
}




