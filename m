Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285163AbRLRVDD>; Tue, 18 Dec 2001 16:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285161AbRLRVCq>; Tue, 18 Dec 2001 16:02:46 -0500
Received: from [65.201.154.134] ([65.201.154.134]:5937 "EHLO
	EXCHANGE01.domain.ecutel.com") by vger.kernel.org with ESMTP
	id <S285160AbRLRVC0> convert rfc822-to-8bit; Tue, 18 Dec 2001 16:02:26 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: a question
Content-Transfer-Encoding: 7BIT
Date: Tue, 18 Dec 2001 16:02:20 -0500
Message-ID: <AF2378CBE7016247BC0FD5261F1EEB210DB5C3@EXCHANGE01.domain.ecutel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: a question
Thread-Index: AcGIB9lkaEdmtvPJEdWseACQJxehMg==
From: "Hari Gadi" <HGadi@ecutel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Hari Gadi" <HGadi@ecutel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a small question regarding the use of NETLINK sockets. I have a
small character driver and  an application which to I want to send some
data using NETLINK sockets.

The questions I have are:
Can I use NETLINK functions from any character driver and to any
process?
Below is the skeleton of my application.

(1)
Below is the skeleton of my application program (ioctl.c) which tries to
read data sent by
char_dev driver.

int kernelsock_open(void)
{

  int kernelfd; 
  kernelfd = open("/dev/char_dev",0);
  length=read(kernelfd,(char *)buffer,(sizeof(struct buffermsg);
}

(2) 
And the skeleton of my driver program is as shown below. (trying to add
netlink support to
chardev.c)

/* chardev.c 
 * 
 * Create an input/output character device
 */

/* Copyright (C) 1998-99 by Ori Pomerantz */

int init_module()
{
  int ret_val;

  /* Register the character device (atleast try) */
  ret_val = register_chrdev(MAJOR_NUM, 
                                 DEVICE_NAME,
                                 &Fops);  
  sendnetlinkpacket();

  return 0;
}

void sendnetlinkpacket(void)
{

  struct  buffermsg *s;
  struct sk_buff *tmpskb;  
  tmpskb=alloc_skb((sizeof(struct buffermsg)),GFP_ATOMIC);
  if(tmpskb)
{
  skb_put(tmpskb,sizeof(struct buffermsg));
  s=(struct buffermsg *)tmpskb->data;
  s->version= 1;
  s->type=SADBM_ACQUIRE;
  
  if(sadb_netlink_post(NETLINK_FIREWALL,tmpskb))
  kfree_skb(tmpskb);
}
}

int sadb_netlink_post(int unit,struct sk_buff *skb)
{
  struct socket *socket1;  
  struct sock *sk=netlink_kernel_create(NETLINK_FIREWALL,NULL);
  socket1=  sk->socket;
  if(socket1)
{
  netlink_broadcast(socket1->sk,skb,0,~0,GFP_ATOMIC);
  return 0;
}
  return 1;

}/*static int sabd_netlink_post()*/



static int device_open(struct inode *inode, 
                       struct file *file)
{
  Device_Open++;

  /* Initialize the message */
  Message_Ptr = Message;

  MOD_INC_USE_COUNT;
  return SUCCESS;
}
     
static int device_release(struct inode *inode, 
                          struct file *file)
{ 
  /* We're now ready for our next caller */
  Device_Open --;

  MOD_DEC_USE_COUNT;

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
  return 0;
#endif
}



static ssize_t device_read(
    struct file *file,
    char *buffer, /* The buffer to fill with the data */   
    size_t length,     /* The length of the buffer */
    loff_t *offset) /* offset to the file */
{
  /* Number of bytes actually written to the buffer */
  int bytes_read = 0;


  /* If we're at the end of the message, return 0 
   * (which signifies end of file) */
  if (*Message_Ptr == 0)
    return 0;

  /* Actually put the data into the buffer */
  while (length && *Message_Ptr)  {    
    put_user(*(Message_Ptr++), buffer++);
    length --;
    bytes_read ++;
  }
  return bytes_read;
}


static ssize_t device_write(struct file *file,
                            const char *buffer,
                            size_t length,
                            loff_t *offset)
{
  int i;
  for(i=0; i<length && i<BUF_LEN; i++)
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
    get_user(Message[i], buffer+i);
#else
    Message[i] = get_user(buffer+i);
#endif  

  Message_Ptr = Message; 
  return i;
}


int device_ioctl(
    struct inode *inode,
    struct file *file,
    unsigned int ioctl_num,/* The number of the ioctl */
    unsigned long ioctl_param) /* The parameter to it */
{
  int i;
  char *temp;
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
  char ch;
#endif

  /* Switch according to the ioctl called */
  switch (ioctl_num) {
    case IOCTL_SET_MSG:
       temp = (char *) ioctl_param; 
   
      get_user(ch, temp);
      for (i=0; ch && i<BUF_LEN; i++, temp++)
        get_user(ch, temp);
      device_write(file, (char *) ioctl_param, i, 0);
      break;

    case IOCTL_GET_MSG:
      /* Give the current message to the calling 
       * process - the parameter we got is a pointer, 
       * fill it. */
      i = device_read(file, (char *) ioctl_param, 99, 0); 
      put_user('\0', (char *) ioctl_param+i);
      break;

    case IOCTL_GET_NTH_BYTE:     
      return Message[ioctl_param];
      break;
  }

  return SUCCESS;
}


struct file_operations Fops = {
  NULL,   /* seek */
  device_read, 
  device_write,
  NULL,   /* readdir */
  NULL,   /* select */
  device_ioctl,   /* ioctl */
  NULL,   /* mmap */
  device_open,
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
  NULL,  /* flush */
#endif
  device_release  /* a.k.a. close */
};

/* Cleanup - unregister the appropriate file from /proc */
void cleanup_module()
{
  int ret;

  /* Unregister the device */
  ret = unregister_chrdev(MAJOR_NUM, DEVICE_NAME);
 
  /* If there's an error, report it */ 
  if (ret < 0)
    printk("Error in module_unregister_chrdev: %d\n", ret);
}














