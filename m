Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbVJSOxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbVJSOxi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 10:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbVJSOxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 10:53:38 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:23543 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751023AbVJSOxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 10:53:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=shJISz9WUaTHjThBpOqLw2d8bJHdVAtp5G84W8uNrcbEYvOUvB2rMOxUi+Xf9BYSh/a9K4Q5ixnu2ukRWOfdITrO/nz9ounNt0hLny0wnLqa0mM5RLB4O5j9u+GP3RfXrcPJ60QDwK3Y2jAZosQsS6NQ/6/bdGdJk11SvhhJDlY=
Message-ID: <7418fe470510190753s1a87687ene196c057a29e014c@mail.gmail.com>
Date: Wed, 19 Oct 2005 16:53:35 +0200
From: Rabih ElMasri <rabih.elmasri@infineon.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: tty line discipline
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1129723302.2822.31.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4107_2508494.1129733615876"
References: <7418fe470510190455x3bb746cax365092504e77ba3c@mail.gmail.com>
	 <1129723302.2822.31.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_4107_2508494.1129733615876
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thank you Arjan for the remarks. I want to establish communication
between a host and a controller. The controller is connected to the
serial port ttyS0. I want to be able to specify how the driver
receives and sends the data.  I thought this would require a line
discipline because a driver for ttyS0 already exists. Please correct
me if I was wrong.

Previously, I used to initialize the module and register the line
discipline to N_MOUSE. Then I would run a C-file from user space with
the code:

i=3DN_MOUSE;
ioctl(fd,TIOCSETD,&i);

This would assign the line discipline to ttyS0 successfully. Now, I
want to establish communication directly from kernel space.

As can be seen from the attached source file, the only fields from the
tty_ldisc structure that I'm using are receive_buf (tl_tty_receive)
and write_wakeup(tl_tty_wakeup).

If the problem is still unclear please tell me.


On 10/19/05, Arjan van de Ven <arjan@infradead.org> wrote:
> On Wed, 2005-10-19 at 13:55 +0200, Rabih ElMasri wrote:
> > hi,
> >
> > I am trying to assign a new line discipline to ttyS0 from within the
> > kernel-space.
>
> why? You don't describe what you want to solve, only how you want to do
> it... it might be entirely the wrong solution for a simple problem..
>
>
> >  During the initialization of my module I do the
> > following:
>
> you forgot to attach the full source of your module or point to URL with
> that. That is basically rule nr 1 when posting about problems with
> out-of-kernel modules; how else are people supposed to help you?
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

------=_Part_4107_2508494.1129733615876
Content-Type: text/plain; name=tl.c; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="tl.c"


#include <linux/fs.h>
#include <linux/syscalls.h>	
#include <linux/ioctl.h>

#include <linux/module.h>
#include <linux/version.h>
#include <linux/init.h>		//for module_exit/init
#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/tty.h>
#include <linux/poll.h>
#include <linux/slab.h> 	//for kmalloc

#include "host.h"

typedef struct PacketInfo_tag
   {
     UINT16 uiWritePtr;
     UINT16 uiLen;
     UINT8* pucPacket;
   } T_PacketInfo;

static enum
{
	Starting_delimiter,
	After_delimiter
} pktStage =Starting_delimiter;


static struct tty_struct *pstLocaltty;
static T_PacketInfo stSendFrame;


MODULE_AUTHOR("Rabih ElMasri");
MODULE_LICENSE("GPL");


void SendFrame(unsigned char *Frame,unsigned int length)
{
	
    len = pstLocaltty->driver->write(pstLocaltty, Frame, length);
    	if (len < Length)
    	{
    	
//the rest will be sent after tl_tty_wakeup is called from lowlevel device driver
    	   printk("Send not complete\n");
    	   stSendFrame.pucPacket=Ptr;
    	   stSendFrame.uiWritePtr=len;
    	   stSendFrame.uiLen=Length;
    	}
    	else
    	{
    	     printk("Send complete\n");
		}
	
		
	return;
}
EXPORT_SYMBOL(SendFrame);


/* tl_tty_open
 * 
 *     Called when line discipline changed to ours.
 *
 * Arguments:
 *     tty    pointer to tty info structure
 * Return Value:    
 *     0 if success, otherwise error code
 */
static int tl_tty_open(struct tty_struct *tty)
{
   printk("tl_tty_open\n");   

   //pstLocaltty = tty;
   
   /* Flush any pending characters in the driver and line discipline. */
   /* FIXME: why is this needed. Note don't use ldisc_ref here as the
      open path is before the ldisc is referencable */
   if (tty->ldisc.flush_buffer)
	   tty->ldisc.flush_buffer(tty);

   if (tty->driver->flush_buffer)
	   tty->driver->flush_buffer(tty);

   
   return 0;
}

