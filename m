Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965137AbWDNKZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbWDNKZU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 06:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965139AbWDNKZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 06:25:20 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:5264 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S965137AbWDNKZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 06:25:19 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17471.30580.883851.856830@gargle.gargle.HOWL>
Date: Fri, 14 Apr 2006 14:20:36 +0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Dan Bonachea <bonachead@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
Newsgroups: gmane.linux.kernel
In-Reply-To: <Pine.LNX.4.64.0604130827490.14565@g5.osdl.org>
References: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu>
	<20060412214613.404cf49f.akpm@osdl.org>
	<443DE2BD.1080103@yahoo.com.au>
	<Pine.LNX.4.64.0604130750240.14565@g5.osdl.org>
	<Pine.LNX.4.64.0604130827490.14565@g5.osdl.org>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
 > 

[...]

 > + * so it's ok to test it independently on the lock/unlock path
 > + * rather than explicitly remembering whether we locked it.
 > + */
 > +static inline loff_t file_pos_read_lock(struct file *file)
 >  {
 > +	if (file->f_mode & FMODE_LSEEK)
 > +		mutex_lock(&file->f_pos_lock);
 >  	return file->f_pos;
 >  }
 >  
 > -static inline void file_pos_write(struct file *file, loff_t pos)
 > +static inline void file_pos_write_unlock(struct file *file, loff_t pos)
 >  {
 >  	file->f_pos = pos;
 > +	if (file->f_mode & FMODE_LSEEK)
 > +		mutex_unlock(&file->f_pos_lock);
 >  }

Naming of two functions above is confusing: it looks like read/write
lock is taken. Maybe file_pos_lock_and_get() and
file_pos_set_and_unlock()?

Nikita.
