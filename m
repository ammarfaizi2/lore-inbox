Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266733AbUG0X5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266733AbUG0X5g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 19:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266736AbUG0X5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 19:57:35 -0400
Received: from salvatore4.bol.com.br ([200.221.24.52]:5513 "EHLO
	salvatore4.bol.com.br") by vger.kernel.org with ESMTP
	id S266733AbUG0X5U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 19:57:20 -0400
Date: Tue, 27 Jul 2004 20:57:18 -0300
Message-Id: <I1JBVI$F6FA5E2E2DFC93D7364971BDDB0B262B@bol.com.br>
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
From: "baugustoss" <baugustoss@bol.com.br>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
X-XaM3-API-Version: 4.1 (B59)
X-type: 0
X-SenderIP: 200.150.37.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I whoud like to port this driver to kernel 2.4.
I'm new in module programming (and write in english 
too, sorry my poor english)

I can compile and load but, when try to write or read a 
data from device the machine reboot.
Kernel show me opp and say :

	Unable to handle kernel NULL pointer 
dereference at virtual address 00000004
Jul 13 17:50:50 linux kernel:  printing eip:
Jul 13 17:50:50 linux kernel: c011b962
Jul 13 17:50:50 linux kernel: *pde = 00000000
Jul 13 17:50:50 linux kernel: Oops: 0002 2.4.19-4GB #1 
Fri Sep 13 13:14:56 UTC 2002
Jul 13 17:50:50 linux kernel: CPU:    0
Jul 13 17:50:50 linux kernel: EIP:    0010:
[interruptible_sleep_on+50/96]    Tainted: P
Jul 13 17:50:50 linux kernel: EIP:    0010:
[<c011b962>]    Tainted: P
Jul 13 17:50:50 linux kernel: EFLAGS: 00010086
Jul 13 17:50:50 linux kernel: eax: c1ac4bac   ebx: 
00000286   ecx: c15bff4c   edx: 00000000
Jul 13 17:50:50 linux kernel: esi: 00000000   edi: 
0000000c   ebp: c15bff68   esp: c15bff44
Jul 13 17:50:50 linux kernel: ds: 0018   es: 0018   ss: 
0018
Jul 13 17:50:50 linux kernel: Process pos4000 (pid: 
4411, stackpage=c15bf000)
Jul 13 17:50:50 linux kernel: Stack: 00000000 c15be000 
00000000 c0a61c00 00000000 00000000 0000000c c011ea5f
Jul 13 17:50:50 linux kernel:        00000000 c15bff98 
c1ac43b0 c1ac46c5 00000000 0000000c 00000014 c010a034
Jul 13 17:50:50 linux kernel:        00000005 c07ef460 
0804a5e0 c0d13920 ffffffea 00000106 c0143725 c0d13920
Jul 13 17:50:50 linux kernel: Call Trace:    
[printk+15/32] [lvm-mod:vg+3257040/231527568] [lvm-
mod:vg+3257829/231526779] [han
dle_IRQ_event+52/112] 
[8390:__insmod_8390_S.rodata_L100+4096800/18148752]
Jul 13 17:50:50 linux kernel: Call Trace:    
[<c011ea5f>] [<c1ac43b0>] [<c1ac46c5>] [<c010a034>] 
[<c07ef460>]
Jul 13 17:50:50 linux kernel:   [sys_read+133/256] 
[system_call+51/64]
Jul 13 17:50:50 linux kernel:   [<c0143725>] 
[<c0108e63>]
Jul 13 17:50:50 linux kernel: Modules: 
[(pos:<c1ac4060>:<c1ac7b20>)] 
[(ne:<c07ee060>:<c07ef9c0>)]
Jul 13 17:50:50 linux kernel: Code: 89 4a 04 89 45 e8 
e8 b3 fb ff ff fa 8b 55 e8 8b 45 e4 89 02

What I'm doing wrong ?
How can help me ?

