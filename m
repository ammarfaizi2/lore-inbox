Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbTAPGsi>; Thu, 16 Jan 2003 01:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbTAPGsi>; Thu, 16 Jan 2003 01:48:38 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:10994 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261561AbTAPGsh>;
	Thu, 16 Jan 2003 01:48:37 -0500
Date: Thu, 16 Jan 2003 12:29:41 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: lots of calls to __write/read_lock_failed
Message-ID: <20030116065940.GA4801@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <3E263285.2000204@us.ibm.com> <20030116044600.GN919@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030116044600.GN919@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2003 at 04:47:30AM +0000, William Lee Irwin III wrote:
> On Wed, Jan 15, 2003 at 08:18:13PM -0800, Dave Hansen wrote:
> >  file_table:_raw_read_lock() 3300000
> >  Call Trace:
> >   [<c0152469>] fget+0x9d/0xa0
> >   [<c0152b27>] sys_fsync+0x21/0xbe
> >   [<c0151b53>] sys_writev+0x47/0x56
> >   [<c010931f>] syscall_call+0x7/0xb
> 
> read_lock(&file->files_lock);

You mean read_lock(&files->file_lock); :)

Dave, does your webserver benchmark clone() tasks with CLONE_FILES ? Unless
the fd table is shared, can't see why there would be contention on this.
If it is indeed necessary to share fd table, then there is a somewhat
unmaintained lockfree fget() patch (files_struct_rcu) that you might want
to try.

> 
> On Wed, Jan 15, 2003 at 08:18:13PM -0800, Dave Hansen wrote:
> > time:_raw_write_lock() 1350000
> > Call Trace:
> >  [<c010f321>] timer_interrupt+0x99/0x9c
> >  [<c010b150>] handle_IRQ_event+0x38/0x5c
> 
> read_lock_irqsave(&xtime_lock, flags)
> or
> write_lock_irq(&xtime_lock);

ISTR a patch from Stephen Hemminger at OSDL that used Andrea's
sequence number trick based rwlock (frlock) to implement do_gettimeofday.
It might be relevant here.

Thanks
Dipankar
