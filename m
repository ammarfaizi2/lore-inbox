Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281322AbRKRIkG>; Sun, 18 Nov 2001 03:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281454AbRKRIj5>; Sun, 18 Nov 2001 03:39:57 -0500
Received: from smtp02.uc3m.es ([163.117.136.122]:37126 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S281322AbRKRIjt>;
	Sun, 18 Nov 2001 03:39:49 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200111180839.fAI8dg124742@oboe.it.uc3m.es>
Subject: Re: Raw access to block devices
In-Reply-To: <20011118081525.50385.qmail@web21106.mail.yahoo.com> from "Roy S.C.
 Ho" at "Nov 18, 2001 00:15:25 am"
To: "Roy S.C. Ho" <scho1208@yahoo.com>
Date: Sun, 18 Nov 2001 09:39:42 +0100 (MET)
Cc: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Roy S.C. Ho wrote:"
> Hi Peter, thanks for your help. I found that the
> control device is only for GETBIND or SETBIND. It
> seems that the binded devices still have to be char
> devices. Is there a way to change this?
> Your help is much appreciated. Thanks.

I'm afraid I only ever read the code, then wrote a simple user space
tool to exercise the ioctls, but never got enough time to try it! But
my impression was that it aimed at controlling the vm system's
reactions to block-device memory buffers.

Here's the test code (rawsetup.c), entirely untested. Copyright me,
of course. 


#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>

#include <linux/major.h>
#include <linux/raw.h>



char *raw_device;
char *blk_device;
int mode;
int fdctl;

static
int cmdline(int argc, char **argv) {
    if (argc < 3)
      return -EINVAL;

    switch (argc) {
    case 3:
      mode = RAW_SET_BIND;
      raw_device = argv[1];
      blk_device = argv[2];
      return 0;
    case 2:
      mode = RAW_GET_BIND;
      raw_device = argv[1];
      return 0;
    }
    return -EINVAL;
}

static
void usage(void) {
   fprintf(stderr,"usage: rawsetup <raw_device> <blk_device>\n");
   fprintf(stderr,"     : rawsetup <raw_device>\n");
}

int setup() {

   int err;
   struct stat statbuf;

   fdctl = open("/dev/raw",O_RDWR);
   if (fdctl < 0) {
     perror("rawsetup error on open of /dev/raw");
     return fdctl;
   }
   err = fstat(fdctl, &statbuf);
   if (err < 0) {
     perror("rawsetup error on stat of /dev/raw");
     return err;
   }
   if (!S_ISCHAR(statbuf.st_rdev)) {
     fprintf(stderr,"/dev/raw is not a character device\n");
     return -ENODEV;
   }
   if (MAJOR(statbuf.st_rdev) != RAW_MAJOR) {
     fprintf(stderr,"/dev/raw is not a RAW minor character device\n");
     return -ENODEV;
   }
   if (MINOR(statbuf.st_rdev) != 0) {
     fprintf(stderr,"/dev/raw is not the RAW control device\n");
     return -ENODEV;
   }
   return 0;
}

int get() {
   struct raw_config_request rq;
   /*        int     raw_minor;
	   __u64   block_major;
	   __u64   block_minor;
    */
   int err;
   struct stat statbuf;

   err = stat(raw_device, &statbuf);
   if (err < 0) {
     perror("rawsetup error on stat of raw device");
     return err;
   }
   if (!S_ISCHAR(statbuf.st_rdev)) {
     fprintf(stderr,"%s is not a character device\n", raw_device);
     return -ENODEV;
   }
   if (MAJOR(statbuf.st_rdev) != RAW_MAJOR) {
     fprintf(stderr,"%s is not a RAW device\n", raw_device);
     return -ENODEV;
   }
   rq.raw_minor = MINOR(statbuf.st_rdev);
   if (rq.raw_minor <= 0) {
     fprintf(stderr,"%s is not a RAW minor device\n", raw_device);
     return -ENODEV;
   }

   err = ioctl(fdctl,RAW_GETBIND,&rq) ;
   if (err < 0) {
     perror("rawsetup error on GETBIND ioctl to /dev/raw");
     return err;
   }
   printf("raw device %s is bound to block device %h:%h\n",
	rq.raw_major, rq.raw_minor);
   return 0;
}

int bind() {

   struct raw_config_request rq;
   /*        int     raw_minor;
	   __u64   block_major;
	   __u64   block_minor;
    */
   int err;
   struct stat statbuf;

   err = stat(raw_device, &statbuf);
   if (err < 0) {
     perror("rawsetup error on stat of raw device");
     return err;
   }
   if (!S_ISCHAR(statbuf.st_rdev)) {
     fprintf(stderr,"%s is not a character device\n", raw_device);
     return -ENODEV;
   }
   if (MAJOR(statbuf.st_rdev) != RAW_MAJOR) {
     fprintf(stderr,"%s is not a RAW device\n", raw_device);
     return -ENODEV;
   }
   rq.raw_minor = MINOR(statbuf.st_rdev);
   if (rq.raw_minor <= 0) {
     fprintf(stderr,"%s is not a RAW minor device\n", raw_device);
     return -ENODEV;
   }

   err = stat(blk_device, &statbuf);
   if (err < 0) {
     perror("rawsetup error on stat of block device");
     return err;
   }
   if (!S_ISBLK(statbuf.st_rdev)) {
     fprintf(stderr,"%s is not a block device\n");
     return -ENODEV;
   }
   rq.block_major = MAJOR(statbuf.st_rdev);
   rq.block_minor = MINOR(statbuf.st_rdev);

   err = ioctl(fdctl,RAW_SETBIND,&rq) ;
   if (err < 0) {
     perror("rawsetup error on SETBIND ioctl to /dev/raw");
     return err;
   }
   return 0;
}

int main(int argc, char **argv) {

   if (cmdline(argc,argv) < 0) {
      usage();
      return 1;
   }
   if (setup() < 0) {
      return 2;
   }
   switch(mode) {
     case RAW_SET_BIND:   return bind();
     case RAW_GET_BIND:   return get();
     default: usage();    return 3;
   }
   return 0;
}

// (C) Peter T, Breuer 2001, ptb@it.uc3m.es