/* tl_tty_close()
 *
 *    Called when the line discipline is changed to something
 *    else, the tty is closed, or the tty detects a hangup.
 */
static void tl_tty_close(struct tty_struct *tty)
{
   printk("tl_tty_close\n");   
   pstLocaltty=NULL;
}

/* tl_tty_ioctl()
 *
 *    Process IOCTL system call for the tty device.
 *
 * Arguments:
 *
 *    tty        pointer to tty instance data
 *    file       pointer to open file object for device
 *    cmd        IOCTL command code
 *    arg        argument for IOCTL call (cmd dependent)
 *
 * Return Value:    Command dependent
 */
static int tl_tty_ioctl(struct tty_struct *tty, struct file * file,unsigned int cmd, unsigned long arg)
{
   int err = 0;

   printk("tl_tty_ioctl\n");   

   switch (cmd) {
   default:
	   err = n_tty_ioctl(tty, file, cmd, arg);
	   break;
   };

   return err;
}


/* ()
 *
 *    Callback for transmit wakeup. Called when low level
 *    device driver can accept more send data.
 *
 * Arguments:        tty    pointer to associated tty instance data
 * Return Value:    None
 */
static void tl_tty_wakeup(struct tty_struct *tty)
{
   unsigned int uilen;
   unsigned int uiLenRemain = stSendFrame.uiLen-stSendFrame.uiWritePtr;
   printk("tl_tty_wakeup\n");   

   clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);

   if (NULL!=stSendFrame.pucPacket)
   {
      uilen = pstLocaltty->driver->write(pstLocaltty, stSendFrame.pucPacket+stSendFrame.uiWritePtr,uiLenRemain);
      if (uilen < uiLenRemain)
      {
			
			stSendFrame.uiWritePtr=uiLenRemain-uilen;
      }
      else
      {
			stSendFrame.pucPacket=NULL;
			stSendFrame.uiWritePtr=0;
			stSendFrame.uiLen=0;
	  }
   }


}

/* tl_tty_room()
 * 
 *    Callback function from tty driver. Return the amount of 
 *    space left in the receiver's buffer to decide if remote
 *    transmitter is to be throttled.
 *
 * Arguments:        tty    pointer to associated tty instance data
 * Return Value:    number of bytes left in receive buffer
 */
static int tl_tty_room (struct tty_struct *tty)
{
   printk("tl_tty_room\n");   

   return 65536;
}



/* tl_tty_receive()
 * 
 *     Called by tty low level driver when receive data is
 *     available.
 *     
 * Arguments:  tty          pointer to tty instance data
 *             data         pointer to received data
 *             flags        pointer to flags for data
 *             count        count of received data in bytes
 *     
 * Return Value:    None
 */
static void tl_tty_receive(struct tty_struct *tty, const __u8 *data, char *flags, int count)
{
   UINT16 uiReadPtr= 0;
   UINT8  Byte;
   UINT8* pack;
   int	  ind;

   printk("tl_tty_receive\n");   
   
   if (test_and_clear_bit(TTY_THROTTLED,&tty->flags) && tty->driver->unthrottle)
	tty->driver->unthrottle(tty);
   // Parse the data
   
   pack= (UINT8*)kmalloc(sizeof(UINT8)*1000,GFP_KERNEL);
   pktStage=Starting_delimiter;

   while ( (uiReadPtr<count))
   {
   		
		memcpy (&Byte, data+uiReadPtr, 1);
   		uiReadPtr++;
   	  	
		//printk("%02X, %d\n ",Byte,ind);
    			
   		switch(pktStage)
		{
			case	Starting_delimiter:
	
				if(Byte==0xf0)
				{
					pack[0]=Byte;
					ind=1;
					pktStage=After_delimiter;
				}
				break;
			
			case	After_delimiter:
				if(Byte!=0xf0)	
				{
					pack[ind]=Byte;
					ind++;
				}
				else if(Byte==0xf0)
				{
					pack[ind]=Byte;
					ind=0;
					pktStage=Starting_delimiter;
					Incoming(pack);
				}
				break;
		}
   }
 }



/*
 * We don't provide read/write/poll interface for user space.
 */
static ssize_t tl_tty_read(struct tty_struct *tty, struct file *file, unsigned char __user *buf, size_t nr)
{
	return 0;
}
static ssize_t tl_tty_write(struct tty_struct *tty, struct file *file, const unsigned char *data, size_t count)
{
	return 0;
}
static unsigned int tl_tty_poll(struct tty_struct *tty, struct file *filp, poll_table *wait)
{
	return 0;
}

