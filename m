Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312354AbSDXQGz>; Wed, 24 Apr 2002 12:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312375AbSDXQGy>; Wed, 24 Apr 2002 12:06:54 -0400
Received: from f218.law11.hotmail.com ([64.4.17.218]:1043 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S312354AbSDXQGw>;
	Wed, 24 Apr 2002 12:06:52 -0400
X-Originating-IP: [137.204.212.122]
From: "il boba" <il_boba@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: what`s wrong?
Date: Wed, 24 Apr 2002 18:06:42 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <F218eE3VsX7PVTdAMDm0000842f@hotmail.com>
X-OriginalArrivalTime: 24 Apr 2002 16:06:42.0963 (UTC) FILETIME=[06880630:01C1EBAA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there anybody that can help me understand what`s wrong with this code?

Mostly i`m not sure about the correct use of the functions filp_open, 
generic_file_read and filp_close.

When i compile as a module on the kernel and after, when i do the INSMOD  , 
at first said SEGMENTATION FAULT, right now it just blocks the whole 
machine.

Any help or hint is very welcome!!!
thanks
boba

Here is the code:

/* FILE NAME : pops.c */


#include <linux/kernel.h>
#include <linux/module.h>


#define BUFSIZ 8192

#if CONFIG_MODVERSIONS==1
#define MODVERSIONS
#include <linux/modversions.h>
#endif

#include <linux/fs.h>


#if LINUX_VERSION_CODE > KERNEL_VERSION(2,2,0)
#include <asm/uaccess.h>
#endif



int init_err_frame(int []);

/* prints the vector err_frame */

int init_module()
{
  int err_frame[BUFSIZ];
  int i, k;
  k = init_err_frame(err_frame);
  for (i = 0; i < k; i++){
    printk("%d \n", err_frame[i]);
  }
  return 0;
}

/* inizializza il vettore err_frame */

int init_err_frame(int err_frame[]) {

  int i, k = 0, j = 0;
  char buffer[BUFSIZ];
  int temp[2];
  int retval;


  struct file * f = 
filp_open("/usr/src/kernel-source-2.2.19/pinux/misc/err_file", 0, 0);  /* i 
want it only readable */
  if (f == '\0'){
       printk ("errore nell' APERTURA del file d'errore");
       return -1;
  }
  printk("%d ", f->f_count);
  if ((generic_file_read(f, buffer, BUFSIZ, &f->f_pos)) < 0 ){
    printk ("errore nella LETTURA del file");
    if ((retval = filp_close(f, NULL)) < 0){
       printk ("errore nella CHIUSURA del file");
       return -3;
    }
    return -2;
  }
  for (i=0; i < '\0'; i++){
    temp[j] = buffer[i];
    if (j == 1){
      err_frame[k] = (int) temp[0] + (int) temp[1];
      j = 0;
      k++;
    } else
      j = 1;
  }
  filp_close(f,NULL);
  return k;
}

void cleanup_module()
{
  printk(".........");
}



and i compile it as
cc -D__KERNEL__ -I/usr/src/kernel-source-2.2.19/include -Wall 
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe 
-fno-strength-reduce -mpreferred-stack-boundary=2 -m486 -DCPU=486 -DMODULE 
-DEXPORT_SYMTAB -c pops.c



_________________________________________________________________
MSN Foto è il modo più semplice per condividere e stampare le tue foto: 
http://photos.msn.com/support/worldwide.aspx