Thank
Bruno Augusto

#define MODULE
#include <linux/module.h>
#include <linux/compatmac.h>
#include <linux/config.h>
#include <linux/types.h>
#include <linux/signal.h>
#include <linux/errno.h>
#include <linux/kernel.h>
#include <linux/sched.h>
#include <linux/major.h>
#include <linux/fs.h>
#include <linux/wrapper.h>
#include <linux/kdev_t.h>

#include "pos.h"

MODULE_LICENSE("GPL");

static struct pos pos[MAXDEV];

static int pos_open(struct inode *inode, struct file 
*file);
static int pos_release(struct inode *inode, struct file 
*file);
//static ssize_t pos_read(struct inode *inode, struct 
file *file, char *buf, int count);
//static ssize_t pos_write(struct inode *inode, struct 
file *file, char *buf, int count);
static ssize_t pos_read(struct file *file, char *buf, 
size_t length, loff_t *offset);
static ssize_t pos_write(struct file *file, const char 
*buf, size_t length, loff_t *offset);

static int deadlock_detected(int minor, int parent)
{
        return false;
}

static int copy_tokern(char *usr, int count, int minor, 
int parent)
{
        int c=(count>BSIZE)?BSIZE:count;

        printk("------Modulo copy_to user\n");

        copy_from_user(pos[parent].buf, usr, c);
        pos[parent].count=c;
        pos[parent].pos=0;
        pos[parent].state|=FULL_STA;
        pos[parent].state&=~EMPTY_STA;
        if (pos[parent].state&READ_STA)
                /*wake_up_process((task_t *)&(pos
[parent].wait)); */
              wake_up_interruptible(&(pos
[parent].wait));

        pos[minor].state&=~WRITE_STA;

        return c;
}


static int copy_tousr(char *usr, int count, int minor, 
int parent)
{
        printk("------Modulo copy_to user\n");

        int c=(count>pos[minor].count)?pos
[minor].count:count;

        copy_to_user(usr, pos[minor].buf, c);

        if (!(pos[minor].count-=c)) {

                pos[minor].state|=EMPTY_STA;
                pos[minor].state&=~(READ_STA|FULL_STA);

              if (pos[parent].state&WRITE_STA)
                        /*wake_up_process(&(pos
[parent].wait));*/
                      wake_up_interruptible(&(pos
[parent].wait));
        } else {
                pos[minor].pos+=c;
        }

        return c;
}

static int pos_open(struct inode *inode, struct file 
*file)
{
        unsigned int minor = MINOR(file->f_dentry-
>d_inode->i_rdev);
        unsigned int parent;

        printk("------Modulo pos Open\n");

        if (minor>=MAXDEV)
                return -ENODEV;
        parent=(minor >= MAXPOS)?(minor-MAXPOS):
(minor+MAXPOS);

        if (minor >= MAXPOS && !(pos
[parent].state&OPEN_STA))
                return -EUNATCH;

        if (pos[minor].state&OPEN_STA)
                return -EUSERS;

        pos[minor].state=(OPEN_STA|EMPTY_STA);


        return 0;
}

static int pos_release(struct inode *inode, struct file 
*file)
{
        unsigned int minor = MINOR(file->f_dentry-
>d_inode->i_rdev);;
        unsigned int parent;

        printk("------ Modulo pos release\n");

        parent = (minor >= MAXPOS)?(minor-MAXPOS):
(minor+MAXPOS);

        if (minor < MAXPOS && (pos
[parent].state&OPEN_STA))
                pos[parent].state|=CLOSE_STA;

        /*wake_up_process((pos[parent].wait));*/
       wake_up_interruptible(&(pos[parent].wait));

        memset((char*)&pos[minor],0,sizeof(struct pos));

        return 0;

}