int init_uart(char *dev)
{
    
    //int i;
    //int err;
    struct termios newtio;//,oldtio;
	struct file 	*fp; 			//refer to linux/fs.h for the struct
	
    fp = filp_open(dev, O_RDWR | O_NOCTTY,0); //refer to fs/open.c for filp_open()
    //filp_open calls tty_open which stores a pointer to the tty_struct in the private_data field
    
    if (IS_ERR(fp))
    {
	    printk("Can't open serial port\n");
	    return -1;
    }

//latest    
    /*
    if((err=n_tty_ioctl((struct tty_struct *)(fp->private_data), fp,TCGETA,&oldtio))<0) //prototype in tty.h, found in tty_ioctl.c
    {
    	printk("Can't get the old termios. Error:%d,%d,%d \n",err,EBADF,ENOTTY);
        //return -1;
    }
    */
    
    newtio.c_cflag = B115200 | CRTSCTS | CS8 | CLOCAL | CREAD;
    newtio.c_iflag = IGNPAR;
    newtio.c_oflag = 0;

    /* set input mode (non-canonical, no echo,...) */
    newtio.c_lflag = 0;

    newtio.c_cc[VTIME]    = 0;   /* inter-character timer unused */
    newtio.c_cc[VMIN]     = 1;   /* blocking read until 1 chars received */

    pstLocaltty=(struct tty_struct *)(fp->private_data);
    
    //setting the new termios of the tty_struct
    pstLocaltty->termios=&newtio; //refer to struct tty_struct in tty.h
      
//latest     
    //setting the new termios in the tty_struct   
 /*
    if((err=n_tty_ioctl((struct tty_struct *)(fp->private_data), fp,TCSETA,&newtio))<0) //prototype in tty.h, found in tty_ioctl.c
    {
    	printk("Can't set the new termios. Error: %d,%d,%d,%d,%d,%d \n",err,EBADF,ENOTTY,EINTR,EINVAL,EIO);
        return -1;
    }
    
    //assigning the new line discipline
    //the important bypass (N_MOUSE is unused in Linux, so we use it here)
    //this will call tl_tty_open
    
    i = N_MOUSE;    
    //if((err=fp->f_op->ioctl(fp->f_dentry->d_inode,fp, TIOCSETD,&i))<0) //refer to tty_ioctl in tty_io.c (usr/src/linux/drivers/char/)
    if(err=((struct tty_struct *)(fp->private_data))->driver->ioctl((struct inode *)fp->f_dentry->d_inode,fp, TIOCSETD, &i)<0) 
    {
	    printk("Can't set line discipline. Error: %d,%d,%d,%d,%d,%d \n",err,EBADF,ENOTTY,EINTR,EINVAL,EIO);
	    return -1;
    }
   */ 
    return 1;
}



static int __init tl_init(void)
{
	static struct tty_ldisc tl_ldisc;
	int err;
	int n;

	/* Register the tty discipline */
	printk(": tl_init\n");

	memset(&tl_ldisc, 0, sizeof (tl_ldisc));
	tl_ldisc.magic       = TTY_LDISC_MAGIC;
	tl_ldisc.name        = "n_tl";
	tl_ldisc.open        = tl_tty_open;
	tl_ldisc.close       = tl_tty_close;
	tl_ldisc.read        = tl_tty_read;
	tl_ldisc.write       = tl_tty_write;
	tl_ldisc.ioctl       = tl_tty_ioctl;
	tl_ldisc.poll        = tl_tty_poll;
	tl_ldisc.receive_room= tl_tty_room;
	tl_ldisc.receive_buf = tl_tty_receive;
	tl_ldisc.write_wakeup= tl_tty_wakeup;
	tl_ldisc.owner       = THIS_MODULE;

	if ((err = tty_register_ldisc(N_MOUSE, &tl_ldisc))) {
		printk(": HCI line discipline registration failed. (%d)\n", err);
		return err;
	}


	//initializing the serial interface
	n = init_uart("/dev/ttyS0");
	if (n < 0)
	{
	   printk("\nCan't initialize device\n");
	   return -1;	//any value other than zero indicates an error
   	}
   	
   	//setting the new line discipline
   	
 
 	pstLocaltty->ldisc=tl_ldisc;	//refer to struct tty_struct in tty.h
	pstLocaltty->ldisc.refcount = 0;
	(pstLocaltty->ldisc.open)(pstLocaltty);

	return 0;
}

static void __exit tl_exit(void)
{
	int err;
	
	//fp->f_op->release(fp->f_dentry->d_inode,fp);
	//fp=NULL;

	(pstLocaltty->ldisc.close)(pstLocaltty);
	pstLocaltty=NULL;

	/* Release tty registration of line discipline */
	if ((err = tty_register_ldisc(N_MOUSE, NULL)))
		printk(": Can't unregister HCI line discipline (%d)\n", err);
	
}


module_init(tl_init);
module_exit(tl_exit);


------=_Part_4107_2508494.1129733615876--
