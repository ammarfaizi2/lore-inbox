Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVDCXq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVDCXq7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 19:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVDCXq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 19:46:59 -0400
Received: from inet-tsb5.toshiba.co.jp ([202.33.96.24]:400 "EHLO
	inet-tsb5.toshiba.co.jp") by vger.kernel.org with ESMTP
	id S261959AbVDCXqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 19:46:44 -0400
Subject: RE: Isn't there race issue during fput() and the dentry_open()?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Date: Mon, 4 Apr 2005 08:42:30 +0900
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <BF571719A4041A478005EF3F08EA6DF0D963B0@pcsmail03.pcs.pc.ome.toshiba.co.jp>
Thread-Topic: Isn't there race issue during fput() and the dentry_open()?
Thread-Index: AcU4Cgvu4YPY5QPcSpWSmK9CWiEcYwAmmMZg
From: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
To: "Al Viro" <viro@parcelfarce.linux.theplanet.co.uk>
Cc: "LKML" <linux-kernel@vger.kernel.org>,
       "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viro,

Thank you for your replay.

> > Stack traceback for pid 2130
> > 0xf717f1b0	2130	1	1	0	R	
> 0xf717f400 *irqbalance
> > ESP	EIP	Function (args)
> > 0xf75bfe38 0xc02d04b2 _spin_lock+0x2e (0xf7441a80)
> > 0xf75bff34 0xc015667c file_move+0x14 (0xf63080e4, 
> 0xf75bff58, 0x0, 0xf74bf000)
> > 0xf75bff40 0xc0154e37 dentry_open+0xb9 (0xf63080e4, 
> 0xf7f5ad80, 0xc02d00e6, 0x100100, 0x246)
> > 0xf75bff58 0xc0154d78 filp_open+0x36
> > 0xf75bffb4 0xc0155079 sys_open+0x31
> > 0xf75bffc4 0xc02d196f syscall_call+0x7
> > 
> > The patch was made. Is this patch right?
> > 
> > diff -urN linux-2.6.12-rc1.orig/fs/file_table.c 
> linux-2.6.12-rc1/fs/file_table.c
> > --- linux-2.6.12-rc1.orig/fs/file_table.c	2005-03-02 
> 16:37:47.000000000 +0900
> > +++ linux-2.6.12-rc1/fs/file_table.c	2005-03-31 
> 17:50:46.323999320 +0900
> > @@ -209,11 +209,11 @@
> >  
> >  void file_kill(struct file *file)
> >  {
> > +	file_list_lock();
> >  	if (!list_empty(&file->f_list)) {
> > -		file_list_lock();
> >  		list_del_init(&file->f_list);
> > -		file_list_unlock();
> >  	}
> > +	file_list_unlock();
> >  }
> 
> This is absolutely useless.  What are you trying to protect 
> and how the
> hell could keeping a lock around that check prevent any sort 
> of deadlock?

I think that it is true not to be able to acquire file_list_lock()
that is called from file_move().
 
> Besides, who could possibly call fput() on struct file allocated by
> dentry_open() and do that before the latter returns a reference to
> that struct file?

Indeed, Is there a good method of debugging this issue?
In the check on the source, a doubtful place was not found except file_kill(). 
I might call not race of fput() and the dentry_open() but
the deadlock of file_list_lock(). 
--
Haruo