static ssize_t pos_read(struct file *file, char *buf, 
size_t length, loff_t *offset)
{

        unsigned int minor = MINOR(file->f_dentry-
>d_inode->i_rdev);
        unsigned int parent;

        init_waitqueue_head(&(pos[minor].wait));

        printk("------ Modulo pos read\n");
        pos[minor].state|=READ_STA;

        parent=(minor>=MAXPOS)?(minor-MAXPOS):
(minor+MAXPOS);

        if (pos[minor].state&CLOSE_STA)
                return -EUNATCH;

again:

        if (deadlock_detected(minor,parent))
                return -EDEADLK;

        if (pos[minor].state&FULL_STA){
 
                length = copy_tousr(buf, length, minor, 
parent);
        } else {
              
              interruptible_sleep_on(&(pos
[minor].wait));

                if (pos[minor].state&CLOSE_STA) {
                        return -EUNATCH;
                } else if (!(pos
[minor].state&FULL_STA)) {
                        return -EINTR;
                } else {
                        goto again;
                }
        }
        return length;
}

static ssize_t pos_write(struct file *file, const char 
*buf, size_t length, loff_t *offset)
{
        unsigned int minor = MINOR(file->f_dentry-
>d_inode->i_rdev);
        unsigned int parent;

        pos[minor].state|=WRITE_STA;

        parent=(minor>=MAXPOS)?(minor-MAXPOS):
(minor+MAXPOS);

        if (pos[minor].state&CLOSE_STA)
                return -EUNATCH;
again:
        if (deadlock_detected(minor,parent))
                return -EDEADLK;

        if (pos[parent].state&EMPTY_STA)
                length = copy_tokern(buf, length, 
minor, parent);
        else {

                interruptible_sleep_on(&(pos
[minor].wait));


                if (pos[minor].state&CLOSE_STA){
                        return -EUNATCH;
                } else if (!(pos
[parent].state&EMPTY_STA)) {
                        return -EINTR;
                } else {
                        goto again;
                }
        }
        return length;
}



static struct file_operations pos_fops = {
        NULL,
        NULL,
        pos_read,       /* read */
        pos_write,      /* write */
        NULL,
        NULL,
        NULL,
        NULL,
        pos_open,       /* open */
        NULL,
        pos_release,    /* release */
        NULL,
        NULL,
        NULL,
        NULL,
        NULL
};

int pos_init(void)
{
        printk("Iniciando registro POS4000...");

        if (register_chrdev
(POS4000_MAJOR,"pos",&pos_fops)){
                printk("Incapaz de alocar major %d para 
o dispositivo pos.\n", POS4000_MAJOR);
                return -1;
        }

        memset((char*)pos,0,sizeof(struct pos)*MAXDEV);

        printk("Dispositivo POS4000 instalado com 
sucesso !!!\n");

        return 0;
}

void pos_exit(void)
{

        int ret = unregister_chrdev
(POS4000_MAJOR, "pos");
           if (ret < 0) printk("Error in 
unregister_chrdev: %d\n", ret);
}

module_init(pos_init);
module_exit(pos_exit);


////// pos.h

#ifndef POS_H
#define POS_H

typedef unsigned char   byte;

#define BSIZE   512

#define MAXPOS  12
#define MAXDEV  (MAXPOS*2)

#ifndef POS4000_MAJOR
#define POS4000_MAJOR   60
#endif

#define EMPTY_STA       0x01
#define FULL_STA        0x02
#define CLOSE_STA       0x04
#define READ_STA        0x08
#define WRITE_STA       0x10
#define OPEN_STA        0x20
#define DEADL_STA       0x40

#define true    1
#define false   0

struct pos {
        byte    buf[BSIZE]; /* buffer */
        byte    state;
        int     count;
        int     pos;
        wait_queue_head_t wait;
};
#endif
 
__________________________________________________________________________
Acabe com aquelas janelinhas que pulam na sua tela.
AntiPop-up UOL - É grátis!
http://antipopup.uol.com.br/


