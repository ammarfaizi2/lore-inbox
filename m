Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268425AbUJMF5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268425AbUJMF5L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 01:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268421AbUJMF5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 01:57:11 -0400
Received: from virt10p.secure-wi.com ([209.216.203.97]:37579 "EHLO
	virt10p.secure-wi.com") by vger.kernel.org with ESMTP
	id S268440AbUJMF4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 01:56:43 -0400
Message-ID: <005101c4b763$5e3cba60$41c8a8c0@Eshwar>
From: "eshwar" <eshwar@moschip.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Write  USB Device Driver entry not called
Date: Thu, 21 Oct 2004 17:14:48 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am writing usb Device Driver for vendor specific Device for the kernel
2.6.8 ... When i have loaded my skelton usb driver
ioctl,read,probe,disconnect,release entry points are working fine but when i
issue write() returns as bad file descriptor.... even though i have open the
device file with S_IWUSR

The error message is comming vfs_wirte() function

 if (!(file->f_mode & FMODE_WRITE))
                return -EBADF;

It seems to be f_mode is not set with FMODE_WRITE

Can any one help me to fix this problem.... Thanks in Advance

Regards
Eshwar


The skelton driver is as follows and application code follows the driver
code...

Driver.c

#include <linux/module.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/usb.h>
#include <asm/uaccess.h>


/* Function prototypes */
static int otg_cli_open ( struct inode *inode, struct file *file);
/* Function prototypes */
static int otg_cli_open ( struct inode *inode, struct file *file);
static void otg_cli_disconnect( struct usb_interface *intf);
static int otg_cli_release ( struct inode *inode, struct file *file);
static ssize_t otg_cli_read (struct file *file, char *buffer, size_t count,
                          loff_t *ppos);
static ssize_t otg_cli_write (struct file *file, const char *buffer,
                          size_t count, loff_t *ppos);
static int otg_cli_probe( struct usb_interface *intf,
                          const struct usb_device_id *id);

static struct usb_device_id otg_device_id[] = {
        { USB_INTERFACE_INFO(USB_CLASS_VENDOR_SPEC, 0x00, 0xff) },
        {},
 };

struct usb_driver otg_cli_driver = {
        .owner      =   THIS_MODULE,
        .name       =   "xyz",
        .probe      =   otg_cli_probe,
        .disconnect =   otg_cli_disconnect,
        .id_table   =   otg_device_id,
};

static struct file_operations otg_cli_fops = {
        .owner   =      THIS_MODULE,
        .write    =     otg_cli_write,
        .open    =      otg_cli_open,
        .read    =      otg_cli_read,
        .release =      otg_cli_release,
};

static struct usb_class_driver otg_cli_class = {
        .name =         "xyz",
        .fops =         &otg_cli_fops,
};

static struct usb_class_driver otg_cli_class = {
        .name =         "moschip-otg",
        .fops =         &otg_cli_fops,
        .mode =         S_IRWXU | S_IRWXG | S_IRWXO | S_IFCHR,
        .minor_base =   250,
};

static int otg_cli_ioctl ( struct inode *inode, struct file *file,
                       unsigned int cmd, unsigned long arg)
{

    printk("Eshwar: otg_cli_ioctl");
   return 0;
}

static ssize_t otg_cli_read (struct file *file, char *buffer,
          size_t count, loff_t *ppos)
{
     printk("Eshwar: otg_cli_read");
     return 0;
}

static ssize_t otg_cli_write (struct file *file, const char *buffer,
        size_t count,loff_t *ppos)
{
    printk("Eshwar: otg_cli_write");
    return 0;
}

static int otg_cli_open ( struct inode *inode, struct file *file)
{
    printk("Eshwar: otg_cli_open");
   return 0;
}

static int otg_cli_release ( struct inode *inode, struct file *file)
{
    printk("Eshwar: otg_cli_release");
    return 0;
}

static int otg_cli_probe( struct usb_interface *intf,
                         const struct usb_device_id *id)
{

    printk("Eshwar: otg_cli_probe\n");
    return 0;
}

static void otg_cli_disconnect( struct usb_interface *intf)
{
        printk("Eshwar: otg_cli_disconnect\n");
    usb_deregister_dev (intf, &otg_cli_class);
}

static int __init otg_cli_init(void)
{
    printk ("Eshwar: otg_cli_init\n");
    /* register this driver with the USB subsystem */
    usb_register(&otg_cli_driver);
    return 0;
}

/* OTG cleanup module */
static void __exit otg_cli_exit(void)
{
    usb_deregister(&otg_cli_driver);
}

module_init (otg_cli_init);
module_exit (otg_cli_exit);

app.c


int main(int argc, char *argv[])
{
    int devfd;
    char send[512];

    memset(send,'a',512);

  devfd = open("/dev/usb/dabusb10",O_APPEND | S_IRUSR| S_IWUSR );
  if ( write(devfd,send,512) < 0) {
       printf ("write Failed\n");
       return  -1;
  }

  return 0;

}

