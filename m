Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbSLaJPL>; Tue, 31 Dec 2002 04:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbSLaJPL>; Tue, 31 Dec 2002 04:15:11 -0500
Received: from [61.11.237.102] ([61.11.237.102]:40964 "HELO
	cse-qmail.cse.iitkgp.ernet.in") by vger.kernel.org with SMTP
	id <S262796AbSLaJPK>; Tue, 31 Dec 2002 04:15:10 -0500
Date: 31 Dec 2002 09:23:08 -0000
Message-ID: <20021231092308.15659.qmail@cpusrv-ibm-5.cse.iitkgp.ernet.in>
From: "Vadlapudi Madhu" <Vadlapudi.Madhu@cse.iitkgp.dhs.org>
To: linux-kernel@vger.kernel.org
Subject: Require help in accessing file from kernel space
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Friends,

Please help me finding the bug in the following code. When i ran this code the system is
hanging (kernel panic). I am trying to open a file in kernel space and try to read, it is able open
the file but unable to read.

Code is :

##############################
  struct file     *filp;
  mm_segment_t    oldfs;
  char 		  *fname = "/etc/testfile";
  int 		  error = 0;
  char            *buf = NULL;
  int             bytesread = 0;

  oldfs = get_fs(); 
  set_fs(get_ds());
  
  buf = (char*)kmalloc(50, GFP_ATOMIC);
  if( buf == NULL ) {
    printk(KERN_DEBUG"[Unable to allocate buf memory]\n");
    error = -3;
    goto out2;
  }
  memset(buf,0,50);

  filp = filp_open(fname,O_RDONLY,0);

  if( IS_ERR(filp) || filp==NULL ) {
    printk(KERN_DEBUG"[opening file error:%s]\n",fname);
    error = -1;
    goto out;
  }

  if( !filp || !filp->f_op || !filp->f_op->read ) {
    printk(KERN_DEBUG"[filp does not have read function]\n");
    error = -2;
    goto out1;
  }
// I am getting error here
  bytesread = filp->f_op->read(filp, buf, 41, &filp->f_pos);
  buf[bytesread]='\0';
  printk(KERN_DEBUG"[buffer-%s]\n",buf);

 out1:
  if( filp!=NULL || !IS_ERR(filp) )
    filp_close(filp,NULL);
  
out:
  if( buf != NULL )
    kfree(buf);
out2:
  set_fs(oldfs); 

  return error;        
###################################

Thanks in advance.

Rgda,

Madhu V
