Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129270AbRCHQgX>; Thu, 8 Mar 2001 11:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129272AbRCHQgN>; Thu, 8 Mar 2001 11:36:13 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:772 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S129270AbRCHQgJ>; Thu, 8 Mar 2001 11:36:09 -0500
Message-Id: <200103081726.f28HQ0Q04099@513.holly-springs.nc.us>
Subject: Re: opening files in /proc, and modules
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200103081651.f28GpkQ04042@513.holly-springs.nc.us>
Content-Type: text/plain
X-Mailer: Evolution (0.9/+cvs.2001.03.06.23.22 - Preview Release)
Date: 08 Mar 2001 11:35:42 -0500
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Figured it out -- I think. This appears to be the answer:

In struct proc_dir_entry,set the fill_inode function pointer to a
callback to handle refcounts.

struct proc_dir_entry
{
...
void (*fill_inode)(struct inode *, int);
...
};


void fill_inode_cb(struct inode *i, int v)
{
 if (v==0)
 {
  MOD_DEC_USE_COUNT;
  return;
 };
 if (v==1)
 {
  MOD_INC_USE_COUNT;
  return;
 };
};


... right?  :)


On 08 Mar 2001 11:01:28 -0500, Michael Rothwell wrote:
> How can I detect that open() has been called on a file in procfs that a
> module provides? If I modprobe my module, open one or more if its proc
> entries, then rmmod the module while the proc files are still open, then
> the deletion of those entries is deferred. When I close the file(s), the
> kernel oopses. I need to be able to detect open() and close() in order
> to increment/decrement the reference count for my module, to prevent it
> from being rmmoded when in use. Any tips?
> 
> Thanks! 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

